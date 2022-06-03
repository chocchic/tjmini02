package com.qna.domain;

import java.util.Date;

import lombok.Data;
@Data
public class QnaVO {
	private Integer qnum; //qna 번호
	private String qtitle; //qna 제목
	private String qcnt; //	qna 내용
	private String qcat; //qna 분류
	private Integer qmnum; //qna 작성자 회원번호
	private Integer qpnum; //상품 고유 번호
	private Date rdate; //문의 시간
	private String is_replyed; //답변 여부
	private Date qrdate; //답변 시각 
	private String qreply; //답변 내용 
	
	private String mid; //회원 아이디 
	private String pname;//상품 이름 
	private Integer mnum; //qna 작성자 회원번호
	
	

}
