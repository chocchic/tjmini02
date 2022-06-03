package com.admin.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.admin.domain.Criteria;
import com.admin.domain.AlarmVO;
import com.admin.domain.CouponVO;
import com.admin.mapper.CouponMapper;

@Service
public class CouponServiceImpl implements CouponService{
	
	@Autowired
	private CouponMapper couponMapper;
	
	// 회원 리스트
	@Override
	public List<CouponVO> getList() {
		return couponMapper.getList();
		
	}
	
	// 회원 리스트 페이징처리해서 가져오기 
	@Override
	public List<CouponVO> getList(Criteria cri) {
		if(cri.getType() != null) {
			if(cri.getType().equals("T")){ 
				 if(cri.getKeyword().equals("씨앗")) {
					 cri.setKeyword("1"); 
				 }else if(cri.getKeyword().equals("새싹")) {
					 cri.setKeyword("2"); 
				 }else if(cri.getKeyword().equals("나무")) {
					 cri.setKeyword("3"); 
				 } 
			 }
		}
		 
		 
		return couponMapper.getListWithPaging(cri);
	}

	//회원리스트 개수 구하기
	@Override
	public int getTotal(Criteria cri) {
		return couponMapper.getTotalCount(cri);
	}

	//글 하나 가져오기
	@Override
	public CouponVO get(Long cpnum) {
		return couponMapper.read(cpnum); 
	}

	// 회원 삭제
	@Override
	public boolean delete(Long cpnum) {
		
		return couponMapper.delete(cpnum) == 1;
	}
	
	// 회원 수정하기
	@Override
	public boolean modify(CouponVO coupon) {
		return couponMapper.update(coupon) == 1;
	}

	@Override
	public void oneRegister(CouponVO coupon) {
		couponMapper.oneRegister(coupon);
		
	}

	@Override
	public List findMnum(int mtier) {
		return couponMapper.findMnum(mtier);
	}

	@Override
	public void multiRegister(List<CouponVO> list) {
		couponMapper.multiRegister(list);
		
	}

	
}
