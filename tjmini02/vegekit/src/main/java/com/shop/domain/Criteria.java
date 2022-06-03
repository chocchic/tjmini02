package com.shop.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Criteria { // 페이징처리시 부수적으로 필요한 정보들 담아줄 객체 

	private int pageNum; 	// 페이지 번호 
	private int listQty;	// 한페이지에 보여줄 게시물 개수 
	
	private String keyword; // 검색 키워드 
	private String cate;
	private String nutr1;
	private String nutr2;
	private String nutr3;
	private String ord;
	
	public Criteria() {
		this(1, 12);
	}
	public Criteria(int pageNum, int listQty) {
		this.pageNum = pageNum; 
		this.listQty = listQty;
	}
		
	// 파라미터 완성해서 돌려주는 메서드 
	public String getParameterLink() {
		// ?pageNum=3&listQty=10
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
				.queryParam("pageNum", this.pageNum)
				.queryParam("listQty", this.listQty)
				.queryParam("keyword", this.keyword)
				.queryParam("cate", this.cate)
				.queryParam("nutr1", this.nutr1)
				.queryParam("nutr2", this.nutr2)
				.queryParam("nutr3", this.nutr3)
				.queryParam("ord", this.ord); 
		System.out.println("uri string : " + builder.toUriString());
		
		return builder.toUriString();
	}
	
	
	
	
	
	
	
}
