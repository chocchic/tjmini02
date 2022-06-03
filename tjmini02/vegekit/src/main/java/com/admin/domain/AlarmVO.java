package com.admin.domain;


import java.sql.Date;

import lombok.Data;

@Data
public class AlarmVO {
	private long anum;
	private long mnum;
	private String atype;
	private String acnt;
	private Date ardate;
	private String is_read;

	private long mtier;	// 등급
	private String mid;	// 등급
	
}
