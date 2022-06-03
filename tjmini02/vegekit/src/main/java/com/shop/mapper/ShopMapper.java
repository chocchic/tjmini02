package com.shop.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.shop.domain.ShopVO;
import com.project.domain.ProductVO;
import com.shop.domain.AddressVO;
import com.shop.domain.CartVO;
import com.shop.domain.CouponVO;
import com.shop.domain.Criteria;
import com.shop.domain.MemberCVO;
import com.shop.domain.QnaVO;
import com.shop.domain.ReviewVO;

public interface ShopMapper {

	// 글 전체 가져오기 
	public List<ShopVO> getList(); 
	
	// 페이징처리해서 전체 글 가져오기 
	//public List<ShopVO> getListWithPaging(Criteria cri);
	
	public List<ShopVO> getCateListWithPaging(Criteria cri);
		// 전체 글의 개수 가져오기 
	//public int getTotalCount(Criteria cri);
	public int getCateTotalCount(Criteria cri);
	// 글 하나 가져오기 
	public ShopVO read(Long pnum);
	
	// 팔린 갯수 가져오기
	public int getSoldCount(Long pnum);
	public int getReviewCount(Long pnum);
	public int getQnaCount(Long pnum);
	
	public List<ReviewVO> getReviewList(Long pnum);
	
	public List<QnaVO> getQnaList(Long pnum);

	public Long findMnum(String mid);

	public int removeHeart(@Param("pnum")Long pnum, @Param("mnum")Long mnum);

	public int addCart(@Param("pnum")Long pnum,@Param("mnum") Long mnum);

	public int addHeart(@Param("pnum")Long pnum, @Param("mnum")Long mnum);

	public int findCart(@Param("pnum")Long pnum, @Param("mnum")Long mnum);

	public int findHeart(@Param("pnum")Long pnum, @Param("mnum")Long mnum);

	public int updateHeart(@Param("pnum")Long pnum, @Param("heart")int heart);
	public int getPHeart(@Param("pnum")Long pnum);
	
	public List<CartVO> getCart(Long mnum);
	public int getCartCount(Long mnum);
	public MemberCVO getMem(Long mnum);
	
	public List<CouponVO> getCoupons(Long mnum);
	
	public List<AddressVO> getAddrs(Long mnum);

	public AddressVO getAddr(@Param("mnum")Long mnum, @Param("alias")String alias);

	public void removeCart(@Param("mnum")Long mnum,@Param("pnum")Long pnum);

	public int updateCart(@Param("quantity")int quantity, @Param("pnum")Long pnum, @Param("mnum")Long mnum);

	public int getSumCart(Long mnum);

	public CouponVO getCoupon(Long cnum);

	public List<Long> getHeartList(Long mnum);

	public int isSub(@Param("pnum")Long pnum, @Param("mnum")Long mnum);
	
	//세일 중인 상품 가져오기 
	public ProductVO findSale(ProductVO vo);

}
