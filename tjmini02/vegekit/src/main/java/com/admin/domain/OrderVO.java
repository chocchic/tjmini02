package com.admin.domain;


import java.sql.Date;

import lombok.Data;

@Data
public class OrderVO {
	private long onum;
	private long mnum;
	private String mid;
	private long dpnum;
	private String daddr;
	private String recname;
	private String rectel;
	private long ofee;
	private long ototal;
	private long cpwon;
	private long classper;
	private String is_sub;
	private String otype;
	private Date odate;
	private long odel_state;
	
}
