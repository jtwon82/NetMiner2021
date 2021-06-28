package com.netMiner.app.model.service;

import java.util.Map;

import com.netMiner.app.model.vo.MemberVo;

public interface MemberService {

	String getTestDate();

	boolean checkJoin(MemberVo vo);

	MemberVo getUserInfo(MemberVo memberVo);

	void signUp(MemberVo memberVo);

	void updateAuthkey(MemberVo memberVo);

	void insertMemberInfoTmp(MemberVo memberVo);

	MemberVo getUserInfoTmp(MemberVo memberVo);

	void signUpGeneral(MemberVo memberVo);

	void updateNewPwd(MemberVo vo);

	void updateNewUserId(Map<String, Object> param);

	void updateNewUserInfo(MemberVo oldMemberVo, MemberVo memberVo);

	int checkUser(String userId);

	void deleteMemberInfoTmp(MemberVo memberVo);

	
}
