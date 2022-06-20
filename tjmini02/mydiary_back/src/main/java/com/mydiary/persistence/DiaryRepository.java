package com.mydiary.persistence;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.mydiary.model.Diary;
import com.mydiary.model.Member;

public interface DiaryRepository extends JpaRepository<Diary, Long>{
	List<Diary> findItemByMember(Member member);
}
