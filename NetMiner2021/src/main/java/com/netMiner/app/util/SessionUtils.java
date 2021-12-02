package com.netMiner.app.util;

import javax.servlet.http.HttpSession;

public class SessionUtils {

	public static String getLanguage(HttpSession session) {
		String language= "";
		try {
			language= (String) session.getAttribute("language");
			if (language== null) {
				language= "";
			}
		}catch(Exception e) {
		}
		return language;
	}
}
