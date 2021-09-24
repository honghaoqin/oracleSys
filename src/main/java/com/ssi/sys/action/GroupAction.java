/*---------代码生成请勿手工修改---------*/
package com.ssi.sys.action;

import java.sql.Types;
import java.util.Map;

import org.apache.commons.lang.ObjectUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;

import com.ssi.framework.utils.SqlUtis;
import com.ssi.sys.dao.GroupDao;
import com.ssi.sys.service.GroupService;

/**
 * 用户组
 */
public class GroupAction extends com.ssi.sys.action.SysBaseAction {
	public static final String AUTH_LIST = "S_GROUP_LIST";
	public static final String AUTH_ADD = "S_GROUP_ADD";
	public static final String AUTH_EDIT = "S_GROUP_EDIT";
	public static final String AUTH_DEL = "S_GROUP_DEL";
	public static final String AUTH_ASSIGN_USER = "S_GROUP_ASSIGN_USER";

	/**
	 * 服务层
	 */
	@Autowired
	GroupService groupService;

	/**
	 * 列表
	 * 
	 * @return
	 */
	public String list() {
		this.checkAuth(AUTH_LIST);
		return "/WEB-INF/jsp/sys/group/list.jsp";
	}

	/**
	 * 列表
	 * 
	 * @return
	 */
	public String loadList() {
		this.checkAuth(AUTH_LIST);
		
		this.resultList = this.groupService.list(formMap, page,this.getSessionUser());
		return "/WEB-INF/jsp/sys/group/load_list.jsp";

	}

	/**
	 * 转到增加页面
	 * 
	 * @return
	 */
	public String loadAdd() {
		this.checkAuth(AUTH_ADD);
		return "/WEB-INF/jsp/sys/group/load_add.jsp";
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
			Object obj = this.groupService.insert(formMap);
			formMap.remove(SqlUtis.WHERE_SQL);
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
	public String loadEdit() {
		this.checkAuth(AUTH_EDIT);
		this.resultMap = (Map) this.groupService.one(formMap);
		return "/WEB-INF/jsp/sys/group/load_edit.jsp";
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
			this.groupService.update(formMap);
			this.auditLog(AUTH_EDIT, "修改:" + formMap.get(GroupDao.GROUP_ID));// 操作日志
			msg = "{\"MSG\":\"数据修改成功!\",\"ID\":\""
					+ formMap.get(GroupDao.GROUP_ID) + "\"}";
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
		this.resultMap = (Map) this.groupService.one(formMap);
		return "/WEB-INF/jsp/sys/group/load_view.jsp";
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
			this.groupService.delete(formMap);
			this.auditLog(AUTH_DEL, "删除:" + formMap.get(GroupDao.GROUP_ID));// 操作日志
			msg = "{\"MSG\":\"数据删除成功!\"}";
		} catch (Exception e) {
			msg = "{\"MSG\":\"数据删除失败!\"}";
		} finally {
			this.saveActionMessage(msg);
		}
		return "/commons/actionMessage.jsp";
	}

	/**
	 * 转到查看用户组
	 * 
	 * @author shimh
	 * @return
	 */
	public String toViewUser() {
		this.resultList = this.groupService.listViewGroupUser(formMap);
		return "/WEB-INF/jsp/sys/group/view.jsp";
	}

	/**
	 * 转到用户组分配用户页面
	 * 
	 * @author shimh
	 * @return
	 */
	public String toAssignUser() {
		this.checkAuth(AUTH_ASSIGN_USER);
	    this.resultList = this.groupService.listGroupUser(formMap);
		return "/WEB-INF/jsp/sys/group/load_assign.jsp";
	}

	/**
	 * 用户组分配用户
	 * 
	 * @author shimh
	 * @return
	 */
	public String assignUser() {
		String msg = "";
		try {
			this.checkAuth(AUTH_ASSIGN_USER);
			// 保存数据
			this.groupService.assignUser(formMap);
			msg = "{\"MSG\":\"用户分配成功!\"}";
		} catch (Exception e) {
			msg = "{\"MSG\":\"用户分配失败!\"}";
		} finally {
			this.saveActionMessage(msg);
		}
		return "/commons/actionMessage.jsp";

	}
	
	

	/**
	 * 转到查看用户组
	 * 
	 * @author shimh
	 * @return
	 */
	public String loadViewAuth() {
		// 查询用户组用户
		this.resultMap=(Map)this.groupService.one(formMap);		
			/*	String typeId =ObjectUtils.toString(formMap.get("TYPE_ID"));
				if (!StringUtils.isBlank(typeId)) {
				this.resultList = this.groupService.queryList(formMap);
				}*/
		return "/WEB-INF/jsp/sys/group/load_viewauth.jsp";
	}

	/**
	 * 转到用户组分配用户页面
	 * 
	 * @author shimh
	 * @return
	 */
	public String loadAssignAuth() {
		this.checkAuth(AUTH_ASSIGN_USER);
		// 查询用户组用户
		resultMap=(Map)this.groupService.one(formMap);
		
		String typeId =ObjectUtils.toString(formMap.get("TYPE_ID"));
	/*	if (!StringUtils.isBlank(typeId)) {	
		this.resultList = this.groupService.queryList(formMap);
		}*/
		return "/WEB-INF/jsp/sys/group/load_assignauth.jsp";
	}

	/**
	 * 用户组分配用户
	 * 
	 * @author shimh
	 * @return
	 */
	public String assignAuth() {
		String msg = "";
		try {
			this.checkAuth(AUTH_ASSIGN_USER);
			// 保存数据
			this.groupService.assignAuth(formMap);
			msg = "{\"MSG\":\"数据权限分配成功!\"}";
		} catch (Exception e) {
			msg = "{\"MSG\":\"数据权限分配失败!\"}";
		} finally {
			this.saveActionMessage(msg);
		}
		return "/commons/actionMessage.jsp";

	}
	
}
