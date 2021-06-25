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
		return "home";
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
		
		if (nation.equals("KR")) {
			memberVo.setLanguage("ko");
		} else {
			memberVo.setLanguage("en");
		}
		
		String randomNumber = sendEmail.sendCheckEmail(userId);
		
		//임시 유저 저장 
		if (!"".equals(randomNumber)) {
			memberService.insertMemberInfoTmp(memberVo);					
		}
		
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
		 
	@RequestMapping( value="findUserInfo", method=RequestMethod.POST)
	public ModelAndView resetPwd (ModelAndView mv,HttpServletRequest request) {
		String userId = request.getParameter("email");
		MemberVo vo = new MemberVo();
		vo.setUserId(userId);
		//1. 해당유저의 존재 여부 파악  있으면  메일 보내기  없으면 해당 유저가 없으므로 가입창으로 
		boolean checkResult = memberService.checkJoin(vo);
		boolean sendMail = false;
		if (checkResult) {
			String[] urlSp = request.getRequestURL().toString().split("/");
			//2. 메일로 보내기  <a href="">비밀번호 재설정</a> 해당 href 뒤에 이메일 정보 
			StringBuffer sb = new StringBuffer()
					.append(urlSp[0]).append("//").append(urlSp[2])
					.append("/").append("moveCheckEmail?")
					.append("userId=").append(userId);
			sendMail = sendEmail.sendReSetPwd(sb.toString(), userId);
		}
		mv.addObject("sendMail", sendMail);
		mv.setViewName("jsonView");
		return mv;
	}
}
