package com.netMiner.app.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ThreadLocalRandom;

import javax.servlet.ServletRequest;
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

import com.netMiner.app.model.service.BillingService;
import com.netMiner.app.model.vo.BillingVo;
import com.netMiner.app.model.vo.MemberVo;
import com.netMiner.app.util.Base64Util;
import com.netMiner.app.util.StringUtils2;

@Controller
public class BillingController extends HttpServlet {

	private static final Logger logger = LoggerFactory.getLogger(BillingController.class);
	
	@Autowired
	private BillingService billingService;

	/*page Move Billing*/
	@RequestMapping(value="pricing", method=RequestMethod.GET) 
	public String pricing (Model mv,HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		String language = (String) session.getAttribute("language");
		MemberVo member = (MemberVo) session.getAttribute("memberVo");
		String type = (String) request.getParameter("type");
		if (member == null ) {
			return "redirect:/login";
		}
		String userId = member.getUserId();
		boolean checkDate = false;
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("userId", userId);
		Map<String, Object> result = billingService.selectSubscript(param);

		//해당 유저의 플랜타입 01 사용여부 확인 
		Map<String, Object> checkUserTiralInfo = billingService.checkUserTiralInfo(param);
		
		//해당유저의 현재 플랜과 TRAIL 사용 여부와 동일한경우 
		if (result != null) {
			//Trial 를 사용한 사용자 
			if (result.get("NO").equals("01")) {
				//현재 사용중인 플랜이 Trial 인경우
				member.setPlanType(1);
			} else {
				//현재 사용중인 플랜이 Trial 이 아닌경우 
				
				if (type != null) {
					if (type.equals("changePlan")) {
						//해당 플랜 변경인지 
						member.setPlanType(1);
					} else if (type.equals("upgradePlan")) {
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
				member.setPlanType(1);
			} else {
				//신규  사용자 
				member.setPlanType(0);
			}
		}
		
		logger.info("memberPlanType- {}, language-{}", member.getPlanType(), member.getLanguage());
		session.setAttribute("memberVo",member);
		param = new HashMap<String,Object>();
		if (language.equals("_EN")) {
			param.put("language","en");
		} else {
			param.put("language","ko");
		}
		List<Map<String,Object>> faqList = billingService.selectFaqList(param);
		logger.info("faqList - {}", faqList.toString());
		mv.addAttribute("faqList", faqList);
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
		
		//logger.info("billingList - {}", billingList.toString());
		//logger.info("nowPlan - {}", nowPlan.toString());
		BillingVo billingVo = new BillingVo().fromMap((HashMap<String, Object>)nowPlan);
		
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
		if (memberVo == null ) {
			return "redirect:/login";
		}
		logger.info("dateType- {}", dateType);
		logger.info("billingOldVo-{}",billingOldVo);
		
		//planCode 가 널인경우 새로 고침이므로 메인으로 이동 
		if (planCode == null) {
			return "redirect:/";
		}
		
		
		HashMap<String , Object> param= new HashMap<String , Object>();
		param.put("planCode", planCode);
		
		HashMap<String ,Object> billingMap= billingService.selectPlanCode(param);	
		billingVo = new BillingVo().fromMap(billingMap);
		billingVo.setDATE_TYPE(dateType);
		billingVo.setORDER_ID("ORD_"+ new Base64Util().enCodingBase64(String.format("%s%s%s%s", planCode, dateType, timestamp, randomNo)));
		billingVo.setORDER_PNM(String.valueOf(randomNo));
		billingVo.setCUSTOMER_NAME("CUSTOMER_NAME");
		billingVo.setPAY_TYPE(payType);
		logger.info("billingVoSelectPlanCode - {} ", billingVo.toString());
		
		if (language.equals("_EN")) {
			billingVo.setPAY_PLATFORM("paypal");
			if (billingOldVo != null) {
				if (billingOldVo.getDiffDay() > -7 && billingOldVo.getDiffDay() < 7) {
					//플랜 연장 인경우 
					if (dateType.equals("year")) {
						int total = (int) ((billingVo.getPLAN_PER_EN()* 12) - (billingVo.getPLAN_PER_EN()* 12 )* 0.2);
						billingVo.setPAY_PRICE(total);
						billingVo.setPAY_PRICE_VAT(billingVo.getPAY_PRICE()* 100/110);
						billingVo.setVAT(billingVo.getPAY_PRICE()-billingVo.getPAY_PRICE()* 100/110);
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
					if (billingOldVo.getDATE_TYPE().equals("year")) {
						// 1년에서 1년 업그레이드시
						int oldPrice = billingOldVo.getPLAN_PER_EN();
						int nowPrice = (int) ((billingVo.getPLAN_PER_EN()* 12) - (billingVo.getPLAN_PER_EN()* 12 )* 0.2);
						int result = (nowPrice/365*(billingOldVo.getDiffDay())) - oldPrice - (oldPrice * ((365 - billingOldVo.getDiffDay()) /365));
						
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
						int result = (nowPrice/30*(billingOldVo.getDiffDay())) - oldPrice - (oldPrice * ((30 - billingOldVo.getDiffDay()) /30));
						
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
				if (billingOldVo.getDiffDay() > -7 && billingOldVo.getDiffDay() < 7) {
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
					if (billingOldVo.getDATE_TYPE().equals("year")) {
						// 1년에서 1년 업그레이드시
						int oldPrice = billingOldVo.getPLAN_PER_KO();
						int nowPrice = (int) ((billingVo.getPLAN_PER_KO()* 12) - (billingVo.getPLAN_PER_KO()* 12 )* 0.2);
						int result = (nowPrice/365*(billingOldVo.getDiffDay())) - oldPrice - (oldPrice * ((365 - billingOldVo.getDiffDay()) /365));
						
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
						int result = (nowPrice/30*(billingOldVo.getDiffDay())) - oldPrice - (oldPrice * ((30 - billingOldVo.getDiffDay()) /30));
						
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
		
		
		
		if (planCode.equals("01")) {
			billingVo.setUSER_ID(memberVo.getUserId());
			billingVo.setDATE_TYPE("month");
			billingService.insertSubscript(billingVo);			
			pagePath = "redirect:/goSubscribeComplete";
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
			, BillingVo form) {
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

				billingService.insertSubscript(billingVo);
				logger.info("insert succ billingVo {}", billingVo);
				
				return "redirect:/goSubscribeComplete";
			} else {
				
				return "redirect:/";
			}
			
		}
	}
	
	@RequestMapping(value="order",method=RequestMethod.GET)
	public ModelAndView order(ModelAndView mv,HttpSession session,HttpServletRequest request, HttpServletResponse response
			, BillingVo form) {
		String language = (String) session.getAttribute("language");
		String path = "homePage"+ language;
		BillingVo billingVo = (BillingVo) session.getAttribute("billing");
		
		logger.info("billingVo {}", billingVo);
		
		mv.setViewName(path+"/order");
		return mv;
	}
	
	@RequestMapping(value="goSubscribeComplete",method=RequestMethod.GET)
	public ModelAndView goSubscribeComplete(ModelAndView mv,HttpSession session,HttpServletRequest request, HttpServletResponse response
			, BillingVo form) {
		String language = (String) session.getAttribute("language");
		String path = "homePage"+ language;
		
		logger.info("form {}", form);
		
		mv.setViewName(path+"/subscribe_complete");
		return mv;
	}
	@RequestMapping(value="invoice",method=RequestMethod.GET)
	public String goInvoice(Model mv,HttpSession session,HttpServletRequest request, HttpServletResponse response) {
		String language = (String) session.getAttribute("language");
		String billingNo= request.getParameter("no");
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("billingNo", billingNo);
		Map<String ,Object> result = billingService.selectSubscriptOne(param);
		result.put("PAY_TAX",(int) result.get("PAY_PRICE") - (int) result.get("PAY_PRICE") * 100/110);
		mv.addAttribute("result",result);
		mv.addAttribute("language",language);
		String path = "homePage"+ language;
		return path + "/invoice";
	}
}
