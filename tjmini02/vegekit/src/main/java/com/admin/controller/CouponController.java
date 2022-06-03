package com.admin.controller;


import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.request;

import java.util.ArrayList;
import java.util.List;

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
import com.admin.domain.CouponVO;
import com.admin.domain.PageDTO;
import com.admin.service.CouponService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/vegekit/admin/coupon/*")
@Log4j
public class CouponController {
	
	@Autowired
	private CouponService couponService;
	
	
	
	
	//쿠폰 리스트 출력
	@GetMapping("list") // list 요청시 pageNum, listQty 가 들어와야함.
	public void list(Criteria cri, Model model) {
		
		// 페이징처리 버전!! 
		// 현재 페이지 번호에 따른, 보여줄 글 목록 가져와 view에 전달 
		model.addAttribute("coupon", couponService.getList(cri));
		
		// 전체 쿠폰 개수 가져오고 
		int total = couponService.getTotal(cri); 
		// 화면에 띄워줄 페이지번호등 계산완료된 PageDTO 객체도 view전달 
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		
	}

	// 수정폼 이동
	@GetMapping({"detail","modifyForm"})
	public void content(@RequestParam("cpnum") Long cpnum, @ModelAttribute("cri")Criteria cri, Model model) {
		model.addAttribute("coupon", couponService.get(cpnum)); 
	}
	
	// 수정폼 이동
	@GetMapping("deleteForm")
	public void deleteForm(@RequestParam("cpnum") Long cpnum, @RequestParam("checkedCpnum") String checkedCpnum, @ModelAttribute("cri")Criteria cri, Model model) {
		model.addAttribute("coupon", couponService.get(cpnum)); 
		model.addAttribute("checkedCpnum", checkedCpnum); 
		
	}
	
	// 쿠폰 폼
	@GetMapping("writeForm")
	public void writeForm() {
		
	}
	
	// 쿠폰 등록
	@PostMapping("write")
	public String write(CouponVO coupon) {
		List list = new ArrayList();
		List<CouponVO> realList = new ArrayList<CouponVO>();
		if(coupon.getMtier() == 0) { // 개인한테 보낼경우
			couponService.oneRegister(coupon);
		}else if(coupon.getMtier() == 1){ // 씨앗
			list = couponService.findMnum(1);
		}else if(coupon.getMtier() == 2){ // 새싹
			list = couponService.findMnum(2);
		}else if(coupon.getMtier() == 3){ // 나무
			list = couponService.findMnum(3);
		}else if(coupon.getMtier() == 4){ // 전체
			list = couponService.findMnum(4);
		}

		
		for(int i=0; i < list.size(); i++) {
			realList.add(i, new CouponVO());
			realList.get(i).setMnum(Integer.parseInt((list.get(i).toString().substring(6,list.get(i).toString().length()-1))));
			realList.get(i).setCpname(coupon.getCpname());
			realList.get(i).setCpwon(coupon.getCpwon());

		}
		if(coupon.getMtier() != 0 && list.size() != 0) {
			couponService.multiRegister(realList);
		}
		
		return "redirect:/vegekit/admin/coupon/list";
	}
	
	
	
	
	
	// 삭제
	@PostMapping("delete")
	public String delete(@RequestParam("cpnum") Long cpnum, @RequestParam("checkedCpnum") String checkedCpnum, Criteria cri,
			RedirectAttributes rttr) {
		if(cpnum != null) {
			if(couponService.delete(cpnum)) {
				rttr.addFlashAttribute("result", "success"); 
			}
		}else {
			String chCpNum = checkedCpnum;
			String[] list = chCpNum.split(" ");
			
			for(int i = 0; i < list.length; i++) {
				couponService.delete(Long.parseLong(list[i]));
			}
			rttr.addFlashAttribute("result", "success"); 
		}

		return "redirect:/vegekit/admin/coupon/list" + cri.getParameterLink();
		
	}

	
	
	// 수정
	@PreAuthorize("isAuthenticated()")
	@PostMapping("modify")
	public String modify(CouponVO member, Criteria cri, RedirectAttributes rttr) {
		
		boolean res = couponService.modify(member);
		if(res) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/vegekit/admin/coupon/list" + cri.getParameterLink(); 
	}
	
	
	
	
	
	
}












