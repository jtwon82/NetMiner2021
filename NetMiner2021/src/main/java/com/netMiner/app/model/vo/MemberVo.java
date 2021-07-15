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
	private String userCode;
	private String userId;
	private String userPwd;
	private String nation = "";
	private String company;
	private String useCode;
	private String language;
	private String marketYn;
	private String authKey;
	private String googleYn;
	private String userStatsYn;
	
	
	public Map<String,Object> getMemberInfoMap(){
		Map<String,Object> result = new HashMap<String,Object>();
		result.put("no", this.no);
		result.put("userId", this.userId);
		result.put("userCode", this.userCode);
		result.put("userPwd", this.userPwd);
		result.put("nation", this.nation);
		result.put("company", this.company);
		result.put("useCode", this.useCode);
		result.put("language", this.language);
		result.put("marketYn", this.marketYn);
		result.put("googleYn", this.googleYn);
		result.put("userStatsYn", this.userStatsYn);
		return result;
	}
}
