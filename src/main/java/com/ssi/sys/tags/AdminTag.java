package com.ssi.sys.tags;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import com.ssi.framework.spring.SpringUtils;
import com.ssi.sys.model.SysSessionUser;
import com.ssi.sys.service.AuthService;

public class AdminTag extends TagSupport {
	
	static AuthService authService = SpringUtils.getBean(AuthService.class);
	
	private boolean admin;//是否是管理员.true|false
	
	public void setAdmin(boolean admin) {
		this.admin = admin;
	}

	public boolean isAdmin() {
		return admin;
	}

	@Override
	public int doStartTag() throws JspException {
		HttpServletRequest request = (HttpServletRequest) this.pageContext.getRequest();
		SysSessionUser sessionUser = (SysSessionUser) request.getSession().getAttribute(SysSessionUser.SESSION_KEY);
		if (sessionUser==null) {
			return SKIP_PAGE;
		}
		if (admin) {
			if(authService.isAdmin(sessionUser.getUserId())){
				return EVAL_BODY_INCLUDE;
			}
		}else {
			if(!authService.isAdmin(sessionUser.getUserId())){
				return EVAL_BODY_INCLUDE;
			}
		}
		
		return SKIP_BODY;
	}
	
}
