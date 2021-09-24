package com.ssi.sys.action;
import org.springframework.beans.factory.annotation.Autowired;

import com.ssi.sys.service.LoginLogService;
/**
 * 登录日志
 */
public class LoginLogAction extends com.ssi.sys.action.SysBaseAction {
	public static final String AUTH_LIST="S_LOGIN_LOG_LIST";
	/**
	 * 服务层
	 */
	@Autowired
	LoginLogService loginLogService;
	public String list(){
		this.checkAuth(AUTH_LIST);
		this.resultList = this.loginLogService.list(formMap, page);
		return "/WEB-INF/jsp/sys/loginlog/list.jsp";	
	}
	/**
	 * 列表
	 * @return
	 */
	public String loadList() {
		this.checkAuth(AUTH_LIST);
		this.resultList = this.loginLogService.list(formMap, page);
		return "/WEB-INF/jsp/sys/loginlog/load_list.jsp";
		
	}
}
