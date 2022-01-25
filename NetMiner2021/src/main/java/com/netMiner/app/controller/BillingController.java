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
	public String pricing (HttpSession session) {
		String language = (String) session.getAttribute("language");
		MemberVo member = (MemberVo) session.getAttribute("memberVo");
		if (member == null ) {
			return "redirect:/login";
		}
		String userId = member.getUserId();
		boolean checkDate = false;
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("userId", userId);
		Map<String, Object> result = billingService.selectSubscript(param);
		//플랜타입이 trial 이고 날짜가 지난경우 해당 trial 막아야함 
		if (result != null && result.get("PLAN_CODE").equals("01")) {
			Date nowDate = new Date(System.currentTimeMillis());
			 SimpleDateFormat dateFormat = new 
		                SimpleDateFormat ("yyyy-MM-dd");
			 try {
				Date date1 = dateFormat.parse(dateFormat.format(nowDate));
				Date date2 = dateFormat.parse((String) result.get("EXITS_DATE"));
				logger.info("date1 -{}",date1.toString());
				logger.info("date2 -{}",date2.toString());
				if (date1.after(date2)) {
					checkDate = true;
				}
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		} 
		if (checkDate) {
			//trial 이고 해당 trial 이 날짜가 지난경우 -1 리턴 
			member.setPlanType(-1);
		} else {
			if (result != null) {
				if (result.get("PLAN_CODE").equals("01")) {
					//조회가 trial 이고 해당 trial이 날짜가 지나지 않는 경우 1 리턴 
					member.setPlanType(1);					
				} else {
					//조회가 되고 trial이 아닌경우 해당 plancode 리턴 
					member.setPlanType(Integer.parseInt((String) result.get("PLAN_CODE")));
				}
			} else{
				//조회가 안되는 경우 신규 이므로 0 리턴 
				member.setPlanType(0);
			} 
		}		
		logger.info("memberPlanType- {}", member.getPlanType());
		session.setAttribute("memberVo",member);
		
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
		
		logger.info("billingList - {}", billingList.toString());
		logger.info("nowPlan - {}", nowPlan.toString());
		
		long diffDays = 0;
		Date nowDate = new Date(System.currentTimeMillis());
		 SimpleDateFormat dateFormat = new 
	                SimpleDateFormat ("yyyy-MM-dd");
		 if (nowPlan != null) {
			 try {
					Date now = dateFormat.parse(dateFormat.format(nowDate));
					Date exitsDate = dateFormat.parse(dateFormat.format(nowPlan.get("EXITS_DATE")));
					logger.info("date1 -{}",now.toString());
					logger.info("date2 -{}",exitsDate.toString());
					diffDays = ((exitsDate.getTime() - now.getTime())/1000)/ (24*60*60);
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
		} else if (nowPlan != null && billingList.size() > 0){
			// 둘다 존재 하는 경우 
			mv.addAttribute("nowPlan", nowPlan);
			mv.addAttribute("diffDays", diffDays);
			mv.addAttribute("billingList", billingList);
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
		MemberVo memberVo = (MemberVo) session.getAttribute("memberVo");
		String timestamp= new SimpleDateFormat("HHmmss").format(new Date());
		int randomNo= ThreadLocalRandom.current().nextInt(1000000, 10000000);
		String pagePath = "";
		if (memberVo == null ) {
			return "redirect:/login";
		}
		
		if (planCode == null) {
			if(billingVo==null) {
				return "redirect:/";
			}
			planCode = billingVo.getPLAN_CODE();
		}
		
		HashMap<String , Object> param= new HashMap<String , Object>();
		param.put("planCode", planCode);
		
		HashMap<String ,Object> billingMap= billingService.selectPlanCode(param);	
		billingVo = new BillingVo().fromMap(billingMap);
		billingVo.setDATE_TYPE(dateType);
		billingVo.setORDER_ID("ORD_"+ new Base64Util().enCodingBase64(String.format("%s%s%s%s", planCode, dateType, timestamp, randomNo)));
		billingVo.setORDER_PNM("ORDER_PNM");
		billingVo.setCUSTOMER_NAME("CUSTOMER_NAME");
		billingVo.setPAY_TYPE(payType);
		
		if (language.equals("EN")) {
			billingVo.setPAY_PLATFORM("paypal");
			
		} else {
			billingVo.setPAY_PLATFORM("toss");
			if (dateType.equals("year")) {
				int total = (int) ((billingVo.getPLAN_PER_KO()* 12) - (billingVo.getPLAN_PER_KO()* 12 )* 0.2);
				billingVo.setPAY_PRICE(total);
				billingVo.setPAY_PRICE_VAT(billingVo.getPAY_PRICE()* 100/110);
				billingVo.setVAT(billingVo.getPAY_PRICE()-billingVo.getPAY_PRICE()* 100/110);	
			} else {
				billingVo.setPAY_PRICE( billingVo.getPLAN_PER_KO());
				billingVo.setPAY_PRICE_VAT(billingVo.getPAY_PRICE()* 100/110);
				billingVo.setVAT(billingVo.getPAY_PRICE()-billingVo.getPAY_PRICE()* 100/110);
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
