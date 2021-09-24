package com.ssi.sys.dao;
import java.sql.Types;
import java.util.Map;

import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import com.ssi.framework.dao.BaseDao;
import com.ssi.framework.exceptions.BusinessException;
import com.ssi.framework.utils.SqlUtis;
/**
 * 权限
 */
@Repository
public class AuthDao extends BaseDao{
	public static final String NAMESPACE="S_AUTH";
	public static final String AUTH_ID="AUTH_ID";//权限代码
	public static final String NAME="NAME";//权限名称
	public static final String PARENT_ID="PARENT_ID";//上级权限
	public static final String PARAM="PARAM";//参数
	public static final String MENU="MENU";//菜单
	public static final String SORT="SORT";//排序
	public static final String REMARK="REMARK";//备注
	public static final String TARGET="TARGET";//跳转
	public static final String UPDATED_BY="UPDATED_BY";//更新人
	public static final String UPDATED_DATE="UPDATED_DATE";//更新时间
	public static final String CREATED_BY="CREATED_BY";//创建人
	public static final String CREATED_DATE="CREATED_DATE";//创建时间
	@Override
	public String getNamespace() {
		return NAMESPACE;
	}
	
	public String getUpdateParentIdStatement() {
		return getNamespace() + ".updateParentId";
	}
	
	@org.springframework.beans.factory.annotation.Value("${admin}")
	String admin;
	/**
	 * @param userId
	 * @return
	 */
	public boolean isAdmin(String userId){
		if (userId.equals(admin)) {
			return true;
		}
		return false;
	}
	/**
	 * @return
	 */
	public String getAdmin() {
		return admin;
	}
	
	/**
	 * 验证权限.有权限返回null,没有权限返回权限信息(map需要提供AUTH_ID,USER_ID)
	 * @param map
	 * @return
	 */
	public Object checkAuth(Map map){
		SqlUtis.prepareSql(map, "", SqlUtis.getSQLRequired(map, "a." + AuthDao.AUTH_ID, Types.VARCHAR));
		if(this.exists(map)){
			if (map.get(UserDao.USER_ID).equals(admin)) {
				return null;
			}
			map.remove(SqlUtis.WHERE_SQL);
			return this.one(this.getNamespace()+".checkAuth",map);
		}else{
			throw new BusinessException("请先添加权限记录到数据库: "+map.get(AuthDao.AUTH_ID));
		}
		
	}
	
}
