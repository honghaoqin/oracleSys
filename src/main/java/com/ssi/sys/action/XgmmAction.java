package com.ssi.sys.action;

import java.sql.Types;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import com.ssi.framework.utils.SqlUtis;
import com.ssi.sys.service.UserService;

public class XgmmAction extends com.ssi.sys.action.SysBaseAction{
	@Autowired
	UserService userService;
	
	@Override
	protected void validateTimeout() {
		//登录时不用验证
	}
	

}
