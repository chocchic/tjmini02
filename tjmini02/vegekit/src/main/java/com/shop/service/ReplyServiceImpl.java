package com.shop.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.domain.Criteria;
import com.shop.domain.ReviewVO;
import com.shop.domain.QnaVO;
import com.shop.domain.ReplyPageDTO;
import com.shop.domain.ReplyPageDTO2;
import com.shop.mapper.ReplyMapper;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class ReplyServiceImpl implements ReplyService {

	@Autowired
	private ReplyMapper replyMapper;
	
	@Override
	public ReplyPageDTO getReviewListPage(Long pnum, Criteria cri) {
		log.info("get review list bno : " + pnum);
		log.info("get review list cri : " + cri);
		ReplyPageDTO p = new ReplyPageDTO(0, null);
		p.setList(replyMapper.getReviewListWithPaging(pnum, cri));
		p.setReplyCount(replyMapper.rCount(pnum));
		return p;
	}
	
	@Override
	public ReplyPageDTO2 getQnaListPage(Long pnum, Criteria cri) {
		log.info("get qna list bno : " + pnum);
		log.info("get qna list cri : " + cri);
		ReplyPageDTO2 p = new ReplyPageDTO2(0, null);
		p.setList(replyMapper.getQnaListWithPaging(pnum, cri));
		p.setReplyCount(replyMapper.qCount(pnum));
		return p;
	}
	
}
