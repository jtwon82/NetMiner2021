package com.netMiner.app.controller;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.netMiner.app.config.SendEmail;
import com.netMiner.app.model.dao.SelectDao;
import com.netMiner.app.model.service.MemberService;
import com.netMiner.app.model.vo.MemberVo;
import com.netMiner.app.util.Base64Util;
import com.netMiner.app.util.CryptUtil;
import com.netMiner.app.util.StringUtils2;

/**
 * Servlet implementation class PageMoveController
 */
@Controller
public class PageMoveController extends HttpServlet {
	private static final Logger logger = LoggerFactory.getLogger(PageMoveController.class);
	
	@Autowired
	private SelectDao selectDao;
	
	@Autowired
	private MemberService memberService;

	@Autowired
	private SendEmail sendEmail;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model, HttpSession session, HttpServletResponse response) throws IOException {
		logger.info("Welcome home! The client locale is {}.", locale);

		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		String formattedDate = dateFormat.format(new Date());
		model.addAttribute("serverTime", formattedDate );
		String language = (String) session.getAttribute("language");
		String url = "home"+language;
		
		logger.info("url {}", url);
		return url;
	}
	
	@RequestMapping(value="register" ,method =  RequestMethod.GET)
	public String register(HttpSession session) {
		if(session.getAttribute("memberVo")!=null) {
			return "redirect:/";
		}
		String language = (String) session.getAttribute("language");
		String path = "member"+ language;
		return path+"/register";		
	}
	@RequestMapping(value= {"login","login_dev"}, method = RequestMethod.GET)
	public String login(HttpSession session, HttpServletRequest request) {
		if(session.getAttribute("memberVo")!=null) {
			return "redirect:/";
		}
		String language = (String) session.getAttribute("language");
		if (language == null) {
			language = request.getParameter("language") == null ? "" : request.getParameter("language");
		}
		
		String path = "member"+ language;
		return path+"/login";
	}
	@RequestMapping(value="logOut", method = RequestMethod.GET)
	public String logOut(HttpSession session) {
		String language = (String) session.getAttribute("language");
		session.removeAttribute("memberVo");
		session.removeAttribute("billingVo");
		session.removeAttribute("billingOld");
		session.setAttribute("language", language);		
		return "redirect:/";
	}
	@RequestMapping(value="activate", method = RequestMethod.GET)
	public String activate(HttpSession session, HttpServletRequest request) {
		String language = (String) session.getAttribute("language");
		String path = "member"+ language;
		return path+"/activate";
	}
	@RequestMapping(value="whyNetMiner", method=RequestMethod.GET) 
	public String whyNetMiner (HttpSession session) {
		String language = (String) session.getAttribute("language");
		String path = "homePage"+ language;
		return path+"/whyNetminer";
	}
	@RequestMapping(value="feature", method=RequestMethod.GET) 
	public String feature (HttpSession session) {
		String language = (String) session.getAttribute("language");
		String path = "homePage"+ language;
		return path+"/feature";
	}
	@RequestMapping(value="function", method=RequestMethod.GET) 
	public String function (HttpSession session) {
		String language = (String) session.getAttribute("language");
		String path = "homePage"+ language;
		return path+"/function";
	}
	@RequestMapping(value="solution", method=RequestMethod.GET) 
	public String solution (HttpSession session) {
		String language = (String) session.getAttribute("language");
		String path = "homePage"+ language;
		return path+"/solution";
	}
	@RequestMapping(value="TermsOfService", method=RequestMethod.GET)
	public String termsOfService(HttpSession session) {
		String language = (String) session.getAttribute("language");
		String path = "homePage"+ language;
		return path+"/term";
	}
	@RequestMapping(value="Privacy", method=RequestMethod.GET)
	public String Privacy(HttpSession session) {
		String language = (String) session.getAttribute("language");
		String path = "homePage"+ language;
		return path+"/privacy";
	}
	

	
	
	
	
	@RequestMapping(value="check", method= {RequestMethod.GET, RequestMethod.POST})
	public String goCheck (ModelAndView mv, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws IOException {
		Locale local = request.getLocale();
		String location = local.toString();
		String language = "";
		if (!location.contains("KR")) {
			language = "_EN";
		}
		
//		if(!Constant.checkDBError)
//			response.sendRedirect("./");
		
		return "homePage"+language+"/check";
	}
	@RequestMapping(value="turnToGeneral", method=RequestMethod.GET)
	public String turnToGeneral(HttpSession session, HttpServletResponse response) {
		String language = (String) session.getAttribute("language");
		String url = "";
		try {
			MemberVo outMemberVo = (MemberVo) session.getAttribute("outMemberVo");
			if(outMemberVo==null) {
				return "redirect:/";
			}
			
			//휴면 계정 일반회원으로 변환
			int no =memberService.turnToGeneral(outMemberVo);
			MemberVo member= memberService.getUserInfoLastlogin(outMemberVo);
			
			//일반회원 계정으로 확인 
			session.setAttribute("memberVo", member);
			session.setAttribute("memberId", CryptUtil.getInstance().encryptLoginfo(member));
			
//			if ("_EN".equals(language)) {
//				StringUtils2.script(response, "Account conversion is complete.", "./");
//				
//			} else {
//				StringUtils2.script(response, "계정 전환이 완료 되었습니다.", "./");
//			}
			StringUtils2.script(response, language, "계정 전환이 완료 되었습니다.", "Account conversion is complete.", "./");
			url = "homePage"+language+"/main";
		} catch (Exception e) {
			e.printStackTrace();
		}
		return url;
	}
	@RequestMapping(value="loginUser", method = {RequestMethod.POST,RequestMethod.GET}) 
	public String loginUser(HttpServletRequest request,HttpSession session, HttpServletResponse response) {
		if(session.getAttribute("memberVo")!=null) {
			return "redirect:/";
		}
		MemberVo memberVo= new MemberVo();
		String url  = "";
		String language = (String) session.getAttribute("language");
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
			
			memberVo = memberService.getUserInfoLastlogin(memberVo);
			logger.info("memberVo {}", memberVo);
			
			if(memberVo!=null && memberVo.getUserPwd().equals(memberVo.getChk())) {
				logger.info("memberVo {}", memberVo.getMemberInfoMap());

				if ("03".equals(memberVo.getUserCode()) && "N".equals(memberVo.getUserStatsYn())) {
					session.setAttribute("outMemberVo", memberVo);
					url = "member"+language+"/activate";
					
				} else if ("03".equals(memberVo.getUserCode()) && "Y".equals(memberVo.getUserStatsYn())) {
					StringUtils2.script(response, language, "탈퇴한 회원입니다."
							, "탈퇴한 회원입니다.", "./login");
					url  = "member"+language+"/login";
					
				} else {
					session.setAttribute("memberVo", memberVo);
					session.setAttribute("memberId", CryptUtil.getInstance().encryptLoginfo(memberVo));
					url  = "redirect:/";
				}
				
//				if ( "Y".equals(memberVo.getUserStatsYn())) {
//					if (! "_EN".equals(language)) {
//						StringUtils2.script(response, "입력하신 이메일 또는 비밀번호가 올바르지 않습니다.", "./login");
//						url  = "member/login";
//					} else {
//						StringUtils2.script(response, "The email address or password is incorrect.", "./login");
//						url  = "member"+language+"/login";
//					}
//					
//					StringUtils2.script(response, language, "입력하신 이메일 또는 비밀번호가 올바르지 않습니다."
//							, "The email address or password is incorrect.", "./login");
//					url  = "member"+language+"/login";
//					
//				} else {
//					if ("03".equals(memberVo.getUserCode()) && "N".equals(memberVo.getUserStatsYn())) {
//						session.setAttribute("outMemberVo", memberVo);
//						url = "member"+language+"/activate";
//					} else {
//						session.setAttribute("memberVo", memberVo);
//						session.setAttribute("memberId", CryptUtil.getInstance().encryptLoginfo(memberVo));
//						url  = "redirect:/";
//					}
//				}
			} else {
				StringUtils2.script(response, language, "입력하신 이메일 또는 비밀번호가 올바르지 않습니다."
						, "The email address or password is incorrect.", "./login");
				url  = "member"+language+"/login";
			}
			
		} catch (Exception e) {
			logger.error("err ", e);
			url  = "member"+language+"/login";
		}
		return url;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	@RequestMapping(value="account" , method=RequestMethod.GET)
	public String accountUser(HttpSession session, HttpServletResponse response) {
		String language = (String) session.getAttribute("language");
		if(session.getAttribute("memberVo")==null) {
			StringUtils2.script(response, language, "로그인 정보가 없습니다.", "Nothing the login infomation.", "./login");
		}
		if (session.getAttribute("userId") != null) {
			session.removeAttribute("userId");
		}
		return "member"+language+"/account";
	}
	@RequestMapping(value="moveCheckEmail", method = RequestMethod.GET)
	public String moveCheckEmail(Model model ,HttpSession session, HttpServletRequest request) {
		if(session.getAttribute("chk")==null) {
			return "redirect:/login";
		}
		String language = (String) session.getAttribute("language");
		String chk= (String) session.getAttribute("chk");
		logger.info("chk:{}", chk);
		
		String timestamp= new SimpleDateFormat("HHmm").format(new Date());
		String userId= new Base64Util().deCodingBase64(chk.split(",")[1]);
		String oldTimestamp= chk.split(",")[0];
		logger.info("moveCheckEmail : {}, {}, {}", chk, userId, timestamp);

		Map<String,Object> authData = selectDao.getauthData(userId);
		
		if(Integer.parseInt(timestamp) - Integer.parseInt(oldTimestamp)>30) {
			return "redirect:/login";
		}
		
		model.addAttribute("authData", authData);
		model.addAttribute("userId", userId);
		String path = "member"+ language;
		return  path+"/authentic";
	}
	@RequestMapping(value="registerComplete", method=RequestMethod.GET)
	public String registerComplete (HttpSession session) {
		if(session.getAttribute("chk")==null) {
			return "redirect:/";
		}
		session.setAttribute("chk", null);
		
		String language = (String) session.getAttribute("language");
		String path = "member"+ language;
		return path + "/register_complete";
	}
	
	

	@RequestMapping(value="goCheckEmail", method=RequestMethod.GET)
	public String goCheckEmail (Model model,  HttpServletRequest request, HttpSession session) {
		if(session.getAttribute("chk")==null) {
			return "redirect:/";
		}
		String language = (String) session.getAttribute("language");
		String chk= (String) session.getAttribute("chk");
		logger.info("chk:{}", chk);
		
		String timestamp= new SimpleDateFormat("HHmm").format(new Date());
		String userId= new Base64Util().deCodingBase64(chk.split(",")[1]);
		String oldTimestamp= chk.split(",")[0];
		logger.info("goChangePwd : {}, {}, {}", chk, userId, timestamp);
		
		if(Integer.parseInt(timestamp) - Integer.parseInt(oldTimestamp)>30) {
			return "redirect:/";
		}
		
		model.addAttribute("userId", userId);
		
		String path = "member"+ language;
		return path+"/authentic";
	}
	@RequestMapping(value="registerCheckEmail", method=RequestMethod.GET) 
	public String registerCheckEmail (HttpSession session, HttpServletRequest request) {
		if(session.getAttribute("chk")==null) {
			return "redirect:/";
		}
		String language = (String) session.getAttribute("language");
		String userId= request.getParameter("userId");
		
		MemberVo vo= (MemberVo) session.getAttribute("memberVo");
		
		Map<String , Object> param = new HashMap<String, Object>();
		param.put("newUserId", userId);
		int count  = memberService.selectUserCount(param);
		if (count == 0) {
			if(vo.getUserId()==null) {
				return "redirect:/";
			} else {
				param.put("userId", vo.getUserId());
				memberService.updateNewUserId(param);
				
				vo.setUserId(userId);
				vo= memberService.getUserInfo(vo);
				session.setAttribute("memberVo", vo);
			}
		}  else {
			return "redirect:/";
		}

		session.setAttribute("chk", null);
		
		return "member"+language+"/account";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	@RequestMapping(value="findPwd", method = RequestMethod.GET)
	public String findPwd(HttpSession session) {
		if(session.getAttribute("memberVo")!=null) {
			return "redirect:/";
		}
		String language = (String) session.getAttribute("language");
		String path = "member"+ language;
		return path+"/searchPw";
	}
	@RequestMapping(value="goChangePwd", method=RequestMethod.GET) 
	public String goChangePwd (Model mv, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		Base64Util base64 = new Base64Util();
		String userid= base64.deCodingBase64(request.getParameter("userId"));
		String language= base64.deCodingBase64(request.getParameter("language"));
		String url = "";

		String chk= (String) session.getAttribute("chk");
		logger.info("chk:{}", chk);
		if(chk==null){
//			if ("_EN".equals(language)) {
//				StringUtils2.script(response, "This link is no longer vaild. Please try resetting your password again.", "/");
//			} else {
//				StringUtils2.script(response, "이 URL은 더 이상 유효하지 않습니다. 다시 비밀번호 재설정을 요청하세요.", "/");
//			}
			StringUtils2.script(response, language, "이 URL은 더 이상 유효하지 않습니다. 다시 비밀번호 재설정을 요청하세요."
					, "This link is no longer vaild. Please try resetting your password again.", "/");
			return "empty";
//			return "redirect:/";
		}
		
		if(userid.equals("")) {
			String timestamp= new SimpleDateFormat("HHmm").format(new Date());
			userid= base64.deCodingBase64(chk.split(",")[1]);
			String oldTimestamp= chk.split(",")[0];
			logger.info("goChangePwd : {}, {}, {}", chk, userid, timestamp);
			
			if(Integer.parseInt(timestamp) - Integer.parseInt(oldTimestamp)>30) {
//				if ("_EN".equals(language)) {
//					StringUtils2.script(response, "This link is no longer vaild. Please try resetting your password again.", "/");
//				} else {
//					StringUtils2.script(response, "이 URL은 더 이상 유효하지 않습니다. 다시 비밀번호 재설정을 요청하세요.", "/");
//				}
				StringUtils2.script(response, language, "이 URL은 더 이상 유효하지 않습니다. 다시 비밀번호 재설정을 요청하세요."
						, "This link is no longer vaild. Please try resetting your password again.", "/");
				return "empty";
			}
		}
		
		Map<String,Object> result = selectDao.getauthData(userid);
		String DATE_CHECK= "N";
		try {
			DATE_CHECK= StringUtils2.defaultIfEmpty((String) result.get("DATE_CHECK"), "N");
		}catch(Exception e) {
		}
		mv.addAttribute("userId",userid);
		mv.addAttribute("DATE_CHECK", DATE_CHECK);

		url = "member"+language+"/searchPw";
		
		return url;
	}
	
	
}
