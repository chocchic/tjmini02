package com.admin.mapper;


import java.util.List;

import com.admin.domain.Criteria;
import com.admin.domain.ProductVO;

// 상품
public interface ProductMapper {

	// 상품 등록
	public void register(ProductVO product);
	
	// 상품 리스트
	public List<ProductVO> getList();
	
	// 페이징처리해서 전체 상품 가져오기 
	public List<ProductVO> getListWithPaging(Criteria cri); 
	
	// 전체 상품의 개수 가져오기 
	public int getTotalCount(Criteria cri);
	
	// 상품 하나 가져오기 
	public ProductVO read(Long pnum);
	
	// 상품 삭제 
	public int delete(Long pnum);
	
	// 상품 수정
	public int update(ProductVO vo);
}
