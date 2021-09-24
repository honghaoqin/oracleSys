/*---------代码生成请勿手工修改---------*/
package com.ssi.sys.dao;
import java.util.Map;

import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ssi.framework.dao.BaseDao;
/**
 * 用户
 */
@Repository
public class UserDao extends BaseDao{
	public static final String NAMESPACE="S_USER";
	public static final String USER_ID="USER_ID";//用户代码
	public static final String LOGIN_ID="LOGIN_ID";//登陆账号
	public static final String NAME="NAME";//用户姓名
	public static final String PSW="PSW";//密码
	public static final String TYPE_ID="TYPE_ID";//类型
    public static final String START_DT="START_DT";//生效日期
	public static final String END_DT="END_DT";//失效日期
	public static final String ZW="ZW";//职位
	public static final String DEPT_ID="DEPT_ID";//部门
	public static final String TELLPHONE="TELLPHONE";//手机
	public static final String PHONE="PHONE";//电话
	public static final String EMAIL="EMAIL";//邮箱
	public static final String UPDATED_BY="UPDATED_BY";//更新人
	public static final String UPDATED_DATE="UPDATED_DATE";//更新时间
	public static final String CREATED_BY="CREATED_BY";//创建人
	public static final String CREATED_DATE="CREATED_DATE";//创建时间
	public static final String REMARK="REMARK";//备注
	public static final String OBJ_ID="OBJ_ID";//人员编号
	public static final String PAGE_SIZE="PAGE_SIZE";//分页
	public static final String STYLESHEET="STYLESHEET";//皮肤
	public static final String LOGIN_DT="LOGIN_DT";//上次登录时间
	public static final String HREPORT_ID="HREPORT_ID";//案件编号
	public static final String POSITION_ID="POSITION_ID";//职务编码
	public static final String RESOLUTION="RESOLUTION";//分辨率
	@Override
	public String getNamespace() {
		return NAMESPACE;
	}
	
	
	
	/**
	 * 删除用户角色
	 * @param map
	 * @return
	 */
	@Transactional
	public int deleteRoleUser(Map map) {
		return this.delete(this.getNamespace()+".deleteRoleUser", map);
	}
	
}
