package com.admin.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.admin.domain.Criteria;
import com.admin.domain.AlarmVO;
import com.admin.domain.SubscriptionVO;
import com.admin.mapper.OrderMapper;
import com.admin.mapper.SubscriptionMapper;

@Service
public class SubscriptionServiceImpl implements SubscriptionService{
	
	@Autowired
	private SubscriptionMapper subMapper;
	
	// 구독 리스트
	@Override
	public List<SubscriptionVO> getList() {
		return subMapper.getList();
		
	}
	
	// 회원 리스트 페이징처리해서 가져오기 
	@Override
	public List<SubscriptionVO> getList(Criteria cri) {
		return subMapper.getListWithPaging(cri);
	}

	//회원리스트 개수 구하기
	@Override
	public int getTotal(Criteria cri) {
		return subMapper.getTotalCount(cri);
	}

	//글 하나 가져오기
	@Override
	public SubscriptionVO get(String subnum) {
		return subMapper.read(subnum); 
	}

	// 회원 삭제
	@Override
	public boolean delete(String subnum) {
		
		return subMapper.delete(subnum) == 1;
	}
	
	// 회원 수정하기
	@Override
	public boolean modify(SubscriptionVO vo) {
		return subMapper.update(vo) == 1;
	}



	
}
