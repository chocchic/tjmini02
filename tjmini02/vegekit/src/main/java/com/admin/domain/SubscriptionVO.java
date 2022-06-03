package com.admin.domain;


import java.sql.Date;

import lombok.Data;

@Data
public class SubscriptionVO {
	private String subnum;
	private long submnum;
	private Date subend;
	private long subpnum;
	private long subquantity;
	private String mid;
	
}
