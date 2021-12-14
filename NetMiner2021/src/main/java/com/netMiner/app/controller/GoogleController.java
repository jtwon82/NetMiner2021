package com.netMiner.app.controller;


import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;
import org.springframework.web.util.UriComponentsBuilder;

import com.fasterxml.jackson.annotation.JsonInclude.Include;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.PropertyNamingStrategy;
import com.netMiner.app.config.Constant;
import com.netMiner.app.model.service.MemberService;
import com.netMiner.app.model.vo.GoogleOAuthRequest;
import com.netMiner.app.model.vo.GoogleOAuthResponse;
import com.netMiner.app.model.vo.MemberVo;
import com.netMiner.app.util.CryptUtil;
import com.netMiner.app.util.StringUtils2;

/**
 * Servlet implementation class GoogleController
 */
@Controller
public class GoogleController  {
	private static final Logger logger = org.slf4j.LoggerFactory.getLogger(GoogleController.class);
	
	final static String GOOGLE_AUTH_BASE_URL = "https://accounts.google.com/o/oauth2/v2/auth";
	final static String GOOGLE_TOKEN_BASE_URL = "https://oauth2.googleapis.com/token";
	final static String GOOGLE_REVOKE_TOKEN_BASE_URL = "https://oauth2.googleapis.com/revoke";

	String GOOGLE_CALL_BACK_LOGIN_URL;
	String GOOGLE_CALL_BACK_REGISTER_URL;
	
	private String clientId = "370772071579-3fkr20hhlegikl89aggi9jfjrlos4h46.apps.googleusercontent.com";
	private String clientSecret = "Xuvy3VghnbUWj0Y6racOHwCD";
	
	
	@Autowired
	private MemberService memberService;
	/**
	 * Authentication Code를 전달 받는 엔드포인트
	 **/
	@RequestMapping(value = "auth", method = RequestMethod.GET)
	public ModelAndView googleAuth(ModelAndView mv ,HttpServletRequest request ,HttpServletResponse response ,HttpSession session)
			throws JsonProcessingException {
		String url = "";
		String authCode = request.getParameter("code");
		String language = (String) session.getAttribute("language");
		
		GOOGLE_CALL_BACK_LOGIN_URL = Constant.getInstance(request).GOOGLE_CALL_BACK_LOGIN_URL;
		GOOGLE_CALL_BACK_REGISTER_URL = Constant.getInstance(request).GOOGLE_CALL_BACK_REGISTER_URL;
		
		if (language == null) {
			language = "";
		}
		try {
			// 일반로그인
			if (authCode == null || authCode.equals("")) {
				if(session.getAttribute("memberVo")!=null) {
					mv.setView(new RedirectView("/"));
					return mv;		
				}
				if (language.equals("_EN")) {
					mv.setViewName("member"+language+"/login");
					return mv;			
				} else {
					mv.setViewName("member/login");
					return mv;					
				}
			}
			
			// 구글로그인
			//HTTP Request를 위한 RestTemplate
			RestTemplate restTemplate = new RestTemplate();
			
			//Google OAuth Access Token 요청을 위한 파라미터 세팅
			GoogleOAuthRequest  googleOAuthRequestParam = GoogleOAuthRequest
					.builder()
					.clientId(clientId)
					.clientSecret(clientSecret)
					.code(authCode)
					.redirectUri(GOOGLE_CALL_BACK_LOGIN_URL)
					.grantType("authorization_code").build();
	
			
			//JSON 파싱을 위한 기본값 세팅
			//요청시 파라미터는 스네이크 케이스로 세팅되므로 Object mapper에 미리 설정해준다.
			ObjectMapper mapper = new ObjectMapper();
			mapper.setPropertyNamingStrategy(PropertyNamingStrategy.SNAKE_CASE);
			mapper.setSerializationInclusion(Include.NON_NULL);
	
			//AccessToken 발급 요청
			ResponseEntity<String> resultEntity = restTemplate.postForEntity(GOOGLE_TOKEN_BASE_URL, googleOAuthRequestParam, String.class);
	
			//Token Request
			GoogleOAuthResponse result = mapper.readValue(resultEntity.getBody(), new TypeReference<GoogleOAuthResponse>() {
				});
				
			//ID Token만 추출 (사용자의 정보는 jwt로 인코딩 되어있다)
			String jwtToken = result.getIdToken();
			String requestUrl = UriComponentsBuilder.fromHttpUrl("https://oauth2.googleapis.com/tokeninfo")
			.queryParam("id_token", jwtToken).encode().toUriString();
			
			String resultJson = restTemplate.getForObject(requestUrl, String.class);
			
			Map<String,String> userInfo = mapper.readValue(resultJson, new TypeReference<Map<String, String>>(){});
			
			MemberVo memberVo = new MemberVo();
			memberVo.setUserId(userInfo.get("email"));
			memberVo.setUserPwd(userInfo.get("kid"));
			memberVo.setGoogleYn("Y");
	
			mv.addObject("userInfo",userInfo);
	//		mv.addObject("GOOGLE_CALL_BACK_LOGIN_URL", GOOGLE_CALL_BACK_LOGIN_URL);
	//		mv.addObject("GOOGLE_CALL_BACK_REGISTER_URL", GOOGLE_CALL_BACK_REGISTER_URL);
			
			MemberVo member= memberService.getUserInfoLastlogin(memberVo);
			if ( member == null ) {
					url = "member"+language+"/register_sns_fail";
			} else {
				if ("03".equals(member.getUserCode()) && "N".equals(member.getUserStatsYn())) {
					// 휴면 계정인 경우 휴면 계정 페이지로 이동 후 재 로그인 
					session.setAttribute("outMemberVo", memberVo);
					url = "member"+language+"/activate";
					
				} else if ("Y".equals(member.getUserStatsYn())) {
					if (language.equals("_EN")) {
						StringUtils2.script(response, "The ID has been withdrawn.", "./login");
					} else {
						StringUtils2.script(response, "해당 아이디는 탈퇴 되었습니다", "./login");
					}
	
					url = "member"+language+"/login";
					
				} else {
					MemberVo t= new MemberVo();
					t.setUserId(member.getUserId());
					t.setUserCode(member.getUserCode());
					t.setNo(member.getNo());
					t.setLastLoginDate(member.getLastLoginDate());
					
					session.setAttribute("memberVo", member);
					session.setAttribute("memberId", CryptUtil.getInstance().encryptLoginfo(t));
					url = "homePage"+language+"/main";
				}
			}
		} catch (Exception e) {
			mv.setView(new RedirectView("/"));
			return mv;
		} 
		logger.info("url {}", url);
		mv.setViewName(url);
		return mv;
	}
	
	
	@RequestMapping(value = "socialRegister", method = RequestMethod.GET)
	public ModelAndView googleRegister(ModelAndView mv, HttpServletRequest request, HttpSession session, HttpServletResponse response)
			throws Exception {
		String url = "";
		try {
			String authCode = request.getParameter("code");
			String language = (String) session.getAttribute("language");
			if (language == null) {
				language = "";
			}
			try {
				if (authCode == null || authCode.equals("")) {
					if (language.equals("_EN")) {		
						mv.setViewName("member"+language+"/login");
					} else {
						mv.setViewName("member/login");				
					}
					return mv;
				}
				//HTTP Request를 위한 RestTemplate
			RestTemplate restTemplate = new RestTemplate();
			
			//Google OAuth Access Token 요청을 위한 파라미터 세팅
			GoogleOAuthRequest  googleOAuthRequestParam = GoogleOAuthRequest
					.builder()
					.clientId(clientId)
					.clientSecret(clientSecret)
					.code(authCode)
					.redirectUri(GOOGLE_CALL_BACK_REGISTER_URL)
					.grantType("authorization_code").build();

			
			//JSON 파싱을 위한 기본값 세팅
			//요청시 파라미터는 스네이크 케이스로 세팅되므로 Object mapper에 미리 설정해준다.
			ObjectMapper mapper = new ObjectMapper();
			mapper.setPropertyNamingStrategy(PropertyNamingStrategy.SNAKE_CASE);
			mapper.setSerializationInclusion(Include.NON_NULL);

			//AccessToken 발급 요청
			ResponseEntity<String> resultEntity = restTemplate.postForEntity(GOOGLE_TOKEN_BASE_URL, googleOAuthRequestParam, String.class);

			//Token Request
			GoogleOAuthResponse result = mapper.readValue(resultEntity.getBody(), new TypeReference<GoogleOAuthResponse>() {
				});
				
			//ID Token만 추출 (사용자의 정보는 jwt로 인코딩 되어있다)
			String jwtToken = result.getIdToken();
			String requestUrl = UriComponentsBuilder.fromHttpUrl("https://oauth2.googleapis.com/tokeninfo")
			.queryParam("id_token", jwtToken).encode().toUriString();
			
			String resultJson = restTemplate.getForObject(requestUrl, String.class);
			
			Map<String,String> userInfo = mapper.readValue(resultJson, new TypeReference<Map<String, String>>(){});
			logger.info("userInfo {}", userInfo);
			
			//model.addAllAttributes(userInfo);
			mv.addObject("userInfo", userInfo);
			
			MemberVo memberVo = new MemberVo();
			memberVo.setUserId(userInfo.get("email"));
			memberVo.setUserPwd(userInfo.get("kid"));
			int count= memberService.checkUser( (String) userInfo.get("email"));
			if (count < 1) {			
				url = "member"+language+"/register_sns";
				
			} else {
				if (language.equals("_EN")) {
					StringUtils2.script(response, "This email address already exists.", "./login");
				} else {
					StringUtils2.script(response, "이미 가입한 이메일입니다.", "./login");
				}
				url = "member"+language+"/login";
			}
			} catch (IOException e) {
				e.printStackTrace();
			} 
		} catch(Exception e) {
			mv.setView(new RedirectView("/"));
			return mv;
		}
		mv.setViewName(url);
		return mv;
	}

	/**
	 * 토큰 무효화 
	 **/
	@GetMapping("google/revoke/token")
	@ResponseBody
	public Map<String, String> revokeToken(@RequestParam(value = "token") String token) throws JsonProcessingException {

		Map<String, String> result = new HashMap<>();
		RestTemplate restTemplate = new RestTemplate();
		final String requestUrl = UriComponentsBuilder.fromHttpUrl(GOOGLE_REVOKE_TOKEN_BASE_URL)
				.queryParam("token", token).encode().toUriString();
		
		System.out.println("TOKEN ? " + token);
		
		String resultJson = restTemplate.postForObject(requestUrl, null, String.class);
		result.put("result", "success");
		result.put("resultJson", resultJson);

		return result;

	}
	
	

}
