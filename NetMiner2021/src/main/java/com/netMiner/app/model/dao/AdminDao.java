package com.netMiner.app.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface AdminDao {

	String selectDate();


	int getAdminCount(Map<String, Object> map);
	
	List<HashMap<String, Object>> getAdminList(Map<String, Object> map);

	HashMap<String, Object> getAdminInfo(Map<String, Object> map);

	void modifyAdminInfo(Map<String, Object> map);

	void insertAdminInfo(Map<String, Object> map);

	void deleteAdminInfo(Map<String, Object> map);


	
	int getMemberCount(Map<String, Object> map);
	
	List<HashMap<String, Object>> getMemberList(Map<String, Object> map);

	HashMap<String, Object> getMemberInfo(Map<String, Object> map);

	void modifyMemberInfo(Map<String, Object> map);

	void insertMemberInfo(Map<String, Object> map);

	void insertMemberInfoDrop(Map<String, Object> map);

	void deleteMemberInfo(Map<String, Object> map);

	void updateSubscript(Map<String, Object> map);

	

	int getMemberQuitCount(Map<String, Object> map);
	
	List<HashMap<String, Object>> getMemberQuitList(Map<String, Object> map);

	HashMap<String, Object> getMemberQuitInfo(Map<String, Object> map);

	void modifyMemberQuitInfo(Map<String, Object> map);

	void insertMemberQuitInfo(Map<String, Object> map);

	void deleteMemberQuitInfo(Map<String, Object> map);


	
	List<HashMap<String, Object>> getEmailList(Map<String, Object> map);

	int getEmailCount(Map<String, Object> map);

	HashMap<String, Object> getEmailDetailInfo(Map<String, Object> map);

	void deleteEmailInfo(HashMap<String, Object> map);

	void insertEmailInfo(HashMap<String, Object> map);

	void modifyEmailInfo(HashMap<String, Object> map);

	
	
	
	

	List<HashMap<String, Object>> getOrderList(Map<String, Object> map);

	int getOrderCount(Map<String, Object> map);

	HashMap<String, Object> getOrderDetailInfo(Map<String, Object> map);

	void deleteOrderInfo(HashMap<String, Object> map);

	void insertOrderInfo(HashMap<String, Object> map);

	void modifyOrderInfo(HashMap<String, Object> map);

	
	

	List<HashMap<String, Object>> getFaqList(Map<String, Object> map);

	int getFaqCount(Map<String, Object> map);

	HashMap<String, Object> getFaqDetailInfo(Map<String, Object> map);

	void deleteFaqInfo(HashMap<String, Object> map);

	void insertFaqInfo(HashMap<String, Object> map);

	void modifyFaqInfo(HashMap<String, Object> map);

	
	
	
	void modifyDropMemberInfo(HashMap<String, Object> map);

	void recoverMemberQuitInfo(HashMap<String, Object> json);

	Map getCheck(HashMap<String, Object> json);

	void modifyCheck(HashMap<String, Object> json);
}
