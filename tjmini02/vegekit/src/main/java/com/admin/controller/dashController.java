package com.admin.controller;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.admin.domain.AlarmVO;
import com.admin.domain.Criteria;
import com.admin.domain.PageDTO;
import com.admin.service.AlarmService;
import com.admin.service.MMemberService;
import com.member.service.MemberService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/vegekit/admin/dash/*")
@Log4j
public class dashController {
	
	@Autowired
	MMemberService memberService;
	
	@GetMapping("main")
	public void mypage(Criteria cri, Model model) {
		//log.info("대쉬보드 요청!!!");
		//model.addAttribute("list", memberService.getList(cri));
		
		// 전체 글의 개수 가져오고 
		//int total = memberService.getTotal(cri); 
		// 화면에 띄워줄 페이지번호등 계산완료된 PageDTO 객체도 view전달 
		//model.addAttribute("pageMaker", new PageDTO(cri, total));
	} 
	
	

	
	
	
}












