package com.netMiner.app.model.service;

import java.util.HashMap;
import java.util.Map;


public interface BillingService {

	HashMap<String, Object> selectPlanCode(Map<String, Object> param);

}
