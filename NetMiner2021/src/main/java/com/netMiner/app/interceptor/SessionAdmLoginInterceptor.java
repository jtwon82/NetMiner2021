package com.netMiner.app.interceptor;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.web.servlet.HandlerInterceptor;

import com.netMiner.app.config.Constant;
import com.netMiner.app.model.dao.SelectDao;
import com.netMiner.app.model.vo.AdminVo;
import com.netMiner.app.model.vo.MemberVo;

public class SessionAdmLoginInterceptor implements HandlerInterceptor{
	private static final Logger logger= LoggerFactory.getLogger(SessionAdmLoginInterceptor.class);

	@Autowired
	private SelectDao selectDao;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session= request.getSession();
		StringBuffer sbUrl = request.getRequestURL();
		String url = sbUrl.toString();
		
		logger.info("getRequestURL {}", request.getRequestURL());
		
		request.setAttribute("GOOGLE_CALL_BACK_LOGIN_URL", Constant.getInstance(request).GOOGLE_CALL_BACK_LOGIN_URL);
		request.setAttribute("GOOGLE_CALL_BACK_REGISTER_URL", Constant.getInstance(request).GOOGLE_CALL_BACK_REGISTER_URL);
		
		if (url.contains("admin")) {
			// 세션체크
//			HttpSession session= request.getSession();
			AdminVo admin= (AdminVo)session.getAttribute(Constant.ADMIN_SESSION);
			if(admin== null){
				logger.info("sendRedirect admin/login");
				response.sendRedirect("/admin/login");
				return false;
			}
		}
		if (Constant.checkDBError) {
			Map<String, Object> checkData= new HashMap();
			checkData.put("COMMENT_KR","긴급 시스템 점검");
			checkData.put("COMMENT_EN","Temporary System Maintenance");
			checkData.put("DBDOWN", "DBDOWN");
			session.setAttribute("checkData", checkData);
			response.sendRedirect("./check");
			logger.info("sendRedirect check");
			return false;
		} else {
			String [] urlPath = {"login","feature","Privacy","solution",
					"function","feature","whyNetMiner","registerCheckEmail",
					"goCheckEmail","goChangePwd","register","findPwd",
					"moveCheckEmail","activate","account","pricing","billing"};
			for (String path : urlPath) {
				if (url.contains(path)) {
					try {
						if(Constant.checkDBError) throw new Exception();
						
						Map<String, Object> checkData= selectDao.getCheckData();
						if (checkData != null && "Y".equals(checkData.get("STATS_YN").toString())) {
							checkData.put("DBDOWN", "");
							session.setAttribute("checkData", checkData);
							response.sendRedirect("./check");
							logger.info("sendRedirect check");
							return false;
						}
					}catch(Exception e) {
						Constant.checkDBError=true;
						Map<String, Object> checkData= new HashMap();
						checkData.put("COMMENT_KR","긴급 시스템 점검");
						checkData.put("COMMENT_EN","Temporary System Maintenance");
						checkData.put("DBDOWN", "DBDOWN");
						session.setAttribute("checkData", checkData);
						response.sendRedirect("./check");
						logger.info("sendRedirect check");
						return false;
					}
				}
			}
			if ("account".contains(url)) {
//				HttpSession session= request.getSession();
				MemberVo vo = (MemberVo) session.getAttribute("memberVo");
				if (vo == null) {
					response.sendRedirect("/");
					logger.info("sendRedirect /");
					return false;
				}
				
			}
		}

		if(session.getAttribute("language")==null) {
			Locale locate= LocaleContextHolder.getLocale();
			if(locate.toString().contains("KR")) {
				session.setAttribute("language", "");
			} else {
				session.setAttribute("language", "_EN");
			}
		}
		logger.info("language {}", session.getAttribute("language"));
		
		
		Date date = new Date();
		String nowDate= "";
		if (session.getAttribute("language").equals("")) {
			SimpleDateFormat form = new SimpleDateFormat("yyyy년 MM월 dd일");
			nowDate = form.format(date);
		} else {
			SimpleDateFormat form = new SimpleDateFormat("yyyy/ MM/ dd");
			nowDate = form.format(date);			
		}
		session.setAttribute("nowDate", nowDate);
		
		return true;
	}
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		if(ex != null) {
			response.sendRedirect("./check");
		}
		
	}

}
