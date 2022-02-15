package com.netMiner.app.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.netMiner.app.model.vo.BillingVo;
import com.netMiner.app.model.vo.MemberVo;

public interface BillingDao {

	HashMap<String, Object> selectPlanCode(Map<String, Object> param);

	HashMap<String, Object> selectSubscript(Map<String, Object> param);

	void insertSubscript(BillingVo billingVo);

	List<Map<String,Object>> selectSubscriptAll(Map<String, Object> param);

	Map<String, Object> selectSubscriptOne(Map<String,Object> param);

	Map<String, Object> checkUserTiralInfo(Map<String, Object> param);

	List<Map<String,Object>> selectFaqList(Map<String, Object> param);


}
