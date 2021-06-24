package com.netMiner.app.controller;

import java.util.List;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.netMiner.app.model.dao.SelectDao;
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
	public @ResponseBody ModelAndView getNationCode(ModelAndView mv, HttpServletRequest requets, HttpServletResponse response) {
		List<NationVo> result = selectDao.getNation();
		mv.addObject("NationVo", result);
		mv.setViewName("jsonView");
		response.setContentType("application/x-json; charset=UTF-8");
		return mv;
	}
}
