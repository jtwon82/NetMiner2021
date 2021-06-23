package com.netMiner.app.model.vo;

import java.io.Serializable;

import lombok.Data;

@Data
public class NationVo implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String nationCode;
	private String nationNameKr;
	private String nationNameEn;
}
