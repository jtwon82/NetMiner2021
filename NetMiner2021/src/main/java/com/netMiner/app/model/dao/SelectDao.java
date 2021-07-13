package com.netMiner.app.model.dao;

import java.util.List;
import java.util.Map;

import com.netMiner.app.model.vo.MailVo;
import com.netMiner.app.model.vo.NationVo;

public interface SelectDao {

	List<NationVo> getNation();

	MailVo getRandomMail(String mailCode);

	Map<String, Object> getCheckData();

	void insertEmailSendLog(Map<String, Object> param);

}
