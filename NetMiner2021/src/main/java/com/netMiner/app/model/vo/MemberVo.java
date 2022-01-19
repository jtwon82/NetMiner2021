package com.netMiner.app.model.vo;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

import lombok.Data;

@Data
public class MemberVo implements Serializable{
	/**
	 * 
	 */

	private static final long serialVersionUID = 1L;
	private int no; 
	private String typeCode;
	private String userCode;
	private String oldUserId;
	private String userId;
	private String userPwd;
	private String nation="";
	private String company;
	private String useCode;
	private String language;
	private String marketYn="N";
	private String authKey;
	private String googleYn="N";
	private String userStatsYn="N";
	private String lastLoginDate;
	private String chk;
	private String planType;
	
	public MemberVo() {
		
	}
	
	public MemberVo(HashMap<String, Object> json) {
		if(json.containsKey("typeCode"))this.userId= json.get("userId").toString();
		if(json.containsKey("userCode"))this.userCode= json.get("userCode").toString();
		if(json.containsKey("oldUserId"))this.oldUserId= json.get("oldUserId").toString();
		if(json.containsKey("userId"))this.userId= json.get("userId").toString();
		if(json.containsKey("userPwd"))this.userPwd= json.get("userPwd").toString();
		if(json.containsKey("nation"))this.nation= json.get("nation").toString();
		if(json.containsKey("company"))this.company= json.get("company").toString();
		if(json.containsKey("useCode"))this.useCode= json.get("useCode").toString();
		if(json.containsKey("language"))this.language= json.get("language").toString();
		if(json.containsKey("marketYn"))this.marketYn= json.get("marketYn").toString();
		if(json.containsKey("authKey"))this.authKey= json.get("authKey").toString();
		if(json.containsKey("googleYn"))this.googleYn= json.get("googleYn").toString();
		if(json.containsKey("userStatsYn"))this.userStatsYn= json.get("userStatsYn").toString();
		if(json.containsKey("lastLoginDate"))this.lastLoginDate= json.get("lastLoginDate").toString();
		if(json.containsKey("chk"))this.chk= json.get("chk").toString();
		
	}
	
	public Map<String,Object> getMemberInfoMap(){
		Map<String,Object> result = new HashMap<String,Object>();
		result.put("no", this.no);
		result.put("oldUserId", this.oldUserId);
		result.put("userId", this.userId);
		result.put("typeCode", this.typeCode);
		result.put("userCode", this.userCode);
		result.put("userPwd", this.userPwd);
		result.put("nation", this.nation);
		result.put("company", this.company);
		result.put("useCode", this.useCode);
		result.put("language", this.language);
		result.put("marketYn", this.marketYn);
		result.put("googleYn", this.googleYn);
		result.put("userStatsYn", this.userStatsYn);
		result.put("lastLoginDate", this.lastLoginDate);
		return result;
	}
}
