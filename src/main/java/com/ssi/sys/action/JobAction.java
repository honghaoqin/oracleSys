/*---------代码生成请勿手工修改---------*/
package com.ssi.sys.action;
import java.sql.Types;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import com.ssi.framework.utils.SqlUtis;
import com.ssi.sys.dao.JobDao;
import com.ssi.sys.service.JobService;

/**
 * 定时任务
 */
public class JobAction extends com.ssi.sys.action.SysBaseAction {
	public static final String AUTH_LIST="S_JOB_LIST";
	public static final String AUTH_ADD="S_JOB_ADD";
	public static final String AUTH_EDIT="S_JOB_EDIT";
	public static final String AUTH_DEL="S_JOB_DEL";
	public static final String AUTH_STOP="S_JOB_STOP";
	public static final String AUTH_START="S_JOB_START";
	
	/**
	 * 服务层
	 */
	@Autowired
	JobService jobService;
	

	
	/**
	 * 列表
	 * 
	 * @return
	 */
	public String list() {
		this.checkAuth(AUTH_LIST);
		this.resultList = this.jobService.list(formMap, page);
		return "/WEB-INF/jsp/sys/job/list.jsp";
	}

	

	/**
	 * 转到增加页面
	 * 
	 * @return
	 */
	public String toAdd() {
		this.checkAuth(AUTH_ADD);
		return "/WEB-INF/jsp/sys/job/add.jsp";
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
			Object  obj=this.jobService.insert(formMap);
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
	    this.resultMap = (Map) this.jobService.one(formMap);
		return "/WEB-INF/jsp/sys/job/edit.jsp";
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
			
				this.jobService.update(formMap);
				formMap.remove(SqlUtis.WHERE_SQL);
			// end 更新数据库

			this.auditLog(AUTH_EDIT,
					"修改:" + formMap.get(JobDao.JOB_ID));// 操作日志
			msg = "{\"MSG\":\"数据修改成功!\",\"ID\":\""
					+ formMap.get(JobDao.JOB_ID) + "\"}";
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
			// 删除数据库
			this.jobService.delete(formMap);
			// 操作日志	
			this.auditLog(AUTH_DEL,"删除:"+formMap.get(JobDao.JOB_ID));
			msg = "{\"MSG\":\"数据删除成功!\"}";
		} catch (Exception e) {
			msg = "{\"MSG\":\"数据删除失败!\"}";
		} finally {
			this.saveActionMessage(msg);
		}
		return "/commons/actionMessage.jsp";
	}

	/**
	 * 停止
	 * @return
	 */
	public String stop() {
		String msg = "";
		try {
			this.checkAuth(AUTH_STOP);
			this.jobService.stop(formMap);
			this.auditLog(AUTH_STOP,"停止:" + formMap.get(JobDao.JOB_ID));// 操作日志
			msg = "{\"MSG\":\"停止成功!\"}";
		} catch (Exception e) {
			msg = "{\"MSG\":\"停止失败!\"}";
		} finally {
			this.saveActionMessage(msg);
		}
		return "/commons/actionMessage.jsp";
	}
	
	
	/**
	 * 启动
	 * 
	 * @return
	 */
	public String start() {
		String msg = "";
		try {
			this.checkAuth(AUTH_START);
			//启动job
			this.jobService.start((Map) this.jobService.one(formMap));
			// 操作日志
			this.auditLog(AUTH_START,
					"启动:" + formMap.get(JobDao.JOB_ID));
			msg = "{\"MSG\":\"启动成功!\"}";
		} catch (Exception e) {
			msg = "{\"MSG\":\"启动失败!\"}";
		} finally {
			this.saveActionMessage(msg);
		}
		return "/commons/actionMessage.jsp";
	}
	
	public  String  cron(){
		return "/WEB-INF/jsp/sys/job/cron.jsp";	
	}
	
	
}
