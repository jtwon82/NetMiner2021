package com.netMiner.app.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface AdminService {

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
	
	void deleteMemberInfo(Map<String, Object> map);


	
	int getMemberQuitCount(Map<String, Object> map);
	
	List<HashMap<String, Object>> getMemberQuitList(Map<String, Object> map);

	HashMap<String, Object> getMemberQuitInfo(Map<String, Object> map);

	void modifyMemberQuitInfo(Map<String, Object> map);

	void insertMemberQuitInfo(Map<String, Object> map);
	
	void deleteMemberQuitInfo(Map<String, Object> map);


}
