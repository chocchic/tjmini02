package com.mydiary.persistence;

import org.springframework.data.jpa.repository.JpaRepository;

import com.mydiary.model.Diary;

public interface DiaryRepository extends JpaRepository<Diary, Long>{

}
