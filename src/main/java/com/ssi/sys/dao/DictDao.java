/*---------代码生成请勿手工修改---------*/
package com.ssi.sys.dao;

import java.sql.Types;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.ObjectUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ssi.framework.dao.BaseDao;
import com.ssi.framework.exceptions.BusinessException;
import com.ssi.framework.spring.SpringUtils;
import com.ssi.framework.utils.SqlUtis;
import com.ssi.sys.service.DictService;

/**
 * 字典
 */
@Repository
public class DictDao extends BaseDao {
	public static final String NAMESPACE = "S_DICT";
	public static final String DICT_ID = "DICT_ID";// 主键
	public static final String TYPE = "TYPE";// 类型
	public static final String VALUE = "VALUE";// 值
	public static final String TEXT = "TEXT";// 文本
	public static final String DES = "DES";// 描述
	public static final String SORT = "SORT";// 排序
	public static final String CACHE = "CACHE";// 缓存
	public static final String UPDATED_BY = "UPDATED_BY";// 更新人
	public static final String UPDATED_DATE = "UPDATED_DATE";// 更新时间
	public static final String CREATED_BY = "CREATED_BY";// 创建人
	public static final String CREATED_DATE = "CREATED_DATE";// 创建时间
	/**
	 * 字典类型
	 */
	public static final String DICTTYPE = "dicttype";
	/**
	 * 系统参数
	 */
	public static final String SYSPARAM = "sysparam";
	/**
	 * 系统主页
	 */
	public static final String MAIN_PAGE = "MAIN_PAGE";
	/**
	 * 保存登录日志的天数
	 */
	public static final String LOGIN_LOG_DAY = "LOGIN_LOG_DAY";
	/**
	 * 保存操作日志的天数
	 */
	public static final String AUDIT_LOG_DAY = "AUDIT_LOG_DAY";
	/**
	 * SQL下拉列表
	 */
	public static final String SQL = "SQL";
	/**
	 * 缓存
	 */
	//public static com.ssi.util.MemcachedUtil cache = com.ssi.util.MemcachedUtil.getInstance();
	public static Map cache=new  HashMap();

	@Override
	public String getNamespace() {
		return NAMESPACE;
	}



	

	/**
	 * 增加
	 * @param map
	 * @return
	 */
	@Transactional
	public Object insert(Map map) {
		Object obj = this.insert(getInsertStatement(), map);
		return obj;
	}

	/**
	 * 修改
	 * @param map
	 * @return
	 */
	@Transactional
	public int update(Map map) {
		int temp = this.update(getUpdateStatement(), map);
		return temp;
	}

	/**
	 * 删除
	 * 
	 * @param map
	 * @return
	 */
	@Transactional
	public int delete(Map map) {
		int temp = this.delete(getDeleteStatement(), map);
		return temp;
	}



	/**
	 * 类里面调用集合字典
	 * 
	 * @param fromMap
	 * @return
	 */
	public List<Map> getList(Map fromMap) {
		SqlUtis.prepareSql(fromMap, "", SqlUtis.getSQL(fromMap, "a." + DictDao.TYPE, Types.VARCHAR),
				SqlUtis.orderBy(DictDao.SORT));
		List list = this.list(fromMap);// TODO 缓存
		return list;
	}

	public static List getDictByType(String type) {
		// 从数据库获取
		Map map = new HashMap();
		map.put(DictDao.TYPE, type);
		SqlUtis.prepareSql(map, "", SqlUtis.getSQLRequired(map, "a." + DictDao.TYPE, Types.VARCHAR)," order by a.sort asc ");
		return SpringUtils.getBean(DictDao.class).list(map);
	}
	
	/**
	 * 获取字典文本(map需要提供TYPE,VALUE)
	 * 
	 * @param map
	 * @return
	 */
	public String getText(Map map) {
		if (!map.containsKey(DictDao.TYPE) || !map.containsKey(DictDao.VALUE)) {
			throw new BusinessException("调用参数错误，找不到结果");
		}
		String type =ObjectUtils.toString(map.get(DictDao.TYPE));
		String value =ObjectUtils.toString(map.get(DictDao.VALUE));
		if (StringUtils.isBlank(type)) {
			return null;
		}
		if (StringUtils.isBlank(value)) {
			return value;
		}
		return getText(type, value);
	}
    /**
     * 获取系统参数
     * @param value
     * @return
     */
	public static String getSysParam(String value) {
		return getText(DictDao.SYSPARAM, value);
	}



	/**
	 * 初始化
	 */
	public synchronized void init() {
		// 所有缓存的字典
		Map searchMap = new HashMap();
		SqlUtis.prepareSql(searchMap, " and a.cache='1'");
		List list = com.ssi.framework.spring.SpringUtils.getBean(DictDao.class).list(searchMap);
		DictDao.setCache(list);

	}

	private static synchronized void setCache(List<Map> cacheList) {
		if (cacheList != null && !cacheList.isEmpty()) {
			for (int i = 0; i < cacheList.size(); i++) {
				Map<String, String> dictMap = cacheList.get(i);
				if (dictMap != null) {
					String type = dictMap.get(DictDao.TYPE);
					String value = dictMap.get(DictDao.VALUE);
					String text = dictMap.get(DictDao.TEXT);
					if (StringUtils.isNotEmpty(type) && StringUtils.isNotEmpty(value)) {
						cache.put(type + "_" + value, text);
					}
				}
			}
		}
	}

	/**
	 * 获取字典文本
	 * 
	 * @param type
	 *            类型
	 * @param value
	 *            值
	 * @return
	 */
	public static String getText(String type, String value) {
		if (StringUtils.isEmpty(type) || StringUtils.isEmpty(value)) {
			return null;
		}
		String is_cache = ObjectUtils.toString(cache.get("is_cache"));
		if (!"true".equals(is_cache)) {
			com.ssi.framework.spring.SpringUtils.getBean(DictDao.class).init();
			cache.put("is_cache", "true");
		}
		String text = ObjectUtils.toString(cache.get(type + "_" + value));
		if ("".equals(text)) {
			Map dict = getDict(type, value);
			if (null != dict && !dict.isEmpty()) {
				text = ObjectUtils.toString(dict.get(DictDao.TEXT));
			}

		}
		return text;
	}

	public static Map getDict(String type, String value) {
		if (StringUtils.isEmpty(type) || StringUtils.isEmpty(value)) {
			return null;
		}
		// 从数据库获取
		Map map = new HashMap();
		map.put(DictDao.TYPE, type);
		map.put(DictDao.VALUE, value);
		SqlUtis.prepareSql(map, "", SqlUtis.getSQLRequired(map, "a." + DictDao.TYPE, Types.VARCHAR),
				SqlUtis.getSQLRequired(map, "a." + DictDao.VALUE, Types.VARCHAR));
		Object obj = SpringUtils.getBean(DictDao.class).one(map);
		if (null != obj) {
			return (Map) obj;
		}

		return null;
	}

	/**
	 * 获取字典文本
	 * 
	 * @param key
	 *            是字典的type_value格式
	 * @return
	 */
	public static String getText(String key) {
		if (StringUtils.isBlank(key)) {
			return null;
		}
		int pos = key.indexOf("_");
		if (pos == -1) {
			return null;
		}
		String type = key.substring(0, pos);
		String value = key.substring(pos + 1);
		return getText(type, value);
	}	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
