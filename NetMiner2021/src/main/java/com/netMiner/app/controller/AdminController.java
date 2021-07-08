package com.netMiner.app.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
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
import com.netMiner.app.model.vo.CommonPagedList;
import com.netMiner.app.util.MapUtils;
import com.netMiner.app.util.Paging;

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
			if(StringUtils.isEmpty(json.get("id").toString()) || StringUtils.isEmpty(json.get("pwd").toString()))
				return Constant.ResultJson(ServiceResult.INVALID_PARAM.name(),"","");

			AdminVo admin= AdminVo.fromMap(adminService.getAdminInfo(json));
			if(admin== null)
				return Constant.ResultJson(ServiceResult.NOT_FOUND.name(),"1","");

			if(!admin.getADMIN_PWD().equals(admin.getPwd())) {
				return Constant.ResultJson(ServiceResult.NOT_FOUND.name(),"2","");
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
			return Constant.ResultJson(ServiceResult.FAIL.name(),"","");
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

		int pageNumber= Integer.parseInt((String) MapUtils.getOrDefault(json, "pageNumber", "1"));
		Paging paging= new Paging(pageNumber, Constant.PER_ONE_PAGE, Constant.PER_PAGE_GROUP);
		paging.setBaseUrlFormat( paging.getPagingBaseUrl("administrator", request.getQueryString(), pageNumber) );
		
		HashMap<String, Object> map= new HashMap();
		map.put("firstOffset", paging.getFirstOffset());
		map.put("lastOffset", paging.getLastOffset());
		List list= adminService.getAdminList(map);

		CommonPagedList pagedList= new CommonPagedList();
		pagedList.setList(list);
		if(pagedList != null && list.size()>0){
			pagedList.setPaging(paging);

			int count= adminService.getAdminCount(map);
			paging.setTotalEntryCount(count);
		}

		model.addAttribute("list", pagedList.getList());
		model.addAttribute("paging", paging);

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

		int pageNumber= Integer.parseInt((String) MapUtils.getOrDefault(json, "pageNumber", "1"));
		
		logger.info("pageNumber-{}", pageNumber);

		Paging paging= new Paging(pageNumber, Constant.PER_ONE_PAGE, Constant.PER_PAGE_GROUP);
		paging.setBaseUrlFormat( paging.getPagingBaseUrl("user", request.getQueryString(), pageNumber) );

	
		json.put("firstOffset", paging.getFirstOffset());
		json.put("lastOffset", paging.getLastOffset());
		List list= adminService.getMemberList(json);

		CommonPagedList pagedList= new CommonPagedList();
		pagedList.setList(list);
		if(pagedList != null && list.size()>0){
			pagedList.setPaging(paging);

			int count= adminService.getMemberCount(json);
			paging.setTotalEntryCount(count);
		}
		logger.info("paging {}", paging);

		
		model.addAttribute("json", json);
		model.addAttribute("list", pagedList.getList());
		model.addAttribute("paging", paging);


		return "admin/user";
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

			if(json.get("MODE").equals("delete")) {
				adminService.deleteMemberInfo(json);

			} else if(json.get("MODE").equals("insert")) {
				adminService.insertMemberInfo(json);

			} else if(json.get("MODE").equals("modify")) {
				adminService.modifyMemberInfo(json);
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

		logger.info("paging {}", paging);

		List list= adminService.getMemberQuitList(json);

		if(list != null && list.size()>0){

			int count= adminService.getMemberQuitCount(json);

			model.addAttribute("list", list);
			model.addAttribute("paging2", paging.printPaging_S(page, Constant.PER_PAGE_GROUP, paging.pageCnt(count, Constant.PER_PAGE_GROUP), "quit?page=", "", "", "red"));
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
				adminService.modifyMemberQuitInfo(json);

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
		int pageNumber= Integer.parseInt((String) MapUtils.getOrDefault(json, "pageNumber", "1"));

		Paging paging= new Paging(pageNumber, Constant.PER_ONE_PAGE, Constant.PER_PAGE_GROUP);
		paging.setBaseUrlFormat( paging.getPagingBaseUrl("email", request.getQueryString(), pageNumber) );
		json.put("firstOffset", paging.getFirstOffset());
		json.put("lastOffset", paging.getLastOffset());

		List list= adminService.getEmailList(json);
		logger.info("email list size - {}", list.size());
		CommonPagedList pagedList= new CommonPagedList();
		pagedList.setList(list);
		logger.info("firstOffset - {}, lastOffset- {}",paging.getFirstOffset() ,paging.getLastOffset());
		if(pagedList != null && list.size()>0){
			pagedList.setPaging(paging);

			int count= adminService.getEmailCount(json);
			paging.setTotalEntryCount(count);
		}

		model.addAttribute("json", json);
		model.addAttribute("list", pagedList.getList());
		model.addAttribute("paging", paging);

		return "admin/email";
	}

	@RequestMapping(value="mail_modify", method={RequestMethod.GET, RequestMethod.POST})
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
	@RequestMapping(value="user/downLoadExcel", method=RequestMethod.POST)
	public ModelAndView downloadExcelFile(ModelAndView model, HttpServletRequest request , HttpServletResponse response) {

		String USER_ID = request.getParameter("USER_ID");
		String COMPANY = request.getParameter("COMPANY");
		String USE_CODE = request.getParameter("USE_CODE");
		String MARKET_YN = request.getParameter("MARKET_YN");
		String SDATE = request.getParameter("SDATE");
		String EDATE  = request.getParameter("EDATE");

		Map<String , Object> param = new HashMap<String , Object> ();
		param.put("USER_ID", USER_ID);
		param.put("COMPANY", COMPANY);
		param.put("USE_CODE", USE_CODE);
		param.put("MARKET_YN", MARKET_YN);
		param.put("SDATE", SDATE);
		param.put("EDATE", EDATE);

		List<HashMap<String, Object>> list= adminService.getMemberList(param);

		Date date = new Date();
		SimpleDateFormat dayformat = new SimpleDateFormat("yyyyMMdd", Locale.KOREA);
		SimpleDateFormat hourformat = new SimpleDateFormat("hhmmss", Locale.KOREA);
		String day = dayformat.format(date);
		String hour = hourformat.format(date);
		String fileName = "_" + day + "_" + hour + ".xls";
		
		model.addObject("fileName", fileName);
		model.addObject("list", list);
		model.addObject("sheetName", "USER_INFO");
		model.setViewName("jsonView");
		
		return model;
	}
	
	
}
