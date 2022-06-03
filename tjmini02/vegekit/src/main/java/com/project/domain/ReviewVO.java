package com.project.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ReviewVO {
	private Integer rnum; //리뷰 번호(시퀀스)
	private String rtitle; //리뷰 제목
	private String rcnt; //리뷰 내용
	private Integer pnum; //상품 번호
	private Integer mnum; //회원 번호
	private Date rdate; //생성 날짜
	private float rstar; //별점 
	private String iname; //이미지 이름 
	private String mid; //회원 아이디 
	

	
}
