/*---------代码生成请勿手工修改---------*/
package com.ssi.sys.action;

import java.util.*;
import java.sql.Types;

import org.apache.commons.lang.ObjectUtils;
import org.springframework.beans.factory.annotation.Autowired;

import com.ssi.framework.exceptions.BusinessException;
import com.ssi.framework.utils.SqlUtis;
import com.ssi.sys.service.TodoService;
/**
 * 待办
 */
public class TodoAction extends com.ssi.sys.action.SysBaseAction {
	public static final String AUTH_LIST="S_TODO_LIST";
	/**
	 * 服务层
	 */
	@Autowired
	TodoService todoService;
	/**
	 * 列表
	 * @return
	 */
	public String list() {
		this.checkAuth(AUTH_LIST);
		this.resultList = this.todoService.list(formMap, page);
		return "/WEB-INF/jsp/sys/todo/list.jsp";
		
	}
}
