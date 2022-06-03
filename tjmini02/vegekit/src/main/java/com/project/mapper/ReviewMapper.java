package com.project.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.project.domain.ReviewVO;

public interface ReviewMapper {
	//리뷰 등록 
	public int insert (ReviewVO vo);
	
	//글 하나 가져오기
	public ReviewVO read(Integer rnum);
	
	//회원번호로 회원 아이디 가져오기 
	public String getMid(ReviewVO vo);
	
	//별점 평균 구하기 
	public float getStarAvg(Integer pnum);
	
	//별점 평균 반영하기 
	public void updateStar(@Param("starAvg") float starAvg,@Param("pnum")  Integer pnum);
	
	//글 수정 
	public void update(ReviewVO vo);
	
	//글 하나 삭제
	public int delete(Integer rnum);
	
	//관리자 리뷰 리스트
	public List<ReviewVO> getAdminList(Integer pnum);

	//사용자 리뷰 리스트 
	public List<ReviewVO> myReviewList(Integer mnum );

	public List<Integer> getMyP(Integer mnum);

	
}


