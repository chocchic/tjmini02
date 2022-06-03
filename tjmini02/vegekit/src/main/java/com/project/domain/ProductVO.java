package com.project.domain;


import java.sql.Date;

import lombok.Data;

@Data
public class ProductVO {
	private long pnum;
	private String pname;
	private int pprice;
	private int pstock;
	private Date prdate;
	private int phearts;
	private float pstar;
	private String pdiet;
	private String pnutr1;
	private String pnutr2;
	private String pnutr3;
	private Date ppdate;
	private Date pexdate;
	private String is_sale;
	private int status;
	private String thumb;
	private String detail;
	
}
