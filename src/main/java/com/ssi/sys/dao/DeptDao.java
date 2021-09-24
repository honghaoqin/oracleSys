/*---------代码生成请勿手工修改---------*/
package com.ssi.sys.dao;
import java.sql.Types;
import java.util.Map;

import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ssi.framework.dao.BaseDao;
import com.ssi.framework.exceptions.BusinessException;
import com.ssi.framework.utils.SqlUtis;
/**
 * 部门
 */
@Repository
public class DeptDao extends BaseDao{
	public static final String NAMESPACE="S_DEPT";
	public static final String DEPT_ID="DEPT_ID";//部门代码
	public static final String NAME="NAME";//部门名称
	public static final String PARENT_ID="PARENT_ID";//上级部门
	public static final String SPELL="SPELL";//拼音头
	public static final String DES="DES";//说明
	public static final String UPDATED_BY="UPDATED_BY";//更新人
	public static final String UPDATED_DATE="UPDATED_DATE";//更新时间
	public static final String CREATED_BY="CREATED_BY";//创建人
	public static final String CREATED_DATE="CREATED_DATE";//创建时间
	public static final String SORT="SORT";//排序
	public static final String TYPE_ID="TYPE_ID";//类型
	
	@Override
	public String getNamespace() {
		return NAMESPACE;
	}
	@Override
	@Transactional
	public int delete(Map map) {
		try {

			SqlUtis.prepareSql(map, "",
					SqlUtis.getSQLRequired(map, DeptDao.PARENT_ID,DeptDao.DEPT_ID, Types.VARCHAR));
			this.update(getUpdateParentIdStatement(), map);
			SqlUtis.prepareSql(map, "",
					SqlUtis.getSQLRequired(map, DeptDao.DEPT_ID, Types.VARCHAR));
			int result = this.delete(getDeleteStatement(), map);
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			throw new BusinessException("删除失败:" + e.getMessage(), e);
		}
	}

	public String getUpdateParentIdStatement() {
		return getNamespace() + ".updateParentId";
	}
	/**
	 * 数据同步
	 * @param map
	 */
	@Transactional
	public  void  syndept(Map  map){
		SqlUtis.prepareSql(map, "",
				SqlUtis.getSQLRequired(map, " a."+DeptDao.DEPT_ID,DeptDao.DEPT_ID, Types.VARCHAR,SqlUtis.EQ));
		if(this.exists(map)){
			this.update(map);
		}else{
			this.insert(this.NAMESPACE+".syninsert",map);
		}
	}
}
