package com.shop.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ReviewVO {
	private String mid;
	private Long rnum;
	private String rtitle;
	private String rcnt;
	private Long pnum;
	private Long mnum;
	private Date rdate;
	private float rstar;
	private String iname;
}
