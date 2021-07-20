package com.netMiner.app.controller;


import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.UriComponentsBuilder;


import com.fasterxml.jackson.annotation.JsonInclude.Include;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.PropertyNamingStrategy;
import com.netMiner.app.model.service.MemberService;
import com.netMiner.app.model.vo.GoogleOAuthRequest;
import com.netMiner.app.model.vo.GoogleOAuthResponse;
import com.netMiner.app.model.vo.MemberVo;
import com.netMiner.app.util.CryptUtil;

/**
 * Servlet implementation class GoogleController
 */
@Controller
public class GoogleController  {
	private static final Logger logger = org.slf4j.LoggerFactory.getLogger(GoogleController.class);
	
	final static String GOOGLE_AUTH_BASE_URL = "https://accounts.google.com/o/oauth2/v2/auth";
	final static String GOOGLE_TOKEN_BASE_URL = "https://oauth2.googleapis.com/token";
	final static String GOOGLE_REVOKE_TOKEN_BASE_URL = "https://oauth2.googleapis.com/revoke";
	//final static String GOOGLE_CALL_BACK_LOGIN_URL = "http://localhost:8080/auth";	
	//final static String GOOGLE_CALL_BACK_REGISTER_URL = "http://localhost:8080/socialRegister";
	
	final static String GOOGLE_CALL_BACK_LOGIN_URL = "https://www.netminer365.com/auth";	
	final static String GOOGLE_CALL_BACK_REGISTER_URL = "https://www.netminer365.com/socialRegister";
	
	
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
		CryptUtil cu = new CryptUtil();
		String authCode = request.getParameter("code");
		String language = (String) session.getAttribute("language");
		if (language == null) {
			language = "";
		}
		try {			
			if (authCode == null || authCode.equals("")) {
				if (language.equals("_EN")) {
					
					mv.setViewName("member"+language+"/login");
					return mv;			
				} else {
					mv.setViewName("member/login");
					return mv;					
				}
			}
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

		int count = memberService.checkUser( (String) userInfo.get("email"));
		
		boolean checkUserCount = true; 
		
		if (count > 0) {
			checkUserCount = false;
		}
		mv.addObject("userInfo",userInfo);
		
		MemberVo member = memberService.getUserInfo(memberVo);
		if (member == null) {
			url = "member"+language+"/register_sns_fail";									
		} else {
			if ("03".equals(member.getUserCode()) && "N".equals(member.getUserStatsYn())) {
				
				// 휴면 계정인 경우 휴면 계정 페이지로 이동 후 재 로그인 
				session.setAttribute("outMemberVo", memberVo);
				url = "member"+language+"/activate";
			} else if ("Y".equals(member.getUserStatsYn())) {
				response.setContentType("text/html; charset=UTF-8"); 
				PrintWriter out = response.getWriter(); 
				
				if (language.equals("_EN")) {
					out.println("<script>alert('The ID has been withdrawn.'); location.href='./login';</script>"); 				
				} else {
					out.println("<script>alert('해당 아이디는 탈퇴 되었습니다.'); location.href='./login';</script>"); 				
				}
				out.flush();

				url = "member"+language+"/login";
			} else {
				session.setAttribute("memberVo", member);
				session.setAttribute("memberId", cu.encryptLoginfo(memberVo.getUserId(), "02", memberVo.getNo()));
				url = "homePage"+language+"/main";
			}
		}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		mv.setViewName(url);
		return mv;
	}
	
	
	@RequestMapping(value = "socialRegister", method = RequestMethod.GET)
	public ModelAndView googleRegister(ModelAndView mv, HttpServletRequest request, HttpSession session, HttpServletResponse response)
			throws JsonProcessingException {
		String url = "";
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
		//model.addAllAttributes(userInfo);
		mv.addObject("userInfo", userInfo);
		MemberVo memberVo = new MemberVo();
		memberVo.setUserId(userInfo.get("email"));
		memberVo.setUserPwd(userInfo.get("kid"));
		int count = memberService.checkUser( (String) userInfo.get("email"));
		boolean checkUserCount = true; 
		
		if (count > 0) {
			checkUserCount = false;
		}
		
		if (checkUserCount) {			
			url = "member"+language+"/register_sns";
		} else {
			response.setContentType("text/html; charset=UTF-8"); 
			PrintWriter out = response.getWriter(); 
			if (language.equals("_EN")) {
				out.println("<script>alert('This email address already exists.'); location.href='./login';</script>"); 
				out.flush();
			} else {
				out.println("<script>alert('이미 가입한 이메일입니다. '); location.href='./login';</script>"); 
			}
			out.flush();
			url = "member"+language+"/login";
		}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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
