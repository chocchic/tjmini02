package com.mydiary.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mydiary.dto.MemberDTO;
import com.mydiary.dto.ResponseMemberDTO;
import com.mydiary.service.MemberService;

@RestController
@RequestMapping("/mydiary")
public class MainController {
	@Autowired
	private MemberService memberService;
	
	@GetMapping("/main")
	public void showMain() {}
	
	@PostMapping("/register")
	public ResponseEntity<?> registerMember(MemberDTO dto){
		// 시큐리티 연결시 수정
		ResponseMemberDTO response = null;
		try {
			//데이터 삽입 처리
			String email = memberService.registerMember(dto);
			// member_auth에 일반 유저로 등록
			response = ResponseMemberDTO.builder().email(email).build();
		}catch(Exception e) {
			String error = e.getMessage();
			response = ResponseMemberDTO.builder().error(error).build();
		}
		return ResponseEntity.ok().body(response);
	}
	
	@PostMapping("/login")
	public ResponseEntity<?> loginMember(MemberDTO dto){
		// 시큐리티 연결시 수정
		ResponseMemberDTO response = null;
		try {
			//로그인 처리
			MemberDTO result = memberService.loginMember(dto);
			if(result == null) {
				response = ResponseMemberDTO.builder()
						.error("없는 이메일이나 잘못된 비밀번호입니다.").build();
			}else {
				response = ResponseMemberDTO.builder()
						.email(result.getEmail())
						.name(result.getName())
						.imageurl(result.getImageurl())
						.regdate(result.getRegdate())
						.moddate(result.getModdate())
						.lastlogindate(result.getLastlogindate())
						.build();
			}
		}catch(Exception e) {
			String error = e.getMessage();
			response = ResponseMemberDTO.builder().error(error).build();
		}
		return ResponseEntity.ok().body(response);
	}
	@PostMapping("/logout")
	public ResponseEntity<?> logoutMember(MemberDTO dto){
		// 시큐리티 연결시 수정
		return null;
	}
	
	@GetMapping("/get")
	public ResponseEntity<?> getMember(MemberDTO dto){
		ResponseMemberDTO response = null;
		try {
			//회원 정보 가져오기
			MemberDTO result = memberService.getMember(dto);
			if(result == null) {
				response = ResponseMemberDTO.builder()
						.error("없는 이메일입니다.").build();
			}else {
				response = ResponseMemberDTO.builder()
						.email(result.getEmail())
						.name(result.getName())
						.imageurl(result.getImageurl())
						.regdate(result.getRegdate())
						.moddate(result.getModdate())
						.lastlogindate(result.getLastlogindate())
						.build();
			}
		}catch(Exception e) {
			String error = e.getMessage();
			response = ResponseMemberDTO.builder().error(error).build();
		}
		return ResponseEntity.ok().body(response);
	}
}