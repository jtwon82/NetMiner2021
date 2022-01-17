package com.netMiner.app.model.dao;

import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.netMiner.app.model.vo.BillingVo;

@Repository
public class BillingDaoImpl implements BillingDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public HashMap<String, Object> selectPlanCode(Map<String, Object> param) {
		HashMap<String, Object> result = sqlSession.selectOne("getPlanCode", param);
		return result;
	}

}
