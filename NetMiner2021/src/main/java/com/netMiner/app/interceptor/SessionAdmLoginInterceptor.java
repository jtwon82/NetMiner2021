package com.netMiner.app.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.HandlerInterceptor;

import com.netMiner.app.config.Constant;
import com.netMiner.app.model.vo.AdminVo;

public class SessionAdmLoginInterceptor implements HandlerInterceptor{
	private static final Logger logger= LoggerFactory.getLogger(SessionAdmLoginInterceptor.class);

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		// 세션체크
		HttpSession session= request.getSession();
		AdminVo admin= (AdminVo)session.getAttribute(Constant.ADMIN_SESSION);
		logger.info("admin {}", admin);
		if(admin== null){
			response.sendRedirect("/admin");
			return false;
		}
		
//		if(!request.getRequestURI().contains("/mgr/login/pw") && 
//				admin.getRegidate().equals(admin.getLast_pwd())) {
//			response.sendRedirect("/mgr/login/pw?isforce=1");
//			return false;
//		}
		
		return true;
	}
 
}
