package com.netMiner.app.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.netMiner.app.model.dao.AdminDao;

@Service
public class AdminServiceImpl implements AdminService{
	
	@Autowired
	private AdminDao adminDao;

	@Override
	public String selectDate() {
		return adminDao.selectDate();
	}


	@Override
	public int getAdminCount(Map<String, Object> map) {
		return adminDao.getAdminCount(map);
	}

	@Override
	public List<HashMap<String, Object>> getAdminList(Map<String, Object> map) {
		return adminDao.getAdminList(map);
	}

	@Override
	public HashMap<String, Object> getAdminInfo(Map<String, Object> map) {
		return adminDao.getAdminInfo(map);
	}
	
	@Override
	public void modifyAdminInfo(Map<String, Object> map) {
		adminDao.modifyAdminInfo(map);
	}

	@Override
	public void insertAdminInfo(Map<String, Object> map) {
		adminDao.insertAdminInfo(map);
	}

	@Override
	public void deleteAdminInfo(Map<String, Object> map) {
		adminDao.deleteAdminInfo(map);
	}
	
	


	@Override
	public int getMemberCount(Map<String, Object> map) {
		return adminDao.getMemberCount(map);
	}
	
	@Override
	public List<HashMap<String, Object>> getMemberList(Map<String, Object> map) {
		return adminDao.getMemberList(map);
	}

	@Override
	public HashMap<String, Object> getMemberInfo(Map<String, Object> map) {
		return adminDao.getMemberInfo(map);
	}
	
	@Override
	public void modifyMemberInfo(Map<String, Object> map) {
		adminDao.modifyMemberInfo(map);
	}

	@Override
	public void insertMemberInfo(Map<String, Object> map) {
		adminDao.insertMemberInfo(map);
	}

	@Override
	public void deleteMemberInfo(Map<String, Object> map) {
		adminDao.deleteMemberInfo(map);
	}


	

	@Override
	public int getMemberQuitCount(Map<String, Object> map) {
		return adminDao.getMemberQuitCount(map);
	}
	
	@Override
	public List<HashMap<String, Object>> getMemberQuitList(Map<String, Object> map) {
		return adminDao.getMemberQuitList(map);
	}

	@Override
	public HashMap<String, Object> getMemberQuitInfo(Map<String, Object> map) {
		return adminDao.getMemberQuitInfo(map);
	}
	
	@Override
	public void modifyMemberQuitInfo(Map<String, Object> map) {
		adminDao.modifyMemberQuitInfo(map);
	}

	@Override
	public void insertMemberQuitInfo(Map<String, Object> map) {
		adminDao.insertMemberQuitInfo(map);
	}

	@Override
	public void deleteMemberQuitInfo(Map<String, Object> map) {
		adminDao.deleteMemberQuitInfo(map);
	}

}
