package com.netMiner.app.model.dao;

import java.util.List;
import java.util.Map;

import com.netMiner.app.model.vo.MemberVo;

public interface MemberDao {

	String selectDate();

	MemberVo getUserInfo(MemberVo vo);

	MemberVo getUserInfoLastlogin(MemberVo vo);

	void signUp(MemberVo memberVo);

	void updateAuthkey(MemberVo memberVo);

	void insertMemberInfoTmp(MemberVo memberVo);

	MemberVo getUserInfoTmp(MemberVo memberVo);

	void signUpGeneral(MemberVo memberVo);

	MemberVo checkJoin(MemberVo vo);

	void updateNewPwd(MemberVo vo);

	void updateNewUserId(Map<String, Object> param);

	void updateNewUserInfo(Map<String, Object> param);

	void dropTempUser();

	int checkUser(String userId);

	void deleteMemberInfoTmp(MemberVo memberVo);

	void deleteMember(MemberVo vo);

	List<Map<String, Object>> getLastLoginFerYear();

	void changeMemberInfo(MemberVo vo);

	void getPassByDormant();

	List<Map<String, Object>> getMarketYnUser();

	Integer turnToGeneral(MemberVo outMemberVo);

	int selectUserCount(Map<String, Object> param);

	void deleteDropMember();

	int checkDropUser(String userId);

	Map<String, Object> checkRandomNumber(Map<String, Object> param);

	List<Map<String, Object>> getPayPlanUser();

	MemberVo selectPayCompleteUser(MemberVo memberVo);


}
