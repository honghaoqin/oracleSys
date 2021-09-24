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
import com.ssi.framework.utils.SqlUtis;
import com.ssi.sys.dao.AuthDao;
import com.ssi.sys.dao.DeptDao;
import com.ssi.sys.dao.GroupDao;
import com.ssi.sys.dao.UserDao;
import com.ssi.sys.model.SysSessionUser;
import com.ssi.util.PingYinUtil;

/**
 * 用户组
 */
@Service
public class GroupService extends BaseService {
	@Autowired
	GroupDao groupDao;
	@Autowired
	AuthDao authDao;
	/**
	 * 新增数据
	 * @param map
	 * @return
	 */
	@Transactional
	public Object insert(Map map) {
		Object obj = this.groupDao.insert(map);
		return obj;

	}
	/**
	 * 更新数据
	 * @param map
	 * @return
	 */

	@Transactional
	public int update(Map map) {
		SqlUtis.prepareSql(map, SqlUtis.getSQLRequired(map
				, "a." +GroupDao.GROUP_ID, Types.VARCHAR, SqlUtis.EQ));
		int count = this.groupDao.update(map);
		map.remove(SqlUtis.WHERE_SQL);
		return count;

	}
	/**
	 * 查询一个对象
	 * @param map
	 * @return
	 */
	public Object one(Map map) {
		SqlUtis.prepareSql(map, SqlUtis.getSQLRequired(map, "a."+GroupDao.GROUP_ID, Types.VARCHAR, SqlUtis.EQ));
		map.put("JOIN_COL"," ,b.NAME as DEPT_ID_NAME ");
		map.put("JOIN_SQL","  left join S_DEPT b on (a.DEPT_ID = b.DEPT_ID) ");
		Object obj = this.groupDao.one(map);
		map.remove(SqlUtis.WHERE_SQL);
		map.remove("JOIN_COL");
		map.remove("JOIN_SQL");
		return obj;
	}

	/**
	 * 分页查询结果集合
	 * @param map
	 * @return
	 */
	public List list(Map map,Page page,SysSessionUser sysSessionUser) {
		SqlUtis.prepareSql(map, "", SqlUtis.getSQL(map, "a."
				+ GroupDao.NAME, Types.VARCHAR),
				SqlUtis.orderBy(" a."+GroupDao.CREATED_DATE +" DESC"));
		// 非管理员只可以看本部门和子部门
		if(!authDao.isAdmin(sysSessionUser.getUserId())){
			map.put("JOIN_COL"," ,b.NAME as DEPT_ID_NAME ");
			map.put("JOIN_SQL"," join  (select *  from S_DEPT aa start with aa.dept_id='"
						+ sysSessionUser.getDeptId()
						+ "' connect by prior aa.dept_id = aa.parent_id   ) b on (a.DEPT_ID = b.DEPT_ID) ");
		}else{
			// 管理员可以看全部，非管理员只可以看本部门和子部门
			map.put("JOIN_COL"," ,b.NAME as DEPT_ID_NAME ");
			map.put("JOIN_SQL","  left join S_DEPT b on (a.DEPT_ID = b.DEPT_ID) ");
		}
		List list = this.groupDao.list(map,page);
		map.remove(SqlUtis.WHERE_SQL);
		return list;
	}
	
	
	/**
	 * 查询结果集合
	 * @param map
	 * @return
	 */
	public List listGroup(Map map) {
		SqlUtis.prepareSql(map,SqlUtis.getSQL(map,"a."+GroupDao.NAME,Types.VARCHAR,SqlUtis.LIKE));
		List list = this.groupDao.list(this.groupDao.getNamespace()+".selectGroup",map);
		map.remove(SqlUtis.WHERE_SQL);
		return list;
	}
	
	/**
	 * 查询已经分配的用户组结果集合
	 * @param map
	 * @return
	 */
	public List listViewGroup(Map map) {
		List list = this.groupDao.list(this.groupDao.getNamespace()+".viewGroup",map);
		return list;
	}
	/**
	 * 查询用户组用户结果集合
	 * @param map
	 * @return
	 */
	public List listViewGroupUser(Map map) {
		// 查询用户组用户
		SqlUtis.prepareSql(map, "", SqlUtis.getSQLRequired(map, "b."
				+ GroupDao.GROUP_ID, Types.VARCHAR));
		List list = this.groupDao.list(this.groupDao.getNamespace()+".viewGroupUser",map);
		map.remove(SqlUtis.WHERE_SQL);
		return list;
	}
	
	/**
	 * 查询用户组用户结果集合
	 * @param map
	 * @return
	 */
	public List listGroupUser(Map map) {
		// 查询用户组用户
		SqlUtis.prepareSql(map, "",
				SqlUtis.getSQL(map, "a.DEPT_ID", Types.VARCHAR));
		List list = this.groupDao.list(this.groupDao.getNamespace()+".selectGroupUser",map);
		map.remove(SqlUtis.WHERE_SQL);
		return list;
	}
	
	
	
	
	
	
	/**
	 * 用户分配用户组
	 * @param map
	 */
	@Transactional
	public void assignGroup(Map map) {
		String userId = (String) map.get("USER_ID");
		if (StringUtils.isBlank(userId)) {
			throw new BusinessException("请先选择用户");
		}
		// 先删除
		SqlUtis.prepareSql(map, "", SqlUtis.getSQLRequired(map, "a.USER_ID", Types.VARCHAR, SqlUtis.EQ));
		this.groupDao.delete(this.groupDao.getNamespace() + ".deleteGroupUser", map);
		map.remove(SqlUtis.WHERE_SQL);
		// 再增加
		String groupId = (String) map.get("GROUP_ID");
		if (StringUtils.isBlank(groupId)) {
			return;
		}
		String[] groupIds = StringUtils.split(groupId, ",");
		if (groupIds == null || groupIds.length == 0) {
			return;
		}
		for (String group : groupIds) {
			if (StringUtils.isBlank(group)) {
				continue;
			}
			Map userMap = new HashMap();
			userMap.put(GroupDao.GROUP_ID, group.trim());
			userMap.put("USER_ID", userId.trim());
			this.groupDao.insert(this.groupDao.getNamespace() + ".insertGroupUser", userMap);
		}
	}

	/**
	 * 用户组分配用户
	 * 
	 * @param map
	 */
	@Transactional
	public void assignUser(Map map) {
		String groupId = (String) map.get(GroupDao.GROUP_ID);
		if (StringUtils.isBlank(groupId)) {
			throw new BusinessException("请先选择用户组");
		}
		// 先删除
		SqlUtis.prepareSql(map, "", SqlUtis.getSQLRequired(map, "a." + GroupDao.GROUP_ID, Types.VARCHAR));
		this.groupDao.delete(this.groupDao.getNamespace() + ".deleteGroupUser", map);
		map.remove(SqlUtis.WHERE_SQL);
		// 再增加
		String userId = (String) map.get("USER_ID");
		if (StringUtils.isBlank(userId)) {
			return;
		}
		String[] user_ids = StringUtils.split(userId, ",");
		if (user_ids == null || user_ids.length == 0) {
			return;
		}
		for (String user : user_ids) {
			if (StringUtils.isBlank(user)) {
				continue;
			}
			Map userMap = new HashMap();
			userMap.put(GroupDao.GROUP_ID, groupId.trim());
			userMap.put("USER_ID", user.trim());
			this.groupDao.insert(this.groupDao.getNamespace() + ".insertGroupUser", userMap);
		}
	}
	@Transactional
	public int delete(Map map) {
		try {
			SqlUtis.prepareSql(map, "", SqlUtis.getSQLRequired(map, "a." + GroupDao.GROUP_ID, Types.VARCHAR));
			// 删除用户组的用户
			this.groupDao.delete(this.groupDao.getNamespace() + ".deleteGroupUser", map);
			// 删除用户组
			int result = this.groupDao.delete(map);
			map.remove(SqlUtis.WHERE_SQL);
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			throw new BusinessException("更新失败:" + e.getMessage(), e);
		}
	}

	@Transactional
	public void assignAuth(Map map) {

		String groupId = (String) map.get(GroupDao.GROUP_ID);
		if (StringUtils.isBlank(groupId)) {
			throw new BusinessException("请先选择用户组");
		}
		String typeId = (String) map.get(UserDao.TYPE_ID);
		if (StringUtils.isBlank(typeId)) {
			throw new BusinessException("请先选择类型");
		}
		// 删除以前的数据
		SqlUtis.prepareSql(map, "",
				SqlUtis.getSQLRequired(map, "a." + GroupDao.GROUP_ID, Types.VARCHAR, SqlUtis.EQ),
				SqlUtis.getSQLRequired(map, "a." + UserDao.TYPE_ID, Types.VARCHAR, SqlUtis.EQ));
		this.groupDao.delete(this.groupDao.getNamespace() + ".deleteGroupAuth", map);
		map.remove(SqlUtis.WHERE_SQL);
		// 再增加
		String objId = (String) map.get("OBJ_ID");
		if (StringUtils.isBlank(objId)) {
			return;
		}
		String[] obj_ids = StringUtils.split(objId, ",");
		if (obj_ids == null || obj_ids.length == 0) {
			return;
		}
		for (String obj : obj_ids) {
			if (StringUtils.isBlank(obj)) {
				continue;
			}
			Map authMap = new HashMap();
			authMap.put(GroupDao.GROUP_ID, groupId.trim());
			authMap.put(UserDao.TYPE_ID, typeId.trim());
			authMap.put("OBJ_ID", obj.trim());
			this.groupDao.insert(this.groupDao.getNamespace() + ".insertGroupAuth", authMap);
		}

	}



}
