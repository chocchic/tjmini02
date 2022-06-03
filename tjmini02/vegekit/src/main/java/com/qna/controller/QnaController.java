package com.qna.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.common.security.domain.CustomUser;
import com.member.domain.MemberVO;
import com.qna.domain.QnaVO;
import com.qna.service.QnaService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/vegekit/qna/*")
@Log4j
public class QnaController { //사용자쪽 문의 
	@Autowired
	private QnaService qnaS;
	
	//문의 작성 (사용자)
	@GetMapping("write")
	public void write(Authentication auth, @RequestParam("pnum") Integer pnum,Model model) {
		System.out.println("pnum writeform: " + pnum);
		model.addAttribute("pnum", pnum);
		CustomUser user = (CustomUser)auth.getPrincipal();
		MemberVO member = user.getMember();
		model.addAttribute("mnum", member.getMnum());
		System.out.println("write get 요청 "); 
	}
	
	@PostMapping("write")
	public String writePro(QnaVO vo, Model model) { //
		log.info(vo);
		qnaS.register(vo);
		return "redirect:/vegekit/qna/list"; //마이페이지 상품 문의 내역으로 리다이렉
	}
	
	//나의 문의 리스트
	@GetMapping("list")
	public void list(QnaVO vo, Model model, Authentication auth) {
		CustomUser user = (CustomUser)auth.getPrincipal();
		MemberVO member = user.getMember();
		model.addAttribute("list", qnaS.getList(member.getMnum()));
	}
	
	//문의 보기(본문), 수정, 삭제 
	@GetMapping({"content","modify","delete"})
	public void content(@RequestParam("qnum") Integer qnum, Model model) {
		model.addAttribute("qna",qnaS.get(qnum));
	}
	
	//문의 수정
	@PostMapping("modify")
	public String modify(QnaVO vo) {
		qnaS.modify(vo);
		return "redirect:/vegekit/qna/list";
	}
	
	//문의 삭제
	@PostMapping("delete")
	public String delete(@RequestParam("qnum") Integer qnum,RedirectAttributes rttr) {
		qnaS.remove(qnum);
		rttr.addFlashAttribute("result","delete success");
		return "redirect:/vegekit/qna/list"; //파일 연결하면 마이페이지 문의 내역으로 리다이렉트 해주기 
	}
		

	
	
	

}
