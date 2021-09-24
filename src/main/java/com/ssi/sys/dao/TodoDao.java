/*---------代码生成请勿手工修改---------*/
package com.ssi.sys.dao;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.ssi.framework.dao.BaseDao;
/**
 * 待办
 */
@Repository
public class TodoDao extends BaseDao{
	public static final String NAMESPACE="S_TODO";
	public static final String ID="ID";//编号
	public static final String USER_ID="USER_ID";//待办人
	public static final String DEPT_ID="DEPT_ID";//部门
	public static final String TODO_TYPE="TODO_TYPE";//代办类型
	public static final String MANUSER_ID="MANUSER_ID";//管理者
	public static final String OBJ_ID="OBJ_ID";//待办对象
	public static final String OBJ_URL="OBJ_URL";//待办链接
	public static final String MONSTARTIME="MONSTARTIME";//起始时间
	public static final String MONENDTIME="MONENDTIME";//结束时间
	public static final String MSG="MSG";//待办描述
	public static final String DODEGREE="DODEGREE";//级别
	public static final String MONTIME="MONTIME";//发起时间
	public static final String NOMON="NOMON";//是否提醒
	public static final String ISSCAN="ISSCAN";//是否扫描
	@Override
	public String getNamespace() {
		return NAMESPACE;
	}
}
