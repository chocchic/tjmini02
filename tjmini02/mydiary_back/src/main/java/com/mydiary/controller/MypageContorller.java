package com.mydiary.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mydiary.dto.MemberDTO;
import com.mydiary.dto.ResponseMemberDTO;
import com.mydiary.service.DiaryService;
import com.mydiary.service.MemberService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/mydiary")
@RequiredArgsConstructor
public class MypageContorller {
	private final MemberService memberService;
	
	@PostMapping("/mypage/update")
	public ResponseEntity<?> updateMember(MemberDTO dto){
		ResponseMemberDTO response = null;
		try {
			//데이터 수정 처리
			String email = memberService.updateMember(dto);
			response = ResponseMemberDTO.builder().email(email).build();
		}catch(Exception e) {
			String error = e.getMessage();
			response = ResponseMemberDTO.builder().error(error).build();
		}
		return ResponseEntity.ok().body(response);
	}
	
	@PostMapping("/mypage/delete")
	public ResponseEntity<?> deleteMember(MemberDTO dto){
		ResponseMemberDTO response = null;
		try {
			//데이터 삭제 처리
			String email = memberService.deleteMember(dto);
			response = ResponseMemberDTO.builder().email(email).build();
		}catch(Exception e) {
			String error = e.getMessage();
			response = ResponseMemberDTO.builder().error(error).build();
		}
		return ResponseEntity.ok().body(response);
	}
	
}
