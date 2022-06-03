package com.member.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.common.security.domain.CustomUser;
import com.member.domain.MemberVO;
import com.member.service.MemberService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/vegekit/common/*")
@Log4j
public class CommonController {

	@Autowired
	private MemberService memberService; 
	
	@GetMapping("main")
	public void main() {
		log.info("main!!");
	}

	@GetMapping("login")
	public void login(String error, String logout, Model model, HttpServletRequest request) {
		log.info("login form!!!");
		log.info("error : " + error);
		log.info("logout : " + logout);
		
		String referrer = request.getHeader("Referer"); 		
		request.getSession().setAttribute("prevPage", referrer);
		
		
		if(error != null) {
			model.addAttribute("error", "일치하는 회원정보가 없습니다. 다시 한번 확인해주세요."); 
		}
		if(logout != null) {
			model.addAttribute("logout", "Logout!!"); 
		}
		
	}
	
	// 회원가입 폼 
	@GetMapping("signup")
	public void signup() {
		log.info("signup form!!!");
	}
	// 회원가입 처리 
	@PostMapping("signup")
	public String signupPro(String au, MemberVO vo, RedirectAttributes rttr) {
		log.info("signup Pro!!!!");
		log.info("au : " + au);
		
		int result = memberService.addMember(vo); 
		memberService.addAuth(au, vo.getMnum());
		
		if(result == 1) {
			rttr.addFlashAttribute("msg", "success"); 
		}
		
		return "redirect:/vegekit/main";
	}
	
	
	//아이디 중복체크
	@RequestMapping(value = "memberIdChk", method = RequestMethod.POST)
	@ResponseBody
	public String memberIdChkPOST(MemberVO member) {
		String mid=member.getMid();
		int result=memberService.idCheck(mid);
		if(result != 0) {
			
			return "fail";	// 중복 아이디가 존재
			
		} else {
			
			return "success";	// 중복 아이디 x
			
		}
		
	}
	
	@GetMapping("findId")
	public void findId() {
		log.info("findId폼 요청---------");
	}
	
	@PostMapping("findId")
	public String findIdPro(MemberVO param, Model model) {
		String member=memberService.findId(param);
		model.addAttribute("member", member);
		
		return "vegekit/common/findIdPro";
	}
	
	//비번 재설정
	@GetMapping("resetPw")
	public void resetPw() {
		log.info("resetPw 폼 요청!");		
	}
	
	@PostMapping("resetPwPro")
	public String resetPwPro(MemberVO member, Model model) {  
		log.info("resetPw 처리 요청!!");
		
		if(memberService.findPwChk(member)==0) {
			log.info("일치하는 회원정보 없음");
			model.addAttribute("msg", "아이디와 전화번호를 다시 확인해주세요.");
			
			return "/vegekit/common/resetPw";
		}else {
			log.info("resetPro에서 회원정보 일치할 경우---------");
			model.addAttribute("mid", member.getMid());			//resetPwPro 뷰로 mid를 보내줌 -> 뷰에서 name=mid를 찾아 히든으로 changePwPro에 보내줌
			return "/vegekit/common/resetPwPro";
		}
	
	}
	
	@PostMapping("changePwPro")
	public String changePwPro(MemberVO member, RedirectAttributes rttr) {	//resetPwPro에서 mid와 mpw 받을 membervo 객체
		log.info("changePwPro 요청됨-------------");
		log.info("비번 변경할 아이디 : "+member.getMid());
		int result = memberService.resetPw(member);
		log.info("resetPw result결과값 : " + result);
		rttr.addFlashAttribute("result", result);
		
		return "redirect:/vegekit/common/login";
	}
	
	
	// 접근 제한시 처리할 경로 
	@GetMapping("accessError")
	public void accessDenied(Authentication auth, Model model) {
		// 사용자 정보가 필요한경우 Authentication 타입 매개변수 추가 
		log.info("accessDenied : " + auth); 
		
		model.addAttribute("msg", "access denied"); 
	}
	
	
	
	
}
