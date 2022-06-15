package com.mydiary.model;

import java.time.LocalTime;

import javax.persistence.Entity;
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
	private String email;
	private String password;
	private String nickname;
	private String job;
	private Integer age;
	private boolean isLocked;
	private LocalTime unlockDate;
}