package com.netMiner.app.controller;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Servlet implementation class PageMoveController
 */
@Controller
public class PageMoveController extends HttpServlet {
	
	private static final Logger logger = LoggerFactory.getLogger(PageMoveController.class);
	
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
	
	@RequestMapping(value="gooleJoin", method = RequestMethod.GET)
	public String goGoogle(HttpServletRequest request) {
		
		return "member/register_sns";
	}
	
	@RequestMapping(value="moveCheckEmail", method = RequestMethod.GET)
	public String moveCheckEmail() {
		
		return "member/authentic";
	}
}
