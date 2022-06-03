package com.project.service;

import java.util.List;

import com.project.domain.ReviewVO;

public interface ReviewService {
	
	//리뷰 저장
	public void register(ReviewVO vo);
	
	
	//글 본문 가져오기 
	public ReviewVO get(Integer rnum);
	
	
	//상품리뷰별점 평균 가져오기
	public float getStarAvg(Integer pnum);
	//상품 별점 상품 테이블에 저장하기
	public void saveStar(float starAvg, Integer pnum);
	
	//리뷰 수정
	public void modify(ReviewVO vo);
	
	//리뷰 삭제
	public int remove(Integer rnum);
	
	//관리자 글목록 가져오기
	public List<ReviewVO> getAdminList(Integer pnum);
	
	//사용자 글목록 가져오기
	public List<ReviewVO> myReviewList(Integer mnum );


	public List<Integer> getMyP(Integer mnum);

}
