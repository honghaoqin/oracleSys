/*---------代码生成请勿手工修改---------*/
package com.ssi.sys.action;

import java.sql.Types;
import java.util.Map;

import org.apache.commons.lang.ObjectUtils;
import org.springframework.beans.factory.annotation.Autowired;

import com.ssi.framework.exceptions.BusinessException;
import com.ssi.framework.utils.SqlUtis;
import com.ssi.sys.dao.DeptDao;
import com.ssi.sys.service.DeptService;
import com.ssi.util.PingYinUtil;

/**
 * 部门
 */
public class DeptAction extends com.ssi.sys.action.SysBaseAction {
	public static final String AUTH_LIST = "S_DEPT_LIST";
	public static final String AUTH_ADD = "S_DEPT_ADD";
	public static final String AUTH_EDIT = "S_DEPT_EDIT";
	public static final String AUTH_DEL = "S_DEPT_DEL";

	/**
	 * 服务层
	 */
	@Autowired
	DeptService deptService;

	/**
	 * 列表
	 * 
	 * @return
	 */
	public String list() {
		this.checkAuth(AUTH_LIST);
		this.resultList = this.deptService.list(formMap, page);
		return "/WEB-INF/jsp/sys/dept/list.jsp";
	}

	

	/**
	 * 转到增加页面
	 * 
	 * @return
	 */
	public String toAdd() {
		this.checkAuth(AUTH_ADD);
		return "/WEB-INF/jsp/sys/dept/add.jsp";
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
			Object obj = this.deptService.insert(formMap);
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
		this.resultMap = (Map) this.deptService.one(formMap);
		return "/WEB-INF/jsp/sys/dept/edit.jsp";
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
			this.deptService.update(formMap);
			this.auditLog(AUTH_EDIT, "修改:" + formMap.get(DeptDao.DEPT_ID));// 操作日志
			msg = "{\"MSG\":\"数据修改成功!\",\"ID\":\"" + formMap.get(DeptDao.DEPT_ID) + "\"}";
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
		this.resultMap = (Map) this.deptService.one(formMap);
		return "/WEB-INF/jsp/sys/dept/load_view.jsp";
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
			this.deptService.delete(formMap);
			this.auditLog(AUTH_DEL, "删除:" + formMap.get(DeptDao.DEPT_ID));// 操作日志
			msg = "{\"MSG\":\"数据删除成功!\"}";
		} catch (Exception e) {
			msg = "{\"MSG\":\"数据删除失败!\"}";
		} finally {
			this.saveActionMessage(msg);
		}
		return "/commons/actionMessage.jsp";
	}
	// 部门查看
	public String view() {
		this.resultList = this.deptService.list(formMap);
		return "/WEB-INF/jsp/sys/dept/view.jsp";
	}
	/**
	 * @return
	 */
	public String queryList() {
		this.resultList = this.deptService.list(formMap, page);
		return "/WEB-INF/jsp/sys/dept/query_list.jsp";
	}

}
