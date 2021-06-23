package com.netMiner.app.controller;

import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.netMiner.app.config.SendEmail;
import com.netMiner.app.model.service.MemberService;
import com.netMiner.app.model.vo.MemberVo;

/**
 * Handles requests for the application home page.
 */
@Controller
public class MemberController {

	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	@Autowired
	private MemberService memberService;
	
	@Autowired
	private SendEmail sendEmail;

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);

		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);

		String formattedDate = dateFormat.format(date);

		model.addAttribute("serverTime", formattedDate );

		//String dbDate = memberService.getTestDate();

		//logger.info(dbDate);

		return "home";
	}
	
	@RequestMapping(value="loginUser", method = RequestMethod.POST) 
	public ModelAndView loginUser(HttpServletRequest request,HttpSession session) {
		ModelAndView mv = new ModelAndView();
		MemberVo memberVo = new MemberVo();
		try {
			request.setCharacterEncoding("UTF-8");
			String userId = request.getParameter("email");
			String userPwd = request.getParameter("pwd");
			
			memberVo.setUserId(userId);
			memberVo.setUserPwd(userPwd);
			
			memberVo = memberService.getUserInfo(memberVo);
			
			if (memberVo == null) {
				mv.setViewName("member/register");
			} else {
				session.setAttribute("memberVo", memberVo);
				mv.setViewName("homePage/main");
			}
			
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return mv;
	}
	
	@RequestMapping(value="logOut", method = RequestMethod.GET)
	public String logOut(HttpSession session) {
		session.invalidate();
		return "homePage/main";
	}
	
	@RequestMapping(value="registerStep", method = RequestMethod.POST)
	public ModelAndView goCheckEmail(HttpServletRequest request,HttpSession session) {
		ModelAndView mv = new ModelAndView();
		MemberVo memberVo = new MemberVo();
		
		
		try {
			request.setCharacterEncoding("UTF-8");
			
			String userId = request.getParameter("email");
			memberVo.setUserId(userId);
			memberVo = memberService.getUserInfoTmp(memberVo);
			String marketYn = request.getParameter("marketYn");
			memberVo.setMarketYn(marketYn);
			
			logger.info(memberVo.toString());
			memberService.signUpGeneral(memberVo);			 
	
			session.setAttribute("memberVo", memberVo);
			
			mv.setViewName("jsonView");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}


		return mv;
	}
	
	//email 재인증 또는 추후 회원정보 변경시 사용 
	@RequestMapping(value="emailSender" , method=RequestMethod.POST)
	public ModelAndView sendEmail(HttpSession session, ModelAndView mv, HttpServletRequest request) {
	
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		MemberVo memberVo = new MemberVo();
		
		String userId = request.getParameter("email");
		String userPwd = request.getParameter("pwd");
		String company = request.getParameter("company");
		String nation = request.getParameter("nation");
		String useCode = request.getParameter("useCode");
		
		memberVo.setUserId(userId);
		memberVo.setUserPwd(userPwd);
		memberVo.setCompany(company);
		memberVo.setNation(nation);
		memberVo.setUseCode(useCode);
		
		if (nation.equals("korea")) {
			memberVo.setLanguage("ko");
		} else {
			memberVo.setLanguage("en");
		}
		
		String randomNumber = sendEmail.sendCheckEmail(userId);
		
		//임시 유저 저장 
		memberService.insertMemberInfoTmp(memberVo);		
		
		mv.addObject("randomNumber", randomNumber);
		mv.setViewName("jsonView");
		return mv;
	}

	@RequestMapping(value="registerSNS" , method=RequestMethod.POST)
	public ModelAndView registerSNS (HttpSession session, ModelAndView mv, HttpServletRequest request) {

		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		MemberVo memberVo = new MemberVo();
		
		String userId = request.getParameter("email");
		String userPwd = request.getParameter("pwd");
		String company = request.getParameter("company");
		String nation = request.getParameter("nation");
		String useCode = request.getParameter("useCode");
		String marketYn = StringUtils.trimToNull(request.getParameter("marketYn")) == null ? "N" : "Y";
		
		memberVo.setUserId(userId);
		memberVo.setUserPwd(userPwd);
		memberVo.setCompany(company);
		memberVo.setNation(nation);
		memberVo.setUseCode(useCode);
		memberVo.setMarketYn(marketYn);
		
		if (nation.equals("korea")) {
			memberVo.setLanguage("ko");
		} else {
			memberVo.setLanguage("en");
		}
		logger.info("memberVo - {}", memberVo.toString());
		memberService.signUp(memberVo);
		
		session.setAttribute("memberVo", memberVo);
		mv.setViewName("homePage/main");
		
		return mv;
	}
		 

}
