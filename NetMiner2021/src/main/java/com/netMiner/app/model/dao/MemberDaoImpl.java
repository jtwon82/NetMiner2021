package com.netMiner.app.model.dao;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.netMiner.app.model.vo.MemberVo;

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

	@Override
	public MemberVo getUserInfo(MemberVo vo) {
		 
		MemberVo memberVo = sqlSession.selectOne("getUserInfo", vo);
		
		return memberVo;
	}

	@Override
	public void signUp(MemberVo memberVo) {
		
		sqlSession.insert("insertSignUp", memberVo);
		
	}

	@Override
	public void updateAuthkey(MemberVo memberVo) {
		
		sqlSession.update("updateAuthkey", memberVo);
		
	}

}
