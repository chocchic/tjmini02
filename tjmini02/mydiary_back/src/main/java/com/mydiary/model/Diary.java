package com.mydiary.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;

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
@ToString(exclude="member")
public class Diary extends BaseEntity{
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long dno;
	@Column(length=225, nullable = false)
	private String title;
	@Column(length=2000, nullable = false)
	private String content;
	@Column(length=20)
	private String weather;
	@Column
	private Integer isSecret;
	@Column
	private Integer canReply;
	
	@ManyToOne(fetch=FetchType.LAZY)
	private Member member;
}
