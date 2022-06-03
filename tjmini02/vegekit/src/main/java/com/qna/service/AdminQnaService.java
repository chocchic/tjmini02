package com.qna.service;

import java.util.List;

import com.qna.domain.QnaVO;

public interface AdminQnaService {

	//모든 문의 보기 (관리자) 
	public List<QnaVO> getList();
	
	//문의 본문 가져오기 (관리자) 
	public QnaVO get(Integer qnum);

	//답변 등록 
	public void writeReply(QnaVO vo);

}
