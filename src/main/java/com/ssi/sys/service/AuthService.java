/*---------代码生成请勿手工修改---------*/
package com.ssi.sys.service;

import java.sql.Types;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ssi.framework.bean.Page;
import com.ssi.framework.exceptions.BusinessException;
import com.ssi.framework.service.BaseService;
import com.ssi.framework.utils.SqlUtis;
import com.ssi.sys.dao.AuthDao;
import com.ssi.sys.dao.RoleDao;
import com.ssi.sys.dao.UserDao;

/**
 * 权限
 */
@Service
public class AuthService extends BaseService {
	@Autowired
	AuthDao authDao;

	/**
	 * 新增数据
	 * @param map
	 * @return
	 */
	@Transactional
	public Object insert(Map map) {
	return this.authDao.insert(map);
	}
	/**
	 * 更新数据
	 * @param map
	 * @return
	 */
	@Transactional
	public int update(Map map) {
		map.remove(SqlUtis.WHERE_SQL);
		System.out.println(map);
		SqlUtis.prepareSql(map,SqlUtis.getSQLRequired(map,AuthDao.AUTH_ID, Types.VARCHAR, SqlUtis.EQ));
		int count = this.authDao.update(map);
		map.remove(SqlUtis.WHERE_SQL);
		return count;
	}

	/**
	 * 查询一个对象
	 * @param map
	 * @return
	 */
	public Object one(Map map) {
		SqlUtis.prepareSql(map,SqlUtis.getSQLRequired(map,"a."+AuthDao.AUTH_ID, Types.VARCHAR, SqlUtis.EQ));
		Object obj = this.authDao.one(map);
		map.remove(SqlUtis.WHERE_SQL);
		return obj;
	}

	/**
	 * 是否存在
	 * @param map
	 * @return
	 */
	public boolean exists(Map map) {
		SqlUtis.prepareSql(map,SqlUtis.getSQLRequired(map,"a."+AuthDao.AUTH_ID, Types.VARCHAR, SqlUtis.EQ));
		boolean flag = this.authDao.exists(map);
		map.remove(SqlUtis.WHERE_SQL);
		return flag;
	}



	/**
	 * 删除权限
	 * @param map
	 * @return
	 */

	@Transactional
	public int delete(Map map) {
		try {
			// 更新子的PARENT_ID为null
			SqlUtis.prepareSql(map,
					SqlUtis.getSQLRequired(map,AuthDao.PARENT_ID, AuthDao.AUTH_ID, Types.VARCHAR));
			this.authDao.update(this.authDao.getUpdateParentIdStatement(), map);
			map.remove(SqlUtis.WHERE_SQL);
			SqlUtis.prepareSql(map, "", SqlUtis.getSQLRequired(map,AuthDao.AUTH_ID, Types.VARCHAR));
			// 删除角色权限
			this.authDao.delete(RoleDao.NAMESPACE + ".deleteRoleAuth", map);
			// 删除权限
			int result = this.authDao.delete(this.authDao.getDeleteStatement(), map);
			map.remove(SqlUtis.WHERE_SQL);
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			throw new BusinessException("更新失败:" + e.getMessage(), e);
		}
	}
	/**
	 * 分页查询结果集合
	 * 
	 * @param map
	 * @param page
	 * @return
	 */
	public List list(Map map, Page page) {
		SqlUtis.prepareSql(map,SqlUtis.getSQL(map, "a." + AuthDao.AUTH_ID, Types.VARCHAR),
				SqlUtis.getSQL(map, "a." + AuthDao.NAME, Types.VARCHAR, SqlUtis.LIKE),
				SqlUtis.getSQL(map, "a." + AuthDao.PARENT_ID, Types.VARCHAR),
				SqlUtis.getSQL(map, "a." + AuthDao.MENU, Types.VARCHAR));
		List list = this.authDao.list(map, page);
		map.remove(SqlUtis.WHERE_SQL);
		return list;
	}
	/**
	 * 验证权限.有权限返回null,没有权限返回权限信息(map需要提供AUTH_ID,USER_ID)
	 * @param map
	 * @return
	 */
	public Object checkAuth(Map map) {
		return this.authDao.checkAuth(map);
	}

	/**
	 * 验证权限
	 * @param map
	 * @return
	 */
	public boolean checkAuth(String userId, String authId) {
		if (this.authDao.isAdmin(userId)) {
			return true;
		}
		Map map = new HashMap();
		map.put(UserDao.USER_ID, userId);
		map.put(AuthDao.AUTH_ID, authId);
		Object result = this.checkAuth(map);
		return result == null;
	}

	/**
	 * 获取超级管理员账户
	 * @return
	 */
	public String getAdmin() {
		return this.authDao.getAdmin();
	}

	/**
	 * 判断是否是超级管理员
	 * @param userId
	 * @return
	 */
	public boolean isAdmin(String userId) {
		if (userId.equals(this.authDao.getAdmin())) {
			return true;
		}
		return false;
	}

	
	
	
	/**
	 * 查询结果集合
	 * @param map
	 * @param page
	 * @return
	 */
	public List listAuth(Map map,String  userId) {
		if (!this.isAdmin(userId)) {
			map.put("JOIN_SQL",
					" inner join s_role_auth c on (a.auth_id = c.auth_id)"
							+ " inner join s_role_user d on (c.role_id = d.role_id and d.user_id='"
							+ userId+ "') ");
		}
		List list = this.authDao.list(this.authDao.getNamespace()+ ".selectAuth", map);;
		map.remove(SqlUtis.WHERE_SQL);
		return list;
	}
	
	
	/**
	 * 查询角色权限结果集合
	 * @param map
	 * @param page
	 * @return
	 */
	public List listRoleAuth(Map map) {
		SqlUtis.prepareSql(map, 
				SqlUtis.getSQLRequired(map, "a." + RoleDao.ROLE_ID, Types.VARCHAR, SqlUtis.EQ));
		List list = this.authDao.list(this.authDao.getNamespace()+".selectRoleAuth",map);
		map.remove(SqlUtis.WHERE_SQL);
		return list;
	}
	
	
	
	
}
