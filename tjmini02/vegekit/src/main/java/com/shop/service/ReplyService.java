package com.shop.service;

import java.util.List;

import com.shop.domain.ReplyPageDTO;
import com.shop.domain.ReplyPageDTO2;
import com.shop.domain.Criteria;
import com.shop.domain.ReviewVO;
import com.shop.domain.QnaVO;

public interface ReplyService {



	// 리뷰 페이징 조회 
	public ReplyPageDTO getReviewListPage(Long bno, Criteria cri);
	public ReplyPageDTO2 getQnaListPage(Long bno, Criteria cri);
	//public List<ReviewVO> getReviewList(Long pnum, Criteria cri);
	//public List<QnaVO> getQnaList(Long pnum, Criteria cri);

	
}
