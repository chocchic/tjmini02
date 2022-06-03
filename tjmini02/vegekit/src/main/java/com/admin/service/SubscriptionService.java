package com.admin.service;

import java.util.List;

import com.admin.domain.Criteria;
import com.admin.domain.SubscriptionVO;

public interface SubscriptionService {
	// 구독 하나 가져오기 
	public SubscriptionVO get(String subnum);
	// 구독 리스트
	public List<SubscriptionVO> getList();
	// 구독 리스트 페이징처리해서 가져오기 
	public List<SubscriptionVO> getList(Criteria cri);
	// 구독 글의 개수 가져오기 
	public int getTotal(Criteria cri); 
	// 구독 삭제 
	public boolean delete(String subnum); 
	// 구독 수정
	public boolean modify(SubscriptionVO vo);
	

}
