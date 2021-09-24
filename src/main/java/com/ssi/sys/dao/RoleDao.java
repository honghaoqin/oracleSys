 /*---------代码生成请勿手工修改---------*/
package com.ssi.sys.dao;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.ssi.framework.dao.BaseDao;
/**
 * 角色
 */
@Repository
public class RoleDao extends BaseDao{
	public static final String NAMESPACE="S_ROLE";
	public static final String ROLE_ID="ROLE_ID";//角色代码
	public static final String NAME="NAME";//角色名称
	public static final String UPDATED_DATE="UPDATED_DATE";//更新时间
	public static final String UPDATED_BY="UPDATED_BY";//更新人
	public static final String CREATED_DATE="CREATED_DATE";//创建时间
	public static final String CREATED_BY="CREATED_BY";//创建人
	@Override
	public String getNamespace() {
		return NAMESPACE;
	}

	
}

