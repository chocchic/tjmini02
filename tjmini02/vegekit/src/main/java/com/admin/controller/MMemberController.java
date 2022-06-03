package com.admin.controller;


import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.request;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.admin.domain.Criteria;
import com.admin.domain.MMemberVO;
import com.admin.domain.PageDTO;
import com.admin.service.MMemberService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/vegekit/admin/mMember/*")
@Log4j
public class MMemberController {
	
	@Autowired
	private MMemberService memberService;
	
	
	
	
	//회원 리스트 출력
	@GetMapping("list") // list 요청시 pageNum, listQty 가 들어와야함.
	public void list(Criteria cri, Model model) {
		
		//관리자로 로딩할지...사용자로 로딩할지
		if(cri.getAuth() == null || cri.getAuth().equals("")){
			cri.setAuth("ROLE_MEMBER");
		}
		model.addAttribute("list", memberService.getList(cri));
		
		// 전체 글의 개수 가져오고 
		int total = memberService.getTotal(cri); 
		// 화면에 띄워줄 페이지번호등 계산완료된 PageDTO 객체도 view전달 
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		
	}
	
	// 수정폼 이동
	@GetMapping({"detail","modifyForm", "deleteForm"})
	public void content(@RequestParam("mnum") Long mnum, @ModelAttribute("cri")Criteria cri, Model model) {
		model.addAttribute("member", memberService.get(mnum, cri.getAuth())); 
	}
	
	
	// 삭제
	@PostMapping("delete")
	public String delete(@RequestParam("mnum") Long mnum, Criteria cri,
			RedirectAttributes rttr) {
		if(memberService.delete(mnum)) {
			rttr.addFlashAttribute("result", "success"); 
		}
		return "redirect:/vegekit/admin/mMember/list" + cri.getParameterLink();
	}

	
	
	// 수정
	@PreAuthorize("isAuthenticated()")
	@PostMapping("modify")
	public String modify(MMemberVO member, Criteria cri, RedirectAttributes rttr) {
		
		boolean res = memberService.modify(member);
		if(res) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/vegekit/admin/mMember/list" + cri.getParameterLink(); 
	}
	
	
	// 수정폼 이동
	@GetMapping("authForm")
	public void authForm(@RequestParam("mnum") Long mnum, @RequestParam("auth") String auth, @ModelAttribute("cri")Criteria cri, Model model) {
		
		if(memberService.is_authorize(mnum, "ROLE_ADMIN") > 0) {// 만약 관리자 권한이 있다면...
			model.addAttribute("is_auth", "Y"); 
		}else {
			model.addAttribute("member", memberService.get(mnum, auth)); 
		}
	}
	
	// 관리자 권한 부여
	@PostMapping("auth")
	public String auth(@RequestParam("mnum") Long mnum, @RequestParam("auth") String auth, 
						Criteria cri, RedirectAttributes rttr) {
		
		boolean res = memberService.authorize(mnum, auth);
		if(res) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/vegekit/admin/mMember/list" + cri.getParameterLink(); 
	}
	
	
	
	
	
	
	
	
}












