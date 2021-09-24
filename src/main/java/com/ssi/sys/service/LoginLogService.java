/*---------代码生成请勿手工修改---------*/
package com.ssi.sys.service;
import java.util.*;
import org.apache.commons.lang.*;
import org.springframework.stereotype.Service;
import com.ssi.framework.service.BaseService;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.beans.factory.annotation.Autowired;

import com.ssi.framework.bean.Page;
import com.ssi.framework.exceptions.BusinessException;
import com.ssi.framework.utils.SqlUtis;
import com.ssi.sys.dao.DictDao;
import com.ssi.sys.dao.LoginLogDao;

import java.sql.Types;
/**
 * 登录日志
 */
@Service
public class LoginLogService extends BaseService{
	
	@Autowired
	LoginLogDao  loginLogDao;
	
	/**
	 * 查询结果集合
	 * 
	 * @param map
	 * @return
	 */
	public List list(Map map,Page page) {
		/*if(!authService.isAdmin(this.getSessionUser().getUserId())){
			//this.formMap.put("JOIN_SQL", "join s_user b on (a.USER_ID = b.USER_ID) join ( select dept_id from s_dept a start with dept_id='"+this.getSessionUser().getDeptId()+"' connect by prior dept_id = parent_id ) authdept on (b.dept_id = authdept.dept_id)");
		}*/
		SqlUtis.convertBetweenValue(map, LoginLogDao.LOGIN_TIME);
		SqlUtis.convertBetweenValue(map, LoginLogDao.LOGOUT_TIME);
		SqlUtis.prepareSql(map, ""
				,SqlUtis.getSQL(map,"a."+LoginLogDao.USER_NAME,Types.VARCHAR)
				,SqlUtis.getSQL(map,"a."+LoginLogDao.IP,Types.VARCHAR)
				,SqlUtis.getSQL(map,"a."+LoginLogDao.LOGIN_TIME,Types.TIMESTAMP)
				,SqlUtis.getSQL(map,"a."+LoginLogDao.LOGOUT_TIME,Types.TIMESTAMP)
				);
		List list = this.loginLogDao.list(map,page);
		map.remove(SqlUtis.WHERE_SQL);
		return list;
	}
	
	
}
