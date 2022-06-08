package com.shop.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.common.security.domain.CustomUser;
import com.shop.domain.CartDTO;
import com.shop.service.ShopService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("vegekit/shop/*")
@RequiredArgsConstructor
public class ShopRestController {
	private final ShopService shopService;
	
	@PostMapping("updatecart")
	public ResponseEntity<String> updatecart(@AuthenticationPrincipal CustomUser user, @RequestBody CartDTO cartDTO,Model model) {
		if(user!=null) {
			String mid = user.getUsername();
		    Long mnum = shopService.findMnum(mid);
			if(shopService.updateCart(cartDTO, mnum) > 0) {
				//System.out.println("updated");
				//return "redirect:/vegekit/shop/cart";
				return new ResponseEntity<>("상품이 장바구니에 담겼습니다.", HttpStatus.OK);
			}
			return new ResponseEntity<>("옳지 않은 상품입니다.", HttpStatus.FORBIDDEN);
		}
		return new ResponseEntity<>("옳지 않은 사용자 입니다.", HttpStatus.FORBIDDEN);
		//return "/vegekit/shop/list";
	}
	
	@DeleteMapping("cart/{pnum}")
	public ResponseEntity<String> remove(@PathVariable("pnum")Long pnum, @AuthenticationPrincipal CustomUser user){
	//public String deletecart(Model model, @AuthenticationPrincipal CustomUser user) {
		if(user!=null) {
			String mid = user.getUsername();
		    Long mnum = shopService.findMnum(mid);
			//model.addAttribute("cart", shopService.getCart(mnum));
			shopService.removeCart(mnum, pnum);
		}
		return new ResponseEntity<>("success",HttpStatus.OK);
	}
	
	@GetMapping("addcart")
	public String addCart(@RequestBody CartDTO cartDTO, @RequestParam("url") String url,@AuthenticationPrincipal CustomUser user, RedirectAttributes rttr) {
		if(user != null) {
        	String mid = user.getUsername();
        	Long mnum = shopService.findMnum(mid);
        	if(shopService.findCart(cartDTO.getPnum(),mnum)==1) {
        		shopService.updateCart(cartDTO,mnum);
        		rttr.addFlashAttribute("result", "addCart success");
        	}else {
        		shopService.addCart(cartDTO.getPnum(), mnum);
        		rttr.addFlashAttribute("result", "add to Heart success");
        	}
        }else{
        	rttr.addFlashAttribute("result", "no user info");
        }
        
        rttr.addFlashAttribute("result", "addCart success");
        
        return "redirect:"+url;
    }
	
	@GetMapping("list/addheart")
    public String addHeart(@RequestParam("pnum") Long pnum , @RequestParam("url") String url,@AuthenticationPrincipal CustomUser user, RedirectAttributes rttr) {
        if(user != null) {
        	String mid = user.getUsername();
        	Long mnum = shopService.findMnum(mid);
			//Long mnum = 75L;
        	if(shopService.findHeart(pnum,mnum) > 1) {
        		shopService.removeHeart(pnum,mnum);
        		rttr.addFlashAttribute("result", "remove from Heart success");
        	}else {
        		shopService.addHeart(pnum, mnum);
        		rttr.addFlashAttribute("result", "add to Heart success");
        	}
       }else{
        	rttr.addFlashAttribute("result", "no user info");
       }
        
        return "redirect:"+ url;
    }
}
