package com.mydiary.service;

import org.springframework.stereotype.Service;

import com.mydiary.dto.DiaryDTO;
import com.mydiary.dto.PageRequestDTO;
import com.mydiary.dto.PageResponseDTO;
import com.mydiary.persistence.DiaryRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class DiaryServiceImpl implements DiaryService{
	private final DiaryRepository diaryRepo;

	@Override
	public PageResponseDTO getList(PageRequestDTO dto) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Long registerDiary(DiaryDTO dto) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public DiaryDTO getDiary(DiaryDTO dto) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Long updateDiary(DiaryDTO dto) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Long deleteDiary(DiaryDTO dto) {
		// TODO Auto-generated method stub
		return null;
	}
	
	
}
