package com.netMiner.app.model.dao;

import java.util.List;
import java.util.Map;

import com.netMiner.app.model.vo.MailVo;
import com.netMiner.app.model.vo.NationVo;

public interface SelectDao {

	List<NationVo> getNation();

	MailVo getRandomMail(String mailCode);

	Map<String, Object> getCheckData() throws Exception ;

	void insertEmailSendLog(Map<String, Object> param);

	Map<String,Object> getauthData(String userId);

	void deleteCheckSendAuthData(String userId);

	String getNowDate() throws Exception ;


}
