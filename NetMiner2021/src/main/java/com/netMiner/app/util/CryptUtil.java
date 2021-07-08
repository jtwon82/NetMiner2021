package com.netMiner.app.util;

import java.io.UnsupportedEncodingException;
import java.security.Key;
import java.time.Instant;
import java.util.Base64;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;

public class CryptUtil {
	private Key generateKey(String key) throws UnsupportedEncodingException {
		Key keySpec;

		byte[] keyBytes = new byte[16];
		byte[] b = key.getBytes("UTF-8");

		int len = b.length;
		if (len > keyBytes.length) {
			len = keyBytes.length;
		}

		System.arraycopy(b, 0, keyBytes, 0, len);
		keySpec = new SecretKeySpec(keyBytes, "AES");
		return keySpec;
	}

	private String encryptText(String text, String key) throws Exception {
		String encrypted = "";
		SecretKeySpec ks = (SecretKeySpec) this.generateKey(key);
		Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5Padding");
		cipher.init(Cipher.ENCRYPT_MODE, ks);
		byte[] encryptedBytes = cipher.doFinal(text.getBytes());
		String base64 = Base64.getEncoder().encodeToString(encryptedBytes);
		encrypted = new String(base64);
		return encrypted;
	}

	public String encryptLoginfo(String userid, String usercode) throws Exception {
		Instant instant = Instant.now();
		String key = "cyramnetminer365";
		String idAndCode = "netminer:" + userid + ":" + usercode + ":" + instant.toEpochMilli() + ":365";
		return encryptText(idAndCode, key);
	}

	public static void main(String[] args) throws Exception {
		CryptUtil cu = new CryptUtil();
		System.out.println(cu.encryptLoginfo("sslee@cyram.com", "03"));
	}
}