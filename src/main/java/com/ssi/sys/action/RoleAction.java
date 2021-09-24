/*---------代码生成请勿手工修改---------*/
package com.ssi.sys.action;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import com.ssi.sys.dao.RoleDao;
import com.ssi.sys.service.RoleService;

/**
 * 角色
 */
public class RoleAction extends com.ssi.sys.action.SysBaseAction {
	public static final String AUTH_LIST = "S_ROLE_LIST";
	public static final String AUTH_ADD = "S_ROLE_ADD";
	public static final String AUTH_EDIT = "S_ROLE_EDIT";
	public static final String AUTH_DEL = "S_ROLE_DEL";
	public static final String AUTH_ASSIGN_AUTH = "S_ROLE_ASSIGN_AUTH";
	public static final String AUTH_ASSIGN_UAER = "S_ROLE_ASSIGN_USER";

	/**
	 * 服务层
	 */
	@Autowired
	RoleService roleService;

	/**
	 * 列表
	 * 
	 * @return
	 */
	public String list() {
		this.checkAuth(AUTH_LIST);
		this.resultList = this.roleService.list(formMap, page);
		return "/WEB-INF/jsp/sys/role/list.jsp";
	}



	/**
	 * 转到增加页面
	 * 
	 * @return
	 */
	public String toAdd() {
		this.checkAuth(AUTH_ADD);
		return "/WEB-INF/jsp/sys/role/add.jsp";
	}

	/**
	 * 增加
	 * 
	 * @return
	 */
	public String add() {
		String msg = "";
		try {
			this.checkAuth(AUTH_ADD);
			// 保存到数据库
			Object obj = this.roleService.insert(formMap);
			// end保存到数据库
			this.auditLog(AUTH_ADD, "增加:" + obj);// 操作日志

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
		this.resultMap = (Map) this.roleService.one(formMap);
		return "/WEB-INF/jsp/sys/role/edit.jsp";
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
			// 更新数据库
			this.roleService.update(formMap);
			this.auditLog(AUTH_EDIT, "修改:" + formMap.get(RoleDao.ROLE_ID));// 操作日志
			msg = "{\"MSG\":\"数据修改成功!\",\"ID\":\"" + formMap.get(RoleDao.ROLE_ID) + "\"}";
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
	public String toView() {
		this.resultMap = (Map) this.roleService.one(formMap);
		return "/WEB-INF/jsp/sys/role/view.jsp";
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
			this.roleService.delete(formMap);
			this.auditLog(AUTH_DEL, "删除:" + formMap.get(RoleDao.ROLE_ID));// 操作日志
			msg = "{\"MSG\":\"数据删除成功!\"}";
		} catch (Exception e) {
			msg = "{\"MSG\":\"数据删除失败!\"}";
		} finally {
			this.saveActionMessage(msg);
		}
		return "/commons/actionMessage.jsp";
	}

	/**
	 * 转到分配权限
	 * 
	 * @return
	 */
	public String toAssignAuth() {
		this.checkAuth(AUTH_ASSIGN_AUTH);
		// 查询角色权限
		this.resultList = this.authService.listAuth(formMap,this.getSessionUser().getUserId());
		return "/WEB-INF/jsp/sys/role/assignauth.jsp";
	}

	/**
	 * 分配权限
	 * 
	 * @return
	 */
	public String assignAuth() {
		String msg = "";
		try {
			this.checkAuth(AUTH_ASSIGN_AUTH);
			// 保存数据
			this.roleService.assignAuth(formMap);
			msg = "{\"MSG\":\"权限分配成功!\"}";
		} catch (Exception e) {
			msg = "{\"MSG\":\"权限分配失败!\"}";
		} finally {
			this.saveActionMessage(msg);
		}
		return "/commons/actionMessage.jsp";
	}

	/**
	 * 转到查看权限
	 * 
	 * @author
	 * @return
	 */
	public String toViewAuth() {
		// 查询权限
		this.resultList = this.authService.listRoleAuth(formMap);
		return "/WEB-INF/jsp/sys/role/viewauth.jsp";
	}

	public String toCopyAuth() {
		// 查询角色权限
	    this.resultMap = (Map) this.roleService.one(formMap);
		this.resultList = this.roleService.list(formMap);
		return "/WEB-INF/jsp/sys/role/copyauth.jsp";
	}

	/**
	 * 分配权限
	 * 
	 * @return
	 */
	public String copyAuth() {
		String msg = "";
		try {
			this.checkAuth(AUTH_ASSIGN_AUTH);
			// 权限复制
			this.roleService.copyRoleAuth(formMap);
			msg = "{\"MSG\":\"权限复制成功!\"}";
		} catch (Exception e) {
			msg = "{\"MSG\":\"权限复制失败!\"}";
		} finally {
			this.saveActionMessage(msg);
		}
		return "/commons/actionMessage.jsp";
	}

	/**
	 * 转到角色分配用户的界面
	 * 
	 * @return
	 */
	public String toAssignUser() {
		this.checkAuth(AUTH_ASSIGN_UAER);
		// 查询角色权限
		this.resultList = this.roleService.listRoleUser(formMap);
		return "/WEB-INF/jsp/sys/role/assignuser.jsp";
	}

	/**
	 * 角色分配用户
	 * 
	 * @return
	 */
	public String assignUser() {
		String msg = "";
		try {
			this.checkAuth(AUTH_ASSIGN_UAER);
			// 保存数据
			this.roleService.assignAuth(formMap);
			msg = "{\"MSG\":\"权限分配成功!\"}";
		} catch (Exception e) {
			msg = "{\"MSG\":\"权限分配失败!\"}";
		} finally {
			this.saveActionMessage(msg);
		}
		return "/commons/actionMessage.jsp";
	}

	/**
	 * 转到查看角色已经分配的用户界面
	 * 
	 * @author
	 * @return
	 */
	public String toViewUser() {
		this.checkAuth(AUTH_ASSIGN_UAER);
		// 查询权限
		this.resultList = this.authService.listRoleAuth(formMap);
		return "/WEB-INF/jsp/sys/role/viewuser.jsp";
	}
	
	

	
	
	
	

}
