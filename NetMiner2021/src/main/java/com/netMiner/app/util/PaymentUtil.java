package com.netMiner.app.util;

import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;

import com.google.gson.Gson;

public class PaymentUtil {

	public static String verifyPaymentKey(String orderNo, int amount) {

		URL url = null;
		URLConnection connection = null;
		StringBuilder responseBody = new StringBuilder();
		try {
			url = new URL("https://pay.toss.im/api/v2/status");
			connection = url.openConnection();
			connection.addRequestProperty("Content-Type", "application/json");
			connection.setDoOutput(true);
			connection.setDoInput(true);

			Map<String, Object> map= new HashMap<>();
			map.put("amount", amount);
			map.put("orderNo", orderNo);
			map.put("apiKey", "sk_test_w5lNQylNqa5lNQe013Nq");
			String body= new Gson().toJson(map);

			BufferedOutputStream bos = new BufferedOutputStream(connection.getOutputStream());
			bos.write(body.getBytes(StandardCharsets.UTF_8));
			bos.flush();
			bos.close();

			
		    BufferedReader br = new BufferedReader(new InputStreamReader(connection.getInputStream(), StandardCharsets.UTF_8));
			String line = null;
			while ((line = br.readLine()) != null) {
				responseBody.append(line);
			}
			br.close();
		} catch (Exception e) {
			responseBody.append(e);
		}
		// {"result":0,"msg":"payToken 또는 orderNo 는 필수값입니다.","code":-1,"errorCode":"COMMON_INVALID_PARAMETER","status":200}
		HashMap result= (HashMap) new Gson().fromJson(responseBody.toString(), Map.class);
		
		return result.toString();
	}
}
