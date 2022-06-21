package com.mydiary;

import java.util.stream.IntStream;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.mydiary.model.Diary;
import com.mydiary.model.Member;
import com.mydiary.model.Question;
import com.mydiary.persistence.DiaryRepository;
import com.mydiary.persistence.MemberRepository;
import com.mydiary.persistence.QuestionRepository;

@SpringBootTest
public class TestCase {
	@Autowired
	private MemberRepository m;
	
	//@Test
	public void insertMember() {
		Member member = Member.builder().mno(102L).age(59).job("학생").email("ellena147@naver.com").password("1234").nickname("축축한초코칩").build();
		m.save(member);
	}
	
	//@Test
	public void deleteMember() {
		m.deleteAll();
	}
	
	@Autowired
	private DiaryRepository d;
	
	//@Test
	public void insertDiary() {
		IntStream.rangeClosed(1,100).forEach(i ->{
			Member m = Member.builder().mno(102L).build();
			String weather = "";
			switch(i%4) {
			case 0:
				weather = "맑음";
				break;
			case 1:
				weather = "해가 쨍쨍";
				break;
			case 2:
				weather = "비가 주룩주룩";
				break;
			case 3:
				weather = "강풍!!";
				break;
			case 4:
				weather = "구름이 많음";
				break;
			}
			Diary diary = Diary.builder().title("1231제목_"+i).content("내용\n"+i).weather(weather).member(m).build();
			d.save(diary);
		});
	}
	
	@Autowired
	private QuestionRepository q;
	
	@Test
	public void insertQ() {
		IntStream.rangeClosed(0, 200).forEach(i -> {
			String job = "";
			switch(i%5) {
			case 0:
				job = "학생";
				break;
			case 1:
				job = "주부";
				break;
			case 2:
				job = "직장인";
				break;
			case 3:
				job = "백수";
				break;
			case 4:
				job = "개발자";
				break;
			}
			Question qq = Question.builder().job(job).content("job이 "+ job+"일 때 질문").build();
			q.save(qq);
		});
		IntStream.rangeClosed(1, 210).forEach(i -> {
			int age = ((i%7)+1)*10;
			Question qq = Question.builder().age(age).content("age가 "+age + "일 때 질문").build();
			q.save(qq);
		});
		IntStream.rangeClosed(0, 200).forEach(i -> {
			String job = "";
			int age = 0;
			switch(i%5) {
			case 0:
				job = "학생";
				age = (int) ((Math.random()*3+1)*10);
				break;
			case 1:
				job = "주부";
				age = (int) ((Math.random()*4+2)*10);
				break;
			case 2:
				job = "직장인";
				age = (int) ((Math.random()*3+3)*10);
				break;
			case 3:
				job = "백수";
				age = (int) ((Math.random()*5+1)*10);
				break;
			case 4:
				job = "개발자";
				age = (int) ((Math.random()*6+1)*10);
				break;
			}
			Question qq = Question.builder().age(age).job(job).content("age가"+age+"이고, job이 "+ job+"일 때 질문").build();
			q.save(qq);
		});
	}
}
