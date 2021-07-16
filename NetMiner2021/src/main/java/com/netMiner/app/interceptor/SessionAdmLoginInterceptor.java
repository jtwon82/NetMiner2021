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
import com.netMiner.app.model.vo.MemberVo;

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
				if (checkData != null &&"Y".equals(checkData.get("STATS_YN"))) {
					response.sendRedirect("./check");
					return false;
				}
			}
		}
		if ("account".contains(url)) {
			HttpSession session= request.getSession();
			MemberVo vo = (MemberVo) session.getAttribute("memberVo");
			if (vo == null) {
				response.sendRedirect("/");
				return false;
			}
			
		}
		
		return true;
	}
	

}
