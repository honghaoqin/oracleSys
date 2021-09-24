/*---------代码生成请勿手工修改---------*/
package com.ssi.sys.action;

import java.sql.Types;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import com.google.gson.Gson;
import com.ssi.framework.exceptions.BusinessException;
import com.ssi.framework.utils.SqlUtis;
import com.ssi.sys.dao.AuthDao;
import com.ssi.sys.service.AuthService;

/**
 * 权限
 */
public class AuthAction extends com.ssi.sys.action.SysBaseAction {
	public static final String AUTH_LIST = "S_AUTH_LIST";
	public static final String AUTH_ADD = "S_AUTH_ADD";
	public static final String AUTH_EDIT = "S_AUTH_EDIT";
	public static final String AUTH_DEL = "S_AUTH_DEL";
	/**
	 * 服务层
	 */
	@Autowired
	AuthService authService;
	/**
	 * 列表
	 * @return
	 */
	public String list() {
		this.checkAuth(AUTH_LIST);
		this.resultList = this.authService.list(formMap, page);
		return "/WEB-INF/jsp/sys/auth/list.jsp";
	}
	

	/**
	 * 转到增加页面
	 * @return
	 */
	public String toAdd() {
		this.checkAuth(AUTH_ADD);
		return "/WEB-INF/jsp/sys/auth/add.jsp";
	}

	/**
	 * 增加
	 * 
	 * @return
	 */
	public String add() {
		Map msg = new HashMap<String, String>();
		try {
			this.checkAuth(AUTH_ADD);
			boolean exists = this.authService.exists(formMap);
			if (exists) {
				this.saveActionError("已经存在相同的权限代码" + formMap.get(AuthDao.AUTH_ID));
				return "/WEB-INF/jsp/sys/auth/load_add.jsp";
			} else {
				// 保存到数据库
				Object obj = this.authService.insert(formMap);
				// end保存到数据库
				this.auditLog(AUTH_ADD, "增加:" + formMap.get(AuthDao.AUTH_ID));// 操作日志
				msg.put("MSG", "数据新增成功!");
				msg.put("ID", obj);
			}
		} catch (Exception e) {
			msg.put("MSG", "数据新增失败!");
		} finally {
			this.saveActionMessage(new Gson().toJson(msg));
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
		this.resultMap = (Map) this.authService.one(formMap);
		return "/WEB-INF/jsp/sys/auth/edit.jsp";
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
			this.authService.update(formMap);
			// end 更新数据库
			this.auditLog(AUTH_EDIT, "修改:" + formMap.get(AuthDao.AUTH_ID));// 操作日志
			msg = "{\"MSG\":\"数据修改成功!\",\"ID\":\"" + formMap.get(AuthDao.AUTH_ID) + "\"}";
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

		this.resultMap = (Map) this.authService.one(formMap);
		return "/WEB-INF/jsp/sys/auth/view.jsp";
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
			this.authService.delete(formMap);
			// end删除数据库
			this.auditLog(AUTH_DEL, "删除:" + formMap.get(AuthDao.AUTH_ID));// 操作日志
			msg = "{\"MSG\":\"数据删除成功!\"}";
		} catch (Exception e) {
			msg = "{\"MSG\":\"数据删除失败!\"}";
		} finally {
			this.saveActionMessage(msg);
		}
		return "/commons/actionMessage.jsp";
	}

	/*	*//**
			 * 移动
			 * 
			 * @return
			 *//*
			 * public String moveUpDown(){
			 * this.authService.update("S_AUTH.MOVE_SORT",formMap); return null;
			 * }
			 */
}
