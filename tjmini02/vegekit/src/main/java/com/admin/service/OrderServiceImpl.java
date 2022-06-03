package com.admin.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.admin.domain.Criteria;
import com.admin.domain.AlarmVO;
import com.admin.domain.OrderVO;
import com.admin.mapper.OrderMapper;

@Service
public class OrderServiceImpl implements OrderService{
	
	@Autowired
	private OrderMapper orderMapper;
	
	// 주문 리스트
	@Override
	public List<OrderVO> getList() {
		return orderMapper.getList();
		
	}
	
	// 회원 리스트 페이징처리해서 가져오기 
	@Override
	public List<OrderVO> getList(Criteria cri) {
		return orderMapper.getListWithPaging(cri);
	}

	//회원리스트 개수 구하기
	@Override
	public int getTotal(Criteria cri) {
		return orderMapper.getTotalCount(cri);
	}

	//글 하나 가져오기
	@Override
	public OrderVO get(Long onum) {
		return orderMapper.read(onum); 
	}

	// 회원 삭제
	@Override
	public boolean delete(Long cpnum) {
		
		return orderMapper.delete(cpnum) == 1;
	}
	
	// 회원 수정하기
	@Override
	public boolean modify(OrderVO order) {
		return orderMapper.update(order) == 1;
	}



	
}
