package com.netMiner.app.config;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class Constant {
	private static final Logger logger= LoggerFactory.getLogger(Constant.class);

	public static Constant ins=null;
	
	public static int PER_ONE_PAGE=10;
	public static int PER_PAGE_GROUP=10;
	
	public static String PLAN_CODE = "01";
	
	public static boolean checkDBError = false;
	
	public static String ServiceResultJsonValue= "{\"result\" : \"%s\", \"value\" : \"%s\", \"value2\" : \"%s\"}";
	
	public static String ADMIN_SESSION= "ADMIN_SESSION";

	// local
	public static String URL = "http://localhost:8001";
	public static String GOOGLE_CALL_BACK_LOGIN_URL = URL +"/auth";	
	public static String GOOGLE_CALL_BACK_REGISTER_URL = URL +"/socialRegister";
	
	// dev
	//	public static String URL = "http://dev.netminer365.com/";
	//	public static String GOOGLE_CALL_BACK_LOGIN_URL = URL +"/auth";	
	//	public static String GOOGLE_CALL_BACK_REGISTER_URL = URL +"/socialRegister";
	
	// real
//	public static String URL = "http://www.netminer365.com/";
//	public static String GOOGLE_CALL_BACK_LOGIN_URL = "https://www.netminer365.com/auth";	
//	public static String GOOGLE_CALL_BACK_REGISTER_URL = "https://www.netminer365.com/socialRegister";

	public static Constant getInstance(HttpServletRequest request) {
		if(ins==null) {
			ins = new Constant();
			if(request.getRequestURL().toString().contains("localhost")) {
				ins.URL= "http://localhost:8001";
				ins.GOOGLE_CALL_BACK_LOGIN_URL= "http://localhost:8001/auth";
				ins.GOOGLE_CALL_BACK_REGISTER_URL = "http://localhost:8001/socialRegister";
			}
		}
		return ins;
	}
	
	public static String ResultJson(String result, String value, String value2) {
		String string= String.format(ServiceResultJsonValue, result, value, value2);
		logger.info(string);
		return string;
	}
	
	public enum ServiceResult {
        SUCCESS, 
        FAIL,
        FIX,
        DELETE,
        DUPLICATE,
        NOT_FOUND,
        INVALID_TOKEN,
        NOT_MATCHE,
        INVALID_PARAM,
        INVALID_ACCESS,
        BAD_REQUEST,
        UNAUTHORIZED,
        INVALID_TYPE,
        SUCCESS_CHG, // 패스3개월
        SUCCESS_DOR, // 휴면
        PWD_5MLOCK,	// 5분락중
        PWD_LOCK,	// 락처리
    }
	
}
