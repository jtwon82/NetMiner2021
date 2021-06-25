package com.netMiner.app.model.service;

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

	
}
