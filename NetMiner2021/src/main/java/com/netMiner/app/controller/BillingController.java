package com.netMiner.app.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Base64;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ThreadLocalRandom;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.*;
import org.springframework.http.client.ClientHttpResponse;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.netMiner.app.config.Constant;
import com.netMiner.app.config.SendEmail;
import com.netMiner.app.model.service.BillingService;
import com.netMiner.app.model.service.MemberService;
import com.netMiner.app.model.vo.BillingVo;
import com.netMiner.app.model.vo.MemberVo;
import com.netMiner.app.util.Base64Util;
import com.netMiner.app.util.StringUtils2;

@Controller
public class BillingController extends HttpServlet {

	private static final Logger logger = LoggerFactory.getLogger(BillingController.class);
	
	@Autowired
	private BillingService billingService;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private SendEmail sendEmail;
	
	
	private final ObjectMapper objectMapper = new ObjectMapper();
	private final RestTemplate restTemplate = new RestTemplate();
	/*page Move Billing*/
	@RequestMapping(value="pricing", method=RequestMethod.GET) 
	public String pricing (Model mv,HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		String language = (String) session.getAttribute("language");
		MemberVo member = (MemberVo) session.getAttribute("memberVo");
		String type = (String) request.getParameter("type");

		Map<String,Object> param = new HashMap<String,Object>();
		if (language.equals("_EN")) {
			param.put("language","en");
		} else {
			param.put("language","ko");
		}

		//faq 는 해당 유저의 정보 없이도 알수있어야 하므로 선 select 
		List<Map<String,Object>> faqList = billingService.selectFaqList(param);
		logger.info("faqList - {}", faqList.toString());
		mv.addAttribute("faqList", faqList);
		// 비회원 유저인경우 해당 프라이싱 페이지로 바로 이동 
		if (member == null ) {
			String path = "homePage"+ language;
			return path+"/pricing";
		}

		String userId = member.getUserId();
		boolean checkDate = false;

		param = new HashMap<String,Object>();
		param.put("userId", userId);
		Map<String, Object> result = billingService.selectSubscript(param);
		int diffDays = 0;
		logger.info("result- {}",result);
		if (result != null) {
			diffDays = Integer.parseInt(result.get("DIFF_DAY").toString());
		}
		
		/*
		Date nowDate = new Date(System.currentTimeMillis());
		 SimpleDateFormat dateFormat = new 
	                SimpleDateFormat ("yyyy-MM-dd");
		 if (result != null) {
			 try {
					Date now = dateFormat.parse(dateFormat.format(nowDate));
					Date exitsDate = dateFormat.parse(dateFormat.format(result.get("EXITS_DATE")));
					logger.info("date1 -{}",now.toString());
					logger.info("date2 -{}",exitsDate.toString());
					diffDays = (int) (((exitsDate.getTime() - now.getTime())/1000)/ (24*60*60));					
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
		 }
		 */		 
		if (diffDays <= 0) {
			result = null;
		}
		
		//해당 유저의 플랜타입 01 사용여부 확인 
		Map<String, Object> checkUserTiralInfo = billingService.checkUserTiralInfo(param);
		logger.info("checkUserTiralInfo- {}",checkUserTiralInfo);
		//해당유저의 현재 플랜과 TRAIL 사용 여부와 동일한경우 
		if (result != null) {
			//Trial 를 사용한 사용자 
			if (result.get("PLAN_CODE").equals("01")) {
				//현재 사용중인 플랜이 Trial 인경우
				member.setPlanType(1);
			} else {
				//현재 사용중인 플랜이 Trial 이 아닌경우 
				if (type != null) {
					if (type.indexOf("changePlan") > 0) {
						//해당 플랜 변경인지 
						member.setPlanType(1);
					} else if (type.indexOf("upgradePlan") > 0) {
						//해당 플랜의 업그레이드인지 						
						member.setPlanType(Integer.parseInt((String) result.get("PLAN_CODE")));							
					} else {
						//billing 를 통해 들어온 user 가 아닌경우 
						member.setPlanType(Integer.parseInt((String) result.get("PLAN_CODE")));
					}
				} else {
					
					member.setPlanType(Integer.parseInt((String) result.get("PLAN_CODE")));
				}
			}
		} else {
				//Trial 를 사용하지 않고 바로 진행한후  경우
			if (checkUserTiralInfo != null) {
				member.setPlanType(-1);
			} else { 
				//신규  사용자 
				member.setPlanType(0);
			}
		}
		
		logger.info("memberPlanType- {}, language-{}", member.getPlanType(), member.getLanguage());
		session.setAttribute("memberVo",member);
		logger.info(language);
		String path = "homePage"+ language;
		return path+"/pricing";
	}
	
	@RequestMapping(value="billing", method=RequestMethod.GET) 
	public String billing (HttpSession session, Model mv,HttpServletRequest request, HttpServletResponse response) {
		String language = (String) session.getAttribute("language");
		MemberVo member = (MemberVo) session.getAttribute("memberVo");
		if (member == null ) {
			return "redirect:/login";
		}
		String userId = member.getUserId();
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("userId", userId);
		List<Map<String,Object>> billingList = billingService.selectSubscriptAll(param);
		Map<String, Object> nowPlan = billingService.selectSubscript(param);
		
		BillingVo billingVo = new BillingVo().fromMap((HashMap<String, Object>)nowPlan);
		/*
		int diffDays = 0;
		Date nowDate = new Date(System.currentTimeMillis());
		 SimpleDateFormat dateFormat = new 
	                SimpleDateFormat ("yyyy-MM-dd");
		 if (nowPlan != null) {
			 try {
					Date now = dateFormat.parse(dateFormat.format(nowDate));
					Date exitsDate = dateFormat.parse(dateFormat.format(nowPlan.get("EXITS_DATE")));
					logger.info("date1 -{}",now.toString());
					logger.info("date2 -{}",exitsDate.toString());
					diffDays = (int) (((exitsDate.getTime() - now.getTime())/1000)/ (24*60*60));					
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
		 }
		 */
		int diffDays = billingVo.getDiffDay();
		 //플랜 만료 7일 timestamp		 
		 
		if (nowPlan == null && billingList.size() > 0) {
			// 현재 플랜은 없고 이전 결재 내역이 있는경우 
			mv.addAttribute("nowPlan", "none");
			mv.addAttribute("billingList", billingList);
		} else if (nowPlan != null && billingList.size() == 0) {
			// 현재 플랜은 있으나  이전 결재 내역이 없는경우 
			mv.addAttribute("nowPlan", nowPlan);
			mv.addAttribute("diffDays", diffDays);
			mv.addAttribute("billingList", "none");
			billingVo.setDiffDay(diffDays);
			session.setAttribute("billingOld", billingVo);
		} else if (nowPlan != null && billingList.size() > 0){
			// 둘다 존재 하는 경우 
			mv.addAttribute("nowPlan", nowPlan);
			mv.addAttribute("diffDays", diffDays);
			mv.addAttribute("billingList", billingList);
			billingVo.setDiffDay(diffDays);
			session.setAttribute("billingOld", billingVo);
		} else {
			//현재 플랜도 없고 이전 결재 내역또한 없는경우 
			mv.addAttribute("nowPlan","none");
			mv.addAttribute("billingList", "none");
			
		}
		String path = "homePage"+ language;
		return path + "/billing";
	}
	
	@RequestMapping(value="goSubscribe", method=RequestMethod.GET) 
	public String subscribe (Model mv,HttpSession session,HttpServletRequest request, HttpServletResponse response) {
		String language = (String) session.getAttribute("language");
		String path = "homePage"+ language;
		String payNo= request.getParameter("payNo");
		String planCode= request.getParameter("planCode");
		String dateType = request.getParameter("dateType") == null ? "year" : request.getParameter("dateType");
		String payType = request.getParameter("payType") == null ? "card" : request.getParameter("payType");
		BillingVo billingVo = (BillingVo) session.getAttribute("billing");
		BillingVo billingOldVo = (BillingVo) session.getAttribute("billingOld");
		MemberVo memberVo = (MemberVo) session.getAttribute("memberVo");
		String timestamp= new SimpleDateFormat("HHmmss").format(new Date());
		int randomNo= ThreadLocalRandom.current().nextInt(1000000, 10000000);
		String pagePath = "";
		logger.info("hellow");
		if (memberVo == null ) {
			return "redirect:/login";
		}
		logger.info("dateType- {}", dateType);
		logger.info("billingOldVo-{}",billingOldVo);
		
		//planCode 가 널인경우 새로 고침이므로 메인으로 이동 
		if (planCode == null && payNo == null) {
			return "redirect:/";
		}
		
		//pricing 으로 통해 들어온 유저인경우 이전 billingOldVo 가 없기때문에 해당 부분확인해야함
		if (billingOldVo == null) {
			String userId = memberVo.getUserId();
			Map<String,Object> param = new HashMap<String,Object>();
			param.put("userId", userId);
			Map<String, Object> nowPlan = null ;
			nowPlan = billingService.selectSubscript(param);
			if (nowPlan != null) {
				billingOldVo = new BillingVo().fromMap((HashMap<String, Object>)nowPlan);
				/*
				int diffDays = 0;
				Date nowDate = new Date(System.currentTimeMillis());
				SimpleDateFormat dateFormat = new 
						SimpleDateFormat ("yyyy-MM-dd");
				try {
					Date now = dateFormat.parse(dateFormat.format(nowDate));
					Date exitsDate = dateFormat.parse(dateFormat.format(nowPlan.get("EXITS_DATE")));

					diffDays = (int) (((exitsDate.getTime() - now.getTime())/1000)/ (24*60*60));					
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				billingOldVo.setDiffDay(diffDays);
				*/
				
			}
		}
		
		if (billingOldVo != null && 
				!billingOldVo.getPLAN_CODE().equals("01")
				&& payNo != null) {
			planCode = billingOldVo.getPLAN_CODE();
		}
		
		HashMap<String , Object> param= new HashMap<String , Object>();
		HashMap<String ,Object> billingMap= null;
		param.put("planCode", planCode);
		billingMap= billingService.selectPlanCode(param);	
		billingVo = new BillingVo().fromMap(billingMap);
		billingVo.setDATE_TYPE(dateType);
		billingVo.setORDER_ID("ORD_"+ new Base64Util().enCodingBase64(String.format("%s%s%s%s", planCode, dateType, timestamp, randomNo)));
		billingVo.setORDER_PNM(String.valueOf(randomNo));
		billingVo.setCUSTOMER_NAME("CUSTOMER_NAME");
		billingVo.setPAY_TYPE(payType);
		
		//billingOld Vo 가 널이 아니며 해당 마지막 결제 코드 01 인경우 해당 olDvo를 null 처리한다	
		if (billingOldVo != null) {
			//이전 결재 내역의 만료일 지난경우 해당 billingOldVo 를 null 로 처리 
			if (billingOldVo.getPLAN_CODE().equals("01")) {
				billingOldVo = null;
			}
		}
		
		logger.info("billingVoSelectPlanCode - {} ", billingVo.toString());
		if (! planCode.equals("01")) {
			if (language.equals("_EN")) {
				billingVo.setPAY_PLATFORM("paypal");
				if (billingOldVo != null) {
					if (billingOldVo.getDiffDay() >= -7 && billingOldVo.getDiffDay() <= 7) {
						//플랜 연장 인경우 
						if (dateType.equals("year")) {
							int total = (int) ((billingVo.getPLAN_PER_EN()* 12) - (billingVo.getPLAN_PER_EN()* 12 )* 0.2);
							billingVo.setPAY_PRICE(total);
							billingVo.setPAY_PRICE_VAT(billingVo.getPAY_PRICE()* 100/110);
							billingVo.setVAT(billingVo.getPAY_PRICE()-billingVo.getPAY_PRICE_VAT());
							billingVo.setDiffDay(365 + billingOldVo.getDiffDay());
							billingVo.setDATE_TYPE("year"); 
							billingVo.setType("extensionPlan");
						} else {
							billingVo.setPAY_PRICE( billingVo.getPLAN_PER_EN());
							billingVo.setPAY_PRICE_VAT(billingVo.getPAY_PRICE()* 100/110);
							billingVo.setVAT(billingVo.getPAY_PRICE()-billingVo.getPAY_PRICE()* 100/110);
							billingVo.setDiffDay(30 + billingOldVo.getDiffDay());
							billingVo.setDATE_TYPE("month");
							billingVo.setType("extensionPlan");
						}
						
					} else {
						String payPlatform = (String) billingOldVo.getPAY_PLATFORM(); 
						String payLanguage = payPlatform.equals("toss")?"ko":"en";
						String pageLanguage = language.equals("_EN")?"en":"ko";
						if (!payLanguage.equals(pageLanguage)) {
							 response.setContentType("text/html; charset=UTF-8");
							 String comment= "이전 결재 내역과 다른방식으로 결재를 진행할수 없습니다.";
							 if (pageLanguage.equals("en")) {
								 comment = "You cannot proceed with the payment in a different way than the previous payment history.";
							 }
							 PrintWriter out;
							try {
								out = response.getWriter();
								out.println("<script>alert('"+comment+"'); location.href='./billing';</script>");
								out.flush();
							} catch (IOException e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							}
						}
						
						if (billingOldVo.getDATE_TYPE().equals("year")) {
							// 1년에서 1년 업그레이드시
							int oldPrice = (int) ((billingOldVo.getPLAN_PER_EN()* 12) - (billingOldVo.getPLAN_PER_EN()* 12 )* 0.2);
							int nowPrice = (int) ((billingVo.getPLAN_PER_EN()* 12) - (billingVo.getPLAN_PER_EN()* 12 )* 0.2);
							//int result = (nowPrice/365*(billingOldVo.getDiffDay())) - oldPrice - (oldPrice * ((365 - billingOldVo.getDiffDay()) /365));
							double nowPricePerDay= Math.round(((double)nowPrice/365)*100) / 100.0;
							double oldPricePerDay = Math.round(((double)oldPrice/365)*100)/ 100.0;
							double firstResult = (billingOldVo.getDiffDay() * nowPricePerDay) - (oldPrice - (((365 - billingOldVo.getDiffDay()) * oldPricePerDay)));
							int result = (int) Math.round(firstResult);
								
							billingVo.setPAY_PRICE(result);
							billingVo.setPAY_PRICE_VAT(billingVo.getPAY_PRICE()* 100/110);
							billingVo.setVAT(billingVo.getPAY_PRICE()-billingVo.getPAY_PRICE()* 100/110);
							billingVo.setDiffDay(billingOldVo.getDiffDay());
							billingVo.setEXITS_DATE(billingOldVo.getEXITS_DATE());
							billingVo.setDATE_TYPE("year");
							billingVo.setType("upgradePlan");
							logger.info("billingVo year- {}", billingVo.toString());
						} else {
							// 한달에서 한달 업그레이드시 
							int oldPrice = billingOldVo.getPLAN_PER_EN();
							int nowPrice = billingVo.getPLAN_PER_EN();
							//int result = (nowPrice/30*(billingOldVo.getDiffDay())) - oldPrice - (oldPrice * ((30 - billingOldVo.getDiffDay()) /30));
							double nowPricePerDay= Math.round(((double)nowPrice/30)*100) / 100.0;						
							double oldPricePerDay = Math.round(((double)oldPrice/30)*100)/ 100.0;
							double firstResult = (billingOldVo.getDiffDay() * nowPricePerDay) - (oldPrice - (((30 - billingOldVo.getDiffDay()) * oldPricePerDay)));
							int result = (int) Math.round(firstResult);
							
							billingVo.setPAY_PRICE(result);
							billingVo.setPAY_PRICE_VAT(billingVo.getPAY_PRICE()* 100/110);
							billingVo.setVAT(billingVo.getPAY_PRICE()-billingVo.getPAY_PRICE()* 100/110);
							billingVo.setDiffDay(billingOldVo.getDiffDay());
							billingVo.setEXITS_DATE(billingOldVo.getEXITS_DATE());
							billingVo.setDATE_TYPE("month");
							billingVo.setType("upgradePlan");
							logger.info("billingVo month - {}", billingVo.toString());
						}					
					}
				} else {
					if (dateType.equals("year")) {
						int total = (int) ((billingVo.getPLAN_PER_EN()* 12) - (billingVo.getPLAN_PER_EN()* 12 )* 0.2);
						billingVo.setPAY_PRICE(total);
						billingVo.setPAY_PRICE_VAT(billingVo.getPAY_PRICE()* 100/110);
						billingVo.setVAT(billingVo.getPAY_PRICE()-billingVo.getPAY_PRICE()* 100/110);
						billingVo.setType("none");
					} else {
						billingVo.setPAY_PRICE( billingVo.getPLAN_PER_EN());
						billingVo.setPAY_PRICE_VAT(billingVo.getPAY_PRICE()* 100/110);
						billingVo.setVAT(billingVo.getPAY_PRICE()-billingVo.getPAY_PRICE()* 100/110);
						billingVo.setType("none");
					}
				}
			} else {
				billingVo.setPAY_PLATFORM("toss");
				if (billingOldVo != null) {
					if (billingOldVo.getDiffDay()  >= -7 && billingOldVo.getDiffDay() <= 7) {
						//플랜 연장 인경우 
						if (dateType.equals("year")) {
							int total = (int) ((billingVo.getPLAN_PER_KO()* 12) - (billingVo.getPLAN_PER_KO()* 12 )* 0.2);
							billingVo.setPAY_PRICE(total);
							billingVo.setPAY_PRICE_VAT(billingVo.getPAY_PRICE()* 100/110);
							billingVo.setVAT(billingVo.getPAY_PRICE()-billingVo.getPAY_PRICE()* 100/110);
							billingVo.setDiffDay(365 + billingOldVo.getDiffDay());
							billingVo.setDATE_TYPE("year"); 
							billingVo.setType("extensionPlan");
						} else {
							billingVo.setPAY_PRICE( billingVo.getPLAN_PER_KO());
							billingVo.setPAY_PRICE_VAT(billingVo.getPAY_PRICE()* 100/110);
							billingVo.setVAT(billingVo.getPAY_PRICE()-billingVo.getPAY_PRICE()* 100/110);
							billingVo.setDiffDay(30 + billingOldVo.getDiffDay());
							billingVo.setDATE_TYPE("month");
							billingVo.setType("extensionPlan");
						}
						
					} else {
						String payPlatform = (String) billingOldVo.getPAY_PLATFORM(); 
						String payLanguage = payPlatform.equals("toss")?"ko":"en";
						String pageLanguage = language.equals("_EN")?"en":"ko";
						if (!payLanguage.equals(pageLanguage)) {
							 response.setContentType("text/html; charset=UTF-8");
							 String comment= "이전 결재 내역과 다른방식으로 결재를 진행할수 없습니다.";
							 if (pageLanguage.equals("en")) {
								 comment = "You cannot proceed with the payment in a different way than the previous payment history.";
							 }
							 PrintWriter out;
							try {
								out = response.getWriter();
								out.println("<script>alert('"+comment+"'); location.href='./billing';</script>");
								out.flush();
							} catch (IOException e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							}
						}
						if (billingOldVo.getDATE_TYPE().equals("year")) {
							// 1년에서 1년 업그레이드시
							int oldPrice = (int) ((billingOldVo.getPLAN_PER_KO()* 12) - (billingOldVo.getPLAN_PER_KO()* 12) *0.2);
							int nowPrice = (int) ((billingVo.getPLAN_PER_KO()* 12) - (billingVo.getPLAN_PER_KO()* 12) *0.2);
							
							int result = ((billingOldVo.getDiffDay())*((int)Math.round(Math.round((nowPrice/365))/10.0) * 10))
									-(oldPrice-((365 - billingOldVo.getDiffDay()) * ((int)Math.round(Math.round((oldPrice/365))/10.0) * 10)));
							
							billingVo.setPAY_PRICE(result);
							billingVo.setPAY_PRICE_VAT(billingVo.getPAY_PRICE()* 100/110);
							billingVo.setVAT(billingVo.getPAY_PRICE()-billingVo.getPAY_PRICE()* 100/110);
							billingVo.setDiffDay(billingOldVo.getDiffDay());
							billingVo.setEXITS_DATE(billingOldVo.getEXITS_DATE());
							billingVo.setDATE_TYPE("year");
							billingVo.setType("upgradePlan");
							logger.info("billingVo year- {}", billingVo.toString());
						} else {
							// 한달에서 한달 업그레이드시 
							int oldPrice = billingOldVo.getPLAN_PER_KO();
							int nowPrice = billingVo.getPLAN_PER_KO();

							int result = ((billingOldVo.getDiffDay())*((int)Math.round(Math.round((nowPrice/30))/10.0) * 10))
									-(oldPrice-((30 - billingOldVo.getDiffDay()) * ((int)Math.round(Math.round((oldPrice/30))/10.0) * 10)));
							
							billingVo.setPAY_PRICE(result);
							billingVo.setPAY_PRICE_VAT(billingVo.getPAY_PRICE()* 100/110);
							billingVo.setVAT(billingVo.getPAY_PRICE()-billingVo.getPAY_PRICE()* 100/110);
							billingVo.setDiffDay(billingOldVo.getDiffDay());
							billingVo.setEXITS_DATE(billingOldVo.getEXITS_DATE());
							billingVo.setDATE_TYPE("month");
							billingVo.setType("upgradePlan");
							logger.info("billingVo month - {}", billingVo.toString());
						}					
					}
				} else {
					if (dateType.equals("year")) {
						int total = (int) ((billingVo.getPLAN_PER_KO()* 12) - (billingVo.getPLAN_PER_KO()* 12 )* 0.2);
						billingVo.setPAY_PRICE(total);
						billingVo.setPAY_PRICE_VAT(billingVo.getPAY_PRICE()* 100/110);
						billingVo.setVAT(billingVo.getPAY_PRICE()-billingVo.getPAY_PRICE()* 100/110);
						billingVo.setType("none");
					} else {
						billingVo.setPAY_PRICE( billingVo.getPLAN_PER_KO());
						billingVo.setPAY_PRICE_VAT(billingVo.getPAY_PRICE()* 100/110);
						billingVo.setVAT(billingVo.getPAY_PRICE()-billingVo.getPAY_PRICE()* 100/110);
						billingVo.setType("none");
					}
				}
				
			}
		}
		
		
		if (planCode.equals("01")) {
			billingVo.setUSER_ID(memberVo.getUserId());
			billingVo.setDATE_TYPE("month");
			billingVo.setPLAN_NAME("TRIAL");
			billingService.insertSubscript(billingVo);
			session.setAttribute("billing",billingVo);
			pagePath = "redirect:/goSubscribeCompleteTrial";
		} else {
			
			if (payNo != null) {
				// payNo 가 널이 아닌경우 플랜 연장인 경우 
				param.put("payNo", payNo);
				param.put("userId", memberVo.getUserId());
				Map<String ,Object> result = billingService.selectSubscript(param);
				logger.info("result -{}", result);
				mv.addAttribute("payState", result);
			}
			
			pagePath = path+"/subscribe";
		}
		session.setAttribute("billing",billingVo);
		logger.info("billing -{}", billingVo.toString());
		//mv.setViewName(path+"/subscribe");
		
		return pagePath;
	}
	
	
	/*결제시 해당 데이터 가지고 오는 부분 */
	@RequestMapping(value="payment", method= {RequestMethod.GET, RequestMethod.POST})
	public String payment ( HttpSession session,HttpServletRequest request, HttpServletResponse response
			, BillingVo form) throws Exception {
		String language = (String) session.getAttribute("language");
		MemberVo memberVo = (MemberVo) session.getAttribute("memberVo");
		BillingVo billingVo = (BillingVo) session.getAttribute("billing");
		String payNo =  request.getParameter("payNo");
		
		
		logger.info("form {}", form);
		logger.info("memberVo {}", memberVo);
		logger.info("billingVo {}", billingVo);
		
		if(form == null || memberVo == null || billingVo == null) {
			StringUtils2.script(response, language, "잘못된 접근입니다.", "The wrong approach", "./");
			return "redirect:/";
		}
		else {			
			if(form.getOrderId().equals(billingVo.getORDER_ID()) && payNo == null) {
				billingVo.setUSER_ID(memberVo.getUserId());
				billingVo.setOrderId(form.getOrderId());
				billingVo.setPaymentKey(form.getPaymentKey());
				billingVo.setAmount(form.getAmount());
				
				HttpHeaders headers = new HttpHeaders();
				headers.set("Authorization", "Basic " + Base64.getEncoder().encodeToString((Constant.TOSS_SECRET_KEY + ":").getBytes()));
			    headers.setContentType(MediaType.APPLICATION_JSON);
			    Map<String, String> payloadMap = new HashMap<>();
		        payloadMap.put("orderId", form.getOrderId());
		        payloadMap.put("amount", String.valueOf(form.getAmount()));		
				HttpEntity<String> request1 = new HttpEntity<>(objectMapper.writeValueAsString(payloadMap), headers);
				
				ResponseEntity<JsonNode> responseEntity = restTemplate.postForEntity(
		        "https://api.tosspayments.com/v1/payments/" + form.getPaymentKey(), request1, JsonNode.class);
				 if (responseEntity.getStatusCode() == HttpStatus.OK) {
					 billingService.insertSubscript(billingVo);
					 logger.info("insert succ billingVo {}", billingVo);
					 session.setAttribute("billingVo", billingVo);
					 return "redirect:/goSubscribeComplete";
				 } else {
					 return "redirect:/pricing";
				 }
			} else {
				
				return "redirect:/";
			}
			
		}
	}

	@RequestMapping(value="payment_paypal", method= {RequestMethod.GET, RequestMethod.POST})
	public String payment_paypal ( ModelAndView mv, HttpSession session,HttpServletRequest request, HttpServletResponse response
			, BillingVo form) {
		String language = (String) session.getAttribute("language");
		MemberVo memberVo = (MemberVo) session.getAttribute("memberVo");
		BillingVo billingVo = (BillingVo) session.getAttribute("billing");
		String payNo =  request.getParameter("payNo");
		String path = "homePage"+ language;

		logger.info("form {}", form);
		logger.info("billingVo {}", billingVo);
		if (form.getPayerID() != null) {
			billingVo.setUSER_ID(memberVo.getUserId());
			billingVo.setOrderId(billingVo.getOrderId());
			billingVo.setPaymentKey(form.getPayerID());
			billingVo.setAmount(billingVo.getPAY_PRICE());
			
			billingService.insertSubscript(billingVo);
			logger.info("insert succ PayPal billingVo {}", billingVo);
			session.setAttribute("billingVo", billingVo);
			return "redirect:/payment_paypal_final";
		}  else {
			return "redirect:/";
		}
	}
	@RequestMapping(value="payment_paypal_final", method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView payment_paypal_final ( ModelAndView mv, HttpSession session,HttpServletRequest request, HttpServletResponse response
			, BillingVo form) {
		String language = (String) session.getAttribute("language");
		String path = "homePage"+ language;
		mv.setViewName(path+"/payment_paypal_final");
		return mv;
	}
	@RequestMapping(value="payment_paypal_cancel", method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView payment_paypal_cancel ( ModelAndView mv, HttpSession session,HttpServletRequest request, HttpServletResponse response
			, BillingVo form) {
		String language = (String) session.getAttribute("language");
		String path = "homePage"+ language;
		mv.setViewName(path+"/payment_paypal_cancel");
		return mv;
	}
	@RequestMapping(value="fail", method= {RequestMethod.GET, RequestMethod.POST})
	public void tossfail ( ModelAndView mv, HttpSession session,HttpServletRequest request, HttpServletResponse response
			) {
		 response.setContentType("text/html; charset=UTF-8");
		 String comment= "결제에 실패했습니다. 다시 시도하시거나, 고객 센터로 문의하시기 바랍니다.";		
		 PrintWriter out;
		try {
			out = response.getWriter();
			out.println("<script>alert('"+comment+"'); location.href='./pricing';</script>");
			out.flush();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@RequestMapping(value="order",method=RequestMethod.GET)
	public String order(Model mv,HttpSession session,HttpServletRequest request, HttpServletResponse response
			, BillingVo form) {
		String language = (String) session.getAttribute("language");
		String path = "homePage"+ language;
		BillingVo billingVo = (BillingVo) session.getAttribute("billing");
		MemberVo memberVo = (MemberVo) session.getAttribute("memberVo");
		
		if (memberVo == null) {
			return "redirect:/";
		}
		
		String payUserId = memberVo.getUserId();
		
		logger.info("billingVo {}", billingVo);
		billingVo.setPAY_PLATFORM("bank");
		billingVo.setPAY_TYPE("bank");
		
		sendEmail.sendBankTransfer(payUserId, billingVo);
		mv.addAttribute("billing",billingVo);
		
		return path+"/order";
	}
	
	@RequestMapping(value="goSubscribeComplete",method=RequestMethod.GET)
	public String goSubscribeComplete(Model mv,HttpSession session,HttpServletRequest request, HttpServletResponse response
			, BillingVo form) {
		String language = (String) session.getAttribute("language");
		String path = "homePage"+ language;
		MemberVo memberVo = (MemberVo) session.getAttribute("memberVo");
		BillingVo billingVo = (BillingVo) session.getAttribute("billing");
		logger.info("billingVo- {}", billingVo);
		if (billingVo == null) {
			return path + "/pricing";
		}
		
		if (billingVo.getPaymentKey().equals("")) {
			return path + "/pricing";
		}
		
		logger.info("form {}", form);
		memberVo = memberService.selectPayCompleteUser(memberVo);
		session.setAttribute("memberVo",memberVo);
		session.removeAttribute("billing");
		session.removeAttribute("billingOld");
		mv.addAttribute("billing", billingVo);
		return path+"/subscribe_complete";
	}
	
	@RequestMapping(value="goSubscribeCompleteTrial", method=RequestMethod.GET) 
	public String goSubscribeCompleteTrial (Model mv,HttpSession session,HttpServletRequest request, HttpServletResponse response
			, BillingVo form) {
		String language = (String) session.getAttribute("language");
		String path = "homePage"+ language;
		MemberVo memberVo = (MemberVo) session.getAttribute("memberVo");
		BillingVo billingVo = (BillingVo) session.getAttribute("billing");
		logger.info("billingVo- {}", billingVo);
		if (billingVo == null) {
			return path + "/pricing";
		}
		memberVo = memberService.selectPayCompleteUser(memberVo);
		session.setAttribute("memberVo",memberVo);
		session.removeAttribute("billing");
		session.removeAttribute("billingOld");
		mv.addAttribute("billing", billingVo);
		return path+"/subscribe_complete";
	}
	
	@RequestMapping(value="invoice",method=RequestMethod.GET)
	public String goInvoice(Model mv,HttpSession session,HttpServletRequest request, HttpServletResponse response) {
		String language = (String) session.getAttribute("language");
		String billingNo= request.getParameter("no");
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("billingNo", billingNo);
		Map<String ,Object> result = billingService.selectSubscriptOne(param);
		result.put("PAY_TAX",(int) result.get("PAY_PRICE") - (int) result.get("PAY_PRICE") * 100/110);
		
		if ((int) result.get("PAY_PRICE") < 50000) {
			language = "_EN";
		} else {
			language = "";
		}

		mv.addAttribute("result",result);
		mv.addAttribute("language",language);
		String path = "homePage"+ language;
		return path + "/invoice";
	}
	
	/*
	@RequestMapping("goBank")
	public String goBank(Model mv,HttpSession session,HttpServletRequest request, HttpServletResponse response) {
		String language = (String) session.getAttribute("language");
		String path = "homePage"+ language;
		return path + "/subscribe_complete";
	}
	*/
	
	
}
