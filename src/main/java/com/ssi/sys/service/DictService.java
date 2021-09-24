/*---------代码生成请勿手工修改---------*/
package com.ssi.sys.service;

import java.sql.Types;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.ObjectUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ssi.framework.bean.Page;
import com.ssi.framework.exceptions.BusinessException;
import com.ssi.framework.service.BaseService;
import com.ssi.framework.spring.SpringUtils;
import com.ssi.framework.utils.SqlUtis;
import com.ssi.sys.dao.DictDao;

/**
 * 字典
 */
@Service
public class DictService extends BaseService {
	@Autowired 
	DictDao dictDao;
	/**
	 * 缓存
	 */
	//public static com.ssi.util.MemcachedUtil cache = com.ssi.util.MemcachedUtil.getInstance();
	public static Map cache=new  HashMap();
	/**
	 * 增加
	 * @param map
	 * @return
	 */
	@Transactional
	public Object insert(Map map) {
		Object sys_guid=this.dictDao.UUID();
		map.put("SYS_GUID",sys_guid);
		this.dictDao.insert(map);
		this.dictDao.init();
		return sys_guid;
	}

	/**
	 * 修改
	 * @param map
	 * @return
	 */
	@Transactional
	public int update(Map map) {
		SqlUtis.prepareSql(map,SqlUtis.getSQLRequired(map,DictDao.DICT_ID,Types.VARCHAR,SqlUtis.EQ));
		int count = this.dictDao.update(map);
		map.remove(SqlUtis.WHERE_SQL);
		this.dictDao.init();
		return count;
	}

	/**
	 * 删除
	 * @param map
	 * @return
	 */
	@Transactional
	public int delete(Map map) {
		SqlUtis.prepareSql(map,SqlUtis.getSQLRequired(map,DictDao.DICT_ID,Types.VARCHAR,SqlUtis.EQ));
		int count = this.dictDao.delete(map);
		this.dictDao.init();
		return count;
	}
	/**
	 * 查询一个对象
	 * @param map
	 * @return
	 */
	public Object one(Map map) {
		SqlUtis.prepareSql(map, SqlUtis.getSQLRequired(map, "a." + DictDao.DICT_ID, Types.VARCHAR, SqlUtis.EQ));
		Object obj = this.dictDao.one(map);
		map.remove(SqlUtis.WHERE_SQL);
		return obj;
	}
	
	/**
	 * 查询结果集合
	 * 
	 * @param map
	 * @return
	 */
	public List list(Map map) {
		SqlUtis.prepareSql(map
				,SqlUtis.getSQL(map, "a." + DictDao.TYPE, Types.VARCHAR, SqlUtis.EQ)
				,SqlUtis.getSQL(map,"a." + DictDao.VALUE, Types.VARCHAR, SqlUtis.LIKE)
		        ,SqlUtis.getSQL(map,"a." + DictDao.TEXT, Types.VARCHAR, SqlUtis.LIKE)
		        ,SqlUtis.orderBy(" a." + DictDao.SORT + " DESC"));
		List list = this.dictDao.list(map);
		map.remove(SqlUtis.WHERE_SQL);
		return list;
	}
	
	/**
	 * 查询结果集合
	 * 
	 * @param map
	 * @return
	 */
	public List list(Map map,Page page) {
		SqlUtis.prepareSql(map
				,SqlUtis.getSQL(map, "a." + DictDao.TYPE, Types.VARCHAR, SqlUtis.EQ)
				,SqlUtis.getSQL(map,"a." + DictDao.VALUE, Types.VARCHAR, SqlUtis.LIKE)
		        ,SqlUtis.getSQL(map,"a." + DictDao.TEXT, Types.VARCHAR, SqlUtis.LIKE)
		        ,SqlUtis.orderBy(" a." + DictDao.SORT + " DESC"));
		List list = this.dictDao.list(map,page);
		map.remove(SqlUtis.WHERE_SQL);
		return list;
	}

	

	/**
	 * 类里面调用集合字典
	 * 
	 * @param fromMap
	 * @return
	 *//*
	public List<Map> getList(Map fromMap) {
		SqlUtis.prepareSql(fromMap, "", SqlUtis.getSQL(fromMap, "a." + DictDao.TYPE, Types.VARCHAR),
				SqlUtis.orderBy(DictDao.SORT));
		List list = this.dictDao.list(fromMap);// TODO 缓存
		return list;
	}

	public static List getDictByType(String type) {
		// 从数据库获取
		Map map = new HashMap();
		map.put(DictDao.TYPE, type);
		SqlUtis.prepareSql(map, "", SqlUtis.getSQLRequired(map, "a." + DictDao.TYPE, Types.VARCHAR)," order by a.sort asc ");
		return SpringUtils.getBean(DictDao.class).list(map);
	}*/
}
