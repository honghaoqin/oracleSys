/*---------代码生成请勿手工修改---------*/
package com.ssi.sys.service;

import java.sql.Types;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ssi.framework.bean.Page;
import com.ssi.framework.utils.SqlUtis;
import com.ssi.sys.dao.TodoDao;

/**
 * 待办
 */
@Service
public class TodoService {
	@Autowired
	TodoDao todoDao;

	@Transactional
	public Object insert(Map map) {
		map.put(TodoDao.ID,this.todoDao.UUID());
		return this.todoDao.insert(map);
	}

	/**
	 * 分页查询结果集合
	 * 
	 * @param map
	 * @param page
	 * @return
	 */
	public List list(Map map, Page page) {
		SqlUtis.prepareSql(map, "", SqlUtis.getSQL(map, "a." + TodoDao.USER_ID, Types.VARCHAR),
				SqlUtis.getSQL(map, "a." + TodoDao.MANUSER_ID, Types.VARCHAR),
				SqlUtis.getSQL(map, "a." + TodoDao.MSG, Types.VARCHAR));
		List list = this.todoDao.list(map, page);
		map.remove(SqlUtis.WHERE_SQL);
		return list;

	}

	/**
	 * 分页查询结果集合
	 * 
	 * @param map
	 * @param page
	 * @return
	 */
	public List list(Map map) {
		SqlUtis.prepareSql(map, "", SqlUtis.getSQL(map, "a." + TodoDao.USER_ID, Types.VARCHAR),
				SqlUtis.getSQL(map, "a." + TodoDao.MANUSER_ID, Types.VARCHAR),
				SqlUtis.getSQL(map, "a." + TodoDao.MSG, Types.VARCHAR));
		List list = this.todoDao.list(map);
		map.remove(SqlUtis.WHERE_SQL);
		return list;
	}

}
