package com.project.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.common.security.domain.CustomUser;
import com.member.domain.MemberVO;
import com.project.domain.ProductVO;
import com.project.service.SelectedService;

@Controller
@RequestMapping("/vegekit/*")
public class SelectedController {
	@Autowired
	private SelectedService selectedS;
	
	@GetMapping("main")
	public void main() {
		System.out.println("******main*******");
	}
	
	// select ajax 요청 
	@GetMapping("select")
	public ResponseEntity<List<ProductVO>> select(Model model) {
		System.out.println("select!!!!!!!!!");
		//model.addAttribute("recommList",selectedS.likeSelect());
		List<ProductVO> list = selectedS.likeSelect();
		System.out.println(list);
		return new ResponseEntity<List<ProductVO>>(list, HttpStatus.OK);
	}
	
	// ajax 요청 
	@GetMapping("nuselect")
	public ResponseEntity<List<ProductVO>> nuSelect(Model model,Authentication auth) { 
		System.out.println("nuselect!!!!!!!!!");
		
		List<ProductVO> list = null; 
		if (isAuthenticated()) {
			CustomUser user = (CustomUser)auth.getPrincipal();
			MemberVO member = user.getMember();
			list = selectedS.getMemRecomm(member.getMnum()); //시큐리티로 mnum 뽑아오기. list = selectedS.getRecommProd(Integer mnum); 일단 테스트는 내가 mnum값 넣기.
			System.out.println("login if list: " + list);
	    }
		//로그인안했거나, 로그인했지만 영양소 체크 안했을때(list가 여기까지 null상태이면) 
		if(list == null) {
			list = selectedS.getStarProd(); 
			System.out.println("null일때 list: " + list);
		}
		
		return new ResponseEntity<List<ProductVO>>(list, HttpStatus.OK);
	}
	
	private boolean isAuthenticated() { //로그인 됐는지 여부 트루 폴스로 리턴해준다. 
	    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    if (authentication == null || AnonymousAuthenticationToken.class.
	      isAssignableFrom(authentication.getClass())) {
	        return false;
	    }
	    return authentication.isAuthenticated();
	}



}
