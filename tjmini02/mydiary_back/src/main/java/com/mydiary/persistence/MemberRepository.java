package com.mydiary.persistence;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.mydiary.model.Member;

public interface MemberRepository extends JpaRepository<Member, Long> {
//	@Query("select nickname from member where mno=:mno")
//	String findNicknameById(Long mno);
}