package com.ssi.sys.service;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ssi.framework.utils.SqlUtis;
import com.ssi.sys.dao.AuditLogDao;
import com.ssi.sys.dao.DictDao;
import com.ssi.sys.dao.LoginLogDao;

/**
 * 定时清空日志
 * @author yuan
 *
 */
@Service
public class ClearLogJobService{
	protected static Log LOG = LogFactory.getLog(ClearLogJobService.class);

	@Autowired
	LoginLogDao loginLogDao;
	
	@Autowired
	AuditLogDao auditLogDao;

	@Transactional
	@Scheduled(cron="0 59 23 * * ?")//每天23:59点执行
	public void run(){
		LOG.info("开始清理日志");
		try{
			this.clearLog();
		}catch (Exception e) {
			LOG.error("清理登录日志出错:"+e.getMessage());
			e.printStackTrace();
		}
		try{
			this.clearAuditLog();
		}catch (Exception e) {
			LOG.error("清理操作日志出错:"+e.getMessage());
			e.printStackTrace();
		}
		LOG.info("结束清理日志");
	}

	/**
	 * 清除登录日志
	 */
	private void clearLog(){
		Map map =new HashMap();
		SqlUtis.prepareSql(map, ""
				," and a.login_time < (sysdate - (select to_number(trim(text)) from s_dict b where b.type='"+DictDao.SYSPARAM+"' and b.value='"+DictDao.LOGIN_LOG_DAY+"' ))"
		);
		this.loginLogDao.delete(map);
	}
	/**
	 * 清除操作日志
	 */
	private void clearAuditLog(){
		Map map =new HashMap();
		SqlUtis.prepareSql(map, ""
				," and a.czsj < (sysdate - (select to_number(trim(text)) from s_dict b where b.type='"+DictDao.SYSPARAM+"' and b.value='"+DictDao.AUDIT_LOG_DAY+"' ))"
				);
		this.auditLogDao.delete(map);
	}

}
