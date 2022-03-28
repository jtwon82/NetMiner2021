package com.netMiner.app.scheduler;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.netMiner.app.config.Constant;
import com.netMiner.app.config.SendEmail;
import com.netMiner.app.model.dao.MemberDao;
import com.netMiner.app.model.dao.SelectDao;
import com.netMiner.app.model.vo.MemberVo;

@Component
public class CommonScheduler {
	private static final Logger logger = LoggerFactory.getLogger(CommonScheduler.class);
	
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private SelectDao selectDao;
	
	@Autowired
	private SendEmail sendEmail;
	
	// 매일 9시 마지막 로그인 시간이 1년이 된 사용자에게 메일을 전송한다. 
	@Scheduled(cron="0 0 9 * * *")
//	@Scheduled(cron="*/10 * * * * *")
	public void sendEmail() {
		logger.info("Dormant User ");
		// 휴면 유저 이메일 전송 
		List<Map<String , Object>> member = memberDao.getLastLoginFerYear();
		logger.info("Dormant User size -{} ", member.size());
		for(int i = 0 ; i < member.size() ;  i ++) {
			Map<String , Object> userInfo = member.get(i);
			String userId = (String) userInfo.get("USER_ID");
			String language = (String) userInfo.get("LANGUAGE");
			String url = "";
			if ("en".equals(language)) {
				url = "https://www.netminer365.com/login?language="+"_EN";
			} else {
				url = "https://www.netminer365.com/login";
			}
			boolean result= sendEmail.sendDormantUser(userId, url, language);
			if (result) {
				MemberVo vo = new MemberVo();
				vo.setUserId(userId);
				vo= memberDao.getUserInfo(vo);
				vo.setUserStatsYn("N");
				memberDao.changeMemberInfo(vo);
			} else {
				logger.info("SendMail Fail");
			}
		}
		// 휴면유저 30일 이후 해당 유저 탈퇴 변경 
		memberDao.getPassByDormant();
	}
	
	//광고 동의 2년 주기로 메일 보내기 
	@Scheduled(cron="0 10 9 * * *")
	//@Scheduled(cron="0 26 19 * * *")
	public void sendMarketYnUser() {
		
		List<Map<String , Object>> member = memberDao.getMarketYnUser();
		logger.info("sendMarketYnUser size - {}", member.size());
		for(int i = 0 ; i < member.size() ;  i ++) {
			Map<String , Object> userInfo = member.get(i);
			String userId = (String) userInfo.get("USER_ID");
			String language = (String) userInfo.get("LANGUAGE");
			Date marketDate = (Date) userInfo.get("MARKET_DATE");
			
			sendEmail.sendMarketEmail(userId, language, marketDate);
		}
		logger.info("END sendMarketYnUser");
	}
	//탈퇴회원 1년 경과후 삭제 
	@Scheduled(cron="0 20 9 * * *")
	public void deleteDropMember() {
		logger.info("deleteDropMember Start");
		memberDao.deleteDropMember();
		logger.info("deleteDropMember End");

	}
	
	@Scheduled(cron = "*/30 * * * * *")
	public void changeDBError() {
		try {
			Constant.checkDBError= false;
			String now = selectDao.getNowDate();
		} catch (Exception e) {
			Constant.checkDBError= true;
			logger.error("DB Exception TimeOut");
		}
	}
	//플랜 결제 아이디 중에 3일 전 알림
	@Scheduled(cron="0 30 14 * * *")
	//@Scheduled(cron="*/30 * * * * *")
	public void payPlanUser() {
		try {
			List<Map<String , Object>> memberList = memberDao.getPayPlanUser();
			if (memberList.size() > 0) {
				logger.info("memberList- {} ", memberList.toString());
				
				for (Map<String,Object> result : memberList) {
					String userId = (String) result.get("USER_ID");
					String language = (String) result.get("LANGUAGE");
					String endDate = (String) result.get("END_DATE");
					logger.info("result - {}", result.toString());
					sendEmail.sendPayPlanUser(userId, language, endDate);
				}
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
