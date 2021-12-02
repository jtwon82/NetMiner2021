package com.netMiner.app.controller;

import java.io.PrintWriter;
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

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.netMiner.app.config.Constant;
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

//	@ExceptionHandler(Exception.class)
//	public Object exception(Exception e) {
//		return "check";
//	}

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model, HttpSession session) {
		logger.info("Welcome home! The client locale is {}.", locale);

		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);

		String formattedDate = dateFormat.format(date);

		model.addAttribute("serverTime", formattedDate );
		String language = (String) session.getAttribute("language");
		String url = "home"+language;
		
		try {
			Map<String, Object> checkData = selectDao.getCheckData();
			if (checkData != null) {
				if ("Y".equals(checkData.get("STATS_YN"))) {
					model.addAttribute("checkData", checkData);
					url = "homePage"+language+"/check";
				}
			}
		}catch(Exception e) {
			url = "homePage"+language+"/check";
		}
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
	public String goCheck (ModelAndView mv, HttpServletRequest request, HttpServletResponse response) {
		Locale local = request.getLocale();
		String location = local.toString();
		String language = "";
		if (!location.contains("KR")) {
			language = "_EN";
		}
		Map<String , Object> param = new HashMap<String ,Object>();
		
		if (!Constant.checkDBError) {
			try {
				param =  selectDao.getCheckData();
			}catch(Exception e) {
			}
			mv.addObject("checkData", param);						
		} else {
			param.put("END_DATE_YN","Y");
			param.put("COMMENT_KR","긴급 시스템 점검");
			param.put("COMMENT_EN","Temporary System Maintenance");
			mv.addObject("checkData",param);
		}
		
		return "homePage"+language+"/check";
	}
	@RequestMapping(value="turnToGeneral", method=RequestMethod.GET)
	public String turnToGeneral(HttpSession session, HttpServletResponse response) {
		CryptUtil cu = new CryptUtil();
		String language = (String) session.getAttribute("language");
		String url = "";
		try {
			MemberVo outMemberVo = (MemberVo) session.getAttribute("outMemberVo");
			if(outMemberVo==null) {
				return "redirect:/";
			}
			
			//휴면 계정 일반회원으로 변환
			int no =memberService.turnToGeneral(outMemberVo);
			//일반회원 계정으로 확인 
			outMemberVo.setNo(no);
			outMemberVo.setUserCode("02");
			
			session.setAttribute("memberVo", outMemberVo);
			MemberVo t= new MemberVo();
			t.setUserId(outMemberVo.getUserId());
			t.setUserCode("02");
			t.setNo(no);
			t.setLastLoginDate(outMemberVo.getLastLoginDate());
			session.setAttribute("memberId", cu.encryptLoginfo(t));
			
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
			e.printStackTrace();
		}
		return url;
	}
	@RequestMapping(value="logOut", method = RequestMethod.GET)
	public String logOut(HttpSession session) {
		String language = (String) session.getAttribute("language");
		session.removeAttribute("memberVo");
		session.setAttribute("language", language);		
		return "redirect:/";
	}
	
	@RequestMapping(value="loginUser", method = {RequestMethod.POST,RequestMethod.GET}) 
	public String loginUser(HttpServletRequest request,HttpSession session, HttpServletResponse response) {
		if(session.getAttribute("memberVo")!=null) {
			return "redirect:/";
		}
		CryptUtil cu= new CryptUtil();
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
			
			if(memberVo!=null) {
				logger.info("memberVo {}", memberVo.getMemberInfoMap());
				if ( "Y".equals(memberVo.getUserStatsYn())) {
					if (! "_EN".equals(language)) {
						StringUtils2.script(response, "입력하신 이메일 또는 비밀번호가 올바르지 않습니다.", "./login");
						url  = "member/login";
					} else {
						StringUtils2.script(response, "The email address or password is incorrect.", "./login");
						url  = "member"+language+"/login";
					}
				} else {
					if ("03".equals(memberVo.getUserCode()) && "N".equals(memberVo.getUserStatsYn())) {
						session.setAttribute("outMemberVo", memberVo);
						url = "member"+language+"/activate";
					} else {
						session.setAttribute("memberVo", memberVo);
						session.setAttribute("memberId", cu.encryptLoginfo(memberVo));
						url  = "redirect:/";
					}
				}
			} else {
				StringUtils2.script(response, "The email address or password is incorrect.", "./login");
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
		if(session.getAttribute("memberVo")==null) {
			return "redirect:/";
		}
		String language = (String) session.getAttribute("language");
		if (session.getAttribute("userId") != null) {
			session.removeAttribute("userId");
		}
		
		try {
//			MemberVo vo = (MemberVo) session.getAttribute("memberVo");
//			if (vo == null) {
//				response.setContentType("text/html; charset=UTF-8"); 
//				PrintWriter out;
//				out = response.getWriter();
//				out.println("<script>alert('로그인 정보가 없습니다.'); location.href='./login';</script>"); 
//				return "redirect:/login";
//			} else {
//	
//				return "member"+language+"/account";
//			}
			return "member"+language+"/account";
		} catch (Exception e) {
		} 
		return "/";
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
			param.put("userId", vo.getUserId());
			memberService.updateNewUserId(param);
			
			vo.setUserId(userId);
			vo= memberService.getUserInfo(vo);
			session.setAttribute("memberVo", vo);
			
		}  else {
			return "redirect:/";
		}

		session.setAttribute("chk", null);
		
		return "member"+language+"/account";
	}
	@RequestMapping(value="goCheckEmail", method=RequestMethod.GET)
	public String goCheckEmail (Model model,  HttpServletRequest request, HttpSession session) {
		if(session.getAttribute("chk")==null) {
			return "redirect:/";
		}
		Base64Util base64= new Base64Util();
		String language = (String) session.getAttribute("language");
		String userId= request.getParameter("userId");
		
		String chk= (String) session.getAttribute("chk");
		logger.info("chk:{}", chk);
		if(chk==null){
			return "redirect:/";
		}
		
		if(userId==null ) {
			String timestamp= new SimpleDateFormat("HHmm").format(new Date());
			userId= base64.deCodingBase64(chk.split(",")[1]);
			String oldTimestamp= chk.split(",")[0];
			logger.info("goChangePwd : {}, {}, {}", chk, userId, timestamp);
			
			if(Integer.parseInt(timestamp) - Integer.parseInt(oldTimestamp)>30) {
				return "redirect:/";
			}
		}
		
		model.addAttribute("userId", userId);
		
		String path = "member"+ language;
		return path+"/authentic";
	}
	@RequestMapping(value="moveCheckEmail", method = RequestMethod.GET)
	public String moveCheckEmail(Model model ,HttpSession session, HttpServletRequest request) {
		if(session.getAttribute("chk")==null) {
			return "redirect:/";
		}
		String language = (String) session.getAttribute("language");
		String userId = request.getParameter("userId");
		Map<String,Object> authData = selectDao.getauthData(userId);
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
			if ("_EN".equals(language)) {
				StringUtils2.script(response, "This link is no longer vaild. Please try resetting your password again.", "/");
			} else {
				StringUtils2.script(response, "이 URL은 더 이상 유효하지 않습니다. 다시 비밀번호 재설정을 요청하세요.", "/");
			}
			return "empty";
//			return "redirect:/";
		}
		
		if(userid.equals("")) {
			String timestamp= new SimpleDateFormat("HHmm").format(new Date());
			userid= base64.deCodingBase64(chk.split(",")[1]);
			String oldTimestamp= chk.split(",")[0];
			logger.info("goChangePwd : {}, {}, {}", chk, userid, timestamp);
			
			if(Integer.parseInt(timestamp) - Integer.parseInt(oldTimestamp)>30) {
				if ("_EN".equals(language)) {
					StringUtils2.script(response, "This link is no longer vaild. Please try resetting your password again.", "/");
				} else {
					StringUtils2.script(response, "이 URL은 더 이상 유효하지 않습니다. 다시 비밀번호 재설정을 요청하세요.", "/");
				}
				return "empty";
			}
		}
		
		Map<String,Object> result = selectDao.getauthData(userid);
		String DATE_CHECK= "N";
		try {
			DATE_CHECK= StringUtils.defaultIfEmpty((String) result.get("DATE_CHECK"), "N");
		}catch(Exception e) {
		}
		mv.addAttribute("userId",userid);
		mv.addAttribute("DATE_CHECK", DATE_CHECK);

		url = "member"+language+"/searchPw";
		
		return url;
	}
}
