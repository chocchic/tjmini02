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
	private final MemberService memberService;
	
	@GetMapping("/home")
	public String showhome(PageRequestDTO dto, Model model) {
		model.addAttribute("result",diaryService.getList(dto));
		return "/mydiary/list";
	}
	
	//페이지 단위로 데이터 가져오기 -> 새로고침 필요할 때 호출
	@GetMapping("/getlist")
	public ResponseEntity<?> getList(PageRequestDTO dto){
		//Security 연결시 바꾸기 dto에 mno담아서 전달
		//Long mno = memberService.getMno();
		PageResponseDTO response = null;
		try {
			response = diaryService.getList(dto);
		}catch(Exception e) {
			response = new PageResponseDTO();
			response.setError(e.getMessage());
		}
		return ResponseEntity.ok().body(response);
	}
	
	// 다이어리 입력 폼으로 이동
	
	
	//데이터 삽입
	@PostMapping("/register")
	public ResponseEntity<?> registerItem(DiaryDTO dto){
		DiaryDTO response = null;
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
