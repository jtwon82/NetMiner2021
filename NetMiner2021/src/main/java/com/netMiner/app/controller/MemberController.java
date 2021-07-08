package com.netMiner.app.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

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
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.config.MvcNamespaceHandler;

import com.netMiner.app.config.SendEmail;
import com.netMiner.app.model.service.MemberService;
import com.netMiner.app.model.vo.MemberVo;
import com.netMiner.app.util.CryptUtil;

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
	public String home(Locale locale, Model model, HttpSession session) {
		logger.info("Welcome home! The client locale is {}.", locale);

		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);

		String formattedDate = dateFormat.format(date);

		model.addAttribute("serverTime", formattedDate );
		String url = "home";

		if (session.getAttribute("language") != null) {
			url = url + session.getAttribute("language");
		} else {
			String location = locale.toString();
			if (!location.contains("KR")) {
				session.setAttribute("language", "_EN");
				url = url + "_EN";
			} else {
				session.setAttribute("language", "");
				
			}
			
		}
		
//		String location = locale.toString();
//		if (!location.contains("KR")) {
//			url = url+"_EN";
//		}
		
		return url;
	}
	
	@RequestMapping(value="loginUser", method = RequestMethod.POST) 
	public String loginUser(HttpServletRequest request,HttpSession session, HttpServletResponse response) {
		CryptUtil cu = new CryptUtil();
		MemberVo memberVo = new MemberVo();
		String url  = "";
		String language = (String) session.getAttribute("language");
		if (language == null) {
			language = "";
		}
		try {
			request.setCharacterEncoding("UTF-8");
			String userId = request.getParameter("email");
			String userPwd = request.getParameter("pwd");
			
			memberVo.setUserId(userId);
			memberVo.setUserPwd(userPwd);
			
			memberVo = memberService.getUserInfo(memberVo);
			
			if (memberVo == null) {
				if ("_EN".equals(language)) {
					response.setContentType("text/html; charset=UTF-8"); 
					PrintWriter out = response.getWriter(); 
					out.println("<script>alert('해당 아이디가 없거나 비밀번호가 틀립니다.'); location.href='./login';</script>"); 
					out.flush();
					url  = "member/login";					
				} else {
					response.setContentType("text/html; charset=UTF-8"); 
					PrintWriter out = response.getWriter(); 
					out.println("<script>alert('The ID does not exist or the password is incorrect.'); location.href='./login';</script>"); 
					out.flush();
					url  = "member"+language+"/login";		
				}
			} else {
				session.setAttribute("memberVo", memberVo);
				session.setAttribute("memberId", cu.encryptLoginfo(memberVo.getUserId(), "02"));
				url  = "homePage"+language+"/main";
			}
			
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return url;
	}
	
	@RequestMapping(value="logOut", method = RequestMethod.GET)
	public String logOut(HttpSession session) {
		String language = (String) session.getAttribute("language");
		if (language == null) {
			language = "";
		}
		session.removeAttribute("memberVo");
		session.setAttribute("language", language);		
		return "home"+language;
	}
	
	@RequestMapping(value="registerStep", method = RequestMethod.POST)
	public ModelAndView goCheckEmail(HttpServletRequest request,HttpSession session) {
		ModelAndView mv = new ModelAndView();
		MemberVo memberVo = new MemberVo();
		String language = (String) session.getAttribute("language");
		CryptUtil cu = new CryptUtil();
		if (language == null) {
			language = "";
		}
		
		try {
			request.setCharacterEncoding("UTF-8");

			String userId = request.getParameter("email");
			memberVo.setUserId(userId);
			memberVo = memberService.getUserInfoTmp(memberVo);
			String marketYn = request.getParameter("marketYn");
			memberVo.setMarketYn(marketYn);
			String googleYn = "N";
			memberVo.setGoogleYn(googleYn);
			memberService.signUpGeneral(memberVo);			 
			memberService.deleteMemberInfoTmp(memberVo);
			sendEmail.sendRegisterMail(userId, "", language);
			
			session.setAttribute("memberVo", memberVo);
			session.setAttribute("memberId", cu.encryptLoginfo(memberVo.getUserId(), "02"));
			
			mv.setViewName("jsonView");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}


		return mv;
	}
	
	//email 재인증 또는 추후 회원정보 변경시 사용 
	@RequestMapping(value="emailSender" , method=RequestMethod.POST)
	public ModelAndView sendEmail(HttpSession session, ModelAndView mv, HttpServletRequest request) {
		String language = (String) session.getAttribute("language");
		if (language == null) {
			language = "";
		}
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
		
		String randomNumber = sendEmail.sendCheckEmail(userId, language);
		
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
		String language = (String) session.getAttribute("language");
		CryptUtil cu = new CryptUtil();
		if (language == null) {
			language = "";
		}
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
		String marketYn = request.getParameter("marketYn");
		String googleYn = "Y";
		try {
		memberVo.setUserId(userId);
		memberVo.setUserPwd(userPwd);
		memberVo.setCompany(company);
		memberVo.setNation(nation);
		memberVo.setUseCode(useCode);
		memberVo.setMarketYn(marketYn);
		memberVo.setGoogleYn(googleYn);
		if (nation.equals("korea")) {
			memberVo.setLanguage("ko");
		} else {
			memberVo.setLanguage("en");
		}
		logger.info("memberVo - {}", memberVo.toString());
		memberService.signUp(memberVo);
		

		sendEmail.sendRegisterMail(userId, "", language);
		
		
		session.setAttribute("memberVo", memberVo);
		
			session.setAttribute("memberId", cu.encryptLoginfo(memberVo.getUserId(), "02"));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		mv.setViewName("homePage"+language+"/main");
		
		return mv;
	}
		 
	@RequestMapping( value="findUserInfo", method=RequestMethod.POST)
	public ModelAndView resetPwd (ModelAndView mv,HttpServletRequest request, HttpSession session) {
		String language = (String) session.getAttribute("language");
		
		if (language == null) {
			language = "";
		}
		
		String userId = request.getParameter("email");
		logger.info(userId);

		MemberVo vo = new MemberVo();
		vo.setUserId(userId);
		//1. 해당유저의 존재 여부 파악  있으면  메일 보내기  없으면 해당 유저가 없으므로 가입창으로 
		String googleYn = "N";
		MemberVo checkResult = memberService.checkJoin(vo);
		
		boolean sendMail = false;
		
		if (checkResult != null) {
			googleYn = checkResult.getGoogleYn();
		}
		
		if (checkResult != null && checkResult.getGoogleYn().equals("N")) {
			String[] urlSp = request.getRequestURL().toString().split("/");
			//2. 메일로 보내기  <a href="">비밀번호 재설정</a> 해당 href 뒤에 이메일 정보 
			StringBuffer sb = new StringBuffer()
					.append(urlSp[0]).append("//").append(urlSp[2])
					.append("/").append("goChangePwd?")
					.append("userId=").append(userId)
					.append("&language=").append(language);
			logger.info(sb.toString());
			sendMail = sendEmail.sendReSetPwd(sb.toString(), userId, language);
		} else {
			userId="";
			mv.addObject("googleYn", googleYn);
		}
		mv.addObject("userId", userId);
		mv.setViewName("jsonView");
		return mv;
	}
	@RequestMapping(value="changeNewPwd" , method=RequestMethod.POST)
	public ModelAndView chageNewPwd(ModelAndView mv,HttpServletRequest request) {
		String userId = request.getParameter("email");
		String userPwd = request.getParameter("pwd");
		MemberVo vo = new MemberVo();
		vo.setUserId(userId);
		vo.setUserPwd(userPwd);
		
		memberService.updateNewPwd(vo);
		
		mv.setViewName("jsonView");
		return mv;
	}
	@RequestMapping(value="account" , method=RequestMethod.GET)
	public String accountUser(HttpSession session) {
		String language = (String) session.getAttribute("language");
		if (language == null) {
			language = "";
		}
		MemberVo vo = (MemberVo) session.getAttribute("memberVo");
		logger.info("MemberVo - {}",vo.toString());
		return "member"+language+"/account";
	}
	
	@RequestMapping(value="changeEmail", method=RequestMethod.POST)
	public ModelAndView changeEmail(ModelAndView mv , HttpServletRequest request, HttpSession session) {
		String userId = request.getParameter("email");
		String language = (String) session.getAttribute("language");
		
		if (language == null) {
			language = "";
		}
		
		String randomNumber = sendEmail.sendCheckEmail(userId, language);
		mv.addObject("randomNumber", randomNumber);
		mv.setViewName("jsonView");
		
		if (!"".equals(randomNumber)) {
			session.setAttribute("userId", userId);
			session.setAttribute("randomNumber", randomNumber);			
		}
		return mv;
	}
	
	@RequestMapping(value="chageUserId", method=RequestMethod.POST)
	public ModelAndView chageUserId(ModelAndView mv , HttpServletRequest request, HttpSession session) {
		MemberVo vo = (MemberVo) session.getAttribute("memberVo");
		String newUserId = request.getParameter("email");
		Map<String , Object> param = new HashMap<String, Object>();
		param.put("userId", vo.getUserId());
		param.put("newUserId", newUserId);
		
		memberService.updateNewUserId(param);
		
		mv.setViewName("jsonView");
		
		return mv;		
	}
	
	@RequestMapping(value="updateUserInfo", method=RequestMethod.POST)
	public ModelAndView updateUserInfo (ModelAndView mv,HttpServletRequest request, HttpSession session) {
		String language = (String) session.getAttribute("language");
		
		if (language == null) {
			language = "";
		}
		MemberVo memberVo = new MemberVo();
		String googleYn = request.getParameter("googleYn");
		
		if (googleYn.equals("N") ) {
			String userId = request.getParameter("email");
			String userPwd = request.getParameter("pwd");
			String company = request.getParameter("company");
			String nation = request.getParameter("nation");
			String useCode = request.getParameter("useCode");
			String marketYn = request.getParameter("marketYn");
			memberVo.setUserId(userId);
			memberVo.setUserPwd(userPwd);
			memberVo.setCompany(company);
			memberVo.setNation(nation);
			memberVo.setUseCode(useCode);
			memberVo.setMarketYn(marketYn);
			memberVo.setGoogleYn(googleYn);
		} else {
			String userId = request.getParameter("email");
			String company = request.getParameter("company");
			String nation = request.getParameter("nation");
			String useCode = request.getParameter("useCode");
			String marketYn = request.getParameter("marketYn");
			memberVo.setUserId(userId);
			memberVo.setCompany(company);
			memberVo.setNation(nation);
			memberVo.setUseCode(useCode);
			memberVo.setMarketYn(marketYn);
			memberVo.setGoogleYn(googleYn);
		}

		if (memberVo.getNation().equals("KR")) {
			memberVo.setLanguage("ko");
		} else {
			memberVo.setLanguage("en");
		}
		
		MemberVo oldMemberVo = (MemberVo) session.getAttribute("memberVo");
		
		memberService.updateNewUserInfo(oldMemberVo, memberVo);
		
		if ("Y".equals(memberVo.getMarketYn())) {
			sendEmail.sendMarketEmail(memberVo.getUserId(), language);
		}
		
		memberVo = memberService.getUserInfo(memberVo);
		session.setAttribute("memberVo", memberVo);
		
		mv.setViewName("jsonView");
		
		return mv;
	}
	@RequestMapping(value="checkUser", method=RequestMethod.POST)
	public ModelAndView checkUser (ModelAndView mv,HttpServletRequest request) {
		
		String userId = request.getParameter("email");
		int count = memberService.checkUser(userId);
			
		boolean result = true ; 
		if (count > 0) {
			result = false;
		}
		
		mv.addObject("result", result);
		mv.setViewName("jsonView");
		
		return mv;
	}
	
	@RequestMapping(value="sendNewRandom", method=RequestMethod.POST)
	public ModelAndView sendNewRandom (ModelAndView mv , HttpServletRequest request, HttpSession session) {
		String userId = request.getParameter("email");
		String language = (String) session.getAttribute("language");
		
		if (language == null) {
			language = "";
		}
		String randomNumber = sendEmail.sendCheckEmail(userId, language);
		mv.addObject("randomNumber", randomNumber);
		mv.setViewName("jsonView");
		return mv;
	}
	

	@RequestMapping(value="goBack", method=RequestMethod.GET)
	public ModelAndView goBack(HttpSession session, ModelAndView mv, HttpServletRequest request) {
		if (session.getAttribute("userId")!= null) {
			session.removeAttribute("userId");			
		}
		String form = request.getParameter("form");
		if ("account".equals(form)) {
			mv.addObject("getUrl", "-2");
		} else if ("delete".equals(form)) {
			mv.addObject("getUrl", "./");
		}
		mv.setViewName("jsonView");
		return mv;
	}
	@RequestMapping(value="delteMember", method=RequestMethod.POST)
	public ModelAndView delteMember(ModelAndView mv, HttpSession session) {
		MemberVo vo = (MemberVo) session.getAttribute("memberVo");
		
		memberService.deleteMember(vo);
		
		session.invalidate();
		mv.setViewName("jsonView");
		return mv;
	}
}
