package com.admin.domain;


import java.sql.Date;

import lombok.Data;

@Data
public class MMemberVO {
	private long mnum;
	private String mid;
	private String mpw;
	private String mname;
	private String mtel;
	private String maddr;
	private String mpnum;
	private String mnutr1;
	private String mnutr2;
	private String mnutr3;
	private String mdiet;
	private long mtier;
	private Date mrdate;
	private long mtotal;
	private String is_sale;
	private String is_alive;
	private String auth;
	
	
}
