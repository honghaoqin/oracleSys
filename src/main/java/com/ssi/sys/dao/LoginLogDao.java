/*---------代码生成请勿手工修改---------*/
package com.ssi.sys.dao;
import java.util.*;
import org.apache.commons.lang.*;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import com.ssi.framework.service.BaseService;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.beans.factory.annotation.Autowired;

import com.ssi.framework.dao.BaseDao;
import com.ssi.framework.exceptions.BusinessException;
import com.ssi.framework.utils.SqlUtis;
import java.sql.Types;
/**
 * 登录日志
 */
@Repository
public class LoginLogDao extends BaseDao{
	public static final String NAMESPACE="S_LOGIN_LOG";
	public static final String SESSION_ID="SESSION_ID";//回话
	public static final String USER_ID="USER_ID";//用户代码
	public static final String USER_NAME="USER_NAME";//用户姓名
	public static final String IP="IP";//IP地址
	public static final String BROWSER="BROWSER";//浏览器
	public static final String LOGIN_TIME="LOGIN_TIME";//登录时间
	public static final String LOGOUT_TIME="LOGOUT_TIME";//退出时间
	@Override
	public String getNamespace() {
		return NAMESPACE;
	}
}
