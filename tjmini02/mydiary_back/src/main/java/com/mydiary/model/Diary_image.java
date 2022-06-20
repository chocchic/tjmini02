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
@ToString
public class Diary_image {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long ino;
	@Column(length=225, nullable = false)
	private String name;
	@Column(length=225, nullable = false)
	private String imageurl;
	
	@ManyToOne(fetch=FetchType.LAZY)
	private Diary diary;
}
