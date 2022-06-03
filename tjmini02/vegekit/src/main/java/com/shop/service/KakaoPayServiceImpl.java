package com.shop.service;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

import com.shop.domain.CartnProdVO;
import com.shop.domain.KakaoPayApprovalVO;
import com.shop.domain.KakaoPayReadyVO;
import com.shop.domain.MemberCVO;
import com.shop.domain.SubInactiveVO;
import com.shop.domain.SubVO;
import com.shop.mapper.KakaoMapper;

@Service
public class KakaoPayServiceImpl implements KakaoPayService {
	
	// HTTP REST 요청해주는 기능을 가진 클래스 : 빈으로 등록해서 얻어다 씀
	@Autowired
	private RestTemplate restTemplate;
	private KakaoPayReadyVO readyVO;
	
	@Autowired
	private KakaoMapper shopMapper;
	
	@Override
	public String kakaoPayReady(MemberCVO vo, Long cnum) {
		System.out.println("ready service method");
		// 카카오 결제 준비 처리 요청
		
		// #1. 요청시 필요한 헤더정보 준비
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization","KakaoAK "+"395f6291ce611687cdf212033eb48ca5");
		System.out.println("pay ready : "+ vo);
		Long order_seq = shopMapper.getOrdSeq();
	
		Integer sum = shopMapper.getSumCart(vo.getMnum());
		int ofee = (sum >= 50000)? 0: 3000;
		sum = sum *(100-vo.getPer()) / 100;
		
		if(cnum != 0L) {
			sum -=shopMapper.getCoupon(cnum).getCpwon();
			shopMapper.setOrdSeq(order_seq, vo, ofee,shopMapper.getCoupon(cnum).getCpwon(), sum);
		}else {
			shopMapper.setOrdSeq(order_seq, vo,ofee,0,sum);
		}
		// 카캌오 서버에게 난 JSON 형태로 응답받고 싶어라는 정보를 줌
		headers.add("Accept",MediaType.APPLICATION_JSON_UTF8_VALUE);
		headers.add("Content-type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=utf-8");
		// #2. 카카오 서버로 요청할 때 보내줄 데이터 BODY 준비
		MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
		params.add("cid", "TC0ONETIME"); //가맹점 코드(테스트는 TC0ONETIME로 사용)
		params.add("partner_order_id", Long.toString(order_seq)); 	// 우리 사이트에서 생성한 주문 고유 번호
		params.add("partner_user_id", Long.toString(vo.getMnum())); 		// 결재하는 사용자 id
		params.add("item_name", Long.toString(order_seq));
		params.add("quantity",Integer.toString(shopMapper.getCartCount(vo.getMnum())));
		params.add("total_amount", Integer.toString(sum));				// 상품 총액
		params.add("tax_free_amount", "0");				// 비과세 상품 금액
		params.add("approval_url", "http://localhost:8080/vegekit/kakao/kakaoPaySuccess");// 결제 성공시 redirect할 주소
		params.add("cancel_url", "http://localhost:8080/vegekit/kakao/kakaoPayCancel");	// 결제 취소시 redirect할 주소
		params.add("fail_url", "http://localhost:8080/vegekit/kakao/kakaoPayFail");	// 결제 실패시 redirect할 주소
		
		// 헤더와 바디 합치기
		HttpEntity<MultiValueMap<String, String>> body=  new HttpEntity<MultiValueMap<String,String>>(params,headers);
		System.out.println("pay ready params : "+ params);
		// #3. 요청 
		// 매개변수 1 : 요청 주소
		// 매개변수 2 : 요청 headers + body
		// 매개변수 3 : 응답받을 type
		try {
			readyVO = restTemplate.postForObject(new URI("https://kapi.kakao.com/v1/payment/ready"), body, KakaoPayReadyVO.class);
			readyVO.setOnum(order_seq);
			readyVO.setMember(vo);
			readyVO.setCpnum(cnum);
			System.out.println("readyVO : "+ readyVO);
			
			// 응답으로 받은 redirect: 이동할 주소 리턴
			return readyVO.getNext_redirect_pc_url();
		} catch (RestClientException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (URISyntaxException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		// 결과받아와서 리턴 -> controller에서 redirect: 이동할 주소 리턴
		shopMapper.deleteOrd(order_seq);
		// 위에서 정상적으로 처리 안될시 돌아갈 페이지 처리
		return "/shop/cart";
	}

	// 결제 승인 처리 메서드
	@Override
	public KakaoPayApprovalVO kakaoPayApprove(String pg_token) {
		// 헤더 정보
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization","KakaoAK "+"395f6291ce611687cdf212033eb48ca5");
		headers.add("Accept",MediaType.APPLICATION_JSON_UTF8_VALUE);
		headers.add("Content-type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=utf-8");
		
		// 바디 파라미터
		MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
		params.add("cid", "TC0ONETIME");
		params.add("tid", readyVO.getTid()); // 카카오 페이에서 생성해준 결제 번호
		params.add("partner_order_id", Long.toString(readyVO.getOnum())); 	// 우리 사이트에서 생성한 주문 고유 번호
		params.add("partner_user_id",Long.toString(readyVO.getMember().getMnum())); 		// 결재하는 사용자 id
		params.add("pg_token", pg_token);
		
		// 헤더와 바디 합치기
		HttpEntity<MultiValueMap<String, String>> body=  new HttpEntity<MultiValueMap<String,String>>(params,headers);
		
		// 요청
		try {
			KakaoPayApprovalVO approvalVO =
			restTemplate.postForObject(new URI("https://kapi.kakao.com/v1/payment/approve"), body, KakaoPayApprovalVO.class);
			
			System.out.println("approvalVO : "+ approvalVO);
			return approvalVO; // 응답으로 받은 정보 리턴
		} catch (RestClientException e) {
			e.printStackTrace();
		} catch (URISyntaxException e) {
			e.printStackTrace();
		}
		shopMapper.deleteOrd(readyVO.getOnum());
		return null;
	}

	@Override
	public int registerOrd(KakaoPayApprovalVO vo) {
		// db detail 에 카트에 있는 상품 별로 추가
		List<CartnProdVO> vo2 = shopMapper.getOD(readyVO.getMember().getMnum());
		System.out.println("register Order : " + vo2);
		int product = 0;
		for(CartnProdVO v : vo2) {
			product += shopMapper.addDoder(readyVO.getMember().getMnum(),Long.parseLong(vo.getPartner_order_id()), v);
		}
		// cart에 있는 mnum이 같은거 전부 삭제
		shopMapper.removeAllCart(readyVO.getMember().getMnum());
		if(readyVO.getCpnum()!=0L) {
			shopMapper.removeCoupon(readyVO.getCpnum());
		}
		shopMapper.addOder(vo.getPayment_method_type(), Long.parseLong(vo.getPartner_order_id()));
		shopMapper.updateMem(readyVO.getMember().getMnum(), vo.getAmount().getTotal()+vo.getAmount().getPoint());
		return product;
	}

	@Override //TCSUBSCRIP
	public String kakaoPaySubReady(MemberCVO vo, Long pnum, int q, int total) {
		System.out.println("ready Sub service method");
		// 카카오 결제 준비 처리 요청
		
		// #1. 요청시 필요한 헤더정보 준비
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization","KakaoAK "+"395f6291ce611687cdf212033eb48ca5");
		System.out.println("pay ready : "+ vo);
		Long order_seq = shopMapper.getOrdSeq();
			
		shopMapper.setOrdSeq(order_seq, vo,0,0,total);
		
		// 카캌오 서버에게 난 JSON 형태로 응답받고 싶어라는 정보를 줌
		headers.add("Accept",MediaType.APPLICATION_JSON_UTF8_VALUE);
		headers.add("Content-type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=utf-8");
		// #2. 카카오 서버로 요청할 때 보내줄 데이터 BODY 준비
		MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
		params.add("cid", "TCSUBSCRIP"); //가맹점 코드(테스트는 TC0ONETIME로 사용)
		params.add("partner_order_id", Long.toString(order_seq)); 	// 우리 사이트에서 생성한 주문 고유 번호
		params.add("partner_user_id", Long.toString(vo.getMnum())); 		// 결재하는 사용자 id
		params.add("item_name", Long.toString(order_seq));
		params.add("item_code",Long.toString(pnum));
		params.add("quantity", Integer.toString(q));
		params.add("total_amount", Integer.toString(total));				// 상품 총액
		params.add("tax_free_amount", "0");				// 비과세 상품 금액
		params.add("approval_url", "http://localhost:8080/vegekit/kakao/kakaoPaySubSuccess");// 결제 성공시 redirect할 주소
		params.add("cancel_url", "http://localhost:8080/vegekit/kakao/kakaoPayCancel");	// 결제 취소시 redirect할 주소
		params.add("fail_url", "http://localhost:8080/vegekit/kakao/kakaoPayFail");	// 결제 실패시 redirect할 주소
		
		// 헤더와 바디 합치기
		HttpEntity<MultiValueMap<String, String>> body=  new HttpEntity<MultiValueMap<String,String>>(params,headers);
		System.out.println("pay ready params : "+ params);
		// #3. 요청 
		// 매개변수 1 : 요청 주소
		// 매개변수 2 : 요청 headers + body
		// 매개변수 3 : 응답받을 type
		try {
			readyVO = restTemplate.postForObject(new URI("https://kapi.kakao.com/v1/payment/ready"), body, KakaoPayReadyVO.class);
			readyVO.setOnum(order_seq);
			readyVO.setMember(vo);
			readyVO.setCpnum(pnum);
			System.out.println("readyVO : "+ readyVO);
			
			// 응답으로 받은 redirect: 이동할 주소 리턴
			return readyVO.getNext_redirect_pc_url();
		} catch (RestClientException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (URISyntaxException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		// 결과받아와서 리턴 -> controller에서 redirect: 이동할 주소 리턴
		shopMapper.deleteOrd(order_seq);
		// 위에서 정상적으로 처리 안될시 돌아갈 페이지 처리
		System.out.println("failed : "+vo);
		return "/shop/list";
	}
	
	// 정기결제 처음 시도할 때만
	@Override
	public KakaoPayApprovalVO kakaoPaySubApprove(String pg_token) {
		// 헤더 정보
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization","KakaoAK "+"395f6291ce611687cdf212033eb48ca5");
		headers.add("Accept",MediaType.APPLICATION_JSON_UTF8_VALUE);
		headers.add("Content-type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=utf-8");
		
		// 바디 파라미터
		MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
		params.add("cid", "TCSUBSCRIP");
		params.add("tid", readyVO.getTid()); // 카카오 페이에서 생성해준 결제 번호
		params.add("partner_order_id", Long.toString(readyVO.getOnum())); 	// 우리 사이트에서 생성한 주문 고유 번호
		params.add("partner_user_id",Long.toString(readyVO.getMember().getMnum())); 		// 결재하는 사용자 id
		params.add("pg_token", pg_token);
		
		// 헤더와 바디 합치기
		HttpEntity<MultiValueMap<String, String>> body=  new HttpEntity<MultiValueMap<String,String>>(params,headers);
		
		// 요청
		try {
			KakaoPayApprovalVO approvalVO =
			restTemplate.postForObject(new URI("https://kapi.kakao.com/v1/payment/approve"), body, KakaoPayApprovalVO.class);
			System.out.println("approvalVO : "+ approvalVO);
			return approvalVO; // 응답으로 받은 정보 리턴
		} catch (RestClientException e) {
			e.printStackTrace();
		} catch (URISyntaxException e) {
			e.printStackTrace();
		}
		shopMapper.deleteOrd(readyVO.getOnum());
		return null;
	}

	@Override
	public Date registerSubOrd(KakaoPayApprovalVO vo) {
		Calendar c = Calendar.getInstance();
		CartnProdVO v = new CartnProdVO();
		v.setOdprice(vo.getAmount().getTotal());
		v.setPcount(vo.getQuantity());
		v.setPnum(Long.parseLong(vo.getItem_code()));
		shopMapper.addDoder(Long.parseLong(vo.getPartner_user_id()),Long.parseLong(vo.getPartner_order_id()), v);
		// 결제일 이후 수요일 4번으로 주문 등록, 결제 테이블에 레코드 추가
		long miliseconds = System.currentTimeMillis();
        Date date = new Date(miliseconds);
  		Calendar cal = Calendar.getInstance(); cal.setTime(date); 
		int today = cal.get(Calendar.DAY_OF_WEEK); 
		int d  = (today >= 4) ? 7 -(today-4) : 4 - today; // 일월화수목금 1~7 수요일 기준이라 4.
		Date firstdate = new Date(date.getTime() + d * 1000 * 60 * 60 * 24); // 배송 첫날
		Date subend = new Date(firstdate.getTime() + 21 * 1000 * 60 * 60 * 24); // 배송 마지막날
		shopMapper.addOder2(vo.getPayment_method_type(), Long.parseLong(vo.getPartner_order_id()), vo.getSid());
		//구독 상품 상세 추가
		shopMapper.addDoder(readyVO.getMember().getMnum(),Long.parseLong(vo.getPartner_order_id()), v);
		// 자동결제를 위한 테이블에 추가
		shopMapper.addSub(vo.getSid(),Long.parseLong(vo.getPartner_user_id()), subend, v);
		shopMapper.updateMem(readyVO.getMember().getMnum(), vo.getAmount().getTotal());
		return firstdate;
	}

	@Override
	public KakaoPayApprovalVO kakaoPaySub(String sid) {
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization","KakaoAK "+"395f6291ce611687cdf212033eb48ca5");
		headers.add("Accept",MediaType.APPLICATION_JSON_UTF8_VALUE);
		headers.add("Content-type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=utf-8");
		// sid를 기준으로 구독정보 가져오기
		SubVO sub = shopMapper.getSub(sid);
		System.out.println("pay sub : " + sub);
		int price = shopMapper.getPrice(sub.getSubpnum()); // 상품 pnum을 기준으로 price만 뽑기
		int total = price*sub.getQuantity();
		Long order_seq = shopMapper.getOrdSeq();
		List<MemberCVO> vo = shopMapper.getOderWithMnum(sub.getSubmnum());
		System.out.println("select : "+vo.get(0));
		shopMapper.setOrdSeq(order_seq, vo.get(0),0,0,total);
		// 바디 파라미터
		MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
		params.add("cid", "TCSUBSCRIP");
		params.add("sid", sub.getSubnum()); // 카카오 페이에서 생성해준 결제 번호
		params.add("partner_order_id",Long.toString(order_seq)); 	// 우리 사이트에서 생성한 주문 고유 번호
		params.add("partner_user_id",Long.toString(vo.get(0).getMnum())); 		// 결재하는 사용자 id
		params.add("quantity",Integer.toString(sub.getQuantity()));
		params.add("total_amount",Integer.toString(total));
		params.add("tax_free_amount","0");
		
		// 헤더와 바디 합치기
		HttpEntity<MultiValueMap<String, String>> body=  new HttpEntity<MultiValueMap<String,String>>(params,headers);
		
		// 요청
		try {
			KakaoPayApprovalVO approvalVO =
			restTemplate.postForObject(new URI("https://kapi.kakao.com/v1/payment/subscription"), body, KakaoPayApprovalVO.class);
			approvalVO.setItem_code(Long.toString(sub.getSubpnum()));
			System.out.println("approvalVO : "+ approvalVO);
			return approvalVO; // 응답으로 받은 정보 리턴
		} catch (RestClientException e) {
			e.printStackTrace();
		} catch (URISyntaxException e) {
			e.printStackTrace();
		}
		shopMapper.deleteOrd(order_seq);
		return null;
	}

	@Override
	public SubInactiveVO cancleSub(String sid) {
		// 헤더 정보 /v1/payment/manage/subscription/inactive
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization","KakaoAK "+"395f6291ce611687cdf212033eb48ca5");
		headers.add("Accept",MediaType.APPLICATION_JSON_UTF8_VALUE);
		headers.add("Content-type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=utf-8");
		
		// 바디 파라미터
		MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
		params.add("cid", "TCSUBSCRIP");
		params.add("sid", sid); // 카카오 페이에서 생성해준 결제 번호
		
		// 헤더와 바디 합치기
		HttpEntity<MultiValueMap<String, String>> body=  new HttpEntity<MultiValueMap<String,String>>(params,headers);
				
		// 요청
		try {
			SubInactiveVO vo = restTemplate.postForObject(new URI("https://kapi.kakao.com/v1/payment/manage/subscription/inactive"), body, SubInactiveVO.class);
			return vo;
		} catch (RestClientException e) {
			e.printStackTrace();
		} catch (URISyntaxException e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public void removeSub(String sid) {
		shopMapper.removeSub(sid);
	}
}
