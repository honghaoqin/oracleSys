package com.ssi.sys.action;

import java.util.HashMap;
import java.util.Map;


import com.ssi.framework.bean.SessionUser;
import com.ssi.framework.exceptions.AuthException;
import com.ssi.framework.struts2.BaseAction;
import com.ssi.sys.dao.AuditLogDao;
import com.ssi.sys.model.SysSessionUser;
import com.ssi.sys.service.AuditLogService;
import com.ssi.sys.service.AuthService;
import com.ssi.sys.service.DictService;

public class SysBaseAction extends BaseAction{
	@Autowired
	protected AuditLogService auditLogService;
	@Autowired
	protected AuthService authService;
	@Autowired
	DictService dictService;
	
	/**
	 * 记录操作日志
	 * @param authId 权限ID
	 * @param message 日志描述
	 */
	protected void auditLog(String authId,String message){
		this.auditLogService.auditLog(authId, message, formMap);
	}
	protected void checkAuth(String authId) throws AuthException{
		Map map = new HashMap();
		boolean hasAuth= this.authService.checkAuth(this.getSessionUser().getUserId(), authId);
		if (!hasAuth) {//没有权限
			throw new AuthException("对不起，你没有 "+authId +" 的权限");
		}
	}
	/**
	 * 检查权限   返回true||false
	 * @param authId
	 * @return true||false
	 */
	protected boolean getAuth(String authId){
		Map map = new HashMap();
		boolean hasRight = this.authService.checkAuth(this.getSessionUser().getUserId(), authId);
		if (!hasRight) {//没有权限
			return false;
		}else{
			return true;
		}
	}

	public void prepare() throws Exception {
		super.prepare();
		this.formMap.put("SUPER_ADMIN", authService.getAdmin());
		SysSessionUser sessionUser = this.getSessionUser();
		//this.formMap.put("dictMap", DictService.getCacheMap());
		if(sessionUser != null){
			this.formMap.put(SessionUser.SESSIONUSER_KEY, sessionUser.getAttributes());
		}
	}
	
	/**
	 * 获取当前登录的用户
	 * @return
	 */
	@Override
	protected SysSessionUser getSessionUser(){
		return (SysSessionUser) super.getSessionUser();
	}
}