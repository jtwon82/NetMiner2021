package com.netMiner.app.util;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

public class StringUtils2 {
	public static void script(HttpServletResponse response, String language, String msgKr, String msgEn, String landing) {
		response.setContentType("text/html; charset=UTF-8"); 
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		if("_EN".equals(language)) {
			out.println("<script>alert('"+msgEn+"'); location.href='"+landing+"';</script>");
		} else {
			out.println("<script>alert('"+msgKr+"'); location.href='"+landing+"';</script>");
		}
		out.flush();
	}
	public static boolean isEmpty(String str) {
        return str == null || str.length() == 0;
    }
	public static String defaultIfEmpty(String str, String defaultStr) {
        return isEmpty(str) ? defaultStr : str;
    }
}
