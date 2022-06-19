package com.mydiary.persistence;

import org.springframework.data.jpa.repository.JpaRepository;

import com.mydiary.model.Member;

public interface MemberRepository extends JpaRepository<Member, Long> {
	
}