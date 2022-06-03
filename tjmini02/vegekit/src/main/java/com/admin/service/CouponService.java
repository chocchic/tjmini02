package com.admin.service;

import java.util.List;

import com.admin.domain.Criteria;
import com.admin.domain.CouponVO;

public interface CouponService {
	// 쿠폰 한명 발급
	public void oneRegister(CouponVO coupon);
	// 쿠폰 다중 발급
	public void multiRegister(List<CouponVO> list);
	// 쿠폰 하나 가져오기 
	public CouponVO get(Long cpnum);
	// 쿠폰 리스트
	public List<CouponVO> getList();
	// 쿠폰 리스트 페이징처리해서 가져오기 
	public List<CouponVO> getList(Criteria cri);
	// 쿠폰 글의 개수 가져오기 
	public int getTotal(Criteria cri); 
	// 쿠폰 삭제 
	public boolean delete(Long cpnum); 
	// 쿠폰 수정
	public boolean modify(CouponVO coupon);
	
	public List findMnum(int mtier);
	
}
