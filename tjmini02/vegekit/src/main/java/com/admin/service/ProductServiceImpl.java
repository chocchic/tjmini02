package com.admin.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.admin.domain.Criteria;
import com.admin.domain.ProductVO;
import com.admin.mapper.ProductMapper;

@Service
public class ProductServiceImpl implements ProductService{
	
	@Autowired
	private ProductMapper productMapper;
	
	// 상품 등록
	@Override
	public void register(ProductVO product) {
		productMapper.register(product);
	}
	
	// 상품 리스트
	@Override
	public List<ProductVO> getList() {
		return productMapper.getList();
		
	}
	
	// 상품 리스트 페이징처리해서 가져오기 
	@Override
	public List<ProductVO> getList(Criteria cri) {
		return productMapper.getListWithPaging(cri);
	}

	//상품리스트 개수 구하기
	@Override
	public int getTotal(Criteria cri) {
		return productMapper.getTotalCount(cri);
	}

	//글 하나 가져오기
	@Override
	public ProductVO get(Long pnum) {
		// TODO Auto-generated method stub
		return productMapper.read(pnum); 
	}

	// 상품 삭제
	@Override
	public boolean delete(Long pnum) {
		
		return productMapper.delete(pnum) == 1;
	}
	
	// 상품 수정하기
	@Override
	public boolean modify(ProductVO product) {
		System.out.println("service~~~~~~~~~~~~~~~~~~~~~~~~~~~~impl!!!!!!!!!"+product);
		return productMapper.update(product) == 1;
	}

	
}
