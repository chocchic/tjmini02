package com.member.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class RecdVO {
	private Integer pnum;
	private Integer onum;
	private Integer odnum;
	private String mid;
	private Integer mnum;
	private String thumb;
	private String pname;
	private String pdiet;
	private Integer pprice;
	private Integer pcount;
	private Date odate;
	private Integer odel_state;
	private Integer ototal;
}
