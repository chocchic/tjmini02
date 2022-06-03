package com.qna.service;

import java.util.List;

import com.qna.domain.QnaVO;

public interface QnaService {
	//문의 작성 
	public void register(QnaVO vo);
	
	//문의 목록 가져오기 
	public List<QnaVO> getList(Integer mnum);

	//문의 본문 가져오기 (사용자) 
	public QnaVO get(Integer qnum);
	
	//문의 수정
	public void modify(QnaVO vo);
	
	//문의 삭제
	public int remove(Integer qnum);

}
