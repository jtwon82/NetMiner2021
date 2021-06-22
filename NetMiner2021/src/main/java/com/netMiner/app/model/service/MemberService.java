package com.netMiner.app.model.service;

import com.netMiner.app.model.vo.MemberVo;

public interface MemberService {

	String getTestDate();

	String checkJoin(MemberVo vo);

	MemberVo getUserInfo(MemberVo memberVo);

	void signUp(MemberVo memberVo);

	void updateAuthkey(MemberVo memberVo);

}
