package com.netMiner.app.util;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

public class StringUtils2 {
	public static void script(HttpServletResponse response, String msg, String landing) {
		response.setContentType("text/html; charset=UTF-8"); 
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		} 
		out.println("<script>alert('"+msg+"'); location.href='"+landing+"';</script>"); 
		out.flush();
	}
}
