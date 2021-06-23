package com.netMiner.app.model.dao;


import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.netMiner.app.model.vo.NationVo;

@Repository
public class SelectDaoImpl implements SelectDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public List<NationVo> getNation() {
		List<NationVo> result = sqlSession.selectList("selectNation");
		return result;
	}
}
