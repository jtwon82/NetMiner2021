package com.netMiner.app.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ThreadLocalRandom;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
		String userId = member.getUserId();
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("userId", userId);
		Map<String, Object> result = billingService.selectSubscript(param);
		//플랜타입이 trial 이고 날짜가 지난경우 해당 trial 막아야함 

		session.setAttribute("memberVo",member);
		
		String path = "homePage"+ language;
		return path+"/pricing";
	}
	
	@RequestMapping(value="billing", method=RequestMethod.GET) 
	public String billing (HttpSession session) {
		String language = (String) session.getAttribute("language");
		String path = "homePage"+ language;
		return path+"/billing";
	}
	
	@RequestMapping(value="goSubscribe", method=RequestMethod.GET) 
	public String subscribe (ModelAndView mv,HttpSession session,HttpServletRequest request, HttpServletResponse response) {
		String language = (String) session.getAttribute("language");
		String path = "homePage"+ language;
//		String planCode= request.getParameter("planCode");
		String planCode= request.getParameter("planCode");
		String dateType = request.getParameter("dateType") == null ? "year" : request.getParameter("dateType");
		String payType = request.getParameter("payType") == null ? "card" : request.getParameter("payType");
		BillingVo billingVo = (BillingVo) session.getAttribute("billing");
		String timestamp= new SimpleDateFormat("HHmmss").format(new Date());
		int randomNo= ThreadLocalRandom.current().nextInt(1000000, 10000000);
		
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

		session.setAttribute("billing",billingVo);
		logger.info("billing -{}", billingVo.toString());
		//mv.setViewName(path+"/subscribe");
		
		return path+"/subscribe";
	}
	
	
	/*결제시 해당 데이터 가지고 오는 부분 */
	@RequestMapping(value="payment", method= {RequestMethod.GET, RequestMethod.POST})
	public String payment ( HttpSession session,HttpServletRequest request, HttpServletResponse response
			, BillingVo form) {
		String language = (String) session.getAttribute("language");
		MemberVo memberVo = (MemberVo) session.getAttribute("memberVo");
		BillingVo billingVo = (BillingVo) session.getAttribute("billing");
		
		logger.info("form {}", form);
		logger.info("memberVo {}", memberVo);
		logger.info("billingVo {}", billingVo);
		
		if(form == null || memberVo == null || billingVo == null) {
			StringUtils2.script(response, language, "잘못된 접근입니다.", "The wrong approach", "./");
			return "redirect:/";
		}
		else {
			if(form.getOrderId().equals(billingVo.getORDER_ID())) {
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
	
}
