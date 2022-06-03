package com.admin.service;

import java.util.List;

import com.admin.domain.AlarmVO;
import com.admin.domain.Criteria;

public interface AlarmService {
	
	// 알림 리스트 출력(페이징 처리해서)
	public List<AlarmVO> getList(Criteria cri);

	// 알림 등록
	public void oneRegister(AlarmVO alarm);
	// 알림 등록
	public void multiRegister(List<AlarmVO> list);
	// 알림 하나 가져오기 
	public AlarmVO get(Long anum, Long mnum);
	// 알림 리스트
	public List<AlarmVO> getList();
	// 전체 글의 개수 가져오기 
	public int getTotal(Criteria cri); 
	// 알림 삭제 
	public boolean delete(Long anum); 
	// 알림 수정
	public boolean modify(AlarmVO alarm);
	
	public List findMnum(int mtier);
	
	public int checkId(String mid);
}
