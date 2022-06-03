package com.member.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class SubProdVO {

	private Integer submnum;
	private String subnum;
	private String pname;
	private String daddr;
	private String pdiet;
	private Date odate;
	private Date subend;
	
}
