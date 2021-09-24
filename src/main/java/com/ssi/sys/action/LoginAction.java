package com.ssi.sys.action;

import org.apache.commons.lang.ObjectUtils;
import org.springframework.beans.factory.annotation.Autowired;

import com.ssi.sys.model.SysSessionUser;
import com.ssi.sys.service.UserService;

public class LoginAction extends SysBaseAction {
	
	
	@Autowired
	protected UserService userService;
	@Override
	protected void validateTimeout() {
		//登录时不用验证
	}
	
	/**
	 * 转到登录
	 * @return
	 */
	public String toLogin(){
		return "/login.jsp";
	}

	/**
	 * 用户登录
	 *  @url  /sys/Login/login.do?formMap.PSW=123456&formMap.LOGIN_ID=admin
	 * @return
	 */
	public String login() {
		this.resultMap=this.userService.Login(formMap, request);
		String msg=ObjectUtils.toString(this.resultMap.get("MSG"));
		if(!"".equals(msg)){
			this.saveActionMessage(msg);
		}
		
		
		return ObjectUtils.toString(this.resultMap.get("URL"));
		
	}
   /**
    * 用户退出登录
    * @return
    */
	public String logout(){
		if(this.getSessionUser() != null){
			this.request.getSession().removeAttribute(SysSessionUser.SESSION_KEY);
			this.request.getSession().invalidate();
		}
		return "!/login.jsp";
	}
	
	/**
	 * 转到编辑
	 * @return
	 */
	public String toChangePsw(){
		return "/WEB-INF/jsp/sys/user/change_psw.jsp";
	}
	/**
	 * 用户密码修改
	 * @return
	 */
	public String changePsw() {
		this.saveActionMessage(this.userService.changePsw(formMap));
		return "/WEB-INF/jsp/sys/user/change_psw.jsp";
	}
	
	
	public String   tab(){
	//	return "/WEB-INF/jsp/system/admin/tab.jsp";	
		return "/WEB-INF/jsp/system/admin/default.jsp";	
	}
	
	public  String  login_default(){
		return "/WEB-INF/jsp/system/admin/default.jsp";	
	}
		
	
	
	
	
}
