package com.mydiary.dto;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class DiaryDTO {
	private String error;
	private Long dno;
	private Long member_mno;
	private String title;
	private String content;
	private String nickname;
	private String weather;
	private Integer isSecret;
	private Integer canReply;
	//전송된 파일의 내용을 저장할 속성
	private MultipartFile[] image;
	private LocalDateTime regdate;

	private List<DiaryImgDTO> imagelist;
}
