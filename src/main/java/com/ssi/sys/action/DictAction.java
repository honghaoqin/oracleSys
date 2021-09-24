/*---------代码生成请勿手工修改---------*/
package com.ssi.sys.action;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import com.ssi.sys.dao.AuthDao;
import com.ssi.sys.dao.DictDao;
import com.ssi.sys.service.DictService;
/**
 * 字典
 */
public class DictAction extends com.ssi.sys.action.SysBaseAction {
	public static final String AUTH_LIST="S_DICT_LIST";
	public static final String AUTH_ADD="S_DICT_ADD";
	public static final String AUTH_EDIT="S_DICT_EDIT";
	public static final String AUTH_DEL="S_DICT_DEL";
	/**
	 * 服务层
	 */
	@Autowired
	DictService dictService;
	
	/**
	 * 列表
	 * 
	 * @return
	 */
	public String list() {
		this.checkAuth(AUTH_LIST);
		this.resultList = this.dictService.list(formMap, page);
		return "/WEB-INF/jsp/sys/dict/list.jsp";
	}
	/**
	 * 转到增加页面
	 * 
	 * @return
	 */
	public String toAdd() {
		this.checkAuth(AUTH_ADD);
		return "/WEB-INF/jsp/sys/dict/add.jsp";
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
			//保存到数据库
			Object  obj=this.dictService.insert(formMap);
			//end保存到数据库
			 this.auditLog(AUTH_ADD, "增加:"+obj);//操作日志

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
		
			this.resultMap = (Map) this.dictService.one(formMap);
		return "/WEB-INF/jsp/sys/dict/edit.jsp";
	}

	/**
	 * 编辑
	 * @return
	 */
	public String edit() {
		String msg = "";
		try {
			this.checkAuth(AUTH_EDIT);
			//更新数据库
			this.dictService.update(formMap);
			this.auditLog(AUTH_EDIT, "修改:"+formMap.get(DictDao.DICT_ID));//操作日志
			msg = "{\"MSG\":\"数据修改成功!\",\"ID\":\""
					+ formMap.get(AuthDao.AUTH_ID) + "\"}";
		} catch (Exception e) {
			msg = "{\"MSG\":\"数据修改失败!\"}";
		} finally {
			this.saveActionMessage(msg);
		}
		return "/commons/actionMessage.jsp";
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
			//删除数据库
			this.dictService.delete(formMap);
			//end删除数据库
			this.auditLog(AUTH_DEL, "删除:"+formMap.get(DictDao.DICT_ID));//操作日志
			msg = "{\"MSG\":\"数据删除成功!\"}";
		} catch (Exception e) {
			msg = "{\"MSG\":\"数据删除失败!\"}";
		} finally {
			this.saveActionMessage(msg);
		}
		return "/commons/actionMessage.jsp";
	}

	
}
