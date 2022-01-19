package com.netMiner.app.model.dao;

import java.util.HashMap;
import java.util.Map;

import com.netMiner.app.model.vo.BillingVo;

public interface BillingDao {

	HashMap<String, Object> selectPlanCode(Map<String, Object> param);

	HashMap<String, Object> selectSubscript(Map<String, Object> param);

	void insertSubscript(BillingVo billingVo);

}
