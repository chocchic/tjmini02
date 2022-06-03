package com.admin.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.admin.domain.AlarmVO;
import com.admin.domain.Criteria;

// 알림
public interface AlarmMapper {
	// 개인 알림 등록
	public void oneRegister(AlarmVO alarm);
	
	// 다중 알림 등록
	public void multiRegister(@Param("list") List<AlarmVO> list);
	
	// 알림 리스트
	public List<AlarmVO> getList();
	
	// 페이징처리해서 전체 알림 가져오기 
	public List<AlarmVO> getListWithPaging(Criteria cri); 
	
	// 전체 알림의 개수 가져오기 
	public int getTotalCount(Criteria cri);
	
	// 알림 하나 가져오기 
	public AlarmVO read(@Param("anum") Long anum, @Param("mnum") Long mnum);
	
	// 알림 삭제 
	public int delete(@Param("anum") Long anum);
	
	// 알림 수정
	public int update(AlarmVO alarm);
	
	public List findMnum(@Param("mtier") int mtier);
	
	// 아이디 체크
	public int checkId(@Param("mid") String mid);
}