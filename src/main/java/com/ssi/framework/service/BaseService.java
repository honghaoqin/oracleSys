package com.ssi.framework.service;

import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ssi.framework.bean.Page;
import com.ssi.framework.dao.BaseDao;
import com.ssi.framework.service.inter.IBaseService;
/**
 * @author 123
 */

public  class BaseService //implements IBaseService
{
	protected final Log log = LogFactory.getLog(getClass());
	/**@Autowired
	BaseDao baseDao;
	
	 * 新增数据
	 * @param map
	 * @return
	 *//*
    @Transactional
	public Object insert(Map map) {
		// TODO Auto-generated method stub
		return this.baseDao.insert(map);
	}
    *//**
     * 更新数据
     * @param map
     * @return
     *//*
    @Transactional
	public int update(Map map) {
		// TODO Auto-generated method stub
		 return this.baseDao.update(map);
	}
    *//**
     * 删除数据
     * @param map
     * @return
     *//*
    @Transactional
	public int delete(Map map) {
		// TODO Auto-generated method stub
		return this.baseDao.delete(map);
	}
    *//**
     * 查询一个对象
     * @param map
     * @return
     *//*
	public Object one(Map map) {
		// TODO Auto-generated method stub
		return this.baseDao.one(map);
	}
    *//**
     * 查询结果集合
     * @param map
     * @return
     *//*
	public List list(Map map) {
		// TODO Auto-generated method stub
		return this.baseDao.list(map);
	}
    *//**
     * 分页查询结果集合
     * @param map
     * @param page
     * @return
     *//*
	public List list(Map map, Page page) {
		// TODO Auto-generated method stub
		return this.baseDao.list(map, page);
	}	
	
	*//**
	 * UUID
	 * @return
	 *//*
	public static String UUID() {
		return StringUtils.replace(UUID.randomUUID().toString(), "-", "")
				.toUpperCase();
	}
*/
	
	
	
}
