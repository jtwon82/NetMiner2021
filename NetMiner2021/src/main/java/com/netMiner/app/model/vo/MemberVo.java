package com.netMiner.app.model.vo;

import java.io.Serializable;

import lombok.Data;

@Data
public class MemberVo implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String userId;
	private String userPwd;
	private String nation;
	private String company;
	private String useCode;
	private String language;
	private String marketYn;
	private String authKey;
}
