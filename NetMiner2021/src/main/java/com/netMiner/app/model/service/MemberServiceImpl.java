package com.netMiner.app.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.netMiner.app.model.dao.MemberDao;
import com.netMiner.app.model.vo.MemberVo;

@Service
public class MemberServiceImpl implements MemberService{
	@Autowired
	private MemberDao memberDao;
	@Override
	public String getTestDate() {
		// TODO Auto-generated method stub
		String dbDate = memberDao.selectDate();
		return dbDate;
	}
	@Override
	public String checkJoin(MemberVo vo) {
		
		return "";
	}

}
