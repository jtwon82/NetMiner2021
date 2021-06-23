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
		sqlSession.flushStatements();
		
		return date;
	}

	@Override
	public MemberVo getUserInfo(MemberVo vo) {
		 
		MemberVo memberVo = sqlSession.selectOne("getUserInfo", vo);
		sqlSession.flushStatements();
		if (memberVo != null) {
			sqlSession.update("updateLastLoginDate", vo);
			sqlSession.flushStatements();
		}
		return memberVo;
	}

	@Override
	public void signUp(MemberVo memberVo) {
		
		sqlSession.insert("insertSignUp", memberVo);
		sqlSession.flushStatements();
	}

	@Override
	public void updateAuthkey(MemberVo memberVo) {
		
		sqlSession.update("updateAuthkey", memberVo);
		sqlSession.flushStatements();
	}

	@Override
	public void insertMemberInfoTmp(MemberVo memberVo) {
		
		sqlSession.insert("insertMemberInfoTmp", memberVo);
		sqlSession.flushStatements();
	}

	@Override
	public MemberVo getUserInfoTmp(MemberVo memberVo) {
		MemberVo result = sqlSession.selectOne("getUserInfoTmp", memberVo);
		sqlSession.flushStatements();
		return result;
	}

	@Override
	public void signUpGeneral(MemberVo memberVo) {
		sqlSession.insert("signUpGeneral", memberVo);
		sqlSession.flushStatements();
		
	}

}
