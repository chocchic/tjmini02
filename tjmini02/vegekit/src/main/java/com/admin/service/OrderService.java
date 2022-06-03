package com.admin.service;

import java.util.List;

import com.admin.domain.Criteria;
import com.admin.domain.OrderVO;

public interface OrderService {
	// 주문 하나 가져오기 
	public OrderVO get(Long onum);
	// 주문 리스트
	public List<OrderVO> getList();
	// 주문 리스트 페이징처리해서 가져오기 
	public List<OrderVO> getList(Criteria cri);
	// 주문 글의 개수 가져오기 
	public int getTotal(Criteria cri); 
	// 주문 삭제 
	public boolean delete(Long onum); 
	// 주문 수정
	public boolean modify(OrderVO order);
	

}
