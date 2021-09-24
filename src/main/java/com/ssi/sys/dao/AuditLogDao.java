/*---------代码生成请勿手工修改---------*/
package com.ssi.sys.dao;
import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import com.ssi.framework.dao.BaseDao;
/**
 * 操作日志
 */
@Repository
public class AuditLogDao extends BaseDao{
	public static final String NAMESPACE="S_AUDIT_LOG";
	public static final String AUDIT_LOG_ID="AUDIT_LOG_ID";//主键ID
	public static final String USER_ID="USER_ID";//用户代码
	public static final String USER_NAME="USER_NAME";//用户姓名
	public static final String AUTH_ID="AUTH_ID";//权限代码
	public static final String AUTH_NAME="AUTH_NAME";//权限名称
	public static final String DES="DES";//操作描述
	public static final String RZJB="RZJB";//日志级别
	public static final String CZSJ="CZSJ";//操作时间
	@Override
	public String getNamespace() {
		return NAMESPACE;
	}
	
	
}
