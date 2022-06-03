package com.project.mapper;

import java.util.List;

import com.project.domain.MemberVO;
import com.project.domain.ProductVO;

public interface SelectedMapper {
	//좋아요순 가져오
	public List<ProductVO> likeSelect(); 
	//SelectDTO 타입의 객체는 한가지의 상품 정보만 담을 수 있기 때문에 여러 개의 상품 정보를 담을 수 있도록 list 타입으로 반환
	
	//회원이 선택한 영양소 정보 가져오기
	public MemberVO getMemRecomm(Integer mnum);

	//영양소 정보로 상품 가져오기 
	public List<ProductVO> getRecommProd(MemberVO vo);

	public List<ProductVO> starSelect();
	
	

}
