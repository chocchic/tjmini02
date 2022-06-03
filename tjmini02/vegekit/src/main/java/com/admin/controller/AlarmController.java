package com.admin.controller;


import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

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

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/vegekit/admin/alarm/*")
@Log4j
public class AlarmController {
	
	@Autowired
	private AlarmService alarmService;
	
	//상품 리스트 출력
	@GetMapping("list") // list 요청시 pageNum, listQty 가 들어와야함.
	public void list(Criteria cri, Model model) {

		// 페이징처리 버전!! 
		// 현재 페이지 번호에 따른, 보여줄 글 목록 가져와 view에 전달 
		model.addAttribute("list", alarmService.getList(cri));
		
		// 전체 글의 개수 가져오고 
		int total = alarmService.getTotal(cri); 
		// 화면에 띄워줄 페이지번호등 계산완료된 PageDTO 객체도 view전달 
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		
	}
	
	
	

	
	
	// 알림 등록
	@PostMapping("write")
	public String write(AlarmVO alarm, HttpServletResponse response) throws Exception {
		
		int checkID = alarmService.checkId(alarm.getMid());
		if(alarm.getMtier() == 1) {
			if(checkID < 1) {
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println("<script>alert('아이디를 체크해주세요'); location.href='/vegekit/admin/alarm/writeForm';</script>");
				out.flush();
			}
		}
		List list = new ArrayList();
		List<AlarmVO> realList = new ArrayList<AlarmVO>();
		if(alarm.getMtier() == 0) { // 개인한테 보낼경우
			alarmService.oneRegister(alarm);
		}else if(alarm.getMtier() == 1){ // 씨앗
			list = alarmService.findMnum(1);
		}else if(alarm.getMtier() == 2){ // 새싹
			list = alarmService.findMnum(2);
		}else if(alarm.getMtier() == 3){ // 나무
			list = alarmService.findMnum(3);
		}else if(alarm.getMtier() == 4){ // 전체
			list = alarmService.findMnum(4);
		}

		for(int i=0; i < list.size(); i++) {

			realList.add(i, new AlarmVO());
			realList.get(i).setMnum(Integer.parseInt((list.get(i).toString().substring(6,list.get(i).toString().length()-1))));
			realList.get(i).setAtype(alarm.getAtype());
			realList.get(i).setAcnt(alarm.getAcnt());
			realList.get(i).setIs_read("N");

		}
		if(alarm.getMtier() != 0) {
			alarmService.multiRegister(realList);
		}
		
		return "redirect:/vegekit/admin/alarm/list";
	}
	
	@GetMapping("writeForm")
	public void writeForm(@ModelAttribute("cri")Criteria cri, Model model) {
		
	}
	
	// 수정폼 이동
	@GetMapping({"modifyForm","deleteForm", "detail"})
	public void content(@RequestParam("anum") Long anum, @RequestParam("mnum") Long mnum, @ModelAttribute("cri")Criteria cri, Model model) {
		model.addAttribute("alarm", alarmService.get(anum, mnum)); 
	}
	

	// 알림 수정
	@PostMapping("modify")
	public String modify(AlarmVO alarm, Criteria cri, RedirectAttributes rttr) {
		
		boolean res = alarmService.modify(alarm);
		if(res) {
			rttr.addFlashAttribute("result", "success");
		}
		
		return "redirect:/vegekit/admin/alarm/list" + cri.getParameterLink(); 
	}
	
	@PostMapping("delete")
	public String delete(@RequestParam("anum") Long anum, Criteria cri,
			RedirectAttributes rttr) {
		if(alarmService.delete(anum)) {
			rttr.addFlashAttribute("result", "success"); 
		}
		return "redirect:/vegekit/admin/alarm/list" + cri.getParameterLink();
	}
	
}












