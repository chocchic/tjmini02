package com.mydiary.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mydiary.dto.PageRequestDTO;
import com.mydiary.service.DiaryService;

import lombok.RequiredArgsConstructor;

@RequestMapping("/mydiary")
@Controller
@RequiredArgsConstructor
public class PageController {
	private final DiaryService diaryService;
	
	@GetMapping("/main")
	public void showMain() {
		
	}
	
	@GetMapping("/home")
	public void showhome(PageRequestDTO dto, Model model) {
		model.addAttribute("result",diaryService.getList(dto));
		model.addAttribute("mno", dto.getMno());
	}
	
	@GetMapping("/register")
	public void showregisterForm() {
		
	}
}
