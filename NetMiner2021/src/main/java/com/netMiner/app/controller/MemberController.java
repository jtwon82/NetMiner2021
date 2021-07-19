package com.netMiner.app.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Base64;
import java.util.Base64.Decoder;
import java.util.Base64.Encoder;
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
import com.netMiner.app.model.dao.SelectDao;
import com.netMiner.app.model.service.MemberService;
import com.netMiner.app.model.vo.MemberVo;
import com.netMiner.app.util.Base64Util;
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
	private SelectDao selectDao;
	
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
		String location = locale.toString();
		String language = "";
		//언어 설정 
		if (session.getAttribute("language") != null) {
			url = url + session.getAttribute("language");
			language = (String) session.getAttribute("language");
		} else {
			if (!location.contains("KR")) {
				session.setAttribute("language", "_EN");
				language = "_EN";
				url = url + "_EN";
			} else {
				session.setAttribute("language", "");
				
			}			
		}
		
		Map<String, Object> checkData = selectDao.getCheckData();
		if (checkData != null) {
			if ("Y".equals(checkData.get("STATS_YN"))) {
				model.addAttribute("checkData", checkData);
				url = "homePage"+language+"/check";
			}
		}
		
		return url;
	}
	
	@RequestMapping(value="loginUser", method = {RequestMethod.POST,RequestMethod.GET}) 
	public String loginUser(HttpServletRequest request,HttpSession session, HttpServletResponse response) {
		CryptUtil cu = new CryptUtil();
		MemberVo memberVo = new MemberVo();
		String url  = "";
		String language = (String) session.getAttribute("language");
		if (language == null) {
			language = "";
		}
		if (session.getAttribute("outMemberVo") != null) {
			session.removeAttribute("outMemberVo");
			return "member"+language+"/login";
		}
		try {
			request.setCharacterEncoding("UTF-8");
			String userId = request.getParameter("email");
			String userPwd = request.getParameter("pwd");
			
			memberVo.setUserId(userId);
			memberVo.setUserPwd(userPwd);
			
			memberVo = memberService.getUserInfo(memberVo);
			
			if (memberVo == null || "Y".equals(memberVo.getUserStatsYn())) {
				if (! "_EN".equals(language)) {
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
				if ("03".equals(memberVo.getUserCode())&& "N".equals(memberVo.getUserStatsYn())) {
					session.setAttribute("outMemberVo", memberVo);
					url = "member"+language+"/activate";
				} else {
					session.setAttribute("memberVo", memberVo);
					session.setAttribute("memberId", cu.encryptLoginfo(memberVo.getUserId(), "02", memberVo.getNo()));
					url  = "homePage"+language+"/main";
				}
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
	
	@RequestMapping(value= "registerStep", method = RequestMethod.POST)
	public ModelAndView registerStep(HttpServletRequest request,HttpSession session) {
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
			session.setAttribute("memberId", cu.encryptLoginfo(memberVo.getUserId(), "02", memberVo.getNo()));
			
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
	public ModelAndView emailSender(HttpSession session, ModelAndView mv, HttpServletRequest request) {
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
		
			session.setAttribute("memberId", cu.encryptLoginfo(memberVo.getUserId(), "02", memberVo.getNo()));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		mv.setViewName("homePage"+language+"/main");
		
		return mv;
	}
		 
	@RequestMapping( value="findUserInfo", method=RequestMethod.POST)
	public ModelAndView findUserInfo (ModelAndView mv,HttpServletRequest request, HttpSession session) throws UnsupportedEncodingException {
		String language = (String) session.getAttribute("language");
		Base64Util base64 = new Base64Util();
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
			StringBuffer sb;
				sb = new StringBuffer()
						.append(urlSp[0]).append("//").append(urlSp[2])
						.append("/").append("goChangePwd?")
						.append("userId=").append(base64.enCodingBase64(userId))
						.append("&language=").append(base64.enCodingBase64(language));
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
	public ModelAndView changeNewPwds(ModelAndView mv,HttpServletRequest request) {
		String userId = request.getParameter("email");
		String userPwd = request.getParameter("pwd");
		
		MemberVo vo = new MemberVo();
		vo.setUserId(userId);
		vo.setUserPwd(userPwd);
		
		memberService.updateNewPwd(vo);
		selectDao.deleteCheckSendAuthData(userId);
		
		mv.setViewName("jsonView");
		return mv;
	}
	@RequestMapping(value="account" , method=RequestMethod.GET)
	public String accountUser(HttpSession session, HttpServletResponse response) {
		String language = (String) session.getAttribute("language");
		Date date = new Date();
		String nowDate = "";
		if (session.getAttribute("userId") != null) {
			session.removeAttribute("userId");
		}
		
		if (language == null) {
			SimpleDateFormat form = new SimpleDateFormat("yyyy년 MM월 dd일");
			nowDate = form.format(date);
			language = "";
		} else {
			SimpleDateFormat form = new SimpleDateFormat("yyyy/ MM/ dd");
			nowDate = form.format(date);			
		}
		session.setAttribute("nowDate", nowDate);
		try {
		MemberVo vo = (MemberVo) session.getAttribute("memberVo");
		if (vo == null) {
			response.setContentType("text/html; charset=UTF-8"); 
			PrintWriter out;
			out = response.getWriter();
			out.println("<script>alert('로그인 정보가 없습니다.'); location.href='./login';</script>"); 
			return "member/login";
		} else {

			return "member"+language+"/account";
		}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		return "/";
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
		return mv;
	}
	
	@RequestMapping(value="chageUserId", method=RequestMethod.POST)
	public ModelAndView chageUserId(ModelAndView mv , HttpServletRequest request, HttpSession session) {
		MemberVo vo = (MemberVo) session.getAttribute("memberVo");
		String newUserId = request.getParameter("email");
		Map<String , Object> param = new HashMap<String, Object>();
		param.put("userId", vo.getUserId());
		param.put("newUserId", newUserId);
		int count  = memberService.selectUserCount(param);
		if (count == 0) {
			memberService.updateNewUserId(param);

			mv.addObject("state","success");
		}  else {
			mv.addObject("state","fail");
		}
		
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
		
//		if ("Y".equals(memberVo.getMarketYn())) {
//			sendEmail.sendMarketEmail(memberVo.getUserId(), language);
//		}
		
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
		} else {
			count = memberService.checkDropUser(userId);
			if (count > 0) {
				result = false;
			}
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
		selectDao.deleteCheckSendAuthData(userId);
		
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
		memberService.changeMemberState(vo);
		
		memberService.deleteMember(vo);
		
		session.invalidate();
		mv.setViewName("jsonView");
		return mv;
	}
	@RequestMapping(value="turnToGeneral", method=RequestMethod.GET)
	public String turnToGeneral(HttpSession session, HttpServletResponse response) {
		CryptUtil cu = new CryptUtil();
		String language = (String) session.getAttribute("language");
		if (language == null) {
			language = "";
		}
		String url = "";
		try {
		MemberVo outMemberVo = (MemberVo) session.getAttribute("outMemberVo");
		
		//휴면 계정 일반회원으로 변환
		int no =memberService.turnToGeneral(outMemberVo);
		//일반회원 계정으로 확인 
		outMemberVo.setNo(no);
		outMemberVo.setUserCode("02");
		
		session.setAttribute("memberVo", outMemberVo);
		session.setAttribute("memberId", cu.encryptLoginfo(outMemberVo.getUserId(), "02", no));
		
		if ("_EN".equals(language)) {
			response.setContentType("text/html; charset=UTF-8"); 
			PrintWriter out;
			out = response.getWriter();
			out.println("<script>alert(Account conversion is complete.); location.href='./';</script>");
		} else {
			response.setContentType("text/html; charset=UTF-8"); 
			PrintWriter out;
			out = response.getWriter();
			out.println("<script>alert('계정 전환이 완료 되었습니다.'); location.href='./';</script>");
		}
		url = "homePage"+language+"/main";
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return url;
	}
	
	@RequestMapping(value="checkRandomNumber" ,method=RequestMethod.POST)
	public ModelAndView checkRandomNumber(ModelAndView mv ,HttpServletRequest request) {
		String randomNumber = request.getParameter("randomNumber");
		String userId = request.getParameter("email");
		
		Map<String ,Object> param = new HashMap<String ,Object>();
		param.put("randomNumber", randomNumber);
		param.put("userId", userId);
		
		Map<String, Object> result = memberService.checkRandomNumber(param); 
		
		String DATE_CHECK = (String) result.get("DATE_CHECK");
		String AUTH_CODE = (String) result.get("AUTH_CODE");
		
		if ( "Y".equals(DATE_CHECK)) {
			if (randomNumber.equals(AUTH_CODE)) {
				mv.addObject("result", "SUCCESS");				
			} else {
				mv.addObject("result", "codeFail");
			}
		} else {
			mv.addObject("result", "timeOver");
			selectDao.deleteCheckSendAuthData(userId);
		}
		mv.setViewName("jsonView");
		return mv;
	}
}
