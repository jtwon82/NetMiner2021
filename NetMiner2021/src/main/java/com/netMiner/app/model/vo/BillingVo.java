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
public class BillingVo implements Serializable {

	/*SUBSCRIPT*/
	@JsonAlias("NO") private String NO = "";
	@JsonAlias("REG_DATE") private String REG_DATE = "";
	@JsonAlias("USER_ID") private String USER_ID = "";
	@JsonAlias("LANGUAGE") private String LANGUAGE = "";
	@JsonAlias("PLAN_TYPE") private String PLAN_TYPE = "";
	@JsonAlias("TYPE_CODE") private String TYPE_CODE = "";
	@JsonAlias("PAY_CODE") private String PAY_CODE = ""; 
	@JsonAlias("PAY_PRICE") private int PAY_PRICE = 0;
	@JsonAlias("PAY_PRICE_TOTAL") private int PAY_PRICE_TOTAL = 0;
	@JsonAlias("ACCOUNT_NAME") private String ACCOUNT_NAME = "";
	@JsonAlias("ACCOUNT_NO") private String ACCOUNT_NO = "";
	@JsonAlias("ACCOUNT_HOLDER") private String ACCOUNT_HOLDER = "";
	@JsonAlias("ACCOUNT_DEPOSITLIMIT") private String ACCOUNT_DEPOSITLIMIT = "";
	
	private int VAT = 0;
	private int PAY_PRICE_VAT=0;
	
	/*PLAN_CODE*/
	@JsonAlias("PLAN_CODE") private String PLAN_CODE = "";
	@JsonAlias("PLAN_PER_KO") private int PLAN_PER_KO = 0;
	@JsonAlias("PLAN_PER_EN") private int PLAN_PER_EN = 0;
	@JsonAlias("PLAN_DISCOUNT_PERCENT") private int PLAN_DISCOUNT_PERCENT = 20;
	@JsonAlias("PLAN_NAME") private String PLAN_NAME = "";

	private String DATE_TYPE = "year";
	
	public static BillingVo fromMap(HashMap<String, Object> map) {
		BillingVo result= new ObjectMapper()
				.configure(MapperFeature.ACCEPT_CASE_INSENSITIVE_PROPERTIES, true)
				.convertValue(map, BillingVo.class);
		return result;
	}
	
		
}
