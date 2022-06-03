package com.qna.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qna.domain.QnaVO;
import com.qna.mapper.QnaMapper;

@Service
public class QnaServiceImpl implements QnaService{
	@Autowired
	private QnaMapper qnaM;
	
	//문의 작성 
	@Override
	public void register(QnaVO vo) {
		qnaM.insert(vo);
	}
	
	//문의 리스트 
	@Override
	public List<QnaVO> getList(Integer mnum) {
		System.out.println("!!!!!!!!!!mnum: " + mnum);
		return qnaM.getList(mnum);
	}

	//문의 본문(사용자)
	@Override
	public QnaVO get(Integer qnum) {
		return qnaM.read(qnum);
	}

	//문의 수정 
	@Override
	public void modify(QnaVO vo) {
		qnaM.update(vo);
		
	}

	//문의 삭제 
	@Override
	public int remove(Integer qnum) {
		return qnaM.delete(qnum);
	}



}
