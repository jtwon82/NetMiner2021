package com.netMiner.app.util;

import java.util.Base64;

public class Base64Util {

	
	public String enCodingBase64(String param) {
		String result = "";
		
		byte[] binary = param.getBytes();
		
		result = Base64.getEncoder().encodeToString(binary);
		
		return result;
	}
	
	public String deCodingBase64(String param) {
		String result = "";
		
		try {
			byte[] binary = Base64.getDecoder().decode(param);
			
			result = new String(binary);
		}catch(Exception e) {
			
		}
		
		return result;
	}
}
