package com.ssi.framework.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ssi.framework.bean.Page;
import com.ssi.framework.bean.SessionUser;
import com.ssi.framework.ibatis.spring.SqlMapClientDaoSupport;
import com.ssi.framework.ibatis.sqlmap.engine.execution.CountResult;
@Repository
public abstract class BaseDao extends SqlMapClientDaoSupport {
	protected final Log log = LogFactory.getLog(getClass());

	public abstract String getNamespace();

	/**
	 * 增加
	 * @param map
	 * @return
	 */
	@Transactional
	public Object insert(Map map) {
		return this.insert(getInsertStatement(), map);
	}

	/**
	 * 修改
	 * @param map
	 * @return
	 */
	@Transactional
	public int update(Map map) {
		return this.update(getUpdateStatement(), map);
	}

	/**
	 * 删除
	 * @param map
	 * @return
	 */
	@Transactional
	public int delete(Map map) {
		return this.delete(getDeleteStatement(), map);
	}
	/**
	 * 总数
	 * @param map
	 * @return
	 */
	public int count(Map map) {
		return this.count(getCountStatement(), map);
	}

	/**
	 * 查询一个对象
	 * @param map
	 * @return
	 */
	public Object one(Map map) {
		return this.one(getListStatement(), map);
	}

	/**
	 * 是否存在
	 * 
	 * @param map
	 * @return
	 */
	public boolean exists(Map map) {
		return this.exists(getcheckExistsStatement(), map);
	}

	/**
	 * 判断是否唯一
	 * @param map
	 * @return
	 */
	public boolean checkUnique(Map map) {
		return this.checkUnique(getcheckUniqueStatement(), map);
	}

	/**
	 * 列表
	 * 
	 * @param map
	 * @return
	 */
	public List list(Map map) {
		return this.list(getListStatement(), map);
	}

	/**
	 * 分页列表
	 * @param map
	 * @param page
	 * @return
	 */
	public List list(Map map, Page page) {
		setPageSize(page);
		return this.list(getListStatement(), map, page);
	}
	/**
	 * 设置分页数量
	 * @param page
	 */
	private  void  setPageSize(Page page){
		int pageSize= page.getPageSize();
		//每页多少条数
		  if(pageSize==10){
				SessionUser sessionUser = (SessionUser) ServletActionContext
						.getRequest().getSession()
						.getAttribute(SessionUser.SESSION_KEY); 
				if(null!=sessionUser&&null!=sessionUser.getAttribute("PAGE_SIZE")){
					try {
						pageSize=Integer.parseInt(sessionUser.getAttribute("PAGE_SIZE").toString());
					} catch (Exception e) {
						pageSize=10;
					}
				}
				 page.setPageSize(pageSize);
			 }
	}
	
	
	

	// -------------------
	@Transactional
	public Object insert(String statementName, Map map) {
		map = this.prepareMap(map);
		Object result = getSqlMapClientTemplate().insert(statementName, map);
		return result;
	}

	@Transactional
	public int update(String statementName, Map map) {
		map = this.prepareMap(map);
		int result = getSqlMapClientTemplate().update(statementName, map);
		return result;
	}

	@Transactional
	public int delete(String statementName, Map map) {
		map = this.prepareMap(map);
		int result = getSqlMapClientTemplate().delete(statementName, map);
		return result;
	}

	public int count(String statementName, Map map) {
		map = this.prepareMap(map);
		Number result = (Number) getSqlMapClientTemplate().queryForObject(
				statementName, map);
		if (result == null) {
			return 0;
		}
		return result.intValue();
	}

	public Object one(String statementName, Map map) {
		map = this.prepareMap(map);
		Object result = getSqlMapClientTemplate().queryForObject(statementName,
				map);
		return result;
	}

	public boolean exists(String statementName, Map map) {
		map = this.prepareMap(map);
		Boolean result = (Boolean) getSqlMapClientTemplate().queryForObject(
				statementName, map);
		if (result != null) {
			return result;
		}
		return false;
	}

	public boolean checkUnique(String statementName, Map map) {
		map = this.prepareMap(map);
		Boolean result = (Boolean) getSqlMapClientTemplate().queryForObject(
				statementName, map);
		if (result != null) {
			return result;
		}
		return true;
	}

	public List list(String statementName, Map map) {
		map = this.prepareMap(map);
		List result = getSqlMapClientTemplate()
				.queryForList(statementName, map);
		return result;
	}

	public String getStatementName(String name) {
		return getNamespace() + "." + name;
	}

	public String getInsertStatement() {
		return getStatementName("insert");
	}

	public String getUpdateStatement() {
		return getStatementName("update");
	}

	public String getDeleteStatement() {
		return getStatementName("delete");
	}

	public String getCountStatement() {
		return getStatementName("count");
	}

	public String getListStatement() {
		return getStatementName("list");
	}

	public String getcheckExistsStatement() {
		return getStatementName("exists");
	}

	public String getcheckUniqueStatement() {
		return getStatementName("checkUnique");
	}

	public List list(String statementName, Map map, Page page) {
		if (page == null) {
			List result = this.list(statementName, map);
			page.setTotalCount(result == null ? 0 : result.size());
			page.setPageNumber(1);
			return result;
		}
		CountResult countResult = new CountResult();
		getSqlMapClientTemplate().queryForObject(statementName, map,
				countResult);
		Number totalCount = (Number) countResult.values().iterator().next();
		if (totalCount == null || totalCount.longValue() <= 0) {
			page.setTotalCount(0);
			page.setPageNumber(1);
			return new ArrayList(0);
		}
		page.setTotalCount(totalCount.intValue());
		if (page.getPageNumber() > page.getPages()) {
			page.setPageNumber(1);
		}
		setPageSize(page);
		List result = getSqlMapClientTemplate().queryForList(statementName,
				map, page.getFirstResult(), page.getPageSize());
		return result;
	}

	/**
	 * 
	 * @param sql
	 * @return
	 */
	public Map oneBySql(String sql) {
		Map map = new HashMap();
		map.put("sql", sql);
		List<Map> results = this.list("empty_sqlmap.selectBySql", map);
		if (null != results && !results.isEmpty()) {
			return results.get(0);
		}
		return null;
	}

	/**
	 * 执行sql查询
	 * @param sql
	 * @return
	 */
	public List listBySql(String sql) {
		Map map = new HashMap();
		map.put("sql", sql);
		List<Map> results = this.list("empty_sqlmap.selectBySql", map);
		return results;
	}
   /**
    * 执行sql带分页查询
    * @param sql
    * @param page
    * @return
    */
	public List listBySql(String sql, Page page) {
		setPageSize(page);
		Map map = new HashMap();
		map.put("sql", sql);
		List<Map> results = this.list("empty_sqlmap.selectBySql", map, page);
		return results;
	}
    /**
     *执行sql更新数据
     * @param sql
     * @return
     */
	@Transactional
	public Object executeUpdate(String sql) {
		Map map = new HashMap();
		map.put("sql", sql);
		return this.insert("empty_sqlmap.insert", map);
	}

	/**
	 * 把key装换为大写便于后台处理
	 * 
	 * @param map
	 * @return
	 */
	public static Map<String, Object> convertUpperCaseMap(Map<String, ?> map) {
		Map<String, Object> returnMap = new LinkedHashMap<String, Object>();
		for (String key : map.keySet()) {
			returnMap.put(key.toUpperCase(), map.get(key));
		}
		return returnMap;
	}

  /**
   * 将session参数保存到参数里面
   * @param map
   * @return
   */
	protected Map prepareMap(Map map) {
		if (map == null||map.isEmpty()) {
			map = new HashMap();
		}
		if (!map.containsKey(SessionUser.SESSIONUSER_KEY)) {
			try {
				SessionUser sessionUser = (SessionUser) ServletActionContext
						.getRequest().getSession()
						.getAttribute(SessionUser.SESSION_KEY);
				if (sessionUser != null) {
					map.put(SessionUser.SESSIONUSER_KEY,
							sessionUser.getAttributes());
				}
			} catch (Exception e) {
				// log.error("找不到当前登录用");
			}
		}
		return map;
	}
	
	/**
	 * 获取UUID
	 * @return
	 */
	public static String UUID() {
		return StringUtils.replace(UUID.randomUUID().toString(), "-", "")
				.toUpperCase();
	}

}
