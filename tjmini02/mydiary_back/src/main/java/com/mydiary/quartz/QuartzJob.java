package com.mydiary.quartz;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.stereotype.Component;

import lombok.extern.log4j.Log4j2;

@Log4j2
//@Component
public class QuartzJob implements Job{

	@Override
	public void execute(JobExecutionContext context) throws JobExecutionException {
		// 오후 9시가 되면 db에서 당일 일기를 한 편도 쓰지 않은 사람의 닉네임과 이메일을 검색
		// List<String[]> emailList = memberService.getNotYet();
		System.out.println("스케줄링되는 중");
		
		String host = "smtp.naver.com"; // 네이버의 smpt 서버를 사용(2022년 5월 30일부터 구글은 허용안하는 듯 함)
        String user = "zjavbxu9900@naver.com"; 
        String password = "보안상 지우고 git에 올립니다"; // 위 아이디로 네이버 로그인시 사용하는 비밀번호

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
		//		addArray[i] = new InternetAddress(emailList.get(i)[0]);
		//	}       
			//message.addRecipients(Message.RecipientType.TO, addArray);
            
            message.addRecipient(Message.RecipientType.TO, new InternetAddress("ellena147@naver.com")); 

            // Subject
            message.setSubject("님 메일을 작성하셨나요?");

            // Text
            // 추천 질문을 db로부터 받아서 내용으로 전달
            String Q = ""; //questionService.getQ();
            message.setText("님 오늘하루 어떠셨나요? 오늘 하루를 되돌아 보며 일기를 작성해주세요"+Q); 
            
            // send the message
            Transport.send(message);
            System.out.println("message sent successfully...");
        } catch (AddressException e) {
        	log.error("주소 에러 : ",e.getLocalizedMessage());
        } catch (MessagingException e) {
        	log.error("메세징 에러 : ", e.getLocalizedMessage());
        }
	}
}