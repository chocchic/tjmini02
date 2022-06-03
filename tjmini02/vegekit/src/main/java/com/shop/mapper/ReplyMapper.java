package com.shop.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.shop.domain.Criteria;
import com.shop.domain.ReviewVO;
import com.shop.domain.QnaVO;

public interface ReplyMapper {

	
	
	// 댓글 전체 조회 : 본문글번호를 주고 그 본문글에 달린 모든 댓글을 가져오는 메서드 (+paging)
	public List<ReviewVO> getList(Long bno); 
	
	// 댓글 전체 조회 + 페이징처리  
	public List<ReviewVO> getReviewListWithPaging(
			@Param("pnum") Long pnum, 
			@Param("cri") Criteria cri); 
			
	public List<QnaVO> getQnaListWithPaging(
			@Param("pnum") Long pnum, 
			@Param("cri") Criteria cri);

	public int rCount(Long pnum);
	public int qCount(Long pnum);

	
	// 관리자가 해당 상품 삭제시 리뷰/문의 모두 삭제
	public void deleteReview(Long pnum);
	public void deleteQna(Long pnum);
	
	
	
	
	
	
	
}