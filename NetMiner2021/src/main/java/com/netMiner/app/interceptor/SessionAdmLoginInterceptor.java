package com.netMiner.app.interceptor;

import java.util.Date;
import java.util.Locale;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.netMiner.app.config.Constant;
import com.netMiner.app.model.dao.SelectDao;
import com.netMiner.app.model.vo.AdminVo;

public class SessionAdmLoginInterceptor implements HandlerInterceptor{
	private static final Logger logger= LoggerFactory.getLogger(SessionAdmLoginInterceptor.class);

	@Autowired
	private SelectDao selectDao;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		StringBuffer sbUrl = request.getRequestURL();
		String url = sbUrl.toString();
		if (url.contains("admin")) {
			// 세션체크
			HttpSession session= request.getSession();
			AdminVo admin= (AdminVo)session.getAttribute(Constant.ADMIN_SESSION);
			logger.info("admin {}", admin);
			if(admin== null){
				response.sendRedirect("/admin/login");
				return false;
			}
		}
		String [] urlPath = {"login","feature","Privacy","solution",
				"function","feature","whyNetMiner","registerCheckEmail",
				"goCheckEmail","goChangePwd","register","findPwd",
				"moveCheckEmail","activate","account"};
		
		for (String path : urlPath) {
			if (url.contains(path)) {
				Map<String, Object> checkData = selectDao.getCheckData();
				System.out.println("checkData" + checkData.toString());
				Locale local = request.getLocale();
				String location = local.toString();
				String language = "";
				if (!location.contains("KR")) {
					language = "_EN";
				}
				checkData.put("language", language);
				
				if (checkData != null) {
					if ("Y".equals(checkData.get("STATS_YN"))) {
						RequestDispatcher dispatcher = request.getRequestDispatcher("check");
						request.setAttribute("checkData", checkData);
						dispatcher.forward(request, response);
						return false;
					}			
				}				
			}
		}
		return true;
	}
	

}
