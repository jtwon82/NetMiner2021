package com.netMiner.app.config;

import java.util.concurrent.ThreadLocalRandom;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.eclipse.jdt.internal.compiler.ast.ThisReference;
import org.springframework.context.annotation.Configuration;

@Configuration
public class SendEmail {
	//인증번호 발송 
	public String sendCheckEmail(String userId) {
		// TODO Auto-generated method stub
		String randomNumber = String.valueOf(this.getRandomNumber());
		String comment = "test 입니다. "+ randomNumber;
		String title = "test";
		this.sendMailSender(userId , comment, title);
		return randomNumber;
	}
	//이메일 발송 Sender
	private void sendMailSender(String userId, String comment,String title) {
		   String user = "netminer@cyram.com"; // 네이버일 경우 네이버 계정, gmail경우 gmail 계정
	        String password = "dydrkfl2011@";   // 패스워드
	        
	        String senderUser = "NetMinerTeam@cyram.com";
	        // SMTP 서버 정보를 설정한다.
	        Properties prop = new Properties();
	        prop.put("mail.smtp.host", "smtp.gmail.com"); 
	        prop.put("mail.smtp.port", 465); 
	        prop.put("mail.smtp.auth", "true"); 
	        prop.put("mail.smtp.ssl.enable", "true"); 
	        prop.put("mail.smtp.ssl.trust", "smtp.gmail.com");
	        
	        Session session = Session.getDefaultInstance(prop, new javax.mail.Authenticator() {
	            protected PasswordAuthentication getPasswordAuthentication() {
	                return new PasswordAuthentication(user, password);
	            }
	        });

	        try {
	            MimeMessage message = new MimeMessage(session);
	            message.setFrom(new InternetAddress(senderUser));

	            //수신자메일주소
	            message.addRecipient(Message.RecipientType.TO, new InternetAddress(userId)); 
	            
	            
	            // Subject
	            message.setSubject(title); //메일 제목을 입력

	            // Text
	            message.setText(comment);    //메일 내용을 입력

	            // send the message
	            Transport.send(message); ////전송
	            System.out.println("message sent successfully...");
	        } catch (AddressException e) {
	            // TODO Auto-generated catch block
	            e.printStackTrace();
	        } catch (MessagingException e) {
	            // TODO Auto-generated catch block
	            e.printStackTrace();
	        }
	
	}
	//인증 번호를 준다 
	private int getRandomNumber() {
		// TODO Auto-generated method stub
		return ThreadLocalRandom.current().nextInt(1000000, 10000000);
	}

}
