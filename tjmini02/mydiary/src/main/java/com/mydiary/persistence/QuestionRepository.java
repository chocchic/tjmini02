package com.mydiary.persistence;

import org.springframework.data.jpa.repository.JpaRepository;

import com.mydiary.model.Member;
import com.mydiary.model.Question;

public interface QuestionRepository extends JpaRepository<Question,Long> {

}
