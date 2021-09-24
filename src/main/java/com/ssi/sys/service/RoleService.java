/*---------代码生成请勿手工修改---------*/
package com.ssi.sys.service;

import java.sql.Types;
import java.util.Date;
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
import com.ssi.framework.utils.SqlUtis;
import com.ssi.framework.utils.ZipUtils;
import com.ssi.sys.dao.AuthDao;
import com.ssi.sys.dao.DeptDao;
import com.ssi.sys.dao.RoleDao;
import com.ssi.sys.dao.UserDao;

/**
 * 角色
 */
@Service
public class RoleService extends BaseService {
	@Autowired
	RoleDao roleDao;
	/**
	 * 新增数据
	 * @param map
	 * @return
	 */
	public Object insert(Map map) {
		 Object role_id=this.roleDao.UUID();
		 map.put("CREATED_DATE",new Date());
		 map.put("ROLE_ID",role_id);
		 this.roleDao.insert(map);
		 return role_id;
	}

	/**
	 * 更新数据
	 * @param map
	 * @return
	 */

	@Transactional
	public int update(Map map) {
		SqlUtis.prepareSql(map, SqlUtis.getSQLRequired(map,RoleDao.ROLE_ID, Types.VARCHAR, SqlUtis.EQ));
		int count = this.roleDao.update(map);
		map.remove(SqlUtis.WHERE_SQL);
		return count;
		
	}
	
	
	/**
	 * 查询一个对象
	 * @param map
	 * @return
	 */
	public Object one(Map map) {
		SqlUtis.prepareSql(map, SqlUtis.getSQLRequired(map,RoleDao.ROLE_ID, Types.VARCHAR, SqlUtis.EQ));
		Object obj = this.roleDao.one(map);
		map.remove(SqlUtis.WHERE_SQL);
		return obj;
	}
	/**
	 * 查询结果集合
	 * @param map
	 * @param page
	 * @return
	 */
	public List list(Map map) {
		SqlUtis.prepareSql(map, "", SqlUtis.getSQL(map,RoleDao.NAME, Types.VARCHAR),
				SqlUtis.orderBy(" a." + RoleDao.CREATED_DATE + " DESC"));
		List list = this.roleDao.list(map);
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
		SqlUtis.prepareSql(map, "", SqlUtis.getSQL(map,RoleDao.NAME, Types.VARCHAR),
				SqlUtis.orderBy(" a." + RoleDao.CREATED_DATE + " DESC"));

		List list = this.roleDao.list(map, page);
		map.remove(SqlUtis.WHERE_SQL);
		return list;
	}

	/**
	 * 分配权限
	 * 
	 * @param formMap
	 */
	@Transactional
	public void assignAuth(Map formMap) {
		String roleId = (String) formMap.get(RoleDao.ROLE_ID);
		if (StringUtils.isBlank(roleId)) {
			throw new BusinessException("请先选择角色");
		}
		// 先删除
		SqlUtis.prepareSql(formMap, "", SqlUtis.getSQLRequired(formMap, RoleDao.ROLE_ID, Types.VARCHAR));
		this.roleDao.delete(this.roleDao.getNamespace() + ".deleteRoleAuth", formMap);
		formMap.remove(SqlUtis.WHERE_SQL);
		// 再增加
		String authId = (String) formMap.get(AuthDao.AUTH_ID);
		if (StringUtils.isBlank(authId)) {
			return;
		}
		String[] auth_ids = StringUtils.split(authId, ",");
		if (auth_ids == null || auth_ids.length == 0) {
			return;
		}
		for (String auth : auth_ids) {
			if (StringUtils.isBlank(auth)) {
				continue;
			}
			Map authMap = new HashMap();
			authMap.put(RoleDao.ROLE_ID, roleId.trim());
			authMap.put(AuthDao.AUTH_ID, auth.trim());
			this.roleDao.insert(this.roleDao.getNamespace() + ".insertRoleAuth", authMap);
		}
	}

	/**
	 * 角色删除
	 * 
	 * @param map
	 * @return
	 */
	@Transactional
	public int delete(Map map) {
		try {
			SqlUtis.prepareSql(map, "", SqlUtis.getSQLRequired(map,RoleDao.ROLE_ID, Types.VARCHAR));
			// 删除角色用户
			this.roleDao.delete(this.roleDao.getNamespace() + ".deleteRoleUser", map);
			// 删除角色权限
			this.roleDao.delete(this.roleDao.getNamespace() + ".deleteRoleAuth", map);
			// 删除角色
			int result = this.roleDao.delete(map);
			map.remove(SqlUtis.WHERE_SQL);
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			throw new BusinessException("更新失败:" + e.getMessage(), e);
		}
	}

	/**
	 * 用户分配角色
	 * 
	 * @param formMap
	 */
	@Transactional
	public void assignRole(Map formMap) {
		// 获取用户的ID
		String USER_ID = (String) formMap.get(UserDao.USER_ID);
		if (StringUtils.isBlank(USER_ID)) {
			throw new BusinessException("请先选择用户");
		}
		// 先删除已经分配了的角色
		SqlUtis.prepareSql(formMap, "", SqlUtis.getSQLRequired(formMap, UserDao.USER_ID, Types.VARCHAR));
		this.roleDao.delete(this.roleDao.NAMESPACE + ".deleteRoleUser", formMap);
		formMap.remove(SqlUtis.WHERE_SQL);

		// 分配角色给用户
		String ROLE_ID = (String) formMap.get(RoleDao.ROLE_ID);
		if (StringUtils.isBlank(ROLE_ID)) {
			return;
		}
		String[] role_ids = StringUtils.split(ROLE_ID, ",");
		if (role_ids == null || role_ids.length == 0) {
			return;
		}
		for (String role : role_ids) {
			if (StringUtils.isBlank(role)) {
				continue;
			}
			Map roleMap = new HashMap();
			roleMap.put(RoleDao.ROLE_ID, role.trim());
			roleMap.put(UserDao.USER_ID, USER_ID.trim());
			this.roleDao.insert(this.roleDao.NAMESPACE + ".insertRoleUser", roleMap);
		}
	}

	/**
	 * 复制角色权限
	 * 
	 * @param formMap
	 */
	@Transactional
	public void copyRoleAuth(Map formMap) {
		try {
			SqlUtis.prepareSql(formMap, "", SqlUtis.getSQLRequired(formMap,RoleDao.ROLE_ID, Types.VARCHAR));
			// 删除角色权限
			this.roleDao.delete(this.roleDao.getNamespace() + ".deleteRoleAuth", formMap);
			formMap.remove(SqlUtis.WHERE_SQL);

			Map map = new HashMap();
			map.put("ROLE_ID", ObjectUtils.toString(formMap.get("ROLE_IDS")));
			map.put("ROLEID", ObjectUtils.toString(formMap.get("ROLE_ID")));
			SqlUtis.prepareSql(map, "", SqlUtis.getSQLRequired(map,RoleDao.ROLE_ID, Types.VARCHAR));
			this.roleDao.insert(this.roleDao.getNamespace() + ".copyRoleAuth", map);
			map.remove(SqlUtis.WHERE_SQL);

		} catch (Exception e) {
			e.printStackTrace();
			throw new BusinessException("更新失败:" + e.getMessage(), e);
		}
	}
	
	
	/**
	 * 查询角色用户结果集合
	 * @param map
	 * @param page
	 * @return
	 */
	public List listRoleUser(Map map) {
		List list = this.roleDao.list(this.roleDao.getNamespace()+ ".selectRoleUser",map);
		return list;
	}
	
	/**
	 * 查询结果集合
	 * @param map
	 * @param page
	 * @return
	 */
	public List listRole(Map map) {
		SqlUtis.prepareSql(map
				,SqlUtis.getSQL(map,RoleDao.NAME,Types.VARCHAR,SqlUtis.LIKE)
			);
			//查询角色权限
		List list = this.roleDao.list(this.roleDao.getNamespace()+".selectRole",map);
		map.remove(SqlUtis.WHERE_SQL);
		return list;
	}
	/**
	 * 查询结果集合
	 * @param map
	 * @param page
	 * @return
	 */
	public List listViewRole(Map map) {
		List list = this.roleDao.list(this.roleDao.getNamespace()+".viewRole",map);
		return list;
	}
	
	

	
	
	

}
