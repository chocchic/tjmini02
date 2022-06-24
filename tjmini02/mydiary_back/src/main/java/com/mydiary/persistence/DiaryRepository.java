package com.mydiary.persistence;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.mydiary.dto.DiaryDTO;
import com.mydiary.model.Diary;
import com.mydiary.model.Member;

public interface DiaryRepository extends JpaRepository<Diary, Long>, QuerydslRepository{
	List<Diary> findItemByMember(Member member);
	//Long findIdByDiary(Diary diary);
	// 목록보기를 위한 메서드 
	/*
	@Query(value="select d.*, m.nickname from Diary d left join Member m On d.member_mno = m.mno where m.mno=:mno")
	Page<Object[]> getDiaryWithNickname(Pageable pageable);
	*/
}
