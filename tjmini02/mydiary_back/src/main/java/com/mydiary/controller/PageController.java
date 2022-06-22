package com.mydiary.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mydiary.dto.DiaryDTO;
import com.mydiary.dto.PageRequestDTO;
import com.mydiary.dto.PageResponseDTO;
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
		model.addAttribute("result", result);
		model.addAttribute("mno", pageRequestDTO.getMno());
	}
	
	@GetMapping({"/mydiary/diary", "/mydiary/modify"})
	public void read(@ModelAttribute("requestDTO")PageRequestDTO pageRequestDTO, Model model, DiaryDTO dto) {
		DiaryDTO diaryDTO = diaryService.getDiary(dto);
		model.addAttribute("dto",diaryDTO);
	}
	
	@GetMapping("/register")
	public void showregisterForm() {
		
	}
}
