package com.netMiner.app.model.vo;

import java.io.Serializable;
import java.util.HashMap;

import org.apache.commons.lang3.builder.ToStringBuilder;

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
	@JsonAlias("REG_DATES") private String REG_DATES= "";
	@JsonAlias("LAST_LOGIN_DATE") private String LAST_LOGIN_DATE= "";
	
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
	@JsonAlias("NATION") private String NATION= "";
	@JsonAlias("LANGUAGE") private String LANGUAGE= "";
	@JsonAlias("USE_CODE") private String USE_CODE= "";
	@JsonAlias("MARKET_YN") private String MARKET_YN= "";
	@JsonAlias("MARKET_DATE") private String MARKET_DATE= "";
	@JsonAlias("GOOGLE_YN") private String GOOGLE_YN= "";
	@JsonAlias("USER_OUT_DATE") private String USER_OUT_DATE= "";
	@JsonAlias("USER_STATS_YN") private String USER_STATS_YN= "";
	
	//EMAIL
	@JsonAlias("EMAIL_CODE") private String EMAIL_CODE = "";
	@JsonAlias("TITLE") private String TITLE = "";
	@JsonAlias("EXPLAIN") private String EXPLAIN = "";
	@JsonAlias("COMMENT") private String COMMENT = "";
	
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
	
	public static AdminVo fromMap(HashMap<String, Object> map) {
		AdminVo result= new ObjectMapper()
				.configure(MapperFeature.ACCEPT_CASE_INSENSITIVE_PROPERTIES, true)
				.convertValue(map, AdminVo.class);
		return result;
	}
	
}
