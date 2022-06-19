package com.mydiary.service;

import com.mydiary.dto.DiaryDTO;
import com.mydiary.dto.PageRequestDTO;
import com.mydiary.dto.PageResponseDTO;
import com.mydiary.model.Diary;
import com.mydiary.model.Member;

public interface DiaryService {
	
	//일기 등록
	public Long registerDiary(DiaryDTO dto);
	//하나의 아이템 가져오기
	public DiaryDTO getDiary(DiaryDTO dto);
	//아이템 수정
	public Long updateDiary(DiaryDTO dto);
	//아이템 삭제
	public Long deleteDiary(DiaryDTO dto);
	//페이지 단위로 데이터를 가져오기
	public PageResponseDTO getList(PageRequestDTO dto);

	//DTO를 ENTITY로 변환해주는 메서드
	public default Diary dtoToEntity(DiaryDTO dto) {
		Diary item = Diary.builder().dno(dto.getDno()).title(dto.getTitle()).content(dto.getContent())
				.member(Member.builder().nickname(dto.getNickname()).build()).build();
		return item;
				
	}
	
	//Entity를 DTO로 변환해주는 메서드
	public default DiaryDTO entityToDto(Diary item) {
		DiaryDTO dto = DiaryDTO.builder().title(item.getTitle()).content(item.getContent())
				.nickname(item.getMember().getNickname()).build();
		return dto;
	}
	

}