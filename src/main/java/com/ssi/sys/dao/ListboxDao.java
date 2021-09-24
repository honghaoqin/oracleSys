package com.ssi.sys.dao;

import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.ssi.framework.dao.BaseDao;
import com.ssi.framework.service.BaseService;

@Repository
public class ListboxDao extends BaseDao{

	@Override
	public String getNamespace() {
		throw new RuntimeException("不支持");
	}
}
