package com.netMiner.app.config;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.concurrent.ThreadLocalRandom;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;

import com.netMiner.app.model.dao.SelectDao;
import com.netMiner.app.model.vo.BillingVo;
import com.netMiner.app.model.vo.MailVo;

@Configuration
public class SendEmail {
	
	private static final Logger logger = LoggerFactory.getLogger(SendEmail.class);
	
	@Autowired
	private SelectDao selectDao;

	
	//마켓팅 수신 정보동의
	public void sendMarketEmail(String userId, String language , Date marketDate) {
		MailVo vo =  new MailVo();
		String title = "";
		String comment = "";
		SimpleDateFormat form = new SimpleDateFormat("yyyy/MM/dd");
		Calendar cal = Calendar.getInstance();
		cal.setTime(marketDate);
		String date = form.format(cal.getTime());
		if ("_EN".equals(language)) {
			vo = selectDao.getRandomMail("06");
		} else {
			vo = selectDao.getRandomMail("01");
		}
		title = vo.getTitle();
		comment = vo.getComment();
		comment = comment.replace("{YYYY/MM/DD}", date);
		boolean result = this.sendMailSender(userId , comment, title);
		
	}
	
	//비밀번호재설정을 위한 인증 
	public boolean sendReSetPwd(String url, String userId, String language) {
		MailVo vo = new MailVo();
		String emailCode = "";
		if ("_EN".equals(language)) {
			emailCode= "07";
		} else {
			emailCode ="02";
		}
		vo = selectDao.getRandomMail(emailCode);
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("userId", userId);
		param.put("emailCode", emailCode);
		param.put("randomNumber", "");
		selectDao.insertEmailSendLog(param);
		
		String title = vo.getTitle();
		String comment = vo.getComment();
		comment = comment.replace("{changePwd}", url);
		boolean result = this.sendMailSender(userId, comment, title);
		
		return result;
		
	}
	
	//인증번호 발송 
	public String sendCheckEmail(String userId, String language) {
		MailVo vo = new MailVo();
		String emailCode = "";
		if ("_EN".equals(language)) {
			emailCode = "08";
		} else {
			emailCode = "03";
		}
		vo = selectDao.getRandomMail(emailCode);
		String randomNumber = String.valueOf(this.getRandomNumber());
		String comment = vo.getComment();
		comment = comment.replace("{randomNumber}", randomNumber);
		String title = vo.getTitle();
		boolean result = this.sendMailSender(userId , comment, title);
		
		if (!result) {
			randomNumber = "";
		} else {
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("userId", userId);
			param.put("emailCode", emailCode);
			param.put("randomNumber", randomNumber);
			logger.info("param {}", param);
			
			selectDao.insertEmailSendLog(param);
		}
		
		return randomNumber;
	}
		
	//가입 축하 이메일 발송 
	public void sendRegisterMail(String userId, String url, String language) {
		MailVo vo = new MailVo();
		
		if ("_EN".equals(language)) {
			vo = selectDao.getRandomMail("09");
		} else {
			vo = selectDao.getRandomMail("04");
		}		
		String title = vo.getTitle();
		String comment = vo.getComment();
		boolean result = this.sendMailSender(userId , comment, title);
	}
	
	//휴면 유저 이메일 발송 
	public boolean sendDormantUser(String userId, String url, String language) {
		MailVo vo = new MailVo();
		
		if ("en".equals(language)) {
			vo = selectDao.getRandomMail("10");
		} else {
			vo = selectDao.getRandomMail("05");
		}
		Date nowDate = new Date();
		SimpleDateFormat form = new SimpleDateFormat("yyyy/MM/dd");
		Calendar cal = Calendar.getInstance();
		cal.setTime(nowDate);
		cal.add(Calendar.DATE, 30);
		String date = form.format(cal.getTime());
		
		String title = vo.getTitle();
		String comment = vo.getComment();
		comment = comment.replace("{goNetminer}", url);
		comment = comment.replace("{YYYY/MM/DD}", date);
		boolean result = this.sendMailSender(userId , comment, title);
		
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
//        prop.put("mail.smtp.host", "smtp.gmail.com"); 
//        prop.put("mail.smtp.port", 587); 
//        prop.put("mail.smtp.auth", "true"); 
//        prop.put("mail.smtp.ssl.enable", "true");
//        prop.put("mail.smtp.starttls.enable", "true"); 
//        prop.put("mail.smtp.ssl.trust", "smtp.gmail.com");
        
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
        } catch (Exception e) {
        	logger.error("err ", e);
            result = false;
        }
        return result;
	
	}
	//인증 번호를 준다 
	private int getRandomNumber() {
		return ThreadLocalRandom.current().nextInt(1000000, 10000000);
	}

	//플랜 종료 3일전 유저 메일 발송 
	public void sendPayPlanUser(String userId, String language, String endDate) {
		MailVo vo = new MailVo();
		
		if ("ko".equals(language)) {
			vo = selectDao.getRandomMail("11");
		} else {
			vo = selectDao.getRandomMail("12");
		}
		
		String title = vo.getTitle();
		String comment = vo.getComment();
		
		comment = comment.replace("{YYYY/MM/DD}", endDate);
		logger.info("payPlan- {}", vo.toString());
		
		this.sendMailSender(userId, comment, title);
	}
	
	//영문 플랜 계좌 이체시 
	public void sendBankTransfer(String payUserId,BillingVo billingVo) {
		StringBuffer sb = new StringBuffer()
			.append("<html>")
			.append("<head></head>")
			.append("<body>")
			.append("- 회원 ID : ").append(payUserId).append("<br>")
			.append("- 상품명  : ").append(billingVo.getPLAN_NAME()).append("<br>")
			.append("- 구독기간 : ").append(billingVo.getDATE_TYPE().equals("month")? "월": "년").append("<br>")
			.append("- 결제금액 : ").append(" $ ").append(billingVo.getPAY_PRICE()).append("<br>")
			.append("</body>")
			.append("</html>");					
		String title = "해외 계좌이체 주문건";
		
		this.sendMailSender("netminer@cyram.com",sb.toString(), title);
	}

}
