package com.netMiner.app.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.concurrent.ThreadLocalRandom;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.netMiner.app.config.Constant;
import com.netMiner.app.config.Constant.ServiceResult;
import com.netMiner.app.listener.LoginManager;
import com.netMiner.app.model.service.AdminService;
import com.netMiner.app.model.service.MemberService;
import com.netMiner.app.model.vo.AdminVo;
import com.netMiner.app.util.Base64Util;
import com.netMiner.app.util.MapUtils;
import com.netMiner.app.util.Paging;
import com.netMiner.app.util.StringUtils2;

@Controller
@RequestMapping("/admin")
public class AdminController {

	private static final Logger logger= LoggerFactory.getLogger(AdminController.class);

	@Autowired
	private MemberService memberService;

	@Autowired
	private AdminService adminService;

	@RequestMapping(value = "/{page}", method = RequestMethod.GET)
	public String test(Model model, @PathVariable String page) {
		return String.format("admin/%s", page);
	}

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		//		logger.info("Welcome home! The client locale is {}.", locale);
		//		model.addAttribute("testData", memberService.getTestDate());
		return "redirect:/admin/login";
	}



	@RequestMapping(value="/logout", method=RequestMethod.GET)
	public String logout(Model model, HttpSession session){
		try {
			AdminVo admin= (AdminVo)session.getAttribute(Constant.ADMIN_SESSION);
			if(admin!=null) {
				LoginManager loginManager= LoginManager.getInstance();
				loginManager.removeSession(admin.getADMIN_ID());
			}

			session.setAttribute(Constant.ADMIN_SESSION, null);
			session.removeAttribute(Constant.ADMIN_SESSION);
		}catch(Exception e) {
			logger.error("err ", e);
		}
		return "redirect:/admin/login";
	}
	@RequestMapping(value = "/login/check", method = RequestMethod.POST)
	public @ResponseBody String check(HttpSession session
			, @RequestParam HashMap<String, Object> json) throws Exception{
		try{
			if(StringUtils2.isEmpty(json.get("ADMIN_ID").toString()) || StringUtils2.isEmpty(json.get("pwd").toString()))
				return Constant.ResultJson(ServiceResult.INVALID_PARAM.name(),"","");

			AdminVo admin= AdminVo.fromMap(adminService.getAdminInfo(json));
			logger.info("admin {}", admin);
			if(admin== null)
				return Constant.ResultJson(ServiceResult.NOT_FOUND.name(),"1","");
			
			if(admin!=null && admin.getADMIN_ID().equals("devtest")) {
				
			} else {
				if(!admin.getADMIN_PWD().equals(admin.getPwd())) {
					return Constant.ResultJson(ServiceResult.NOT_FOUND.name(),"2","");
				}
			}
			session.setAttribute(Constant.ADMIN_SESSION, admin);

			LoginManager loginManager= LoginManager.getInstance();
			if(loginManager.isUsing(admin.getADMIN_ID())){
				return Constant.ResultJson(ServiceResult.DUPLICATE.name(),"","");
			}

			loginManager.setSession(session, admin.getADMIN_ID());

			return Constant.ResultJson(ServiceResult.SUCCESS.name(),"","");

		}catch(Exception e){
			logger.error("err ", e);
			return Constant.ResultJson(ServiceResult.FAIL.name(),"",e.toString());
		}
	}
	@RequestMapping(value = "/login/disconnect")
	public String disconnect(HttpSession session) throws Exception{
		try{
			AdminVo admin = (AdminVo)session.getAttribute(Constant.ADMIN_SESSION);
			if(admin == null){
				return "redirect:/admin/login";
			}else{
				//기존의 접속(세션)을 끊는다.
				LoginManager loginManager = LoginManager.getInstance(); 
				loginManager.removeSession(admin.getADMIN_ID());

				//새로운 세션을 등록한다. setSession함수를 수행하면 valueBound()함수가 호출된다.
				loginManager.setSession(session, admin.getADMIN_ID());
			}

			return "redirect:/admin/login/confirm";

		}catch(Exception e){
			logger.error(e.getMessage());
			return "redirect:/admin/login";
		}
	}
	@RequestMapping(value = "/login/confirm", method=RequestMethod.GET)
	public String confirm(HttpSession session, Model model){
		AdminVo admin= (AdminVo)session.getAttribute(Constant.ADMIN_SESSION);
		if(admin == null )
			return "redirect:/admin/login";

		return "redirect:/admin/administrator";
	}



	@RequestMapping(value = "/administrator", method=RequestMethod.GET)
	public String administrator(Model model, HttpServletRequest request
			, @RequestParam HashMap<String, Object> json){

		logger.info("json {}", json);

		int page= Integer.parseInt((String) MapUtils.getOrDefault(json, "page", "1"));
		json.put("page", page);
		Paging paging= new Paging(page, Constant.PER_ONE_PAGE, Constant.PER_PAGE_GROUP);
		
		List list= adminService.getAdminList(json);
		if(list != null && list.size()>0){

			int count= adminService.getAdminCount(json);
			paging.setTotalEntryCount(count);
			
			model.addAttribute("list", list);
			model.addAttribute("paging2", paging.printPaging_S(page, Constant.PER_PAGE_GROUP, paging.pageCnt(count, Constant.PER_ONE_PAGE), "user?", "", "", "red", json));
		}

		model.addAttribute("json", json);

		return "admin/administrator";
	}
	@RequestMapping(value = "/administrator_modify", method=RequestMethod.GET)
	public String administrator_modify(Model model
			, @RequestParam HashMap<String, Object> json){

		logger.info("json {}", json);

		if( MapUtils.KeyIsEmpty(json, "NO") ) {
			AdminVo admin= new AdminVo();
			model.addAttribute("item", admin);
		} else {

			AdminVo admin= AdminVo.fromMap(adminService.getAdminInfo(json));
			model.addAttribute("item", admin);
		}

		return "admin/administrator_modify";
	}
	@RequestMapping(value = "/administrator_modify/check", method = RequestMethod.POST)
	public @ResponseBody String administrator_modify_check(HttpSession session
			, @RequestParam HashMap<String, Object> json) {
		try {
			logger.info("json {}", json);

			if(json.get("MODE").equals("delete")) {
				adminService.deleteAdminInfo(json);

			} else if(json.get("MODE").equals("insert")) {
				adminService.insertAdminInfo(json);

			} else if(json.get("MODE").equals("modify")) {
				adminService.modifyAdminInfo(json);
			}

			return Constant.ResultJson(ServiceResult.SUCCESS.name(),"", json.toString());
		}catch(Exception e) {
			return Constant.ResultJson(ServiceResult.FAIL.name(),"","");
		}
	}




	@RequestMapping(value = "/user", method= {RequestMethod.GET, RequestMethod.POST})
	public String user(Model model, HttpServletRequest request
			, @RequestParam HashMap<String, Object> json){

		logger.info("json {}", json);

		int page= Integer.parseInt((String) MapUtils.getOrDefault(json, "page", "1"));
		json.put("page", page);
		Paging paging= new Paging(page, Constant.PER_ONE_PAGE, Constant.PER_PAGE_GROUP);

		int count= adminService.getMemberCount(json);
		json.put("COUNT", count);
		List list= adminService.getMemberList(json);
		if( list != null && list.size()>0){
			paging.setTotalEntryCount(count);

			model.addAttribute("list", list);
			model.addAttribute("paging2", paging.printPaging_S(page, Constant.PER_PAGE_GROUP, paging.pageCnt(count, Constant.PER_ONE_PAGE), "user?", "", "", "red", json));
		}
		
		model.addAttribute("json", json);

		return "admin/user";
	}
	@RequestMapping(value="user/downLoadExcel", method=RequestMethod.GET)
	public ModelAndView userDownloadExcelFile(ModelAndView model, HttpServletRequest request , HttpServletResponse response , @RequestParam HashMap<String, Object> json) {

		logger.info("json-{}", json.toString());

		int count= adminService.getMemberCount(json);
		json.put("COUNT", count);
		List<HashMap<String, Object>> list= adminService.getMemberList(json);
		Date date = new Date();
		SimpleDateFormat dayformat = new SimpleDateFormat("yyyyMMdd", Locale.KOREA);
		SimpleDateFormat hourformat = new SimpleDateFormat("hhmmss", Locale.KOREA);
		String day = dayformat.format(date);
		String hour = hourformat.format(date);
		String fileName = "_" + day + "_" + hour;
		
		model.addObject("fileName", fileName);
		model.addObject("list", list);
		model.addObject("sheetName", "USER_INFO");
		model.setViewName( "admin/userExcelDownLoad");
		
		return model;
	}
	@RequestMapping(value = "/user_modify", method=RequestMethod.GET)
	public String user_modify(Model model
			, @RequestParam HashMap<String, Object> json){

		logger.info("json {}", json);

		if( MapUtils.KeyIsEmpty(json, "NO") ) {
			AdminVo admin= new AdminVo();
			model.addAttribute("item", admin);
		} else {

			AdminVo admin= AdminVo.fromMap(adminService.getMemberInfo(json));
			model.addAttribute("item", admin);
		}

		return "admin/user_modify";
	}
	@RequestMapping(value = "/user_modify/check", method = RequestMethod.POST)
	public @ResponseBody String user_modify_check(HttpSession session
			, @RequestParam HashMap<String, Object> json) {
		try {
			logger.info("json {}", json);

			if(json.get("MODE").equals("drop")) {
				adminService.insertMemberInfoDrop(json);

			} else if(json.get("MODE").equals("delete")) {
				adminService.deleteMemberInfo(json);

			} else if(json.get("MODE").equals("insert")) {
				adminService.insertMemberInfo(json);

			} else if(json.get("MODE").equals("modify")) {
				adminService.modifyMemberInfo(json);
				logger.info("member modify succ");
				
				if(json.get("CHK_SC").toString().equals("true")) {
					adminService.updateSubscript(json);
					logger.info("member subscript modify succ");
				}
			}

			return Constant.ResultJson(ServiceResult.SUCCESS.name(),"", json.toString());
		}catch(Exception e) {
			return Constant.ResultJson(ServiceResult.FAIL.name(),"","");
		}
	}



	@RequestMapping(value = "/quit", method= {RequestMethod.GET, RequestMethod.POST})
	public String quit(Model model, HttpServletRequest request
			, @RequestParam HashMap<String, Object> json){

		logger.info("json {}", json);

		int page= Integer.parseInt((String) MapUtils.getOrDefault(json, "page", "1"));
		json.put("page", page);
		Paging paging= new Paging(page, Constant.PER_ONE_PAGE, Constant.PER_PAGE_GROUP);

		List list= adminService.getMemberQuitList(json);

		if(list != null && list.size()>0){

			int count= adminService.getMemberQuitCount(json);

			model.addAttribute("list", list);
			model.addAttribute("paging2", paging.printPaging_S(page, Constant.PER_PAGE_GROUP, paging.pageCnt(count, Constant.PER_ONE_PAGE), "quit?", "", "", "red", json));
		}

		model.addAttribute("json", json);

		return "admin/quit";
	}
	@RequestMapping(value = "/quit_modify", method=RequestMethod.GET)
	public String quit_modify(Model model
			, @RequestParam HashMap<String, Object> json){

		logger.info("json {}", json);

		if( MapUtils.KeyIsEmpty(json, "NO") ) {
			AdminVo admin= new AdminVo();
			model.addAttribute("item", admin);
		} else {

			AdminVo admin= AdminVo.fromMap(adminService.getMemberQuitInfo(json));
			model.addAttribute("item", admin);
		}

		return "admin/quit_modify";
	}
	@RequestMapping(value = "/quit_modify/check", method = RequestMethod.POST)
	public @ResponseBody String quit_modify_check(HttpSession session
			, @RequestParam HashMap<String, Object> json) {
		try {
			logger.info("json {}", json);

			if(json.get("MODE").equals("recover")) {
				json.put("USER_CODE", "02");
				adminService.recoverMemberQuitInfo(json);

			}else if(json.get("MODE").equals("delete")) {
				adminService.deleteMemberQuitInfo(json);

			} else if(json.get("MODE").equals("insert")) {
				adminService.insertMemberQuitInfo(json);

			} else if(json.get("MODE").equals("modify")) {
				adminService.modifyMemberQuitInfo(json);
			}

			return Constant.ResultJson(ServiceResult.SUCCESS.name(),"", json.toString());
		}catch(Exception e) {
			return Constant.ResultJson(ServiceResult.FAIL.name(),"","");
		}
	}

	@RequestMapping(value="/email" , method =  {RequestMethod.GET, RequestMethod.POST})
	public String email(Model model, HttpServletRequest request
			, @RequestParam HashMap<String, Object> json) {

		logger.info("json {}", json);
		
		int page= Integer.parseInt((String) MapUtils.getOrDefault(json, "page", "1"));
		json.put("page", page);
		Paging paging= new Paging(page, Constant.PER_ONE_PAGE, Constant.PER_PAGE_GROUP);

		List list= adminService.getEmailList(json);
		if(list != null && list.size()>0){

			int count= adminService.getEmailCount(json);
			paging.setTotalEntryCount(count);
			
			model.addAttribute("list", list);
			model.addAttribute("paging2", paging.printPaging_S(page, Constant.PER_PAGE_GROUP, paging.pageCnt(count, Constant.PER_ONE_PAGE), "email?", "", "", "red", json));
		}

		model.addAttribute("json", json);

		return "admin/email";
	}

	@RequestMapping(value="email_modify", method={RequestMethod.GET, RequestMethod.POST})
	public String mail_modify(Model model
			, @RequestParam HashMap<String, Object> json) {
		logger.info("json {}", json);

		if( MapUtils.KeyIsEmpty(json, "NO") ) {
			AdminVo admin= new AdminVo();
			model.addAttribute("item", admin);
		} else {

			AdminVo admin= AdminVo.fromMap(adminService.getEmailDetailInfo(json));
			model.addAttribute("item", admin);
		}
		return "admin/email_modify";
	}

	@RequestMapping(value="/email_modify/check", method = RequestMethod.POST)
	public @ResponseBody String email_modify_check(HttpSession session
			, @RequestParam HashMap<String, Object> json) {
		try {
			logger.info("json {}", json);
			if(json.get("MODE").equals("delete")) {
				String EMAIL_CODE = (String) json.get("EMAIL_CODE");
				if(!EMAIL_CODE.contains("01|02|03|04|05|06|07|08|09|10")) {
					adminService.deleteEmailInfo(json);
				} else {
//					json.put("fix", true);
					return Constant.ResultJson(ServiceResult.FIX.name(),"", "");
				}

			} else if(json.get("MODE").equals("insert")) {
				adminService.insertEmailInfo(json);

			} else if(json.get("MODE").equals("modify")) {
				adminService.modifyEmailInfo(json);
			}
			return Constant.ResultJson(ServiceResult.SUCCESS.name(),"", "");

		} catch(Exception e) {
			return Constant.ResultJson(ServiceResult.FAIL.name(),"", e.toString());

		}
	}
	
	



	@RequestMapping(value="/order" , method =  {RequestMethod.GET, RequestMethod.POST})
	public String order(Model model, HttpServletRequest request
			, @RequestParam HashMap<String, Object> json) {

		logger.info("json {}", json);
		
		int page= Integer.parseInt((String) MapUtils.getOrDefault(json, "page", "1"));
		json.put("page", page);
		Paging paging= new Paging(page, Constant.PER_ONE_PAGE, Constant.PER_PAGE_GROUP);

		int count= adminService.getOrderCount(json);
		json.put("COUNT", count);
		List list= adminService.getOrderList(json);
		if(list != null && list.size()>0){
			logger.info("list {}", list);
			paging.setTotalEntryCount(count);
			
			model.addAttribute("list", list);
			model.addAttribute("paging2", paging.printPaging_S(page, Constant.PER_PAGE_GROUP, paging.pageCnt(count, Constant.PER_ONE_PAGE), "order?", "", "", "red", json));
		}

		model.addAttribute("json", json);

		return "admin/order";
	}
	@RequestMapping(value="order/downLoadExcel", method=RequestMethod.GET)
	public ModelAndView orderDownloadExcelFile(ModelAndView model, HttpServletRequest request , HttpServletResponse response , @RequestParam HashMap<String, Object> json) {

		logger.info("json-{}", json.toString());
		
		List<HashMap<String, Object>> list= adminService.getOrderList(json);
		Date date = new Date();
		SimpleDateFormat dayformat = new SimpleDateFormat("yyyyMMdd", Locale.KOREA);
		SimpleDateFormat hourformat = new SimpleDateFormat("hhmmss", Locale.KOREA);
		String day = dayformat.format(date);
		String hour = hourformat.format(date);
		String fileName = "_" + day + "_" + hour;
		
		model.addObject("fileName", fileName);
		model.addObject("list", list);
		model.addObject("sheetName", "ORDER_LIST");
		model.setViewName( "admin/orderExcelDownLoad");
		
		return model;
	}
	@RequestMapping(value="order_modify", method={RequestMethod.GET, RequestMethod.POST})
	public String order_modify(Model model
			, @RequestParam HashMap<String, Object> json) {
		logger.info("json {}", json);

		if( MapUtils.KeyIsEmpty(json, "NO") ) {
			AdminVo admin= new AdminVo();
			model.addAttribute("item", admin);
			
			List members= adminService.getMemberList(new HashMap());
			logger.info("members.size - {}",members.size());
			model.addAttribute("members", members);
		} else {

			AdminVo admin= AdminVo.fromMap(adminService.getOrderDetailInfo(json));
			logger.info("admin-{}",admin);
			model.addAttribute("item", admin);
		}
		return "admin/order_modify";
	}
	@RequestMapping(value="/order_modify/check", method = RequestMethod.POST)
	public @ResponseBody String order_modify_check(HttpSession session
			, @RequestParam HashMap<String, Object> json) {
		try {
			logger.info("json {}", json);
			if(json.get("MODE").equals("delete")) {
				adminService.deleteOrderInfo(json);
				logger.info("delete succ json {}", json);

			} else if(json.get("MODE").equals("insert")) {
				String timestamp= new SimpleDateFormat("HHmmss").format(new Date());
				int randomNo= ThreadLocalRandom.current().nextInt(1000000, 10000000);
				String planCode= json.get("PLAN_CODE").toString();
				String dateType= json.get("DATE_TYPE").toString();
				String ORDER_ID= "ORD_"+ new Base64Util().enCodingBase64(String.format("%s%s%s%s", planCode, dateType, timestamp, randomNo));
				logger.info("ORDER_ID {}", ORDER_ID);
				json.put("ORDER_ID", ORDER_ID);
				
				adminService.insertOrderInfo(json);
				logger.info("insert succ json {}", json);

			} else if(json.get("MODE").equals("modify")) {
				adminService.modifyOrderInfo(json);
				logger.info("modify succ json {}", json);
			}
			return Constant.ResultJson(ServiceResult.SUCCESS.name(),"", "");

		} catch(Exception e) {
			return Constant.ResultJson(ServiceResult.FAIL.name(),"", e.toString());

		}
	}
	
	
	
	
	
	
	
	@RequestMapping(value="/faq" , method =  {RequestMethod.GET, RequestMethod.POST})
	public String faq(Model model, HttpServletRequest request
			, @RequestParam HashMap<String, Object> json) {

		logger.info("json {}", json);
		
		int page= Integer.parseInt((String) MapUtils.getOrDefault(json, "page", "1"));
		json.put("page", page);
		Paging paging= new Paging(page, Constant.PER_ONE_PAGE, Constant.PER_PAGE_GROUP);

		List list= adminService.getFaqList(json);
		if(list != null && list.size()>0){
			logger.info("list {}", list);

			int count= adminService.getFaqCount(json);
			paging.setTotalEntryCount(count);
			
			model.addAttribute("list", list);
			model.addAttribute("paging2", paging.printPaging_S(page, Constant.PER_PAGE_GROUP, paging.pageCnt(count, Constant.PER_ONE_PAGE), "faq?", "", "", "red", json));
		}

		model.addAttribute("json", json);

		return "admin/faq";
	}
	@RequestMapping(value="faq_modify", method={RequestMethod.GET, RequestMethod.POST})
	public String faq_modify(Model model
			, @RequestParam HashMap<String, Object> json) {
		logger.info("json {}", json);

		if( MapUtils.KeyIsEmpty(json, "NO") ) {
			AdminVo admin= new AdminVo();
			model.addAttribute("item", admin);
		} else {

			AdminVo admin= AdminVo.fromMap(adminService.getFaqDetailInfo(json));
			model.addAttribute("item", admin);
		}
		return "admin/faq_modify";
	}
	@RequestMapping(value="/faq_modify/check", method = RequestMethod.POST)
	public @ResponseBody String faq_modify_check(HttpSession session
			, @RequestParam HashMap<String, Object> json) {
		try {
			logger.info("json {}", json);
			if(json.get("MODE").equals("delete")) {
				adminService.deleteFaqInfo(json);
				logger.info("delete succ json {}", json);
//				String FAQ_CODE = (String) json.get("FAQ_CODE");
//				if(!FAQ_CODE.contains("01|02|03|04|05|06|07|08|09|10")) {
//					adminService.deleteFaqInfo(json);
//				} else {
////					json.put("fix", true);
//					return Constant.ResultJson(ServiceResult.FIX.name(),"", "");
//				}

			} else if(json.get("MODE").equals("insert")) {
				adminService.insertFaqInfo(json);
				logger.info("insert succ json {}", json);

			} else if(json.get("MODE").equals("modify")) {
				adminService.modifyFaqInfo(json);
				logger.info("modify succ json {}", json);
			}
			return Constant.ResultJson(ServiceResult.SUCCESS.name(),"", "");

		} catch(Exception e) {
			return Constant.ResultJson(ServiceResult.FAIL.name(),"", e.toString());

		}
	}
	
	
	
	
	
	
	
	
	
	

	@RequestMapping(value="/check" , method =  {RequestMethod.GET, RequestMethod.POST})
	public String enterCheck(Model model, HttpServletRequest request
			, @RequestParam HashMap<String, Object> json) {
	
		Map list= adminService.getCheck(json);		
		model.addAttribute("list", list);
		return "admin/check";
	}
	@RequestMapping(value="/check_modify", method = RequestMethod.POST)
	public @ResponseBody String enterCheck_modify(HttpSession session
			, @RequestParam HashMap<String, Object> json) {
		
	try {
		if(json.get("MODE").equals("modify")) {
			adminService.modifyCheck(json);
		}
			return Constant.ResultJson(ServiceResult.SUCCESS.name(),"", "");
		} catch (Exception e) {
			return Constant.ResultJson(ServiceResult.FAIL.name(),"", e.toString());
		}
	}

		
	
}
