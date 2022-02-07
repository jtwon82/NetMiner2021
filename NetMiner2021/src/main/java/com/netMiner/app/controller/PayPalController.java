package com.netMiner.app.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.netMiner.app.model.vo.BillingVo;



@Controller
public class PayPalController extends HttpServlet {
	private static final Logger logger = LoggerFactory.getLogger(PayPalController.class);
	
	private String serverUrl = "http://www.netminer.com";
	
	@RequestMapping("/download_buy/buy/lg-popup.do")
	public String read_lg(HttpSession session,HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		BillingVo billingVo = (BillingVo) session.getAttribute("billing");
		model.addAttribute("buyModel", billingVo);
		logger.info("hellowPayPal_read_lg");
		return "/download_buy/buy/lg-popup2";
	}

	@RequestMapping("/download_buy/buy/paypal-popup.do")
	public String read_paypal(HttpSession session,HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		BillingVo billingVo = (BillingVo) session.getAttribute("billing");
		billingVo.setEncrypted_ret_url(serverUrl);
		model.addAttribute("buyModel", billingVo);
		logger.info("hellowPayPal_read_paypal");
		return "/download_buy/buy/paypal-popup";
	}
	
	@RequestMapping("/download_buy/buy/lg_success-popup.do")
	public String read_lg_success(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//test code
//		String key = "";
//		String[] values = null;
//		Map.Entry<?, ?> entry = null;
//
//		Map<?,?> map = request.getParameterMap();
//		
//		Set<?> set = map.entrySet();
//		Iterator<?> it = set.iterator();
//		
//		while(it.hasNext()) {
//			entry = (Map.Entry<?, ?>) it.next();
//			key = (String) entry.getKey();
//			values = (String[]) entry.getValue();
//			
//			for(String value : values) {
//				System.out.println(key + " -- " + value);
//			}
//		}
		logger.info("hellowPayPal_read_lg_success");
		return "/download_buy/buy/lg_success-popup";
	}
	
	@RequestMapping("/download_buy/buy/lg_fail-popup.do")
	public String read_lg_fail(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//test code
//		String key = "";
//		String[] values = null;
//		Map.Entry<?, ?> entry = null;
//		
//		Map<?,?> map = request.getParameterMap();
//		
//		Set<?> set = map.entrySet();
//		Iterator<?> it = set.iterator();
//		
//		while(it.hasNext()) {
//			entry = (Map.Entry<?, ?>) it.next();
//			key = (String) entry.getKey();
//			values = (String[]) entry.getValue();
//			
//			for(String value : values) {
//				System.out.println(key + " -- " + value);
//			}
//		}
		
		//TODO 실패 시 다시 하게끔 유도해야 함
		logger.info("hellowPayPal_read_lg_fail");
		return "/download_buy/buy/lg_success-popup";
	}
	
	@RequestMapping("/download_buy/buy/paypal_success-popup.do")
	public String read_paypal_success(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//test code
//		String key = "";
//		String[] values = null;
//		Map.Entry<?, ?> entry = null;
//
//		Map<?,?> map = request.getParameterMap();
//		
//		Set<?> set = map.entrySet();
//		Iterator<?> it = set.iterator();
//		
//		while(it.hasNext()) {
//			entry = (Map.Entry<?, ?>) it.next();
//			key = (String) entry.getKey();
//			values = (String[]) entry.getValue();
//			
//			for(String value : values) {
//				System.out.println(key + " -- " + value);
//			}
//		}
		logger.info("hellowPayPal_read_paypal_success");
		return "/download_buy/buy/paypal_success-popup";
	}
	
	@RequestMapping("/download_buy/buy/paypal_fail-popup.do")
	public String read_paypal_fail(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//test code
//		String key = "";
//		String[] values = null;
//		Map.Entry<?, ?> entry = null;
//		
//		Map<?,?> map = request.getParameterMap();
//		
//		Set<?> set = map.entrySet();
//		Iterator<?> it = set.iterator();
//		
//		while(it.hasNext()) {
//			entry = (Map.Entry<?, ?>) it.next();
//			key = (String) entry.getKey();
//			values = (String[]) entry.getValue();
//			
//			for(String value : values) {
//				System.out.println(key + " -- " + value);
//			}
//		}
		
		//TODO 실패 시 다시 하게끔 유도해야 함
		logger.info("hellowPayPal_read_paypal_fail");
		return "/download_buy/buy/paypal_success-popup";
	}
	
}

