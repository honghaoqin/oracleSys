/*---------代码生成请勿手工修改---------*/
package com.ssi.sys.action;

import java.sql.Types;
import java.text.ParseException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.commons.lang.ObjectUtils;
import org.springframework.beans.factory.annotation.Autowired;

import com.ssi.framework.exceptions.BusinessException;
import com.ssi.framework.utils.SqlUtis;
import com.ssi.sys.dao.UserDao;
import com.ssi.sys.service.GroupService;
import com.ssi.sys.service.RoleService;
import com.ssi.sys.service.UserService;

/**
 * 用户
 */
public class UserAction extends com.ssi.sys.action.SysBaseAction {
	public static final String AUTH_LIST = "S_USER_LIST";
	public static final String AUTH_ADD = "S_USER_ADD";
	public static final String AUTH_EDIT = "S_USER_EDIT";
	public static final String AUTH_DEL = "S_USER_DEL";
	public static final String AUTH_ASSIGN_ROLE = "S_USER_ASSIGN_ROLE";
	public static final String AUTH_ASSIGN_GROUP = "S_USER_ASSIGN_GROUP";
	/**
	 * 服务层
	 */
	@Autowired
	UserService userService;
	@Autowired
	RoleService roleService;
	@Autowired
	GroupService groupService;

	/*
	 * public String select(){
	 * 
	 * // 管理员可以看全部，非管理员只可以看本部门和子部门 if
	 * (!authService.isAdmin(this.getSessionUser().getUserId())) { this.formMap
	 * .put("JOIN_SQL",
	 * "join (select dept_id,name from s_dept start with dept_id ='" +
	 * this.getSessionUser().getDeptId() +
	 * "' connect by prior dept_id = parent_id) authdept on (a.dept_id = authdept.dept_id)"
	 * ); } SqlUtis.prepareSql(formMap, SqlUtis.getSQL(formMap, "a." +
	 * UserService.LOGIN_ID, Types.VARCHAR), SqlUtis.getSQL(formMap, "a." +
	 * UserService.NAME, Types.VARCHAR), SqlUtis.getSQL( formMap, "a." +
	 * UserService.PSW, Types.VARCHAR), SqlUtis .getSQL(formMap, "a." +
	 * UserService.TYPE_ID, Types.VARCHAR) ,SqlUtis.orderBy(" a."
	 * +UserService.CREATED_DATE +" DESC")); this.resultList =
	 * this.userService.list(formMap, page); return
	 * "/WEB-INF/jsp/sys/user/select.jsp"; }
	 */
	/**
	 * 列表
	 * 
	 * @return
	 */
	public String list() {
		this.checkAuth(AUTH_LIST);
		this.resultList = this.userService.list(formMap, page, this.getSessionUser());
		return "/WEB-INF/jsp/sys/user/list.jsp";
	}

	/**
	 * 列表
	 * 
	 * @return
	 *//*
	public String loadList() {
		this.checkAuth(AUTH_LIST);
		this.resultList = this.userService.list(formMap, page, this.getSessionUser());
		return "/WEB-INF/jsp/sys/user/load_list.jsp";

	}*/

	/**
	 * 转到增加页面
	 * @url /sys/User/toAdd.do
	 * @return
	 */
	public String toAdd() {
		this.checkAuth(AUTH_ADD);
		return "/WEB-INF/jsp/sys/user/add.jsp";
	}

	/**
	 * 增加
	 * @url /sys/User/add.do
	 * @return
	 */
	public String add() {
		String msg = "";
		try {
			this.checkAuth(AUTH_ADD);
		     // 保存到数据库
			Object obj = this.userService.insert(formMap);
			// 操作日志
			this.auditLog(AUTH_ADD, "增加:" + obj);
			msg = "{\"MSG\":\"数据新增成功!\",\"ID\":\"" + obj + "\"}";
		} catch (Exception e) {
			msg = "{\"MSG\":\"数据新增失败!\"}";
		} finally {
			this.saveActionMessage(msg);
		}
		return "/commons/actionMessage.jsp";

	}

	/**
	 * 转到编辑
	 * 
	 * @return
	 */
	public String toEdit() {
		this.checkAuth(AUTH_EDIT);
		this.resultMap = (Map) this.userService.one(formMap);
		return "/WEB-INF/jsp/sys/user/edit.jsp";
	}

	/**
	 * 编辑
	 * 
	 * @return
	 */
	public String edit() {
		String msg = "";
		try {
			this.checkAuth(AUTH_EDIT);
			// 检查是否存在
			Map dbvalue = (Map) this.userService.one(formMap);
			boolean needCheckUnique = false;
			if (!needCheckUnique && !ObjectUtils.equals(dbvalue.get("LOGIN_ID"), formMap.get("LOGIN_ID"))) {
				needCheckUnique = true;
			}
			if (needCheckUnique) {
				try {
					this.checkUnique(formMap);
				} catch (BusinessException e) {
					this.saveActionError(e.getMessage());
					resultMap = formMap;
					return "/WEB-INF/jsp/sys/user/edit.jsp";
				}
			}
			// 更新数据库
			this.userService.update(formMap);
			// 操作日志
			this.auditLog(AUTH_EDIT, "修改:" + formMap.get(UserDao.USER_ID));

			msg = "{\"MSG\":\"数据修改成功!\",\"ID\":\"" + formMap.get(UserDao.USER_ID) + "\"}";
		} catch (Exception e) {
			msg = "{\"MSG\":\"数据修改失败!\"}";
		} finally {
			this.saveActionMessage(msg);
		}
		return "/commons/actionMessage.jsp";
	}

	/**
	 * 转到编辑
	 * 
	 * @return
	 */
	public String loadView() {
		this.resultMap = (Map) this.userService.one(formMap);
		return "/WEB-INF/jsp/sys/user/load_view.jsp";
	}

	/**
	 * 删除
	 * 
	 * @return
	 */
	public String delete() {
		String msg = "";
		try {
			this.checkAuth(AUTH_DEL);
			// 删除数据库
			this.userService.delete(formMap);
			this.auditLog(AUTH_DEL, "删除:" + formMap.get(UserDao.USER_ID));// 操作日志
			msg = "{\"MSG\":\"数据删除成功!\"}";
		} catch (Exception e) {
			msg = "{\"MSG\":\"数据删除失败!\"}";
		} finally {
			this.saveActionMessage(msg);
		}
		return "/commons/actionMessage.jsp";
	}

	/**
	 * 检查唯一
	 * 
	 * @return
	 */
	public void checkUnique(Map formMap) {
		boolean checked = this.userService.checkUnique(formMap);
		if (!checked) {
			throw new BusinessException("已经存在相同的 登陆账号");
		}
	}

	/**
	 * 查看已经分配的角色
	 * 
	 * @return
	 */
	public String loadViewAssignRole() {
		this.checkAuth(AUTH_ASSIGN_ROLE);
		// 查询角色权限
		this.resultList = this.roleService.listViewRole(formMap);
		return "/WEB-INF/jsp/sys/user/load_view_assignrole.jsp";
	}

	/**
	 * 加载角色分配
	 * 
	 * @return
	 */
	public String loadAssignRole() {
		this.checkAuth(AUTH_ASSIGN_ROLE);
		// 查询角色权限
		this.resultList = this.roleService.listRole(formMap);
		return "/WEB-INF/jsp/sys/user/load_assignrole.jsp";
	}

	/**
	 * 角色分配
	 * 
	 * @return
	 */
	public String assignRole() {
		String msg = "";
		try {
			this.checkAuth(AUTH_ASSIGN_ROLE);
			// 保存数据
			this.roleService.assignRole(formMap);
			msg = "{\"MSG\":\"角色分配成功!\"}";
		} catch (Exception e) {
			msg = "{\"MSG\":\"角色分配失败!\"}";
		} finally {
			this.saveActionMessage(msg);
		}
		return "/commons/actionMessage.jsp";

	}

	/**
	 * 查看已经分配的用户组
	 * 
	 * @return
	 */
	public String loadViewAssignGroup() {
		this.checkAuth(AUTH_ASSIGN_GROUP);
		// 查询角色权限
		this.resultList = this.groupService.listViewGroup(formMap);
		return "/WEB-INF/jsp/sys/user/load_view_assigngroup.jsp";
	}

	/**
	 * 加载用户组分配
	 * 
	 * @return
	 */
	public String loadAssignGroup() {
		this.checkAuth(AUTH_ASSIGN_GROUP);
		this.resultList = this.groupService.listGroup(formMap);
		return "/WEB-INF/jsp/sys/user/load_assigngroup.jsp";
	}

	/**
	 * 角色分配
	 * 
	 * @return
	 */
	public String assignGroup() {
		String msg = "";
		try {
			this.checkAuth(AUTH_ASSIGN_GROUP);
			// 保存数据
			this.groupService.assignGroup(formMap);
			msg = "{\"MSG\":\"用户组分配成功!\"}";
		} catch (Exception e) {
			msg = "{\"MSG\":\"角色分配失败!\"}";
		} finally {
			this.saveActionMessage(msg);
		}
		return "/commons/actionMessage.jsp";

	}

	// 更新分辨率
	public String updateResolution() throws ParseException {
		request.getSession().setAttribute(UserDao.RESOLUTION, ObjectUtils.toString(formMap.get(UserDao.RESOLUTION)));
		// 更新数据库
		formMap.put(UserDao.USER_ID, this.getSessionUser().getUserId());
		this.userService.update(formMap);
		return null;
	}
	
	
	
	

}
