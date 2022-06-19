package com.mydiary.model;

import java.time.LocalDateTime;
import java.time.LocalTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Entity
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Getter
@ToString
public class Member extends BaseEntity{
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long mno;
	@Column(length=225, nullable = false)
	private String email;
	@Column(length=225, nullable = false)
	private String password;
	@Column(length=20, nullable = false)
	private String nickname;
	@Column(length=20)
	private String job;
	@Column
	private Integer age;
	
	private LocalDateTime unlockdate;
	private LocalDateTime lastlogindate;
}