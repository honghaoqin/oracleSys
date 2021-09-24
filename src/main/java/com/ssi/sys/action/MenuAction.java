package com.ssi.sys.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.commons.lang.ObjectUtils;
import org.springframework.beans.factory.annotation.Autowired;
import com.ssi.framework.bean.SessionUser;
import com.ssi.framework.utils.SqlUtis;
import com.ssi.framework.utils.TreeUtils;
import com.ssi.sys.dao.AuthDao;
import com.ssi.sys.model.SysSessionUser;
import com.ssi.util.MenuUtil;
public class MenuAction extends SysBaseAction {
	@Autowired
	AuthDao  authDao;
	
	public  String  main(){
		SysSessionUser sessionUser=this.getSessionUser();
		if (sessionUser != null) {
			boolean isAdmin=authService.isAdmin(sessionUser.getUserId());
			Map pmap=new  HashMap();
			if (isAdmin) {
				SqlUtis.prepareSql(pmap, " and a.menu = '1'  and  a.parent_id is null");
				resultList=this.authDao.list(pmap);
			} else {
				pmap.put(SessionUser.SESSIONUSER_KEY,sessionUser.getAttributes());
				SqlUtis.prepareSql(pmap, "   and  a.parent_id is null ");
				resultList= this.authDao.list(authDao.getNamespace()+ ".selectMenu", pmap);
				
			}
			if(null!=resultList&&!resultList.isEmpty()){
			String  parent_id=ObjectUtils.toString(formMap.get("PARENT_ID")).trim();
			if("".equals(parent_id)||"SYS".equals(parent_id)){
				if(null!=resultList&&!resultList.isEmpty()){
					Map map=(Map)resultList.get(0);
					 parent_id=ObjectUtils.toString(map.get("AUTH_ID")).trim();
					 formMap.put("PARENT_ID", parent_id);
			    }	
			  }
			
			
			List<Map> menuList=null;
			if (isAdmin) {
				SqlUtis.prepareSql(formMap, " and  a.menu = '1'    start with a.PARENT_ID='"
						+ parent_id
						+ "'  connect by prior a.AUTH_ID = a.PARENT_ID ");
				menuList=this.authDao.list(formMap);
				formMap.remove(SqlUtis.WHERE_SQL);
			} else {
				formMap.put(SessionUser.SESSIONUSER_KEY,sessionUser.getAttributes());
				menuList= this.authDao.list(authDao.getNamespace()+ ".selectMenu", formMap);
			}
			if(null!=menuList&&!menuList.isEmpty()){
				menuList = TreeUtils.tree(menuList, authDao.PARENT_ID,authDao.AUTH_ID);// 父子树形结构
				String  param=MenuUtil.getChildParam(menuList);
				resultMap.put("leftUrl","/sys/Menu/left.do?formMap.PARENT_ID="+parent_id);
				resultMap.put("rightUrl",param+"?1=1"); 	
			}
			
			}
		}	
		return "/WEB-INF/jsp/system/sys/index.jsp";
	}
	/**
	 *  /sys/Menu/top.do
	 * @return
	 */
	public String  top(){
		resultList=topMenu(this.getSessionUser());
	 return "/WEB-INF/jsp/system/sys/top.jsp";	
	}
	
	
	/**
	 *  /sys/Menu/right.do
	 * @return
	 */
	public String  right(){
		String  parent_id=ObjectUtils.toString(formMap.get("PARENT_ID"));
		SysSessionUser sessionUser=this.getSessionUser();
		if (sessionUser != null) {
			boolean isAdmin=authDao.isAdmin(sessionUser.getUserId());
		if (isAdmin) {
			String left_sql = "select a.*  from S_AUTH a where  a.menu = '1'    start with PARENT_ID='"
					+ parent_id
					+ "'  connect by prior AUTH_ID = PARENT_ID order by a.parent_id,a.sort";
			resultList= this.authDao.listBySql(left_sql);
		}else{
			formMap.put(SessionUser.SESSIONUSER_KEY,sessionUser.getAttributes());
			resultList= this.authDao.list(authDao.getNamespace()+ ".selectMenu", formMap);
		}
		  resultList = TreeUtils.tree(resultList, authDao.PARENT_ID,authDao.AUTH_ID);// 父子树形结构
		String  param=MenuUtil.getChildParam(resultList);
		resultMap.put("param", param);
		 return "!"+param+"?1=1";	
		}	
		return null;
	}
	
	
	
	
	public  List topMenu(SysSessionUser sessionUser) {
		// 查询第一级菜单
		Map map = new HashMap();
		if (sessionUser != null) {
			boolean isAdmin=authDao.isAdmin(sessionUser.getUserId());
			if (isAdmin) {
				SqlUtis.prepareSql(map, " and a." + AuthDao.MENU
						+ " = '1' and  a.parent_id is null");
				return authDao.list(map);
			} else {
				map.put(SessionUser.SESSIONUSER_KEY,
						sessionUser.getAttributes());
				SqlUtis.prepareSql(map, " and  a.parent_id is null ");
				return authDao.list(authDao.getNamespace()
						+ ".selectMenu", map);
			}
		}
		return null;

	}
	
	
	/**
	 * 左边菜单
	 * @return
	 */
	public  String left(){
		String  parent_id=ObjectUtils.toString(formMap.get("PARENT_ID"));
		String  sql="select NAME  from  S_AUTH a where  a.auth_id='"+parent_id+"'";
		Map  map=(Map)this.authDao.listBySql(sql).get(0);
		SysSessionUser sessionUser=this.getSessionUser();
		if (sessionUser != null) {
			boolean isAdmin=authDao.isAdmin(sessionUser.getUserId());
		if (isAdmin) {
			String left_sql = "select a.*  from S_AUTH a where  a.menu = '1'    start with PARENT_ID='"
					+ parent_id
					+ "'  connect by prior AUTH_ID = PARENT_ID order by a.parent_id,a.sort";
			resultList= this.authDao.listBySql(left_sql);
		}else{
			formMap.put(SessionUser.SESSIONUSER_KEY,sessionUser.getAttributes());
			resultList= this.authDao.list(authDao.getNamespace()+ ".selectMenu", formMap);
		}
		  resultList = TreeUtils.tree(resultList, authDao.PARENT_ID,authDao.AUTH_ID);// 父子树形结构
		String  param=MenuUtil.getChildParam(resultList);
		resultMap.put("param", param);
		//System.out.println("param================"+param);
		}
		resultMap.put("pnlTitle", ObjectUtils.toString(map.get("NAME")));
		return "/WEB-INF/jsp/system/sys/left.jsp";
	}


}
