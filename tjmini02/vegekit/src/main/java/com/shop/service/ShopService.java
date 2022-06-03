package com.shop.service;

import java.util.List;

import com.project.domain.ProductVO;
import com.shop.domain.AddressVO;
import com.shop.domain.CartDTO;
import com.shop.domain.CartVO;
import com.shop.domain.CouponVO;
import com.shop.domain.Criteria;
import com.shop.domain.MemberCVO;
import com.shop.domain.QnaVO;
import com.shop.domain.ReviewVO;
import com.shop.domain.ShopVO;

public interface ShopService {

	// 글 하나 가져오기 
	public ShopVO get(Long pnum); 
	
	// 전체 글 가져오기 
	//public List<BoardVO> getList(); 
	// 전체글 페이징처리해서 가져오기 
	//public List<ShopVO> getList(Criteria cri, String ord);
	
	public List<ShopVO> getCateList(Criteria cri);
	
	// 전체 글의 개수 가져오기 
	//public int getTotal(Criteria cri);
	public int getCateTotal(Criteria cri);
	// 현재까지 팔린 수량 가져오기
	public int getSold(Long pnum);
	
	
	public List<ReviewVO> getReview(Long pnum);
	public List<QnaVO> getQna(Long pnum);
	
	public int getReviewCount(Long pnum);
	public int getQnaCount(Long pnum);
	
	public Long findMnum(String mid);
	
	public int findHeart(Long pnum, Long mnum);
	public int findCart(Long pnum, Long mnum);
	
	public int addHeart(Long pnum, Long mnum);
	public int addCart(Long pnum, Long mnum);
	
	public int removeHeart(Long pnum, Long mnum);
	public int updateCart(CartDTO cartDTO, Long mnum);

	public List<CartVO> getCart(Long mnum);
	public int getCartCount(Long mnum);
	
	public MemberCVO getMem(Long mnum);
	
	public List<CouponVO> getCoupons(Long mnum);
	
	public List<AddressVO> getAddrs(Long mnum);
	public AddressVO getAddr(Long mnum, String alias);
	
	public void removeCart(Long mnum, Long pnum);

	public CouponVO getCoupon(Long mnum);

	public int getSumCart(Long mnum);

	public List<Long> getHeart(Long mnum);

	public boolean is_Sub(Long pnum, Long mnum);
	
	public ProductVO findSale(ProductVO vo);

}
