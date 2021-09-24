package com.ssi.sys.tags;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import com.ssi.framework.spring.SpringUtils;
import com.ssi.sys.model.SysSessionUser;
import com.ssi.sys.service.AuthService;

public class AuthTag extends TagSupport {
	
	static AuthService authService = SpringUtils.getBean(AuthService.class);
	
	private String authId;//!开头，表示非
	
	public String getAuthId() {
		return authId;
	}

	public void setAuthId(String authId) {
		this.authId = authId;
	}

	@Override
	public int doStartTag() throws JspException {
		HttpServletRequest request = (HttpServletRequest) this.pageContext.getRequest();
		SysSessionUser sessionUser = (SysSessionUser) request.getSession().getAttribute(SysSessionUser.SESSION_KEY);
		if (sessionUser==null) {
			return SKIP_PAGE;
		}
		boolean hasRight = false;
		if(this.authId.startsWith("!")){
			hasRight = !authService.checkAuth(sessionUser.getUserId(), authId.substring(1));
		}else{
			hasRight = authService.checkAuth(sessionUser.getUserId(), authId);
		}
		if (hasRight) {
			return EVAL_BODY_INCLUDE;
		}
		
		return SKIP_BODY;
	}
	
}
