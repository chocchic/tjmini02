package com.mydiary.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.mydiary.dto.DiaryDTO;
import com.mydiary.dto.DiaryImgDTO;
import com.mydiary.dto.MemberDTO;
import com.mydiary.dto.PageRequestDTO;
import com.mydiary.dto.PageResponseDTO;
import com.mydiary.model.Diary_image;
import com.mydiary.persistence.DiaryImgRepository;
import com.mydiary.service.DiaryService;
import com.mydiary.service.MemberService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/mydiary")
@RequiredArgsConstructor
public class DiaryController {
	private final DiaryService diaryService;
	
	//private final MemberService memberService;
	//데이터 1개 가져오기 -> 이전 일기 또는 다음 일기 읽기
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
	
	@PostMapping("deletepicture")
	public String delPic(@RequestParam("ino")Long ino){
		return diaryService.deletepicture(ino);
	}
	
	@GetMapping("newQ")
	public String getQ() {
		return diaryService.getQ();
	}
}
