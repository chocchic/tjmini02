package com.mydiary.persistence;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.mydiary.model.Diary;
import com.mydiary.model.Diary_image;

public interface DiaryImgRepository extends JpaRepository<Diary_image, Long>{
	List<Diary_image> findDiary_imageByDiary(Diary diary);
}
