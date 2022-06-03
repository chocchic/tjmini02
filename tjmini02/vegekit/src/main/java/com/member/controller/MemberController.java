package com.member.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.admin.domain.Criteria;
import com.common.security.domain.CustomUser;
import com.member.domain.MaddressVO;
import com.member.domain.MemberVO;
import com.member.domain.RecdVO;
import com.member.domain.SubProdVO;
import com.member.mapper.MemberMapper;
import com.member.service.MemberService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/vegekit/member/*")
@Log4j
public class MemberController {
	   @Autowired
	   private MemberService memberService;
	   
	   @GetMapping("mypage2")
	   public void mypage() {
	      log.info("mypage2 요청!!!");
	   } 
	   
	   
	   @GetMapping("modify")
	   public void modify(Authentication auth, Model model) {
	      log.info("modify폼 요청!!");
	      CustomUser customUser = (CustomUser)auth.getPrincipal();
	      log.info("customUser : " + customUser);
	      MemberVO member = memberService.getMember(customUser.getUsername()); 
	      model.addAttribute("member", member);
	   }
	   @PostMapping("modify")
	   public String modifyPro(@AuthenticationPrincipal CustomUser customUser, MemberVO member, Model model) { // pw, age, email
	      log.info("modify 처리 요청!!");
	      
	      member.setMid(customUser.getUsername());
	      int result = memberService.modifyMember(member); 
	      log.info("result modify : " + result);

	      model.addAttribute("result", result);
	      
	      return "vegekit/member/modifyPro";
	   }
	   
	   @GetMapping("delete")
	   public void delete() {
	      log.info("delete 폼 요청!");
	   }
	   
	   // @AuthenticationPrincipal 어노테이션 사용을 위해서는 servlet-context.xml에 
	   // annotatiion-driven > argument-resolvers > AuthenticationPrincipalArgumentResolver빈으로 추가 
	   @PostMapping("delete")
	   public String deletePro(@AuthenticationPrincipal CustomUser customUser, Authentication auth, MemberVO member, Model model) { // pw 만 넘어옴 
	      log.info("delete 처리 요청!!");
	      member.setMid(customUser.getUsername());
	      System.out.println("member : "+member);
	      int result = memberService.deleteMember(member);
	      log.info("delete result : " + result);
	      model.addAttribute("result", result);
	      
	      return "vegekit/member/deletePro";
	   }
	   
	   //직접 입력한 주소록 조회(리스트로)+주소록 디폴트값 조회
	   @GetMapping("addr")
	   public String viewAddr(Authentication auth, Model model) {
	      CustomUser customUser = (CustomUser)auth.getPrincipal();
	      MemberVO member = memberService.getMember(customUser.getUsername()); 
	      List<MaddressVO> addr=memberService.viewAddr(member.getMnum());
	      
	      MemberVO addrDef= memberService.viewAddrDefault(member.getMnum());
	      
	      model.addAttribute("memberAddr", addr);
	      model.addAttribute("memberAddr2", addrDef);
	      return "vegekit/member/addr";
	   }

	   
	   //직접 입력한 주소록 추가
	   @PostMapping("addr")
	   public String insertAddr(MaddressVO addr) {
	      log.info("컨트롤러 - insertAddr 포스트 요청!!!!!!!!!!");
	      memberService.insertAddr(addr);
	      return "redirect:/vegekit/member/addr";
	   }
	   
	   
	   @GetMapping("viewRecd")
	   public String viewRecd(Authentication auth, Model model) {
	      CustomUser customUser = (CustomUser)auth.getPrincipal();
	      List<RecdVO> recd =memberService.viewRecd(customUser.getUsername());
	      model.addAttribute("memberRecd", recd);
	      
	      MemberVO member=memberService.getMember(customUser.getUsername());
	      List<Integer> result=memberService.viewState(member);
	      model.addAttribute("viewState", result);

	      return "vegekit/member/viewRecd";
	   }
	   

	   //배송상태 변경
	   //@RequestMapping(value = "updateState", method = { RequestMethod.POST }) 
	   @PostMapping("updateState")
	   @ResponseBody
	   public String updateState(int onum, Model model) {
	      Integer res=memberService.updateState(onum);
	      //model.addAttribute("result", res);
	      return res.toString();
	   }
	   
	   //내 구독상품 조회
	   @GetMapping("viewSub")
	   public String viewSub(Authentication auth, Model model) {
	      System.out.println("구독 page 요청!!!!!!11");
	      CustomUser customUser = (CustomUser)auth.getPrincipal();
	      MemberVO member = memberService.getMember(customUser.getUsername()); 
	      List<SubProdVO> sub=memberService.viewSub(member.getMnum());

	      model.addAttribute("memberSub", sub);
	   
	      return "vegekit/member/sub";
	   }
	   
	   @GetMapping("RecdDetail")
	   public String RecdDetail(Integer onum, Authentication auth, Model model) {
	      // db가서 상세 주문 제품내역 가져오기-odnum들고 
	      CustomUser customUser = (CustomUser)auth.getPrincipal();
	      List<RecdVO> recd =memberService.viewRecd(customUser.getUsername());
	      model.addAttribute("memberRecd", recd);

	      return "vegekit/member/RecdDetail";
	      
	   }
	

	   
	
	/*-------------------중현 소스시작 --------------------*/
	//회원 리스트 출력
	@GetMapping("alarmList") // list 요청시 pageNum, listQty 가 들어와야함.
	public void list(Criteria cri, Model model, Authentication auth) {
		CustomUser user =  (CustomUser)auth.getPrincipal();
		MemberVO member = user.getMember();
		//long mnum = member.getMnum();
		
		model.addAttribute("list", memberService.getAlarmList(member.getMnum()));
		//model.addAttribute("list", memberService.getAlarmListWithPaging(mnum, cri));
		
		// 전체 글의 개수 가져오고 
		//int total = memberService.getTotal(cri); 
		// 화면에 띄워줄 페이지번호등 계산완료된 PageDTO 객체도 view전달 
		//model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	// 수정폼 이동
	@GetMapping("alarmDetail")
	public void content(@RequestParam("anum") Long anum, @RequestParam("mnum") Long mnum, @ModelAttribute("cri")Criteria cri, Model model) {
		memberService.updateIsRead(anum);
		model.addAttribute("alarm", memberService.getOneAlarm(anum, mnum));
		
	}
	/*-------------------중현 소스종료 --------------------*/
	
	
}
