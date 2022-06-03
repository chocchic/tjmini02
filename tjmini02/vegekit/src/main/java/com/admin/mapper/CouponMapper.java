package com.admin.mapper;


import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.admin.domain.Criteria;
import com.admin.domain.CouponVO;

// 쿠폰
public interface CouponMapper {

	// 쿠폰 리스트
	public List<CouponVO> getList();
	
	// 페이징처리해서 전체 쿠폰 가져오기 
	public List<CouponVO> getListWithPaging(Criteria cri); 
	
	// 전체 쿠폰수 가져오기 
	public int getTotalCount(Criteria cri);
	
	// 쿠폰 한개 가져오기 
	public CouponVO read(@Param("cpnum") Long cpnum);
	
	// 쿠폰 삭제 
	public int delete(Long cpnum);
	
	// 쿠폰 수정
	public int update(CouponVO vo);
	
	// 쿠폰 한명 발급
	public void oneRegister(CouponVO vo);

	// 다중 쿠폰 발급
	public void multiRegister(@Param("list") List<CouponVO> list);
	
	public List findMnum(@Param("mtier") int mtier);
}