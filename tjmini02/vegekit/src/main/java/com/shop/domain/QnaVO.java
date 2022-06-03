package com.shop.domain;

import java.util.Date;

import lombok.Data;

@Data
public class QnaVO {
	private String mid;
	private Long qnum;
	private String qtitle;
	private String qcnt;
	private Long qmnum;
	private Long qpnum;
	private Date rdate;
	private String is_replyed;
}
