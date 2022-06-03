package com.member.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.admin.domain.AlarmVO;
import com.admin.domain.Criteria;
import com.member.domain.AuthVO;
import com.member.domain.MaddressVO;
import com.member.domain.MemberVO;
import com.member.domain.RecdVO;
import com.member.domain.SubProdVO;

// 회원 가입 mapper
public interface MemberMapper {

	//회원 추가 
	public int addMember(MemberVO member);
	//권한 추가 
	public int addAuth(AuthVO auth);
	
	// 아이디 중복 검사
	public int idCheck(String mid);
	
	// 회원 한명 정보 가져오기 
	public MemberVO getMember(String mid); 
	
	// 회원 정보 수정 
	public int updateMember(MemberVO member);
	
	// 회원 삭제 
	public int deleteMember(int mnum);
	// 권한 삭제 
	public int deleteAuth(int mnum);
	//address 삭제
	public int deleteAddr(int mnum);
	
	
	//auth 삭제해주기 위해 mid로 mnum 찾아오기
	public int findMnum(String mid);
	
	//id찾기
	public String findByNameandTel(MemberVO member);
	
	
	//pw찾기 - 본인인증(mid, mtel)
	public int findPwChk(MemberVO member);

	//본인인증 후 pw재설정
	public int resetPw(MemberVO member);

	//결제내역 조회
	public List<RecdVO> viewRecd(String mid);
	
	//주문상태 조회
	public List<Integer> viewState(int mnum);
	
	//내 주소록 추가(직접입력)
	public int insertAddr(MaddressVO addr); 
	
	//직접 입력한 주소록 조회(리스트)
	public List<MaddressVO> viewAddr(int mnum);
	
	//주소록 디폴트값 조회
	public MemberVO viewAddrDefault(int mnum);
	
	//배송상태 변경
	public int updateState(int onum);

	//구독 상품 조회/변경
	public List<SubProdVO> viewSub(int submnum);
	
	
	//구독테이블에서 sid가져옴
//	public List<String> getSid(int mnum);
//	
//	public List<SubProdVO> getOderInfo(String sid);
	
	
	/*-------------------중현 소스시작 --------------------*/
	// 나의 알림 목록 조회
	public List<AlarmVO> getAlarmList(@Param("mnum") long mnum);
	// 나의 알림 목록 페이징 처리해서 조회
	public List<AlarmVO> getAlarmListWithPaging(@Param("mnum") long mnum, Criteria cri);
	// 화면에 띄울 전체 개수 가져오기
	public int getTotal(Criteria cri);
	
	// 한개의 알림 가져오기
	public AlarmVO getOneAlarm(@Param("anum") long anum, @Param("mnum") long mnum);
	
	public void updateIsRead(@Param("anum") long anum);
	/*-------------------중현 소스끝 ---------------------*/
	
}
