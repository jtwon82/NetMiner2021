package com.netMiner.app.model.dao;

import com.netMiner.app.model.vo.MemberVo;

public interface MemberDao {

	String selectDate();

	MemberVo getUserInfo(MemberVo vo);

	void signUp(MemberVo memberVo);

	void updateAuthkey(MemberVo memberVo);

}
