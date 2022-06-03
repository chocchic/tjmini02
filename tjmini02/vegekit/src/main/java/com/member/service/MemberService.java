package com.member.service;

import java.util.List;
import java.util.Map;

import com.admin.domain.AlarmVO;
import com.admin.domain.Criteria;
import com.member.domain.MaddressVO;
import com.member.domain.MemberVO;
import com.member.domain.RecdVO;
import com.member.domain.SubProdVO;

// 서비스 인터페이스 : 비지니스 로직 처리 
public interface MemberService {

	// 회원 추가(가입처리) 
	public int addMember(MemberVO member); 
	// 권한 추가 
	public int addAuth(String au, Integer mnum);
	
	// 아이디 중복 검사
	public int idCheck(String mid);
	
	// 회원정보 가져오기 
	public MemberVO getMember(String mid); 
	
	// 회원 정보 수정 처리 
	public int modifyMember(MemberVO member); 
	
	// 회원 탈퇴 처리 
	public int deleteMember(MemberVO member); 
	
	//아이디 찾기
	public String findId(MemberVO param);
	
	//pw찾기 - 본인인증
	public int findPwChk(MemberVO member);
	
	//pw 재설정
	public int resetPw(MemberVO member);
	
	//주문내역 조회
	public List<RecdVO> viewRecd(String mid);

	//주문상태 가져오기
	public List<Integer> viewState(MemberVO member);

	//내 주소록 추가(직접입력)
	public int insertAddr(MaddressVO addr);
	
	//주소록 조회
	public List<MaddressVO> viewAddr(Integer mnum);
	
	//주소록 디폴트값 조회
	public MemberVO viewAddrDefault(Integer mnum);

	
	//배송상태 변경
	public int updateState(Integer onum);
	
	//구독 상품 조회/변경
	public List<SubProdVO> viewSub(Integer submnum);
	
	//sid로 오더 정보 가져오기
//	public List<SubProdVO> getOderInfo(Integer mnum);
	
	
	/*-------------------중현 소스시작 --------------------*/
	// 나의 알림 목록 조회
	public List<AlarmVO> getAlarmList(long mnum);
	// 나의 알림 목록 페이징처리 조회
	public List<AlarmVO> getAlarmListWithPaging(long mnum, Criteria cri);
	// 화면에 띄울 전체 개수 가져오기
	public int getTotal(Criteria cri);
	// 한개의 알림 가져오기
	public AlarmVO getOneAlarm(long anum, long mnum);
	// 알림 내용 읽을시 읽음으로 표시(update)
	public void updateIsRead(long anum);
	/*-------------------중현 소스끝 ---------------------*/

	
}
