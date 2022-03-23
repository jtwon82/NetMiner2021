package com.netMiner.app.util;

import java.io.UnsupportedEncodingException;
import java.security.Key;
import java.time.Instant;
import java.util.Base64;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.netMiner.app.model.vo.MemberVo;

public class CryptUtil {
	private static final Logger logger = LoggerFactory.getLogger(CryptUtil.class);
	
	private static CryptUtil ins= null;
	
	public static CryptUtil getInstance() {
		if(ins==null) {
			ins = new CryptUtil();
		}
		return ins;
	}
	
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

	public String encryptLoginfo(MemberVo memberVo) throws Exception {
		String userid= memberVo.getUserId();
		//String usercode= memberVo.getUserCode();
		//Integer userNo= memberVo.getNo();
		String uuid = memberVo.getUUID();
		String lastLoginDate= memberVo.getLastLoginDate();

		
		Instant instant = Instant.now();
		String key = "cyramnetminer365";
		String idAndCode = String.format("netminer|%s|%s|%s|%s|%s|365", userid, uuid, memberVo.getTypeCode(), instant.toEpochMilli(), lastLoginDate );
		
		return encryptText(idAndCode, key);
	}

	public static void main(String[] args) throws Exception {
		CryptUtil cu = new CryptUtil();
//		System.out.println(cu.encryptLoginfo("limdh93@naver.com", "02", 46));
	}
}