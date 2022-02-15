package com.netMiner.app.model.dao;

import java.util.HashMap;
import java.util.List;
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
		return sqlSession.selectOne("getUserInfo", vo);	
	}
	
	@Override
	public MemberVo getUserInfoLastlogin(MemberVo vo) {
		sqlSession.update("updateLastLoginDate", vo);			
		sqlSession.flushStatements();
		try {
			return sqlSession.selectOne("getUserInfo", vo);
		}catch(Exception e) {
			List list= sqlSession.selectList("getUserInfo", vo);
			return (MemberVo) list.get(0);
		}
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

	@Override
	public MemberVo checkJoin(MemberVo vo) {
		MemberVo result = sqlSession.selectOne("checkJoin", vo);
		return result;
	}

	@Override
	public void updateNewPwd(MemberVo vo) {
		sqlSession.update("updateNewPwd", vo);
		
	}

	@Override
	public void updateNewUserId(Map<String, Object> param) {
		sqlSession.update("updateUserId", param);			
	}

	@Override
	public void updateNewUserInfo(Map<String, Object> param) {
		
		sqlSession.update("updateNewUserInfo", param);
	}

	@Override
	public void dropTempUser() {
		
		sqlSession.delete("deleteTempUser");
		
	}

	@Override
	public int checkUser(String userId) {
		int result = sqlSession.selectOne("checkUser", userId);
		
		return result;
	}

	@Override
	public void deleteMemberInfoTmp(MemberVo memberVo) {
		
		sqlSession.delete("deleteMemberInfoTmp", memberVo);		
	}

	@Override
	public void deleteMember(MemberVo vo) {

		sqlSession.delete("deleteMemberInfo", vo);		
	}

	@Override
	public List<Map<String, Object>> getLastLoginFerYear() {
		return sqlSession.selectList("getLastLoginFerYear");
	}

	@Override
	public void changeMemberInfo(MemberVo vo) {
		Map map = new HashMap();
		map.put("NO", vo.getNo());
		map.put("userId", vo.getUserId());
		
		sqlSession.update("changeMemberInfo", vo);
		sqlSession.delete("deleteMemberInfo", map);
	}

	@Override
	public void getPassByDormant() {
		// TODO Auto-generated method stub
		sqlSession.update("getPassByDormant");
	}

	@Override
	public List<Map<String, Object>> getMarketYnUser() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("getMarketYnUser");
	}

	@Override
	public Integer turnToGeneral(MemberVo outMemberVo) {
		sqlSession.insert("returnUserInfo" , outMemberVo);
		sqlSession.delete("deletDropMember", outMemberVo);
		sqlSession.flushStatements();

		int no =  sqlSession.selectOne("returnNo", outMemberVo);
		
		return no;
	}

	@Override
	public int selectUserCount(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("selectUserCount", param);
	}

	@Override
	public void deleteDropMember() {
		sqlSession.delete("deleteDropMember");
	}

	@Override
	public int checkDropUser(String userId) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("checkDropUser",userId);
	}

	@Override
	public Map<String, Object> checkRandomNumber(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("checkRandomNumber", param);
	}

	@Override
	public List<Map<String, Object>> getPayPlanUser() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("getPayPlanUser");
	}

	@Override
	public MemberVo selectPayCompleteUser(MemberVo memberVo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("getUserInfoPayComplete", memberVo);
	}


}
