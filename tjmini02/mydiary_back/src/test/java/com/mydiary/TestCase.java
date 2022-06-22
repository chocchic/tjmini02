package com.mydiary;

import java.util.List;
import java.util.Properties;
import java.util.stream.IntStream;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;

import com.mydiary.dto.DiaryDTO;
import com.mydiary.model.Diary;
import com.mydiary.model.Member;
import com.mydiary.model.Question;
import com.mydiary.persistence.DiaryRepository;
import com.mydiary.persistence.MemberRepository;
import com.mydiary.persistence.QuerydslRepository;
import com.mydiary.persistence.QuestionRepository;
import com.querydsl.core.Tuple;

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
	
	//@Test
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
	
	
	//@Test
	public void QDSLtest() {
		//d.search();
		Page<Object[]> pages= d.searchPage("tc", "10", PageRequest.of(0, 20, Sort.by("dno").descending()));
		
		for(Object[] obj: pages.getContent()) {
			Diary diary = (Diary) obj[0];
			DiaryDTO diaryDTO = DiaryDTO.builder().dno(diary.getDno()).content(diary.getContent())
					.title(diary.getTitle()).weather(diary.getWeather()).nickname((String) obj[1])
					.regdate(diary.getRegDate()).build();
			System.out.println(diaryDTO);
		}	
	}
	
	@Test
	public void sendTest() {
		System.out.println("start sending...");
		String host = "smtp.naver.com"; // 네이버의 smpt 서버를 사용(2022년 5월 30일부터 구글은 허용안하는 듯 함)
        String user = ""; 
        String password = ""; // 위 아이디로 네이버 로그인시 사용하는 비밀번호

        // SMTP 서버 정보를 설정한다.
        Properties props = new Properties();
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", 587);
        props.put("mail.smtp.auth", "true");
        
        Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(user, password);
            }
        });

        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(user));            //수신자메일주소
            
            // 위에서 아직 메일 쓰지 않은 사람에 대한 이메일 리스트를 뽑았을 때
           // InternetAddress[] addArray = new InternetAddress[emailList.length];
           //
         //   for(int i = 0; i < emailList.length; i++){
		//		addArray[i] = new InternetAddress(emailList.get(i);
		//	}       
			//message.addRecipients(Message.RecipientType.TO, addArray);
            
            message.addRecipient(Message.RecipientType.TO, new InternetAddress("ellena147@naver.com")); 

            // Subject
            message.setSubject("님 일기를 작성하셨나요?");

            // Text
            // 추천 질문을 db로부터 받아서 내용으로 전달
            String Q = ""; //questionService.getQ();
            message.setText("님 오늘하루 어떠셨나요? 오늘 하루를 되돌아 보며 일기를 작성해주세요"+Q); 
            
            // send the message
            Transport.send(message);
            System.out.println("message sent successfully...");
        } catch(Exception e) {
        	e.getLocalizedMessage();
            // TODO Auto-generated catch block
        }
        System.out.println("end sending...");
	}
}
