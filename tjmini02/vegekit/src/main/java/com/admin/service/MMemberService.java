package com.admin.service;

import java.util.List;

import com.admin.domain.Criteria;
import com.admin.domain.MMemberVO;

public interface MMemberService {
	// 글 하나 가져오기 
	public MMemberVO get(Long mnum, String auth);
	// 회원 리스트
	public List<MMemberVO> getList();
	// 회원 리스트 페이징처리해서 가져오기 
	public List<MMemberVO> getList(Criteria cri);
	// 전체 글의 개수 가져오기 
	public int getTotal(Criteria cri); 
	// 회원 삭제 
	public boolean delete(Long mnum); 
	// 회원 수정
	public boolean modify(MMemberVO member); 
	// 회원 관리자권한 부여
	public boolean authorize(Long mnum,String auth); 
	// 이미 관리자라면...
	public int is_authorize(Long mnum,String auth); 
}
