package com.shop.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ShopVO {
	private Long pnum;
	private String pname;
	private Integer	pprice;
	private Integer pstock;
	private Date prdate;
	private Integer phearts;
	private float pstar;
	private String pdiet;
	private String pnutr1;
	private String pnutr2;
	private String pnutr3;
	private Date ppdate;
	private Date pexdate;
	private String is_sale;
	private Integer status;
	private String thumb;
	private String detail;
}
