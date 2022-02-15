package com.netMiner.app.model.service;

import java.util.Map;

import com.netMiner.app.model.vo.MemberVo;

public interface MemberService {

	String getTestDate();

	MemberVo checkJoin(MemberVo vo);

	MemberVo getUserInfo(MemberVo memberVo);

	MemberVo getUserInfoLastlogin(MemberVo memberVo);

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

	void deleteMember(MemberVo vo);

	Integer turnToGeneral(MemberVo outMemberVo);

	int selectUserCount(Map<String, Object> param);

	void changeMemberInfo(MemberVo vo);

	int checkDropUser(String userId);

	Map<String, Object> checkRandomNumber(Map<String, Object> param);

	MemberVo selectPayCompleteUser(MemberVo memberVo);

	

	
}
