package com.ssi.sys.tags;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import com.ssi.framework.spring.SpringUtils;
import com.ssi.sys.model.SysSessionUser;
import com.ssi.sys.service.AuthService;

public class ManagerTag extends TagSupport {
	
	static AuthService authService = SpringUtils.getBean(AuthService.class);
	
	private boolean manager;//是否是管理员.true|false
	
	public void setManager(boolean manager) {
		this.manager = manager;
	}

	public boolean isManager() {
		return manager;
	}

	@Override
	public int doStartTag() throws JspException {
		String  type="SYSTEM";
		HttpServletRequest request = (HttpServletRequest) this.pageContext.getRequest();
		SysSessionUser sessionUser = (SysSessionUser) request.getSession().getAttribute(SysSessionUser.SESSION_KEY);
		if (sessionUser==null) {
			return SKIP_PAGE;
		}
		if (manager) {
			  if(type.equals(sessionUser.getTypeId())){
				  return EVAL_BODY_INCLUDE; 
			  }
				
			
		}else {
			if(!type.equals(sessionUser.getTypeId())){
				return EVAL_BODY_INCLUDE;
			}
		}
		
		return SKIP_BODY;
	}
	
}
