package com.mydiary.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mydiary.dto.DiaryDTO;
import com.mydiary.dto.MemberDTO;
import com.mydiary.dto.PageRequestDTO;
import com.mydiary.dto.PageResponseDTO;
import com.mydiary.service.DiaryService;
import com.mydiary.service.MemberService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/mydiary")
@RequiredArgsConstructor
public class DiaryController {
	private final DiaryService diaryService;
	//private final MemberService memberService;
	
	//데이터 삽입
	@PostMapping("/register")
	public ResponseEntity<?> registerItem(DiaryDTO dto){
		DiaryDTO response = null;
		System.out.println("regi:"+dto);
		try {
			Long dno = diaryService.registerDiary(dto);
			response = DiaryDTO.builder().dno(dno).build();
		}catch(Exception e) {
			response = DiaryDTO.builder().error(e.getMessage()).build();
		}
		
		return ResponseEntity.ok().body(response);
	}
	
	//데이터 1개 가져오기
	@GetMapping("get")
	public ResponseEntity<?> getItem(DiaryDTO dto){
		DiaryDTO response = null;
		try {
			response = diaryService.getDiary(dto);
		}catch(Exception e) {
			response = DiaryDTO.builder().error(e.getMessage()).build();
		}
		
		return ResponseEntity.ok().body(response);
	}
	
	//데이터 삭제
	@PostMapping("delete")
	public ResponseEntity<?> deleteItem(DiaryDTO dto){
		DiaryDTO response = null;
		try {
			Long dno = diaryService.deleteDiary(dto);
			response = DiaryDTO.builder().dno(dno).build();
		}catch(Exception e) {
			response = DiaryDTO.builder().error(e.getMessage()).build();
		}
		
		return ResponseEntity.ok().body(response);
	}
		
}
