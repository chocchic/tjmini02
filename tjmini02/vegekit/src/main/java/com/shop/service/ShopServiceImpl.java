package com.shop.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.domain.ShopVO;
import com.project.domain.ProductVO;
import com.shop.domain.AddressVO;
import com.shop.domain.CartDTO;
import com.shop.domain.CartVO;
import com.shop.domain.CouponVO;
import com.shop.domain.Criteria;
import com.shop.domain.MemberCVO;
import com.shop.domain.QnaVO;
import com.shop.domain.ReviewVO;
import com.shop.mapper.ShopMapper;

@Service
public class ShopServiceImpl implements ShopService {

	@Autowired
	private ShopMapper shopMapper;

	@Override
	public ShopVO get(Long pnum) {
		return shopMapper.read(pnum); 
	}
	
	@Override
	public List<ShopVO> getCateList(Criteria cri) {
		System.out.println("cri : " + cri);
		return shopMapper.getCateListWithPaging(cri);
	}

	@Override
	public int getCateTotal(Criteria cri) {
		return shopMapper.getCateTotalCount(cri);
	}
	

	@Override
	public int getSold(Long pnum) {
		return shopMapper.getSoldCount(pnum);
	}

	@Override
	public List<ReviewVO> getReview(Long pnum) {
		return shopMapper.getReviewList(pnum);
	}

	@Override
	public List<QnaVO> getQna(Long pnum) {
		return shopMapper.getQnaList(pnum);
	}

	@Override
	public int getReviewCount(Long pnum) {
		return shopMapper.getReviewCount(pnum);
	}

	@Override
	public int getQnaCount(Long pnum) {
		return shopMapper.getQnaCount(pnum);
	}

	@Override
	public Long findMnum(String mid) {
		return shopMapper.findMnum(mid);
	}

	@Override
	public int findHeart(Long pnum, Long mnum) {
		return shopMapper.findHeart(pnum, mnum);
	}

	@Override
	public int findCart(Long pnum, Long mnum) {
		return shopMapper.findCart(pnum,mnum);
	}

	@Override
	public int addHeart(Long pnum, Long mnum) {
		int r = shopMapper.addHeart(pnum,mnum);
		int currentheart = shopMapper.getPHeart(pnum);
		shopMapper.updateHeart(pnum, currentheart+1);
		return r;
	}

	@Override
	public int addCart(Long pnum, Long mnum) {
		return shopMapper.addCart(pnum,mnum);
	}

	@Override
	public int removeHeart(Long pnum, Long mnum) {
		int r = shopMapper.removeHeart(pnum,mnum);
		int currentheart = shopMapper.getPHeart(pnum);
		shopMapper.updateHeart(pnum, currentheart-1);
		return r;
	}

	@Override
	public int updateCart(CartDTO cartDTO,Long mnum) {
		return shopMapper.updateCart(cartDTO.getQuantity(), cartDTO.getPnum(),mnum);
	}

	@Override
	public List<CartVO> getCart(Long mnum) {
		return shopMapper.getCart(mnum);
	}

	@Override
	public int getCartCount(Long mnum) {
		return shopMapper.getCartCount(mnum);
	}

	@Override
	public MemberCVO getMem(Long mnum) {
		return shopMapper.getMem(mnum);
	}

	@Override
	public List<CouponVO> getCoupons(Long mnum) {
		return shopMapper.getCoupons(mnum);
	}

	@Override
	public List<AddressVO> getAddrs(Long mnum) {
		return shopMapper.getAddrs(mnum);
	}

	@Override
	public void removeCart(Long mnum, Long pnum) {
		shopMapper.removeCart(mnum, pnum);
		
	}

	@Override
	public AddressVO getAddr(Long mnum, String alias) {
		return shopMapper.getAddr(mnum, alias);
	}

	@Override
	public CouponVO getCoupon(Long cnum) {
		return shopMapper.getCoupon(cnum);
	}

	@Override
	public int getSumCart(Long mnum) {
		return shopMapper.getSumCart(mnum);
	}

	@Override
	public List<Long> getHeart(Long mnum) {
		return shopMapper.getHeartList(mnum);
	}

	@Override
	public boolean is_Sub(Long pnum, Long mnum) {
		if(shopMapper.isSub(pnum,mnum) > 0) {
			return true;
		}
		return false;
	}
	
	//세일 중인 상품 가져오기 
		@Override
		public ProductVO findSale(ProductVO vo) {
			return shopMapper.findSale(vo);
		}


}
