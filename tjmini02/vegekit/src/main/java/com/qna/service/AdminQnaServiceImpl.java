package com.qna.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qna.domain.QnaVO;
import com.qna.mapper.AdminQnaMapper;

@Service
public class AdminQnaServiceImpl implements AdminQnaService{
	@Autowired
	private AdminQnaMapper adminQnaM;
	
	//모든 문의 보기 
	@Override
	public List<QnaVO> getList() {
		return adminQnaM.getList();
	}

	//문의 본문 보기 
	@Override
	public QnaVO get(Integer qnum) {
		return adminQnaM.read(qnum);
	}


	//답변 등록하기 
	@Override
	public void writeReply(QnaVO vo) {
		adminQnaM.writeReply(vo);
		
		
	}

}
