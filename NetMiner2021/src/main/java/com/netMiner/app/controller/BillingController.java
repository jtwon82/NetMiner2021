package com.netMiner.app.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
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
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.netMiner.app.model.service.BillingService;
import com.netMiner.app.model.vo.BillingVo;
import com.netMiner.app.model.vo.MemberVo;
import com.netMiner.app.util.Base64Util;

@Controller
public class BillingController extends HttpServlet {

	private static final Logger logger = LoggerFactory.getLogger(BillingController.class);
	
	@Autowired
	private BillingService billingService;

    private RestTemplate restTemplate = new RestTemplate();
	
	/*page Move Billing*/
	@RequestMapping(value="pricing", method=RequestMethod.GET) 
	public String pricing (HttpSession session) {
		String language = (String) session.getAttribute("language");
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
		String code = request.getParameter("code");
		String dateType = request.getParameter("dateType") == null ? "year" : request.getParameter("dateType");
		BillingVo billingVo = (BillingVo) session.getAttribute("billing");
		String timestamp= new SimpleDateFormat("HHmmss").format(new Date());
		int randomNo= ThreadLocalRandom.current().nextInt(1000000, 10000000);
		
		if (code == null) {
			if(billingVo==null) {
				return "redirect:/";
			}
			code = billingVo.getPLAN_CODE();
		}
		
		HashMap<String , Object> param = new HashMap<String , Object>();
		param.put("code",code);

		HashMap<String ,Object> billingMap = billingService.selectPlanCode(param);	
		billingVo = new BillingVo().fromMap(billingMap);
		billingVo.setDATE_TYPE(dateType);
		billingVo.setORDER_ID("ORD_"+ new Base64Util().enCodingBase64(String.format("%s%s%s%s", code, dateType, timestamp, randomNo)));
		billingVo.setORDER_NAME("ORDER_NAME");
		billingVo.setCUSTOMER_NAME("CUSTOMER_NAME");
		
		if (language.equals("EN")) {

		} else {
			if (dateType.equals("year")) {
				int total = (int) ((billingVo.getPLAN_PER_KO()* 12) - (billingVo.getPLAN_PER_KO()* 12 )* 0.2);
				billingVo.setPAY_PRICE(total);
				billingVo.setPAY_CODE(billingVo.getPLAN_NAME());
				billingVo.setPAY_PRICE_VAT(billingVo.getPAY_PRICE()* 100/110);
				billingVo.setVAT(billingVo.getPAY_PRICE()-billingVo.getPAY_PRICE()* 100/110);	
			} else {
				billingVo.setPAY_PRICE( billingVo.getPLAN_PER_KO());
				billingVo.setPAY_CODE(billingVo.getPLAN_NAME());
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
	@RequestMapping(value="payment", method=RequestMethod.POST)
	public ModelAndView payment ( ModelAndView mv,HttpSession session,HttpServletRequest request, HttpServletResponse response) {
		String price = request.getParameter("price");
		String planType = request.getParameter("payType");
		MemberVo memberVo = (MemberVo) session.getAttribute("memberVo");
		BillingVo billingVo = (BillingVo) session.getAttribute("billing");
		
		mv.addObject("result" , "success");
		mv.setViewName("jsonView");
		return mv;
	}
	
	@RequestMapping(value="order",method=RequestMethod.GET)
	public ModelAndView order(ModelAndView mv,HttpSession session,HttpServletRequest request, HttpServletResponse response
			, BillingVo form) {
		String language = (String) session.getAttribute("language");
		String path = "homePage"+ language;
		
		logger.info("form {}", form);
		
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
