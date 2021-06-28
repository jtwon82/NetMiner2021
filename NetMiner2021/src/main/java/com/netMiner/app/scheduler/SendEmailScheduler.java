package com.netMiner.app.scheduler;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.netMiner.app.config.SendEmail;
import com.netMiner.app.model.dao.MemberDao;

@Component
public class SendEmailScheduler {
	private static final Logger logger = LoggerFactory.getLogger(SendEmailScheduler.class);
	
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private SendEmail sendEmail;
	
	// 매일 9시 마지막 로그인 시간이 1년이 된 사용자에게 메일을 전송한다. 
	//@Scheduled(cron="* * 9 * * *")
	public void sendEmail() {
		logger.info("send Email 365 User");
	}
	
	//temp 데이터 30분이상 지난 데이터는 삭제한다
	//@Scheduled(cron="* * * * * *")
	public void dropTempUser() {
		
		memberDao.dropTempUser();
	}
}
