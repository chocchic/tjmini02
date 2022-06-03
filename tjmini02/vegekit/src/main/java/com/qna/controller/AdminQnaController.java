package com.qna.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.qna.domain.QnaVO;
import com.qna.service.AdminQnaService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/vegekit/adminQna/*")
@Log4j
public class AdminQnaController {
	@Autowired 
	private AdminQnaService adminQnaS;

	//모든 문의 보기
	@GetMapping("list")
	public void list(Model model) {
		model.addAttribute("list", adminQnaS.getList());
	}
	
	//문의 본문 보기 
	@GetMapping({"content","write"})
	public void content(@RequestParam("qnum") Integer qnum, Model model) {
		model.addAttribute("qna",adminQnaS.get(qnum));
		log.info(qnum);
	}
	
	//답변 등록 
	@PostMapping("write")
	public String modify(QnaVO vo) {
		adminQnaS.writeReply(vo);
		return "redirect:/vegekit/adminQna/list";
	
	}
}
