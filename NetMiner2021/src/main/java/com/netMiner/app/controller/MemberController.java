package com.netMiner.app.controller;

import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.util.Date;
import java.util.Enumeration;
import java.util.Locale;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionContext;

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

	@RequestMapping(value="checkEmail", method = RequestMethod.POST)
	public ModelAndView goCheckEmail(HttpServletRequest request,HttpSession session) {
		ModelAndView mv = new ModelAndView();
		MemberVo memberVo = new MemberVo();
		try {
			request.setCharacterEncoding("UTF-8");
			
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
			logger.info(memberVo.toString());
			
			String randomNumber = sendEmail.sendCheckEmail(userId);
			logger.info(randomNumber);
			mv.setViewName("member/authentic");
			mv.addObject("randomNumber", randomNumber);
			mv.addObject("member", memberVo);
					
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}


		return mv;
	}

}
