 /*---------代码生成请勿手工修改---------*/
package com.ssi.sys.dao;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.ssi.framework.dao.BaseDao;
/**
 * 用户组
 */
@Repository
public class GroupDao extends BaseDao{
	public static final String NAMESPACE="S_GROUP";
	public static final String GROUP_ID="GROUP_ID";//组代码
	public static final String NAME="NAME";//组名称
	public static final String DEPT_ID="DEPT_ID";//所属部门
	public static final String REMARK="REMARK";//备注
	public static final String UPDATED_DATE="UPDATED_DATE";//更新时间
	public static final String UPDATED_BY="UPDATED_BY";//更新人
	public static final String CREATED_DATE="CREATED_DATE";//创建时间
	public static final String CREATED_BY="CREATED_BY";//创建人
	@Override
	public String getNamespace() {
		return NAMESPACE;
	}
	
}

