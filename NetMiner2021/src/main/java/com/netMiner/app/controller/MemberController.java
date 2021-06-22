package com.netMiner.app.controller;

import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
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
				mv.setViewName("homePage/register");
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
	
	@RequestMapping(value="registerStep1", method = RequestMethod.POST)
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
			String marketYn = request.getParameter("marketYn");

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
			logger.info(memberVo.toString());
			memberService.signUp(memberVo);			 
	
			//session.setAttribute("userId", memberVo.getUserId());
			session.setAttribute("memberVo", memberVo);
			
		mv.setViewName("member/authentic");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}


		return mv;
	}
	
	//email 재인증 또는 추후 회원정보 변경시 사용 
	@RequestMapping(value="emailSender" , method=RequestMethod.GET)
	public ModelAndView sendEmail(HttpSession session, ModelAndView mv) {
	
		String userId = (String) session.getAttribute("userId");
		String randomNumber = sendEmail.sendCheckEmail(userId);

		mv.addObject("randomNumber", randomNumber);
		mv.setViewName("jsonView");
		return mv;
	}
	

	/*
	 * @GetMapping("google/auth") public String googleAuth(Model
	 * model, @RequestParam(value = "code") String authCode) throws
	 * JsonProcessingException {
	 * 
	 * //HTTP Request를 위한 RestTemplate RestTemplate restTemplate = new
	 * RestTemplate();
	 * 
	 * //Google OAuth Access Token 요청을 위한 파라미터 세팅 GoogleOAuthRequest
	 * googleOAuthRequestParam = GoogleOAuthRequest .builder() .clientId(clientId)
	 * .clientSecret(clientSecret) .code(authCode)
	 * .redirectUri("http://localhost:8080/login/google/auth")
	 * .grantType("authorization_code").build();
	 * 
	 * 
	 * //JSON 파싱을 위한 기본값 세팅 //요청시 파라미터는 스네이크 케이스로 세팅되므로 Object mapper에 미리 설정해준다.
	 * ObjectMapper mapper = new ObjectMapper();
	 * mapper.setPropertyNamingStrategy(PropertyNamingStrategy.SNAKE_CASE);
	 * mapper.setSerializationInclusion(Include.NON_NULL);
	 * 
	 * //AccessToken 발급 요청 ResponseEntity<String> resultEntity =
	 * restTemplate.postForEntity(GOOGLE_TOKEN_BASE_URL, googleOAuthRequestParam,
	 * String.class);
	 * 
	 * //Token Request GoogleOAuthResponse result =
	 * mapper.readValue(resultEntity.getBody(), new
	 * TypeReference<GoogleOAuthResponse>() { });
	 * 
	 * //ID Token만 추출 (사용자의 정보는 jwt로 인코딩 되어있다) String jwtToken =
	 * result.getIdToken(); String requestUrl =
	 * UriComponentsBuilder.fromHttpUrl("https://oauth2.googleapis.com/tokeninfo")
	 * .queryParam("id_token", jwtToken).encode().toUriString();
	 * 
	 * String resultJson = restTemplate.getForObject(requestUrl, String.class);
	 * 
	 * Map<String,String> userInfo = mapper.readValue(resultJson, new
	 * TypeReference<Map<String, String>>(){}); model.addAllAttributes(userInfo);
	 * model.addAttribute("token", result.getAccessToken());
	 * 
	 * 
	 * 
	 * return "/google.html";
	 * 
	 * }
	 */

}
