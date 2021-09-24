package com.ssi.framework.service.inter;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ssi.framework.bean.Page;

@Service
public  interface IBaseService{
	/**
	 * 新增数据
	 * @param map
	 * @return
	 */
	public Object insert(Map map);
	/**
	 * 修改数据
	 * @param map
	 * @return
	 */
	public int update(Map map);
	/**
	 * 删除
	 * @param map
	 * @return
	 */
	@Transactional
	public int delete(Map map);

	/**
	 * 查询对象
	 * @param map
	 * @return
	 */
	public Object one(Map map);

	/**
	 * 列表
	 * 
	 * @param map
	 * @return
	 */
	public List list(Map map);
	/**
	 * 分页列表
	 * @param map
	 * @param page
	 * @return
	 */
	public List list(Map map, Page page);	
}
