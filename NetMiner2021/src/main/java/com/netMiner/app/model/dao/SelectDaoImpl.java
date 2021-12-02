package com.netMiner.app.model.dao;


import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.netMiner.app.model.vo.MailVo;
import com.netMiner.app.model.vo.NationVo;

@Repository
public class SelectDaoImpl implements SelectDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public List<NationVo> getNation() {
		List<NationVo> result = sqlSession.selectList("selectNation");
		return result;
	}

	@Override
	public MailVo getRandomMail(String mailCode) {
		MailVo vo = sqlSession.selectOne("selectEmail", mailCode);
		return vo;
	}

	@Override
	public Map<String, Object> getCheckData() throws Exception {
		return sqlSession.selectOne("getCheckData");
	}

	@Override
	public void insertEmailSendLog(Map<String, Object> param) {
		sqlSession.insert("insertEmailSendLog", param);
		
	}

	@Override
	public Map<String,Object> getauthData(String userId) {
		return sqlSession.selectOne("getauthData", userId);
	}

	@Override
	public void deleteCheckSendAuthData(String userId) {
		sqlSession.delete("deleteCheckSendAuthData", userId);
		
	}

	@Override
	public String getNowDate() throws Exception {
		return sqlSession.selectOne("getNowDate");
	}
}
