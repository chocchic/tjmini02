package com.mydiary.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Locale;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mydiary.dto.DiaryDTO;
import com.mydiary.dto.PageRequestDTO;
import com.mydiary.dto.PageResponseDTO;
import com.mydiary.model.Question;
import com.mydiary.service.DiaryService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Log4j2
@RequestMapping("/mydiary")
@Controller
@RequiredArgsConstructor
public class PageController {
	private final DiaryService diaryService;
	
	@GetMapping("/main")
	public void showMain() {
		
	}
	
	@GetMapping("/home")
	public void showhome(PageRequestDTO pageRequestDTO, Model model) {
		PageResponseDTO result = diaryService.getList(pageRequestDTO);
		model.addAttribute("q", diaryService.getQ());
		model.addAttribute("result", result);
		model.addAttribute("mno", pageRequestDTO.getMno());
	}
	
	@GetMapping({"/diary", "/modify"})
	public void read(@RequestParam("dno")Long dno, @RequestParam("regdate")String regdate, 
			@RequestParam("mno")Long mno, @ModelAttribute("requestDTO")PageRequestDTO pageRequestDTO,
			Model model) {
		LocalDateTime rregdate = LocalDateTime.parse(regdate); // ISO양식으로 받아온 date를 Localdatetime으로 파싱
		DiaryDTO dto = DiaryDTO.builder().dno(dno).regdate(rregdate).member_mno(mno).build();
		DiaryDTO prevdiaryDTO = diaryService.getPrevDiary(dto);
		DiaryDTO nextdiaryDTO = diaryService.getNextDiary(dto);
		DiaryDTO diaryDTO = diaryService.getDiary(dto);
		
		model.addAttribute("dto",diaryDTO);
		model.addAttribute("nextdto", nextdiaryDTO);
		model.addAttribute("prevdto", prevdiaryDTO);
		model.addAttribute("mno", mno);
	}

	@GetMapping("/register")
	public void showregisterForm(Model model) {
		model.addAttribute("q", diaryService.getQ());
		model.addAttribute("mno", 101L);
	}
	
	//데이터 삽입
	@PostMapping("/register")
	public String registerItem(DiaryDTO dto, RedirectAttributes rAttr){
		Long dno = -1L;
		try {
			dno = diaryService.registerDiary(dto);
		}catch(Exception e) {
			e.getLocalizedMessage();
		}
		rAttr.addAttribute("dno",dno);
		return "redirect:/mydiary/home";
	}
	
	@PostMapping("/remove")
	public String remove(Long dno) {
		diaryService.deleteDiary(dno);
		return "redirect:/mydiary/home";
	}
	
	@PostMapping("/modify")
	// 수정은 이전에 보고있던 목록보기로 돌아갈 수있어야하기 때문에 목록 보기에 필요한 데이터가 필요합니다.
	public String modify(DiaryDTO dto, @ModelAttribute("requestDTO")PageRequestDTO pageRequestDTO,
			RedirectAttributes rAttr) {
		System.out.println("일기수정 : "+dto);
		diaryService.updateDiary(dto);
		
		rAttr.addAttribute("page", pageRequestDTO.getPage());
		rAttr.addAttribute("type", pageRequestDTO.getType());
		rAttr.addAttribute("keyword", pageRequestDTO.getKeyword());
//		rAttr.addAttribute("dno", dto.getDno());
//		rAttr.addAttribute("regdate", dto.getRegdate());
//		rAttr.addAttribute("mno",dto.getMember_mno());
		
		return "redirect:/mydiary/home";
	}
}
