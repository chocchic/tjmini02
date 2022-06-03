package com.admin.mapper;


import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.admin.domain.Criteria;
import com.admin.domain.OrderVO;

// 쿠폰
public interface OrderMapper {

	// 주문 리스트
	public List<OrderVO> getList();
	
	// 페이징처리해서 전체 쿠폰 가져오기 
	public List<OrderVO> getListWithPaging(Criteria cri); 
	
	// 전체 주문수 가져오기 
	public int getTotalCount(Criteria cri);
	
	// 주문 한개 가져오기 
	public OrderVO read(@Param("onum") Long onum);
	
	// 주문 삭제 
	public int delete(Long onum);
	
	// 주문 수정
	public int update(OrderVO vo);
	
}