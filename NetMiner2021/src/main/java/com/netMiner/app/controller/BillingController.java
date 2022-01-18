package com.netMiner.app.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.resource.HttpResource;

import com.netMiner.app.config.Constant;
import com.netMiner.app.model.service.BillingService;
import com.netMiner.app.model.vo.BillingVo;
import com.netMiner.app.model.vo.MemberVo;

@Controller
public class BillingController extends HttpServlet {

	private static final Logger logger = LoggerFactory.getLogger(BillingController.class);
	
	@Autowired
	private BillingService billingService;
	
	
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
	public ModelAndView subscribe (ModelAndView mv,HttpSession session,HttpServletRequest request, HttpServletResponse response) {
		String language = (String) session.getAttribute("language");
		String path = "homePage"+ language;
		String code = request.getParameter("code");
		String dateType = request.getParameter("dateType") == null ? "year" : request.getParameter("dateType");
		BillingVo billingVo = (BillingVo) session.getAttribute("billing");

		if (code == null) {
			code = billingVo.getPLAN_CODE();
		}
		
		HashMap<String , Object> param = new HashMap<String , Object>();
		param.put("code",code);

		HashMap<String ,Object> billingMap = billingService.selectPlanCode(param);	

		billingVo = new BillingVo().fromMap(billingMap);
		billingVo.setDATE_TYPE(dateType);
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
		mv.setViewName(path+"/subscribe");

		return mv;
	}
	
	
	/*결제시 해당 데이터 가지고 오는 부분 */
	@RequestMapping(value="payment", method=RequestMethod.POST)
	public ModelAndView payment ( ModelAndView mv,HttpSession session,HttpServletRequest request, HttpServletResponse response) {
		String price = request.getParameter("price");
		String planType = request.getParameter("payType");
		MemberVo memberVo = (MemberVo) session.getAttribute("memberVo");
		
		mv.addObject("result" , "success");
		mv.setViewName("jsonView");
		return mv;
	}
	
	@RequestMapping(value="order",method=RequestMethod.GET)
	public ModelAndView order(ModelAndView mv,HttpSession session,HttpServletRequest request, HttpServletResponse response) {
		String language = (String) session.getAttribute("language");
		String path = "homePage"+ language;

		mv.setViewName(path+"/order");
		return mv;
	}
	
}
