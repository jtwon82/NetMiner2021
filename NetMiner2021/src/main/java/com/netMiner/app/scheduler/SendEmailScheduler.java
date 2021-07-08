package com.netMiner.app.scheduler;

import java.util.List;
import java.util.Map;

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
	//@Scheduled(cron="0 37 20 * * *")
	@Scheduled(cron="0 0 9 * * *")
	public void sendEmail() {
		logger.info("Dormant User ");
		// 휴면 유저 이메일 전송 
		List<Map<String , Object>> member = memberDao.getLastLoginFerYear();
		
		for(int i = 0 ; i < member.size() ;  i ++) {
			Map<String , Object> userInfo = member.get(i);
			String userId = (String) userInfo.get("USER_ID");
			String language = (String) userInfo.get("LANGUAGE");
			String url = "";
			if ("en".equals(language)) {
				url = "https://www.netminer365.com/activate?language='_EN'";
			} else {
				url = "https://www.netminer365.com/activate";
			}
			boolean result= sendEmail.sendDormantUser(userId, url, language);
			if (result) {
				memberDao.changeMemberState(userId);
			} else {
				logger.info("SendMail Fail");
			}
		}
		// 휴면유저 30일 이후 해당 유저 탈퇴 여부 변경 
		memberDao.getPassByDormant();
	}
	
	//광고 동의 2년 주기로 메일 보내기 
	@Scheduled(cron="0 10 9 * * *")
	//@Scheduled(cron="0 37 20 * * *")
	public void sendMarketYnUser() {
		
		List<Map<String , Object>> member = memberDao.getMarketYnUser();
		
		for(int i = 0 ; i < member.size() ;  i ++) {
			Map<String , Object> userInfo = member.get(i);
			String userId = (String) userInfo.get("USER_ID");
			String language = (String) userInfo.get("LANGUAGE");
			sendEmail.sendMarketEmail(userId, language);
		}
	}
}
