package com.netMiner.app.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MemberDaoImpl implements MemberDao{
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public String selectDate() {
		// TODO Auto-generated method stub
		String date = sqlSession.selectOne("selectDate");
		
		return date;
	}

}
