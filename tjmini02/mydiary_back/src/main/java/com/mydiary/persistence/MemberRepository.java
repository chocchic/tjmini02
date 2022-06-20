package com.mydiary.persistence;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.mydiary.model.Member;

public interface MemberRepository extends JpaRepository<Member, Long> {
	List<Member> findMemberByNickname(String nickname);
}