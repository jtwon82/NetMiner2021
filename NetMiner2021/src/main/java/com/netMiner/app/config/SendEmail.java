package com.netMiner.app.config;

import java.util.concurrent.ThreadLocalRandom;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.context.annotation.Configuration;

@Configuration
public class SendEmail {
	//인증번호 발송 
	public String sendCheckEmail(String userId) {
		// TODO Auto-generated method stub
		String randomNumber = String.valueOf(this.getRandomNumber());
		String comment = "test 입니다. "+ randomNumber;
		String title = "test";
		boolean result = this.sendMailSender(userId , comment, title);
		
		if (!result) {
			randomNumber = "";
		}
		
		return randomNumber;
	}
	
	//비밀번호재설정을 위한 인증 
	public boolean sendReSetPwd(String url, String userId) {
		
		String title = "비밀번호 재생성";
		String comment = "<a href='"+url+"'>비밀번호 재설정</a>";
			
		boolean result = this.sendMailSender(userId, comment, title);
		
		return result;
		
	}

	//이메일 발송 Sender
	private boolean sendMailSender(String userId, String comment,String title) {
			boolean result = true;
		   String user = "netminer@cyram.com"; // 네이버일 경우 네이버 계정, gmail경우 gmail 계정
	        String password = "dydrkfl2011@";   // 패스워드
	        String host = "smtp.gmail.com";
	        String senderUser = "NetMiner Team <netminer@cyram.com>";
	        // SMTP 서버 정보를 설정한다.
	        Properties prop = new Properties();
//	        prop.put("mail.smtp.host", "smtp.gmail.com"); 
//	        prop.put("mail.smtp.port", 587); 
//	        prop.put("mail.smtp.auth", "true"); 
//	        prop.put("mail.smtp.ssl.enable", "true");
//	        prop.put("mail.smtp.starttls.enable", "true"); 
//	        prop.put("mail.smtp.ssl.trust", "smtp.gmail.com");
//	        
	        
	        prop.put("mail.smtp.host", host); 
	        prop.put("mail.smtp.port", "465"); 
	        prop.put("mail.smtp.starttls.enable","true"); 
	        prop.put("mail.smtp.auth", "true"); 
	        prop.put("mail.smtp.debug", "true"); 
	        prop.put("mail.smtp.socketFactory.port", "465"); 
	        prop.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");  
	        prop.put("mail.smtp.socketFactory.fallback", "false");
	        
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
	            message.setContent(comment,"text/html;charset=UTF-8");
	            
	            // send the message
	            Transport.send(message); ////전송
	            System.out.println("message sent successfully...");
	        } catch (AddressException e) {
	            // TODO Auto-generated catch block
	            e.printStackTrace();
	            result = false;
	        } catch (MessagingException e) {
	            // TODO Auto-generated catch block
	            e.printStackTrace();
	            result = false;
	        }
	        return result;
	
	}
	//인증 번호를 준다 
	private int getRandomNumber() {
		// TODO Auto-generated method stub
		return ThreadLocalRandom.current().nextInt(1000000, 10000000);
	}

}
