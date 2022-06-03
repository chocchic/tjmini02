package com.member.domain;

import java.sql.Date;
import java.util.List;

import lombok.Data;

@Data
public class MemberVO {
	
	private Integer mnum; 
	private String mid; 
	private String mpw; 
	private String mname;
	private String mtel;
	private String maddr;
	private Integer mpnum;	
	private String mnutr1;
	private String mnutr2;
	private String mnutr3;
	private String mdiet;
	private String mtier;
	private Date mrdate;
	private Integer mtotal;
	private String is_sale; 
	private String is_alive; 		// 활동중 "Y", 비활동중 "N"(default - 'Y')  
	private List<AuthVO> authList;	//{admin, ROLE_MEMBER} {admin, ROLE_ADMIN}의 형태로 리스트가 들어감
	
}
