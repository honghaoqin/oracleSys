/*---------代码生成请勿手工修改---------*/
package com.ssi.sys.service;

import java.sql.Types;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.ObjectUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ssi.framework.bean.Page;
import com.ssi.framework.exceptions.BusinessException;
import com.ssi.framework.service.BaseService;
import com.ssi.framework.utils.SqlUtis;
import com.ssi.sys.dao.AuthDao;
import com.ssi.sys.dao.DeptDao;
import com.ssi.util.PingYinUtil;

/**
 * 部门
 */
@Service
public class DeptService extends BaseService {
	@Autowired
	DeptDao deptDao;
	@Autowired
	AuthDao authDao;

	/**
	 * 新增数据
	 * @param map
	 * @return
	 */
	@Transactional
	public Object insert(Map map) {
		 Object sys_guid=this.deptDao.UUID();
		map.put("SYS_GUID",sys_guid);
		map.put(DeptDao.SPELL, PingYinUtil.getFirstSpell(ObjectUtils.toString(map.get(DeptDao.NAME))));
		Object obj = this.deptDao.insert(map);
		return obj;

	}

	/**
	 * 更新数据
	 * @param map
	 * @return
	 */

	@Transactional
	public int update(Map map) {
		SqlUtis.prepareSql(map, SqlUtis.getSQLRequired(map,DeptDao.DEPT_ID, Types.VARCHAR, SqlUtis.EQ));
		int count = this.deptDao.update(map);
		map.remove(SqlUtis.WHERE_SQL);
		return count;

	}

	/**
	 * 删除数据
	 * @param map
	 * @return
	 */

	@Transactional
	public int delete(Map map) {
		try {
			SqlUtis.prepareSql(map,
					SqlUtis.getSQLRequired(map,DeptDao.PARENT_ID, DeptDao.DEPT_ID, Types.VARCHAR));
			this.deptDao.update(this.deptDao.getUpdateParentIdStatement(), map);
			map.remove(SqlUtis.WHERE_SQL);
			
			SqlUtis.prepareSql(map,SqlUtis.getSQLRequired(map,DeptDao.DEPT_ID, Types.VARCHAR));
			int result = this.deptDao.delete(map);
			map.remove(SqlUtis.WHERE_SQL);
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			throw new BusinessException("更新失败:" + e.getMessage(), e);
		}
	}

	/**
	 * 查询一个对象
	 * @param map
	 * @return
	 */
	public Object one(Map map) {
		SqlUtis.prepareSql(map, SqlUtis.getSQLRequired(map,"a."+DeptDao.DEPT_ID, Types.VARCHAR, SqlUtis.EQ));
		Object obj = this.deptDao.one(map);
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
		SqlUtis.prepareSql(map, "", SqlUtis.getSQL(map,"a."+DeptDao.NAME, Types.VARCHAR, SqlUtis.LIKE)
		// 管理员可以看全部，非管理员只可以看本部门和子部门

		/*
		 * , authDao.isAdmin(this.getSessionUser().getUserId()) ? "" :
		 * " start with a.dept_id='" + this.getSessionUser().getDeptId() +
		 * "' connect by prior a.dept_id = a.parent_id "
		 */

				, SqlUtis.orderBy(DeptDao.CREATED_DATE + " DESC"));
		List list = this.deptDao.list(map);
		map.remove(SqlUtis.WHERE_SQL);
		return list;
	}

	/**
	 * 分页查询结果集合
	 * @param map
	 * @param page
	 * @return
	 */
	public List list(Map map, Page page) {
		SqlUtis.prepareSql(map,SqlUtis.getSQL(map,"a."+DeptDao.NAME, Types.VARCHAR, SqlUtis.LIKE)
		// 管理员可以看全部，非管理员只可以看本部门和子部门

		/*
		 * , authDao.isAdmin(this.getSessionUser().getUserId()) ? "" :
		 * " start with a.dept_id='" + this.getSessionUser().getDeptId() +
		 * "' connect by prior a.dept_id = a.parent_id "
		 */

				, SqlUtis.orderBy("a."+DeptDao.CREATED_DATE + " DESC"));
		List list = this.deptDao.list(map, page);
		map.remove(SqlUtis.WHERE_SQL);
		return list;
	}

	/**
	 * 数据同步
	 * @param map
	 */
	@Transactional
	public void syndept(Map map) {
		SqlUtis.prepareSql(map, "",
				SqlUtis.getSQLRequired(map,"a."+DeptDao.DEPT_ID, Types.VARCHAR, SqlUtis.EQ));
		if (this.deptDao.exists(map)) {
			this.deptDao.update(map);
		} else {
			this.deptDao.insert(DeptDao.NAMESPACE + ".syninsert", map);
		}
	}
}
