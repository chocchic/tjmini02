package com.admin.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.admin.domain.AlarmVO;
import com.admin.domain.Criteria;
import com.admin.domain.MMemberVO;
import com.admin.mapper.AlarmMapper;
import com.admin.mapper.MMemberMapper;

@Service
public class AlarmServiceImpl implements AlarmService{

	@Autowired
	private AlarmMapper alarmMapper;
	
	// 알림 리스트(페이징처리)
	@Override
	public List<AlarmVO> getList(Criteria cri) {
		return alarmMapper.getListWithPaging(cri);
	}

	// 개인 알림 등록
	@Override
	public void oneRegister(AlarmVO alarm) {
		alarmMapper.oneRegister(alarm);
	}
	
	// 다중 알림 등록
	@Override
	public void multiRegister(List<AlarmVO> list) {
		alarmMapper.multiRegister(list);
	}
	
	// 알림 한개 가져오기
	@Override
	public AlarmVO get(Long anum, Long mnum) {
		return alarmMapper.read(anum, mnum); 
	}

	// 알림 리스트
	@Override
	public List<AlarmVO> getList() {
		return alarmMapper.getList();
	}

	// 알림 개수
	@Override
	public int getTotal(Criteria cri) {
		return alarmMapper.getTotalCount(cri);
	}
	
	// 알림 삭제
	@Override
	public boolean delete(Long anum) {
		return alarmMapper.delete(anum) == 1;
	}

	// 알림 수정
	@Override
	public boolean modify(AlarmVO alarm) {
		return alarmMapper.update(alarm) == 1;
	}

	@Override
	public List findMnum(int mtier) {
		
		return alarmMapper.findMnum(mtier);
	}

	@Override
	public int checkId(String mid) {
		
		return alarmMapper.checkId(mid);
	}
	
}
