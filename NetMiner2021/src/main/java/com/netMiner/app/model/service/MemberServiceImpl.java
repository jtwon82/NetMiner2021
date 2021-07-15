package com.netMiner.app.model.service;

import java.util.HashMap;
import java.util.Map;

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
	public MemberVo checkJoin(MemberVo vo) {
		
		MemberVo result = memberDao.checkJoin(vo);
		return result;
	}
	@Override
	public MemberVo getUserInfo(MemberVo vo) {
		MemberVo getMemberVo = null;
		
		getMemberVo = memberDao.getUserInfo(vo);
		
		
		return getMemberVo;
	}
	@Override
	public void signUp(MemberVo memberVo) {
		
		memberDao.signUp(memberVo);
		
	}
	@Override
	public void updateAuthkey(MemberVo memberVo) {
		memberDao.updateAuthkey(memberVo);
		
	}
	@Override
	public void insertMemberInfoTmp(MemberVo memberVo) {
		memberDao.insertMemberInfoTmp(memberVo);
		
	}
	@Override
	public MemberVo getUserInfoTmp(MemberVo memberVo) {
		MemberVo member = memberDao.getUserInfoTmp(memberVo);
		return member;
	}
	@Override
	public void signUpGeneral(MemberVo memberVo) {
		memberDao.signUpGeneral(memberVo);
		
	}
	@Override
	public void updateNewPwd(MemberVo vo) {
		memberDao.updateNewPwd(vo);		
	}
	@Override
	public void updateNewUserId(Map<String, Object> param) {
		memberDao.updateNewUserId(param);		
	}
	@Override
	public void updateNewUserInfo(MemberVo oldMemberVo, MemberVo memberVo) {
		Map<String,Object> param = memberVo.getMemberInfoMap();
		param.put("oldUserId", oldMemberVo.getUserId());
		
		memberDao.updateNewUserInfo(param);
		
	}
	@Override
	public int checkUser(String userId) {
		int result = memberDao.checkUser(userId);
		return result;
	}
	@Override
	public void deleteMemberInfoTmp(MemberVo memberVo) {
		memberDao.deleteMemberInfoTmp(memberVo);
	}
	@Override
	public void deleteMember(MemberVo vo) {
		memberDao.deleteMember(vo);
		
	}
	@Override
	public Integer turnToGeneral(MemberVo outMemberVo) {
		int no = memberDao.turnToGeneral(outMemberVo);
		
		return no;
	}
	@Override
	public int selectUserCount(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return memberDao.selectUserCount(param);
	}
	@Override
	public void changeMemberState(MemberVo vo) {
		memberDao.changeMemberState(vo.getUserId());
		
	}
	@Override
	public int checkDropUser(String userId) {
		// TODO Auto-generated method stub
		return memberDao.checkDropUser(userId);
	}

}
