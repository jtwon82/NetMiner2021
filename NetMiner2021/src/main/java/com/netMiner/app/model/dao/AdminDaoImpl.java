package com.netMiner.app.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AdminDaoImpl implements AdminDao{
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public String selectDate() {
		String date = sqlSession.selectOne("selectDate");
		sqlSession.flushStatements();
		
		return date;
	}
	

	@Override
	public int getAdminCount(Map<String, Object> map) {
		return sqlSession.selectOne("getAdminCount", map);
	}
		
	@Override
	public List<HashMap<String, Object>> getAdminList(Map<String, Object> map) {
		return sqlSession.selectList("getAdminList", map);
	}

	@Override
	public HashMap<String, Object> getAdminInfo(Map<String, Object> map) {
		return sqlSession.selectOne("getAdminInfo", map);
	}

	@Override
	public void modifyAdminInfo(Map<String, Object> map) {
		sqlSession.update("modifyAdminInfo", map);
	}

	@Override
	public void insertAdminInfo(Map<String, Object> map) {
		sqlSession.update("insertAdminInfo", map);
	}

	@Override
	public void deleteAdminInfo(Map<String, Object> map) {
		sqlSession.update("deleteAdminInfo", map);
	}



	@Override
	public int getMemberCount(Map<String, Object> map) {
		return sqlSession.selectOne("getMemberCount", map);
	}
	
	@Override
	public List<HashMap<String, Object>> getMemberList(Map<String, Object> map) {
		return sqlSession.selectList("getMemberList", map);
	}

	@Override
	public HashMap<String, Object> getMemberInfo(Map<String, Object> map) {
		return sqlSession.selectOne("getMemberInfo", map);
	}

	@Override
	public void modifyMemberInfo(Map<String, Object> map) {
		sqlSession.update("modifyMemberInfo", map);
	}

	@Override
	public void insertMemberInfo(Map<String, Object> map) {
		sqlSession.update("insertMemberInfo", map);
	}

	@Override
	public void insertMemberInfoDrop(Map<String, Object> map) {
		sqlSession.insert("insertMemberInfoDrop", map);
	}
	
	@Override
	public void deleteMemberInfo(Map<String, Object> map) {
		sqlSession.update("deleteMemberInfo", map);
	}
	
	@Override
	public void updateSubscript(Map<String, Object> map) {
		sqlSession.update("updateSubscript", map);
	}

	

	@Override
	public int getMemberQuitCount(Map<String, Object> map) {
		return sqlSession.selectOne("getMemberQuitCount", map);
	}
	
	@Override
	public List<HashMap<String, Object>> getMemberQuitList(Map<String, Object> map) {
		return sqlSession.selectList("getMemberQuitList", map);
	}

	@Override
	public HashMap<String, Object> getMemberQuitInfo(Map<String, Object> map) {
		return sqlSession.selectOne("getMemberQuitInfo", map);
	}

	@Override
	public void modifyMemberQuitInfo(Map<String, Object> map) {
		sqlSession.update("modifyMemberQuitInfo", map);
	}

	@Override
	public void insertMemberQuitInfo(Map<String, Object> map) {
		sqlSession.update("insertMemberQuitInfo", map);
	}

	@Override
	public void deleteMemberQuitInfo(Map<String, Object> map) {
		sqlSession.update("deleteMemberQuitInfo", map);
	}

	
	
	
	
	
	

	@Override
	public List<HashMap<String, Object>> getEmailList(Map<String, Object> map) {
		return sqlSession.selectList("getEmailList", map);
	}

	@Override
	public int getEmailCount(Map<String, Object> map) {
		return sqlSession.selectOne("getEmailCount", map);
	}

	@Override
	public HashMap<String, Object> getEmailDetailInfo(Map<String, Object> map) {
		return sqlSession.selectOne("getEmailDetailInfo", map);
	}

	@Override
	public void deleteEmailInfo(HashMap<String, Object> map) {
		sqlSession.delete("deleteEmailInfo" , map);
	}

	@Override
	public void insertEmailInfo(HashMap<String, Object> map) {
		sqlSession.update("insertEmailInfo", map);
	}

	@Override
	public void modifyEmailInfo(HashMap<String, Object> map) {
		sqlSession.update("modifyEmailInfo", map);
	}

	
	
	
	
	

	@Override
	public List<HashMap<String, Object>> getOrderList(Map<String, Object> map) {
		return sqlSession.selectList("getOrderList", map);
	}

	@Override
	public int getOrderCount(Map<String, Object> map) {
		return sqlSession.selectOne("getOrderCount", map);
	}

	@Override
	public HashMap<String, Object> getOrderDetailInfo(Map<String, Object> map) {
		return sqlSession.selectOne("getOrderDetailInfo", map);
	}

	@Override
	public void deleteOrderInfo(HashMap<String, Object> map) {
		sqlSession.delete("deleteOrderInfo" , map);
	}

	@Override
	public void insertOrderInfo(HashMap<String, Object> map) {
		sqlSession.update("insertOrderInfo", map);
	}

	@Override
	public void modifyOrderInfo(HashMap<String, Object> map) {
		sqlSession.update("modifyOrderInfo", map);
	}


	
	
	
	

	@Override
	public List<HashMap<String, Object>> getFaqList(Map<String, Object> map) {
		return sqlSession.selectList("getFaqList", map);
	}

	@Override
	public int getFaqCount(Map<String, Object> map) {
		return sqlSession.selectOne("getFaqCount", map);
	}

	@Override
	public HashMap<String, Object> getFaqDetailInfo(Map<String, Object> map) {
		return sqlSession.selectOne("getFaqDetailInfo", map);
	}

	@Override
	public void deleteFaqInfo(HashMap<String, Object> map) {
		sqlSession.delete("deleteFaqInfo" , map);
	}

	@Override
	public void insertFaqInfo(HashMap<String, Object> map) {
		sqlSession.update("insertFaqInfo", map);
	}

	@Override
	public void modifyFaqInfo(HashMap<String, Object> map) {
		sqlSession.update("modifyFaqInfo", map);
	}

	
	
	
	
	
	
	
	
	
	
	@Override
	public void modifyDropMemberInfo(HashMap<String, Object> map) {
		sqlSession.update("modifyDropMemberInfo", map);
	}

	@Override
	public void recoverMemberQuitInfo(HashMap<String, Object> json) {
		sqlSession.update("recoverMemberQuitInfo", json);
	}

	@Override
	public Map getCheck(HashMap<String, Object> json) {
		return sqlSession.selectOne("getCheck");
	}

	@Override
	public void modifyCheck(HashMap<String, Object> json) {
		sqlSession.update("modifyCheck", json);
	}


}
