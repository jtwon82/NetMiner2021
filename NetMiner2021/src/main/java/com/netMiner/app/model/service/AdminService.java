package com.netMiner.app.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.xssf.streaming.SXSSFWorkbook;

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
	
	void insertMemberInfoDrop(Map<String, Object> map);
	
	void deleteMemberInfo(Map<String, Object> map);
	
	void updateSubscript(Map<String, Object> map);


	
	int getMemberQuitCount(Map<String, Object> map);
	
	List<HashMap<String, Object>> getMemberQuitList(Map<String, Object> map);

	HashMap<String, Object> getMemberQuitInfo(Map<String, Object> map);

	void modifyMemberQuitInfo(Map<String, Object> map);

	void insertMemberQuitInfo(Map<String, Object> map);
	
	void deleteMemberQuitInfo(Map<String, Object> map);
	
	

	List getEmailList(Map<String, Object> json);

	int getEmailCount(Map<String, Object> json);

	HashMap<String, Object> getEmailDetailInfo(Map<String, Object> map);

	void deleteEmailInfo(HashMap<String, Object> json);

	void insertEmailInfo(HashMap<String, Object> json);

	void modifyEmailInfo(HashMap<String, Object> json);

	
	
	

	List getOrderList(Map<String, Object> json);

	int getOrderCount(Map<String, Object> json);

	HashMap<String, Object> getOrderDetailInfo(Map<String, Object> map);

	void deleteOrderInfo(HashMap<String, Object> json);

	void insertOrderInfo(HashMap<String, Object> json);

	void modifyOrderInfo(HashMap<String, Object> json);

	
	

	List getFaqList(Map<String, Object> json);

	int getFaqCount(Map<String, Object> json);

	HashMap<String, Object> getFaqDetailInfo(Map<String, Object> map);

	void deleteFaqInfo(HashMap<String, Object> json);

	void insertFaqInfo(HashMap<String, Object> json);

	void modifyFaqInfo(HashMap<String, Object> json);

	
	
	
	SXSSFWorkbook excelFileDownloadProcess(List<HashMap<String, Object>> list);

	void modifyDropMemberInfo(HashMap<String, Object> json);

	void recoverMemberQuitInfo(HashMap<String, Object> json);

	Map getCheck(HashMap<String, Object> json);

	void modifyCheck(HashMap<String, Object> json);


}
