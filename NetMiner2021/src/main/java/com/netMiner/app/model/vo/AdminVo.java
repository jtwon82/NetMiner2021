package com.netMiner.app.model.vo;

import java.io.Serializable;
import java.util.HashMap;

import com.fasterxml.jackson.annotation.JsonAlias;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.databind.MapperFeature;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.Data;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class AdminVo implements Serializable{

	@JsonAlias("NO") private String NO= "";
	@JsonAlias("REG_DATE") private String REG_DATE= "";
	@JsonAlias("MB_REG_DATE_STR") private String MB_REG_DATE_STR= "";
	@JsonAlias("REG_DATES") private String REG_DATES= "";
	@JsonAlias("REG_DATE_STR") private String REG_DATE_STR= "";
	@JsonAlias("LAST_LOGIN_DATE") private String LAST_LOGIN_DATE= "";
	@JsonAlias("LAST_LOGIN_DATES") private String LAST_LOGIN_DATES= "";
	
	//ADMIN
	@JsonAlias("ADMIN_CODE") private String ADMIN_CODE= "";
	@JsonAlias("ADMIN_ID") private String ADMIN_ID= "";
	@JsonAlias("ADMIN_PWD") private String ADMIN_PWD= "";
	@JsonAlias("DESCRIPTION") private String DESCRIPTION= "";
	@JsonAlias("pwd") private String pwd= "";

	//MEMBER
	@JsonAlias("USER_CODE") private String USER_CODE= "";
	@JsonAlias("USER_ID") private String USER_ID= "";
	@JsonAlias("USER_PWD") private String USER_PWD= "";
	@JsonAlias("COMPANY") private String COMPANY= "";
	@JsonAlias("MB_COMPANY") private String MB_COMPANY= "";
	@JsonAlias("NATION") private String NATION= "";
	@JsonAlias("NATION_NAME_KR") private String NATION_NAME_KR= "";
	@JsonAlias("MB_NATION") private String MB_NATION= "";
	@JsonAlias("LANGUAGE") private String LANGUAGE= "";
	@JsonAlias("MB_LANGUAGE") private String MB_LANGUAGE= "";
	@JsonAlias("USE_CODE") private String USE_CODE= "";
	@JsonAlias("USE_CODE_STR") private String USE_CODE_STR= "";
	@JsonAlias("MB_USE_CODE") private String MB_USE_CODE= "";
	@JsonAlias("MB_USE_CODE_STR") private String MB_USE_CODE_STR= "";
	@JsonAlias("MARKET_YN") private String MARKET_YN= "";
	@JsonAlias("MARKET_DATE") private String MARKET_DATE= "";
	@JsonAlias("MARKET_DATES") private String MARKET_DATES= "";
	@JsonAlias("GOOGLE_YN") private String GOOGLE_YN= "";
	@JsonAlias("USER_OUT_DATE") private String USER_OUT_DATE= "";
	@JsonAlias("USER_OUT_DATES") private String USER_OUT_DATES= "";
	@JsonAlias("USER_STATS_YN") private String USER_STATS_YN= "";
	@JsonAlias("TYPE_CODE") private String TYPE_CODE= "";
	@JsonAlias("TYPE_CODE_STR") private String TYPE_CODE_STR= "";
	
	//EMAIL
	@JsonAlias("EMAIL_CODE") private String EMAIL_CODE = "";
	@JsonAlias("TITLE") private String TITLE = "";
	@JsonAlias("EXPLAIN") private String EXPLAIN = "";
	@JsonAlias("COMMENT") private String COMMENT = "";
	
	//CHECK
	@JsonAlias("START_DATE") private String  START_DATE = "";
	@JsonAlias("START_DATES") private String  START_DATES = "";
	@JsonAlias("START_HH") private String START_HH = "";
	@JsonAlias("END_DATE") private String END_DATE = "";
	@JsonAlias("END_DATES") private String END_DATES = "";
	@JsonAlias("END_HH") private String END_HH = "";
	@JsonAlias("COMMENT_KR") private String COMMENT_KR = "";
	@JsonAlias("COMMENT_EN") private String COMMENT_EN = "";
	@JsonAlias("STATS_YN") private String STATS_YN= "";
	@JsonAlias("END_DATE_YN") private String END_DATE_YN = "";
	
	
	// faq
	@JsonAlias("CATE_CODE") private String CATE_CODE= "";
	@JsonAlias("CATE_CODE_STR") private String CATE_CODE_STR= "";
//	@JsonAlias("TITLE") private String TITLE= "";
//	@JsonAlias("DESCRIPTION") private String DESCRIPTION= "";
	@JsonAlias("CONTENT") private String CONTENT= "";
	
	
	// order
	@JsonAlias("SC_NO") private String SC_NO= "";
	@JsonAlias("SC_REG_DATE") private String SC_REG_DATE= "";
	@JsonAlias("SC_REG_DATES") private String SC_REG_DATES= "";
	@JsonAlias("SC_USER_ID") private String SC_USER_ID= "";
	@JsonAlias("ORDER_ID") private String ORDER_ID= "";
//	@JsonAlias("ORDER_ID") private String USER_ID= "";
	@JsonAlias("PLAN_CODE") private String PLAN_CODE= "";
	@JsonAlias("SC_PLAN_CODE") private String SC_PLAN_CODE= "";
	@JsonAlias("PLAN_CODE_STR") private String PLAN_CODE_STR= "";
	@JsonAlias("SC_PLAN_CODE_STR") private String SC_PLAN_CODE_STR= "";
	@JsonAlias("PLAN_TYPE") private String PLAN_TYPE= "";
	@JsonAlias("DATE_TYPE") private String DATE_TYPE= "";
	@JsonAlias("PAY_PLATFORM") private String PAY_PLATFORM= "";
	@JsonAlias("PAY_STEP") private String PAY_STEP= "";
	@JsonAlias("PAY_TYPE") private String PAY_TYPE= "";
	@JsonAlias("PAY_PRICE") private String PAY_PRICE= "";
	@JsonAlias("PAY_PRICE_TOTAL") private String PAY_PRICE_TOTAL= "";
	@JsonAlias("ACCOUNT_NAME") private String ACCOUNT_NAME= "";
	@JsonAlias("ACCOUNT_NO") private String ACCOUNT_NO= "";
	@JsonAlias("ACCOUNT_HOLDER") private String ACCOUNT_HOLDER= "";
	@JsonAlias("ACCOUNT_DEPOSITLIMIT") private String ACCOUNT_DEPOSITLIMIT= "";
	@JsonAlias("ORDER_PNM") private String ORDER_PNM= "";
	@JsonAlias("paymentKey") private String paymentKey= "";
	@JsonAlias("amount") private String amount= "";
	@JsonAlias("EXITS_DATE") private String EXITS_DATE= "";
	@JsonAlias("SC_EXITS_DATE") private String SC_EXITS_DATE= "";
	@JsonAlias("SC_EXITS_DATES") private String SC_EXITS_DATES= "";
	@JsonAlias("EXITS_DATE_STR") private String EXITS_DATE_STR= "";

//	public String toString() {
//		return ToStringBuilder.reflectionToString(this);
//	}
	
	public static AdminVo fromMap(HashMap<String, Object> map) {
		AdminVo result= new ObjectMapper()
				.configure(MapperFeature.ACCEPT_CASE_INSENSITIVE_PROPERTIES, true)
				.convertValue(map, AdminVo.class);
		return result;
	}
	
}
