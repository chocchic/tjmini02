package com.admin.service;

import java.util.List;

import com.admin.domain.Criteria;
import com.admin.domain.ProductVO;

public interface ProductService {
	// 상품 등록
	public void register(ProductVO product);
	// 글 하나 가져오기 
	public ProductVO get(Long pnum);
	// 상품 리스트
	public List<ProductVO> getList();
	// 상품 리스트 페이징처리해서 가져오기 
	public List<ProductVO> getList(Criteria cri);
	// 전체 글의 개수 가져오기 
	public int getTotal(Criteria cri); 
	// 상품 삭제 
	public boolean delete(Long pnum); 
	// 상품 수정
	public boolean modify(ProductVO product); 
}
