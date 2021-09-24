package com.ssi.sys.service;
import java.sql.Timestamp;
import java.sql.Types;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ssi.framework.bean.Page;
import com.ssi.framework.service.BaseService;
import com.ssi.framework.utils.SqlUtis;
import com.ssi.sys.dao.AuditLogDao;
/**
 * 操作日志
 */
@Service
public class AuditLogService extends BaseService{
	@Autowired
	AuditLogDao   auditLogDao;
	/**
	 * 新增数据
	 * @param map
	 * @return
	 */
	@Transactional
	public Object insert(Map map) {
		 Object obj=this.auditLogDao.UUID();
		  Timestamp dt=new Timestamp(System.currentTimeMillis()); 
		  // String dt=StringUtils.dateToMillis(new Date()); 
			map.put("CZSJ", dt);
			map.put("LOGIN_TIME", dt);
			map.put(AuditLogDao.AUDIT_LOG_ID,obj);
	       this.auditLogDao.insert(map);
		return obj;

	}
    /**
     * 分页查询结果集合
     * @param map
     * @param page
     * @return
     */
	public List list(Map map, Page page) {
	//	if(!authService.isAdmin(this.getSessionUser().getUserId())){
			//	this.formMap.put("JOIN_SQL", "join s_user b on (a.USER_ID = b.USER_ID) join ( select dept_id from s_dept a start with dept_id='"+this.getSessionUser().getDeptId()+"' connect by prior dept_id = parent_id ) authdept on (b.dept_id = authdept.dept_id)");
	//		}
			SqlUtis.convertBetweenValue(map, AuditLogDao.CZSJ);
			SqlUtis.prepareSql(map, ""
					,SqlUtis.getSQL(map,"a."+AuditLogDao.USER_NAME,Types.VARCHAR,SqlUtis.LIKE)
					,SqlUtis.getSQL(map,"a."+AuditLogDao.AUTH_ID,Types.VARCHAR,SqlUtis.EQ)
					,SqlUtis.getSQL(map,"a."+AuditLogDao.AUTH_NAME,Types.VARCHAR,SqlUtis.EQ)
					);
		return this.auditLogDao.list(map, page);
	}
	/**
	 * 记录操作日志
	 * @param authId 权限ID
	 * @param message 日志描述
	 */
	@Transactional
	public void auditLog(String authId,String message,Map formMap){
		Map map = new HashMap();
		map.putAll(formMap);
		map.put(AuditLogDao.AUTH_ID, authId);
		map.put(AuditLogDao.DES, message);
		map.put(AuditLogDao.RZJB, "info");
		try{
			this.insert(map );
		}catch (Exception e) {
			e.printStackTrace();
		}
	}	
}
