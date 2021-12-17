package com.netMiner.app.controller;

import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.netMiner.app.config.SendEmail;
import com.netMiner.app.model.dao.SelectDao;
import com.netMiner.app.model.service.MemberService;
import com.netMiner.app.model.vo.MemberVo;
import com.netMiner.app.model.vo.NationVo;
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
	

	@RequestMapping(value="checkUser", method=RequestMethod.POST)
	public ModelAndView checkUser (ModelAndView mv, HttpServletRequest request, HttpSession session) {
		Base64Util base64 = new Base64Util();
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
		
		if(result) {
			String timestamp= new SimpleDateFormat("HHmm").format(new Date());
			String chk= String.format("%s,%s", timestamp, base64.enCodingBase64(userId));
			logger.info("chk {}", chk);
			session.setAttribute("chk", String.format("%s,%s", timestamp, base64.enCodingBase64(userId)));
		}
		
		return mv;
	}
	//email 재인증 또는 추후 회원정보 변경시 사용 
	@RequestMapping(value="emailSender" , method=RequestMethod.POST)
	public ModelAndView emailSender(HttpSession session, ModelAndView mv, HttpServletRequest request
			, @RequestParam HashMap<String, Object> json) {
		String language = (String) session.getAttribute("language");
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		logger.info("json {}", json);
		
		MemberVo memberVo = new MemberVo(json);
		if(session.getAttribute("language").toString().contains("EN")) {
			memberVo.setLanguage("en");
		} else {
			memberVo.setLanguage("ko");
		}
		
		String randomNumber = sendEmail.sendCheckEmail(memberVo.getUserId(), language);
		
		//임시 유저 저장 
		if (!"".equals(randomNumber)) {
			memberService.insertMemberInfoTmp(memberVo);					
		}
		
		mv.addObject("randomNumber", randomNumber);
		mv.setViewName("jsonView");
		return mv;
	}
	@RequestMapping(value="checkRandomNumber" ,method=RequestMethod.POST)
	public ModelAndView checkRandomNumber(ModelAndView mv ,HttpServletRequest request, HttpSession session) {
		try {
			String randomNumber = request.getParameter("randomNumber");
			String chk= (String) session.getAttribute("chk");
			logger.info("chk {}", chk);

			String timestamp= new SimpleDateFormat("HHmm").format(new Date());
			String userId= new Base64Util().deCodingBase64(chk.split(",")[1]);
			String oldTimestamp= chk.split(",")[0];
			logger.info("goChangePwd : {}, {}, {}", chk, userId, timestamp);
			
			if(Integer.parseInt(timestamp) - Integer.parseInt(oldTimestamp)>30) {
				mv.addObject("result", "timeOver");
				return mv;
			}
			
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
		}catch(Exception e) {
			mv.addObject("result", "timeOver");
		}
		
		mv.setViewName("jsonView");
		return mv;
	}
	@RequestMapping(value="sendNewRandom", method=RequestMethod.POST)
	public ModelAndView sendNewRandom (ModelAndView mv , HttpServletRequest request, HttpSession session) {
		try {
			String language = (String) session.getAttribute("language");
			String chk= (String) session.getAttribute("chk");
			logger.info("chk {}", chk);
			
			String timestamp= new SimpleDateFormat("HHmm").format(new Date());
			String userId= new Base64Util().deCodingBase64(chk.split(",")[1]);
			String oldTimestamp= chk.split(",")[0];
			logger.info("goChangePwd : {}, {}, {}", chk, userId, timestamp);
			
			if(Integer.parseInt(timestamp) - Integer.parseInt(oldTimestamp)>30) {
				mv.addObject("result", "timeOver");
				return mv;
			}
			
			selectDao.deleteCheckSendAuthData(userId);
			
			sendEmail.sendCheckEmail(userId, language);
			//mv.addObject("randomNumber", randomNumber);
			
			mv.addObject("result", 0);
			
		}catch(Exception e) {
			mv.addObject("result", "timeOver");
		}
		
		mv.setViewName("jsonView");
		return mv;
	}
	
	@RequestMapping(value= "registerStep", method = RequestMethod.POST)
	public ModelAndView registerStep(HttpServletRequest request,HttpSession session) {
		ModelAndView mv = new ModelAndView();
		MemberVo memberVo = new MemberVo();
		String language = (String) session.getAttribute("language");
		
		try {
			request.setCharacterEncoding("UTF-8");

			String userId = request.getParameter("email");			
			String marketYn = request.getParameter("marketYn");
			
			logger.info("registerStep memberVo {}", memberVo);
			memberVo.setUserId(userId);
			memberVo = memberService.getUserInfoTmp(memberVo);
			memberVo.setMarketYn(marketYn);
			memberVo.setGoogleYn("N");
			
			logger.info("registerStep memberVo {}", memberVo);
			
			memberService.signUpGeneral(memberVo);			 
			memberService.deleteMemberInfoTmp(memberVo);
			sendEmail.sendRegisterMail(userId, "", language);
			
			//해당 유저의 password 가 없으므로 쿼리상으로 google yn 을 강제로 Y로 변경후 데이터 가지고옴 
			memberVo.setGoogleYn("Y");
			MemberVo loginMemberVo = memberService.getUserInfo(memberVo);
			logger.info("loginMemberVo {}", loginMemberVo);
			
			session.setAttribute("memberVo", loginMemberVo);
			session.setAttribute("memberId", CryptUtil.getInstance().encryptLoginfo(loginMemberVo));
			
			mv.setViewName("jsonView");
		} catch (Exception e) {
			logger.error("err ", e);
		}

		return mv;
	}

	@RequestMapping(value="registerSNS" , method=RequestMethod.POST)
	public ModelAndView registerSNS (HttpSession session, ModelAndView mv, HttpServletRequest request, MemberVo form) {
		String language = (String) session.getAttribute("language");
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		try {
			if(session.getAttribute("language").toString().contains("EN")) {
				form.setLanguage("en");
			} else {
				form.setLanguage("ko");
			}
			memberService.signUp(form);
			sendEmail.sendRegisterMail(form.getUserId(), "", language);
			
			MemberVo loginMember= memberService.getUserInfoLastlogin(form);
			session.setAttribute("memberVo", loginMember);
			
			logger.info("로그인 유저 정보 - {}",loginMember.toString());
			session.setAttribute("memberId", CryptUtil.getInstance().encryptLoginfo(loginMember));
			session.setAttribute("chk", "registorSNS");
			
			mv.addObject("state", "success");
			
		} catch (Exception e) {
			mv.addObject("state", "fail");
		}
//		mv.setViewName("homePage"+language+"/register_complete");
		
		mv.setViewName("jsonView");
		return mv;
	}
	
	@RequestMapping(value="updateUserInfo", method=RequestMethod.POST)
	public ModelAndView updateUserInfo (ModelAndView mv,HttpServletRequest request, HttpSession session, MemberVo form) {
		MemberVo memberVo= (MemberVo) session.getAttribute("memberVo");

		try {
			if(session.getAttribute("language").toString().contains("EN")) {
				form.setLanguage("en");
			} else {
				form.setLanguage("ko");
			}
			memberVo.setUserPwd(form.getUserPwd());
			MemberVo getUserInfo= memberService.getUserInfo(memberVo);
			logger.info("memberVo -{}", memberVo.toString());

			if("Y".equals(memberVo.getGoogleYn())) {
				form.setOldUserId(getUserInfo.getUserId());
				memberService.updateNewUserInfo(null, form);
				logger.info("form {}", form);

				form.setUserId(memberVo.getUserId());
				form = memberService.getUserInfo(form);
				session.setAttribute("memberVo", form);
				
				mv.addObject("state", "success");
				
			}else if(getUserInfo != null && getUserInfo.getUserPwd().equals(getUserInfo.getChk())) {
				logger.info("form - {}", form.toString());

				form.setOldUserId(getUserInfo.getUserId());
				memberService.updateNewUserInfo(null, form);
				
				form.setUserId(getUserInfo.getUserId());
				form = memberService.getUserInfo(form);
				session.setAttribute("memberVo", form);
				
				mv.addObject("state", "success");
			} else {
				mv.addObject("state", "fail");
			}
		}catch(Exception e) {
			mv.addObject("state", "fail");
		}

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
		memberService.changeMemberInfo(vo);
		
		session.removeAttribute("memberVo");
		mv.setViewName("jsonView");
		return mv;
	}
	
	@RequestMapping(value="getNationCode", method = RequestMethod.GET, produces = "application/text; charset=utf8")
	public @ResponseBody ModelAndView getNationCode(ModelAndView mv, HttpServletRequest requets, HttpServletResponse response, HttpSession session) {
		MemberVo vo = new MemberVo();
		String nationCode = "";
		if (session.getAttribute("memberVo") != null) {
			vo = (MemberVo) session.getAttribute("memberVo");
			logger.info("membervo- {}", vo.toString());
			if (vo.getNation() != null) {
				nationCode = vo.getNation();		
			}
			mv.addObject("userNationCode", nationCode);
		}
		List<NationVo> result = selectDao.getNation();
		mv.addObject("NationVo", result);
		mv.setViewName("jsonView");
		response.setContentType("application/x-json; charset=UTF-8");
		return mv;
	}

	@RequestMapping(value="getNow" , method= RequestMethod.GET)
	public ModelAndView getNow(ModelAndView mv) {
		String dateTime="";
		try {
			dateTime = selectDao.getNowDate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		mv.addObject("nowDateTime", dateTime);
		mv.setViewName("jsonView");
		return mv;
	}
	
	
	
	
	
	
	
	
	

	@RequestMapping(value="changeEmail", method=RequestMethod.POST)
	public ModelAndView changeEmail(ModelAndView mv , HttpServletRequest request, HttpSession session) {
		String userId = request.getParameter("email");
		String language = (String) session.getAttribute("language");
		
		String randomNumber = sendEmail.sendCheckEmail(userId, language);
		mv.addObject("randomNumber", randomNumber);
		mv.setViewName("jsonView");
		return mv;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	@RequestMapping(value="chkUserInfoPwdProc" , method=RequestMethod.POST)
	public ModelAndView chkUserInfoPwdProc(ModelAndView mv, HttpServletRequest request) {
		String userId= request.getParameter("email");
		String userPwd= request.getParameter("pwd");
		
		MemberVo vo = new MemberVo();
		vo.setUserId(userId);
		vo.setUserPwd(userPwd);
		vo.setGoogleYn("N");
		MemberVo member= memberService.getUserInfo(vo);
		logger.info("member {}", member);
		
		if(member!=null && member.getUserPwd().equals(member.getChk())) {
			mv.addObject("result", 0);
		} else {
			mv.addObject("result", 1);
		}
		mv.setViewName("jsonView");
		return mv;
	}
	@RequestMapping( value="findUserInfo", method=RequestMethod.POST)
	public ModelAndView findUserInfo (ModelAndView mv,HttpServletRequest request, HttpSession session) throws UnsupportedEncodingException {
		String language = (String) session.getAttribute("language");
		Base64Util base64 = new Base64Util();
		
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
		
		String timestamp= new SimpleDateFormat("HHmm").format(new Date());
		session.setAttribute("chk", String.format("%s,%s", timestamp, base64.enCodingBase64(userId)));
		
		return mv;
	}
	@RequestMapping(value="changeNewPwd" , method=RequestMethod.POST)
	public ModelAndView changeNewPwds(ModelAndView mv,HttpServletRequest request, HttpSession session) {
		String userId = request.getParameter("email");
		String userPwd = request.getParameter("pwd");
		
		MemberVo vo = new MemberVo();
		vo.setUserId(userId);
		vo.setUserPwd(userPwd);
		
		memberService.updateNewPwd(vo);
		selectDao.deleteCheckSendAuthData(userId);
		session.setAttribute("chk", null);
		
		mv.setViewName("jsonView");
		return mv;
	}
	@RequestMapping(value="changeNewPwd2" , method=RequestMethod.POST)
	public ModelAndView changeNewPwds2(ModelAndView mv,HttpServletRequest request, HttpSession session) {
		String userId = request.getParameter("email");
		String userPwd = request.getParameter("pwd");
		String userPwd2 = request.getParameter("pwd2");
		
		MemberVo vo = new MemberVo();
		vo.setUserId(userId);
		vo.setUserPwd(userPwd);
		vo= memberService.getUserInfo(vo);
		logger.info("vo {}", vo);
		
		if(vo!=null) {
			if(vo.getUserPwd().equals(vo.getChk())) {
				vo.setUserPwd(userPwd2);
				memberService.updateNewPwd(vo);
				
				mv.addObject("result", "o");
			} else {
				mv.addObject("result", "x");
			}
		} else {
			mv.addObject("result", "x");
		}
		
		mv.setViewName("jsonView");
		return mv;
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
}
