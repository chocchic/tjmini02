package com.project.service;

import java.util.List;

import com.project.domain.ProductVO;

public interface SelectedService {
	
	//매퍼 호출하여 list타입 객체에 selectDTO저장.. 
	public List<ProductVO> likeSelect();
	
	//회원이 선택한 영양소 정보 가져오기
	public List<ProductVO> getMemRecomm(Integer mnum);
	
	//별점순으로 가져와서 보여주기 
	public List<ProductVO> getStarProd();

}
