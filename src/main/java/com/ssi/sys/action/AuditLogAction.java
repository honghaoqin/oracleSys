package com.ssi.sys.action;
import org.springframework.beans.factory.annotation.Autowired;
import com.ssi.sys.service.AuditLogService;
/**
 * 操作日志
 */
public class AuditLogAction extends com.ssi.sys.action.SysBaseAction {
	public static final String AUTH_LIST="S_AUDIT_LOG_LIST";
	/**
	 * 服务层
	 */
	@Autowired
	AuditLogService auditLogService;
	public  String  list(){
		this.checkAuth(AUTH_LIST);
		this.resultList = this.auditLogService.list(formMap, page);
		return "/WEB-INF/jsp/sys/auditlog/list.jsp";	
	}
	
}
