package com.shop.service;

import java.util.Date;

import com.shop.domain.KakaoPayApprovalVO;
import com.shop.domain.MemberCVO;
import com.shop.domain.SubInactiveVO;

public interface KakaoPayService {
	// 결제 준비 처리
	public String kakaoPayReady(MemberCVO vo1, Long cnum);
		
	// 결제 승인 요청
	public KakaoPayApprovalVO kakaoPayApprove(String pg_token);

	public int registerOrd(KakaoPayApprovalVO vo);

	public String kakaoPaySubReady(MemberCVO vo, Long pnum, int q, int total);

	public KakaoPayApprovalVO kakaoPaySubApprove(String pg_token);
	
	public Date registerSubOrd(KakaoPayApprovalVO vo);
	
	public KakaoPayApprovalVO kakaoPaySub(String sid);

	public SubInactiveVO cancleSub(String sid);
	
	public void removeSub(String sid);
}
