package com.admin.controller;


import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.request;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.admin.domain.Criteria;
import com.admin.domain.OrderVO;
import com.admin.domain.PageDTO;
import com.admin.service.OrderService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/vegekit/admin/order/*")
@Log4j
public class OrderController {
	
	@Autowired
	private OrderService orderService;
	
	
	
	
	//리스트 출력
	@GetMapping("list") // list 요청시 pageNum, listQty 가 들어와야함.
	public void list(Criteria cri, Model model) {
		if(cri.getType() != null) {
			System.out.println(cri.getType());
			if(cri.getType().equals("S")) {
				if(cri.getKeyword().equals("배송준비")) {
					cri.setKeyword("0");
				}else if(cri.getKeyword().equals("배송중")) {
					cri.setKeyword("1");
				}else if(cri.getKeyword().equals("배송완료")) {
					cri.setKeyword("2");
				}
			}
		}
		// 현재 페이지 번호에 따른, 보여줄 글 목록 가져와 view에 전달 
		model.addAttribute("order", orderService.getList(cri));
		
		// 전체 쿠폰 개수 가져오고 
		int total = orderService.getTotal(cri); 
		// 화면에 띄워줄 페이지번호등 계산완료된 PageDTO 객체도 view전달 
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		
	}

	// 수정폼 이동
	@GetMapping({"detail","modifyForm","updateForm"})
	public void content(@RequestParam("onum") Long onum, @ModelAttribute("cri")Criteria cri, Model model) {
		
		model.addAttribute("order", orderService.get(onum)); 
	}
	
	// 수정폼 이동
	@GetMapping("deleteForm")
	public void deleteForm(@RequestParam("cpnum") Long cpnum, @RequestParam("checkedCpnum") String checkedCpnum, @ModelAttribute("cri")Criteria cri, Model model) {
		model.addAttribute("order", orderService.get(cpnum)); 
		model.addAttribute("checkedCpnum", checkedCpnum); 
		
	}
	
	// 쿠폰 폼
	@GetMapping("writeForm")
	public void writeForm() {
		
	}
	
	// 쿠폰 등록
	@PostMapping("write")
	public String write(OrderVO order) {
		List list = new ArrayList();
		List<OrderVO> realList = new ArrayList<OrderVO>();
		
		
		return "redirect:/vegekit/admin/order/list";
	}
	
	
	
	
	
	// 삭제
	@PostMapping("delete")
	public String delete(@RequestParam("cpnum") Long cpnum, @RequestParam("checkedCpnum") String checkedCpnum, Criteria cri,
			RedirectAttributes rttr) {
		if(cpnum != null) {
			if(orderService.delete(cpnum)) {
				rttr.addFlashAttribute("result", "success"); 
			}
		}else {
			String chCpNum = checkedCpnum;
			String[] list = chCpNum.split(" ");
			
			for(int i = 0; i < list.length; i++) {
				orderService.delete(Long.parseLong(list[i]));
			}
			rttr.addFlashAttribute("result", "success"); 
		}

		return "redirect:/vegekit/admin/order/list" + cri.getParameterLink();
		
	}

	
	
	// 수정
	@PostMapping("modify")
	public String modify(OrderVO order, Criteria cri, RedirectAttributes rttr) {
		boolean res = orderService.modify(order);
		if(res) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/vegekit/admin/order/list" + cri.getParameterLink(); 
	}
	
	
	
	
	
	
}












