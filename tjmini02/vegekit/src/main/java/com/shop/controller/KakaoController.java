package com.shop.controller;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.admin.domain.Criteria;
import com.shop.domain.KakaoPayApprovalVO;
import com.shop.domain.MemberCVO;
import com.shop.domain.SubInactiveVO;
import com.shop.service.KakaoPayService;

@Controller
@RequestMapping("vegekit/kakao/*")
public class KakaoController {
	@Autowired
	private KakaoPayService service;
	
	@GetMapping("kakaoPay")
	public String kakaoPay(MemberCVO vo, @RequestParam("cpnum")Long cnum) {
		System.out.println("kakaoPay Post 요청");
		// 자바를 통해서 kakao api에서 제공한 주소로 http 요청
		System.out.println("mem : " + vo);
		String responseURL = service.kakaoPayReady(vo, cnum);
		// 서비스 처리 결과중 카카오 페이지 준비 결과에 따른 이동할 페이지 주소로 redirect해주기
		// 위에서 리턴받은 페이지 주소로 redirect:
		return "redirect:" + responseURL; // 주소연결
	}
	
	// 정기구독 시작시 sid 받아오는 용도
	@GetMapping("kakaoPaySub")
	public String kakaoPaysub(MemberCVO vo, @RequestParam("pnum")Long pnum, @RequestParam("quantity")int q, @RequestParam("total")String total){
		System.out.println("kakaoPay Post 요청");
		// 자바를 통해서 kakao api에서 제공한 주소로 http 요청
		System.out.println("mem : " + vo);
		int t = (int)(Double.parseDouble(total));
		String responseURL = service.kakaoPaySubReady(vo, pnum, q, t);
		// 서비스 처리 결과중 카카오 페이지 준비 결과에 따른 이동할 페이지 주소로 redirect해주기
		// 위에서 리턴받은 페이지 주소로 redirect:
		return "redirect:" + responseURL; // 주소연결
	}
	// 준비 요청성공시 실행될 요청 메서드
	// 파라미터로 넘어오는 pg_token 받고
	@GetMapping("kakaoPaySuccess")
	public void kakaoPaySuccess(@RequestParam("pg_token") String pg_token, Model model) {
		System.out.println("kakaoPaySuccess.......");
		System.out.println("pg_token : "+ pg_token);
		// 결제 승인 요청(pg_token 전달하면서)
		KakaoPayApprovalVO orderVO = service.kakaoPayApprove(pg_token);
		// db detail 에 카트에 있는 상품 별로 추가
		// cart에 있는 mnum이 같은거 전부 삭제
		// order에 mem으로 하나의 record 추가
		// 사용한 쿠폰 있으면 삭제
		int product = service.registerOrd(orderVO);
		
		model.addAttribute("onum",orderVO.getPartner_order_id());
		model.addAttribute("count", product);
	}
	
	@GetMapping("kakaoPaySubSuccess")
	public void kakaoPaySubSuccess(@RequestParam("pg_token") String pg_token, Model model) {
		System.out.println("kakaoPaySuccess.......");
		System.out.println("pg_token : "+ pg_token);
		// 결제 승인 요청(pg_token 전달하면서)
		KakaoPayApprovalVO orderVO = service.kakaoPayApprove(pg_token);
		
		// order에 mem으로 하나의 record 수정해주기
		Date firstdate = service.registerSubOrd(orderVO);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일");

		model.addAttribute("onum",orderVO.getPartner_order_id());
		model.addAttribute("count", orderVO.getQuantity());
		model.addAttribute("fidate", sdf.format(firstdate));
	
	}
	
	
	@GetMapping("adminSubkakaoPay")
	public String adminSubkakaoPay(Criteria cri, @RequestParam("subnum") String sid, Model model) {
		System.out.println("관리자가 정기결제 시도");
		System.out.println("admis Sub sid : " + sid);
		// 결제 승인 요청(pg_token 전달하면서)
		KakaoPayApprovalVO orderVO = service.kakaoPaySub(sid);
		// db detail 에 카트에 있는 상품 별로 추가
		// cart에 있는 mnum이 같은거 전부 삭제
		// order에 mem으로 하나의 record 추가
		// 사용한 쿠폰 있으면 삭제
		//int product = service.registerOrd(orderVO);
		if(orderVO != null) {
		//service.registerSubOrd(orderVO);
		
		model.addAttribute("onum",orderVO.getPartner_order_id());
		}else System.out.println("정기결제 취소");
		return "/vegekit/admin/dash/main";
	}
	
	@GetMapping("cancelSub")
	public String cancelSub(String sid, Model model) {
		System.out.println("정기결제 삭제");
		
		SubInactiveVO vo = service.cancleSub(sid);
		if(vo.getStatus() != "INACTIVE") {
			System.out.println("성공");
			service.removeSub(sid);
		}
		System.out.println("실패");
		return "/vegekit/member/mypage2";
	}
}
