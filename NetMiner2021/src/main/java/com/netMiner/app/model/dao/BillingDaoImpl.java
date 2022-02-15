package com.netMiner.app.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.netMiner.app.model.vo.BillingVo;
import com.netMiner.app.model.vo.MemberVo;

@Repository
public class BillingDaoImpl implements BillingDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public HashMap<String, Object> selectPlanCode(Map<String, Object> param) {
		HashMap<String, Object> result = sqlSession.selectOne("selectPlanCode", param);
		return result;
	}

	@Override
	public HashMap<String, Object> selectSubscript(Map<String, Object> param) {
		return sqlSession.selectOne("selectSubscript", param);
	}

	@Override
	public void insertSubscript(BillingVo billingVo) {
		sqlSession.insert("insertSubscript", billingVo);
	}

	@Override
	public List<Map<String,Object>> selectSubscriptAll(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("selectSubscriptAll", param);
	}

	@Override
	public Map<String, Object> selectSubscriptOne(Map<String,Object> param) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("selectSubscriptOne", param);
	}

	@Override
	public Map<String, Object> checkUserTiralInfo(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("checkUserTiralInfo", param);
	}

	@Override
	public List<Map<String,Object>> selectFaqList(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("selectFaqList", param);
	}

}
