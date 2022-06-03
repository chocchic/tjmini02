package com.qna.mapper;

import java.util.List;

import com.qna.domain.QnaVO;

public interface AdminQnaMapper {

	//모든 문의 보기 
	public List<QnaVO> getList();

	//문의 본문 보기 
	public QnaVO read(Integer qnum);

	//답변 등록하기 
	public void writeReply(QnaVO vo);

}
