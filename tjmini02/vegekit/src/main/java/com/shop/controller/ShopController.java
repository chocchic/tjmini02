package com.shop.controller;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.common.security.domain.CustomUser;
import com.project.domain.ProductVO;
import com.shop.domain.AddressVO;
import com.shop.domain.Criteria;
import com.shop.domain.MemberCVO;
import com.shop.domain.PageDTO;
import com.shop.domain.ShopVO;
import com.shop.service.ShopService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("vegekit/shop/*")
@Log4j
public class ShopController {
	@Autowired
	private ShopService shopService; 
		
	@GetMapping("list") // list 요청시 pageNum, listQty 가 들어와야함.
	public void list(Criteria cri, Model model, @AuthenticationPrincipal CustomUser user) {
		//로그인 했는지 확인하여 하트 눌렀는지 여부 확인할 수 있을만한 값 넘겨주기
		if(user != null) {
			String mid = user.getUsername();
        	Long mnum = shopService.findMnum(mid);
			model.addAttribute("heart", shopService.getHeart(mnum));
			model.addAttribute("cartcount", shopService.getCartCount(mnum));
		}
		//정기구독도 보여줄지 말지
		model.addAttribute("list", shopService.getCateList(cri));
		int total = shopService.getCateTotal(cri);
		
		model.addAttribute("cartcount", 0);
		model.addAttribute("pageMaker", new PageDTO(cri, total));	
	}
	
	@GetMapping("content")
	public void content(@RequestParam("pnum") Long pnum, @ModelAttribute("cri")Criteria cri, @AuthenticationPrincipal CustomUser user, Model model) {
		model.addAttribute("shop", shopService.get(pnum));
		System.out.println("!!!!shop content : " + shopService.get(pnum));
		model.addAttribute("sold", shopService.getSold(pnum));
		model.addAttribute("reviewcount", shopService.getReviewCount(pnum));
		model.addAttribute("reviewlist",shopService.getReview(pnum));
		model.addAttribute("qnacount", shopService.getQnaCount(pnum));
		model.addAttribute("qnalistt",shopService.getQna(pnum));
	}
	
	@GetMapping("cart")
	public String cart(@AuthenticationPrincipal CustomUser user, Model model, RedirectAttributes rttr) {
		if(user!=null) {
			String mid = user.getUsername();
		    Long mnum = shopService.findMnum(mid);
			model.addAttribute("cart", shopService.getCart(mnum));
			model.addAttribute("member", shopService.getMem(mnum));
			model.addAttribute("coupon",shopService.getCoupons(mnum));
			model.addAttribute("addrs",shopService.getAddrs(mnum));
			return "vegekit/shop/cart";
		}
		rttr.addFlashAttribute("result", "no user info");
		return "vegekit/shop/list";
	}
	
	
	@GetMapping("order") // cpnum=0&is_default=Y&mnum=75&alias=
	public void checkout(@RequestParam("cpnum")Long cnum,@RequestParam("is_default") String is_default,@RequestParam("alias")String alias, @AuthenticationPrincipal CustomUser user, Model model) {
		if(user != null) {
			String mid = user.getUsername();
			Long mnum = shopService.findMnum(mid);
			MemberCVO vo = shopService.getMem(mnum);			
			if(is_default.equals("N")) {
				AddressVO avo = shopService.getAddr(mnum, alias);
				vo.setMname(avo.getRep());
				vo.setMpnum(avo.getPnum());
				vo.setMtel(avo.getReptel());
				vo.setMaddr(avo.getAddr());
			}	
			model.addAttribute("member", vo);
			model.addAttribute("coupon",shopService.getCoupon(cnum));
			model.addAttribute("total",shopService.getSumCart(mnum));
		}
	}
	
	@GetMapping("subcart")
	public String subcart(@AuthenticationPrincipal CustomUser user, @RequestParam("pnum")Long pnum, @RequestParam("amount")int q, Model model, RedirectAttributes rttr) {
		if(user!=null) {
			String mid = user.getUsername();
		    Long mnum = shopService.findMnum(mid);
		    if(shopService.is_Sub(pnum, mnum)) {
		    	rttr.addFlashAttribute("result","이미 구독중인 상품입니다. 결제 정보를 바꾸시려면 마이페이지에서 취소후 다시 하시길 바랍니다.");
		    	return "/vegekit/shop/list";
		    }
			model.addAttribute("product", shopService.get(pnum));
			model.addAttribute("member", shopService.getMem(mnum));
			model.addAttribute("addrs",shopService.getAddrs(mnum));
			model.addAttribute("quantity", q);
			return "/vegekit/shop/subcart";
		}
		rttr.addFlashAttribute("result", "no user info");
		return "vegekit/shop/list";
	}
	
	
	//세일 중인 상품 하나 가져오기
	@GetMapping("saleproduct")
	public String saleproduct(ProductVO vo) {
		ProductVO pvo = shopService.findSale(vo);
		long pnum = pvo.getPnum();
		System.out.println("!!!!!!!!!!!!!!!!!!pnum " +pnum);
		return "redirect:/vegekit/shop/content?pnum="+ pnum;
	}


	@PostMapping("suborder") // cpnum=0&is_default=Y&mnum=75&alias=
	public void subcheckout(@RequestParam("pnum")Long pnum, @RequestParam("quantity")int quantity,
			@RequestParam("is_default") String is_default,@RequestParam("alias")String alias, @AuthenticationPrincipal CustomUser user, Model model) {
		if(user != null) {
			String mid = user.getUsername();
			Long mnum = shopService.findMnum(mid);
			MemberCVO vo = shopService.getMem(mnum);			
			if(is_default.equals("N")) {
				AddressVO avo = shopService.getAddr(mnum, alias);
				vo.setMname(avo.getRep());
				vo.setMpnum(avo.getPnum());
				vo.setMtel(avo.getReptel());
				vo.setMaddr(avo.getAddr());
			}	
			ShopVO product = shopService.get(pnum);
			model.addAttribute("member", vo);
			model.addAttribute("quantity", quantity);
			model.addAttribute("pname",product.getPname());
			model.addAttribute("pnum", product.getPnum());
			model.addAttribute("total", product.getPprice() * quantity);
		}
	}
}
