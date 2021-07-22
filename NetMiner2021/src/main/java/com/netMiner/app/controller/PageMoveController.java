package com.netMiner.app.controller;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.netMiner.app.config.Constant;
import com.netMiner.app.model.dao.SelectDao;
import com.netMiner.app.model.vo.MemberVo;
import com.netMiner.app.model.vo.NationVo;
import com.netMiner.app.util.Base64Util;

/**
 * Servlet implementation class PageMoveController
 */
@Controller
public class PageMoveController extends HttpServlet {
	
	private static final Logger logger = LoggerFactory.getLogger(PageMoveController.class);
	
	@Autowired
	private SelectDao selectDao;
	
	@RequestMapping(value="getNow" , method= RequestMethod.GET)
	public ModelAndView getNow(ModelAndView mv) {
		String dateTime = selectDao.getNowDate();
		mv.addObject("nowDateTime", dateTime);
		mv.setViewName("jsonView");
		return mv;
	}
	
	@RequestMapping(value="register" ,method =  RequestMethod.GET)
	public String register(HttpSession session) {
		String language = (String) session.getAttribute("language");
		if (language == null) {
			language = "";
		}
		String path = "member"+ language;
		return path+"/register";		
	}
	
	@RequestMapping(value= {"login","login_dev"}, method = RequestMethod.GET)
	public String login(HttpSession session, HttpServletRequest request) {
		String language = (String) session.getAttribute("language");
		if (language == null) {
			language = request.getParameter("language") == null ? "" : request.getParameter("language");
		}
		
		String path = "member"+ language;
		return path+"/login";
	}
	@RequestMapping(value="findPwd", method = RequestMethod.GET)
	public String findPwd(HttpSession session) {
		String language = (String) session.getAttribute("language");
		if (language == null) {
			language = "";
		}
		String path = "member"+ language;
		return path+"/searchPw";
	}
	
	@RequestMapping(value="moveCheckEmail", method = RequestMethod.GET)
	public String moveCheckEmail(Model model ,HttpSession session, HttpServletRequest request) {
		String language = (String) session.getAttribute("language");
		String userId = request.getParameter("userId");
		if (language == null) {
			language = "";
		}
		Map<String,Object> authData = selectDao.getauthData(userId);
		model.addAttribute("authData", authData);
		model.addAttribute("userId", userId);
		String path = "member"+ language;
		return  path+"/authentic";
	}
	@RequestMapping(value="activate", method = RequestMethod.GET)
	public String activate(HttpSession session, HttpServletRequest request) {
		String language = (String) request.getAttribute("language");
		if (language == null) {
			language = "";
		} else {
			session.setAttribute("language", "_EN");
		}
		String path = "member"+ language;
		
		return path+"/activate";
	}
	
	@RequestMapping(value="getNationCode", method = RequestMethod.GET, produces = "application/text; charset=utf8")
	public @ResponseBody ModelAndView getNationCode(ModelAndView mv, HttpServletRequest requets, HttpServletResponse response, HttpSession session) {
		MemberVo vo = new MemberVo();
		String nationCode = "";
		if (session.getAttribute("memberVo") != null) {
			vo = (MemberVo) session.getAttribute("memberVo");
			if (vo.getNation() != null) {
				nationCode = vo.getNation();		
			}
			mv.addObject("userNationCode", nationCode);
		}
		List<NationVo> result = selectDao.getNation();
		mv.addObject("NationVo", result);
		mv.setViewName("jsonView");
		response.setContentType("application/x-json; charset=UTF-8");
		logger.info("membervo- {}", vo.toString());
		return mv;
	}
	
	@RequestMapping(value="goChangePwd", method=RequestMethod.GET) 
	public String goChangePwd (Model mv, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		Base64Util base64 = new Base64Util();
		String userId = base64.deCodingBase64(request.getParameter("userId"));
		String language = base64.deCodingBase64(request.getParameter("language"));
		
		String url = "";
		
		if (language == null) {
			language = "";
		}

		Map<String,Object> result = selectDao.getauthData(userId);
		String DATE_CHECK = StringUtils.defaultIfEmpty((String) result.get("DATE_CHECK"), "N");
		mv.addAttribute("userId",userId);
		mv.addAttribute("DATE_CHECK", DATE_CHECK);

		url = "member"+language+"/searchPw";
		
		return url;
	}
	
	@RequestMapping(value="goCheckEmail", method=RequestMethod.GET)
	public String goCheckEmail (Model model,  HttpServletRequest request, HttpSession session) {
		String language = (String) session.getAttribute("language");
		String userId = request.getParameter("userId");
		if (language == null) {
			language = "";
		}
		model.addAttribute("userId", userId);
		String path = "member"+ language;
		return path+"/authentic";
	}
	
	@RequestMapping(value="registerCheckEmail", method=RequestMethod.GET) 
	public String registerCheckEmail (Model model,HttpSession session, HttpServletRequest request) {
		String language = (String) session.getAttribute("language");
		String userId = request.getParameter("userId");
		if (language == null) {
			language = "";
		}
		model.addAttribute("userId", userId);
		String path = "member"+ language;
		return path+"/account";
	}
	
	@RequestMapping(value="whyNetMiner", method=RequestMethod.GET) 
	public String whyNetMiner (HttpSession session) {
		String language = (String) session.getAttribute("language");
		if (language == null) {
			language = "";
		}
		String path = "homePage"+ language;
		return path+"/whyNetminer";
	}
	@RequestMapping(value="feature", method=RequestMethod.GET) 
	public String feature (HttpSession session) {
		String language = (String) session.getAttribute("language");
		if (language == null) {
			language = "";
		}
		String path = "homePage"+ language;
		return path+"/feature";
	}
	@RequestMapping(value="function", method=RequestMethod.GET) 
	public String function (HttpSession session) {
		String language = (String) session.getAttribute("language");
		if (language == null) {
			language = "";
		}
		String path = "homePage"+ language;
		return path+"/function";
	}
	@RequestMapping(value="solution", method=RequestMethod.GET) 
	public String solution (HttpSession session) {
		String language = (String) session.getAttribute("language");
		if (language == null) {
			language = "";
		}
		String path = "homePage"+ language;
		return path+"/solution";
	}
	@RequestMapping(value="TermsOfService", method=RequestMethod.GET)
	public String termsOfService(HttpSession session) {
		String language = (String) session.getAttribute("language");
		if (language == null) {
			language = "";
		}
		String path = "homePage"+ language;
		return path+"/term";
	}
	@RequestMapping(value="Privacy", method=RequestMethod.GET)
	public String Privacy(HttpSession session) {
		String language = (String) session.getAttribute("language");
		if (language == null) {
			language = "";
		}
		String path = "homePage"+ language;
		return path+"/privacy";
	}
	
	@RequestMapping(value="changeLanguage", method=RequestMethod.POST)
	public ModelAndView changeLanguage(ModelAndView mv, HttpSession session, HttpServletRequest request) {
		String language = request.getParameter("language");

		session.removeAttribute("language");
		
		if (language.equals("KR")) {
			session.setAttribute("language", "");
		} else {
			session.setAttribute("language", "_EN");
		}
		mv.setViewName("jsonView");
		
		return mv;
	}
	@RequestMapping(value="check", method= {RequestMethod.GET, RequestMethod.POST})
	public String goCheck (ModelAndView mv, HttpServletRequest request, HttpServletResponse response) {
		Locale local = request.getLocale();
		String location = local.toString();
		String language = "";
		if (!location.contains("KR")) {
			language = "_EN";
		}
		Map<String , Object> param = new HashMap<String ,Object>();
		
		if (!Constant.checkDBError) {
			param =  selectDao.getCheckData();		
			mv.addObject("checkData", param);						
		} else {
			param.put("END_DATE_YN","Y");
			param.put("COMMENT_KR","긴급 시스템 점검");
			param.put("COMMENT_EN","Temporary System Maintenance");
			mv.addObject("checkData",param);
		}
		
		return "homePage"+language+"/check";
	}
	@RequestMapping(value="registerComplete", method=RequestMethod.GET)
	public String registerComplete (HttpSession session) {
		String language = (String) session.getAttribute("language");
		if (language == null) {
			language = "";
		}
		String path = "member"+ language;
		return path + "/register_complete";
	}
}
