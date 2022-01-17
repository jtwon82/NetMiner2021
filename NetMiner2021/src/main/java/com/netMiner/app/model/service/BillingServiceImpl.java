package com.netMiner.app.model.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.netMiner.app.model.dao.BillingDao;
import com.netMiner.app.model.vo.BillingVo;

@Service
public class BillingServiceImpl  implements BillingService{
	
	@Autowired
	private BillingDao billingDao;
	
	@Override
	public HashMap<String, Object> selectPlanCode(Map<String, Object> param) {
		 
		return billingDao.selectPlanCode(param);
	}

}
