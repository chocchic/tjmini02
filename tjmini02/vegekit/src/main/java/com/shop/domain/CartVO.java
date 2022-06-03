package com.shop.domain;

import java.util.Date;

import lombok.Data;

@Data
public class CartVO {
	private Long mnum;
	private Long pnum;
	private int pcount;
	private String pname;
	private int pprice;
	private int pstock;
	private String pdiet;
	private String pnutr1;
	private String pnutr2;
	private String pnutr3;
	private Date pexdate;
	private String is_sale;
	private int status;
	private String thumb;
}
