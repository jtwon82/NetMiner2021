package com.netMiner.app.controller;

import java.util.List;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.netMiner.app.model.dao.SelectDao;
import com.netMiner.app.model.vo.MemberVo;
import com.netMiner.app.model.vo.NationVo;

/**
 * Servlet implementation class PageMoveController
 */
@Controller
public class PageMoveController extends HttpServlet {
	
	private static final Logger logger = LoggerFactory.getLogger(PageMoveController.class);
	
	@Autowired
	private SelectDao selectDao;
	
	@RequestMapping(value="register" ,method =  RequestMethod.GET)
	public String goRegister() {
		return "member/register";		
	}
	
	@RequestMapping(value="login", method = RequestMethod.GET)
	public String goLogin() {
		return "member/login";
	}
	@RequestMapping(value="findPwd", method = RequestMethod.GET)
	public String goFindPwd() {
		return "member/searchPw";
	}
	
	@RequestMapping(value="moveCheckEmail", method = RequestMethod.GET)
	public String moveCheckEmail() {
		
		return "member/authentic";
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
	public ModelAndView goChangePwd (ModelAndView mv, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		String userId = request.getParameter("userId");
		logger.info("userid -{}", userId);
		mv.addObject("userId", userId);
		mv.setViewName("member/searchPw");
		
		return mv;
	}
	
	@RequestMapping(value="goCheckEmail", method=RequestMethod.GET)
	public String goCheckEmail () {
		return "member/authentic";
	}
	
	@RequestMapping(value="registerCheckEmail", method=RequestMethod.GET) 
	public String registerCheckEmail () {
		return "member/account";
	}
	
	@RequestMapping(value="whyNetMiner", method=RequestMethod.GET) 
	public String whyNetMiner () {
		return "homePage/whyNetminer";
	}
	@RequestMapping(value="feature", method=RequestMethod.GET) 
	public String feature () {
		return "homePage/feature";
	}
	@RequestMapping(value="function", method=RequestMethod.GET) 
	public String function () {
		return "homePage/function";
	}
	@RequestMapping(value="solution", method=RequestMethod.GET) 
	public String solution () {
		return "homePage/solution";
	}
	@RequestMapping(value="TermsOfService", method=RequestMethod.GET)
	public String termsOfService() {
		return "homePage/term";
	}
	@RequestMapping(value="Privacy", method=RequestMethod.GET)
	public String Privacy() {
		return "homePage/privacy";
	}
}
