package com.netMiner.app.config;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.netMiner.app.controller.AdminController;

public class Constant {
	private static final Logger logger= LoggerFactory.getLogger(Constant.class);

	public static int PER_ONE_PAGE=3;
	public static int PER_PAGE_GROUP=3;
	
	public static String ServiceResultJsonValue= "{\"result\" : \"%s\", \"value\" : \"%s\", \"value2\" : \"%s\"}";
	
	public static String ADMIN_SESSION= "ADMIN_SESSION";
	
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
