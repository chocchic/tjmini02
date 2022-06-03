package com.member.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.admin.domain.AlarmVO;
import com.admin.domain.Criteria;
import com.member.domain.AuthVO;
import com.member.domain.MaddressVO;
import com.member.domain.MemberVO;
import com.member.domain.RecdVO;
import com.member.domain.SubProdVO;
import com.member.mapper.MemberMapper;

import lombok.extern.log4j.Log4j;


// 서비스 구현 클래스 : 기능 구현 
@Service
@Log4j
public class MemberServiceImpl implements MemberService {

	// 비밀번호 암호화해줄 객체 주입 
	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;  
	
	@Autowired
	private MemberMapper memberMapper;
	
	
	// 회원 추가(가입처리) 구현 
	@Override
	public int addMember(MemberVO member) {
		// 비번 암호화 
		member.setMpw(bCryptPasswordEncoder.encode(member.getMpw()));
		
		// DB 접근해서 추가 
		int result = memberMapper.addMember(member);
		return result;
	}
	// 권한 추가 
	@Override
	public int addAuth(String au, Integer mnum) {
		System.out.println("add id: " + mnum);
		int result = -1; 
		AuthVO auth = new AuthVO(); 
		auth.setMnum(mnum);
		if(au.equals("member")) {
			auth.setAuth("ROLE_MEMBER");
			result = memberMapper.addAuth(auth);
		}else if(au.equals("admin")) {
			auth.setAuth("ROLE_MEMBER");
			result = memberMapper.addAuth(auth);
			auth.setAuth("ROLE_ADMIN");
			result = memberMapper.addAuth(auth);
		}
		System.out.println("add id: " + mnum);
		return result;
	}
	
	//아이디 중복체크
	@Override
	public int idCheck(String mid) {

		return memberMapper.idCheck(mid);
	}

	// 회원 정보 가져오기 
	@Override
	public MemberVO getMember(String mid) { 
		MemberVO member = memberMapper.getMember(mid);
		return member; // Controller한테 전달해줄게 
	}

	// 회원정보 수정 처리 구현 
	@Override
	public int modifyMember(MemberVO member) {
		int result = 0; 
		result = memberMapper.updateMember(member);
		
		return result; // 컨트롤러에서 갱신된 레코드수 돌려주기 
	}

	// 회원 탈퇴 처리 구현 
	@Override
	public int deleteMember(MemberVO member) {
		int result = 0; 
		MemberVO dbMember = getMember(member.getMid());
		if(bCryptPasswordEncoder.matches(member.getMpw(), dbMember.getMpw())) {
			result = 1; 
			int mnum = memberMapper.findMnum(member.getMid());
			int deleteAddr=memberMapper.deleteAddr(mnum);
			int deleteRes = memberMapper.deleteAuth(mnum); 
			deleteRes = memberMapper.deleteMember(mnum);
			
			log.info("delete auth result : " + deleteRes);
			log.info("delete member result : " + deleteRes);  
		}
		
		return result; // Controller에게 id,pw 맞는지의 결과만 전달 
	}

	//id찾기
	@Override
	public String findId(MemberVO param) {
		String member=memberMapper.findByNameandTel(param);

		return member;
		
	}
	
	//pw 재설정
	@Override
	public int resetPw(MemberVO member) {
		member.setMpw(bCryptPasswordEncoder.encode(member.getMpw()));
		return memberMapper.resetPw(member);
	}
	@Override
	public int findPwChk(MemberVO member) {
		return memberMapper.findPwChk(member);
	}
	
	//마이페이지에서 주문내역 조회
	@Override
	public List<RecdVO> viewRecd(String mid) {
		List list=memberMapper.viewRecd(mid);
		System.out.println("viewRecd service : " + list);
		return list;
	}
	@Override
	public List<Integer> viewState(MemberVO member) {
	//	int mnum = memberMapper.findMnum(member.getMid());
		System.out.println("mnum????????????????"+member.getMnum());
		List<Integer> state = memberMapper.viewState(member.getMnum()); 
		log.info("배송상태는?????????? : "+state);
		return state;	
	}
	
	//내 주소록 추가(직접입력)
	@Override
	public int insertAddr(MaddressVO addr) {
		int result=memberMapper.insertAddr(addr);
		return result;
	}
	
	//주소록 조회
	@Override
	public List<MaddressVO> viewAddr(Integer mnum) {
		List list= memberMapper.viewAddr(mnum);
		return list;
	}
	@Override
	public MemberVO viewAddrDefault(Integer mnum) {
		MemberVO member= memberMapper.viewAddrDefault(mnum);
		return member;
	}
	@Override
	public int updateState(Integer onum) {
		log.info("onum 서비스에 이씀???????? : "+onum);
		int result=memberMapper.updateState(onum);
		return result;
	}
	
	//내 구독 상품 조회
	@Override
	public List<SubProdVO> viewSub(Integer submnum) {
		List list=memberMapper.viewSub(submnum);
		return list;
	}
	
	/*-------------------중현 소스시작 --------------------*/
	@Override
	public List<AlarmVO> getAlarmList(long mnum) {
		return memberMapper.getAlarmList(mnum);
	}
	@Override
	public List<AlarmVO> getAlarmListWithPaging(long mnum, Criteria cri) {
		return memberMapper.getAlarmListWithPaging(mnum, cri);
	}
	@Override
	public int getTotal(Criteria cri) {
		
		return memberMapper.getTotal(cri);
	}
	@Override
	public AlarmVO getOneAlarm(long anum, long mnum) {
		return memberMapper.getOneAlarm(anum, mnum);
	}
	@Override
	public void updateIsRead(long anum) {
		memberMapper.updateIsRead(anum);
	}
	/*-------------------중현 소스끝 ---------------------*/
	

	

	

	

	


	
	

	
	

	
}
