package com.admin.mapper;


import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.admin.domain.Criteria;
import com.admin.domain.MMemberVO;

// 회원
public interface MMemberMapper {

	// 회원 리스트
	public List<MMemberVO> getList();
	
	// 페이징처리해서 전체 회원 가져오기 
	public List<MMemberVO> getListWithPaging(Criteria cri); 
	
	// 전체 회원수 가져오기 
	public int getTotalCount(Criteria cri);
	
	// 회원 한명 가져오기 
	public MMemberVO read(@Param("mnum") Long mnum, @Param("auth") String auth);
	
	// 회원 삭제 
	public int delete(Long mnum);
	
	// 회원 수정
	public int update(MMemberVO vo);

	// 회원 권한 부여 
	public int authorize(@Param("mnum") Long mnum, @Param("auth") String auth);
	
	// 이미 관리자라면...?
	public int is_authorize(@Param("mnum") Long mnum, @Param("auth") String auth);
}