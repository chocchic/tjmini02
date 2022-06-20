package com.mydiary.service;

import org.springframework.http.ResponseEntity;

import com.mydiary.dto.MemberDTO;

public interface MemberService {

	String registerMember(MemberDTO dto);

	MemberDTO loginMember(MemberDTO dto);

	MemberDTO getMember(MemberDTO dto);

	ResponseEntity<Object> download(String path);

	String deleteMember(MemberDTO dto);

	String updateMember(MemberDTO dto);

}
