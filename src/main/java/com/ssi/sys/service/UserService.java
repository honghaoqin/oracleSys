/*---------代码生成请勿手工修改---------*/
package com.ssi.sys.service;
import java.sql.Timestamp;
import java.sql.Types;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.commons.lang.ObjectUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ssi.framework.bean.Page;
import com.ssi.framework.exceptions.BusinessException;
import com.ssi.framework.service.BaseService;
import com.ssi.framework.utils.EncryptUtil;
import com.ssi.framework.utils.SqlUtis;
import com.ssi.framework.utils.TreeUtils;
import com.ssi.sys.dao.AuthDao;
import com.ssi.sys.dao.DictDao;
import com.ssi.sys.dao.LoginLogDao;
import com.ssi.sys.dao.RoleDao;
import com.ssi.sys.dao.UserDao;
import com.ssi.sys.model.SysSessionUser;
import com.ssi.util.StringUtils;
/**
 * 用户
 */
@Service
public class UserService extends BaseService{
	
	@Autowired
	AuthDao authDao;
	@Autowired
	UserDao userDao;
	@Autowired
	DictDao dictDao;
	
	/**
	 * 新增数据
	 * @param map
	 * @return
	 * @throws ParseException 
	 */
	@Transactional
	public Object insert(Map map) throws ParseException {
		    Object sys_guid=this.userDao.UUID();
		    SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		    Date dt=new Date(); 
			map.put(UserDao.PSW, EncryptUtil.SHA(ObjectUtils.toString(map.get(UserDao.PSW))));// 加密密码
			map.put("START_DT", sdf.parse(ObjectUtils.toString(map.get("START_DT"))));
			map.put("END_DT", sdf.parse(ObjectUtils.toString(map.get("END_DT"))));
			map.put("CREATED_DATE",dt);
			map.put("LOGIN_DT",dt);
			map.put("SYS_GUID",sys_guid);
			this.userDao.insert(map);
	    return sys_guid;

	}
	public static void main(String[] args) throws ParseException {
	    SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMdd");
		System.out.println(StringUtils.dateToMillis(sdf.parse("20160509")));
		System.out.println(StringUtils.dateToMillis(new Date()));
	}
	
	
	
	/**
	 * 修改
	 * @param map
	 * @return
	 * @throws ParseException 
	 */
	@Transactional
	public int update(Map map) throws ParseException {
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
			map.put("START_DT", sdf.parse(ObjectUtils.toString(map.get("START_DT"))));
			map.put("END_DT", sdf.parse(ObjectUtils.toString(map.get("END_DT"))));
			map.put("UPDATED_DATE",new Date());
		if (((String) map.get(UserDao.PSW)).length() < 20) {
			// 加密密码
			map.put(UserDao.PSW, EncryptUtil.SHA(ObjectUtils.toString(map.get(UserDao.PSW))));
		}
		SqlUtis.prepareSql(map,SqlUtis.getSQLRequired(map,UserDao.USER_ID,Types.VARCHAR,SqlUtis.EQ));
		int count = this.userDao.update(map);
		map.remove(SqlUtis.WHERE_SQL);
		return count;
	}
	
	@Transactional
	public int delete(Map map) {
		if (authDao.isAdmin((String)map.get(UserDao.USER_ID))) {
			throw new BusinessException("超级用户不能删除");
		}
		try {
			SqlUtis.prepareSql(map,SqlUtis.getSQLRequired(map,UserDao.USER_ID,Types.VARCHAR)
			);
			//删除用户角色
			this.userDao.deleteRoleUser(map);
			//删除用户
			int result = this.userDao.delete(map);
			map.remove(SqlUtis.WHERE_SQL);

			//清空缓存
			//this.authService.clearCache();
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			throw new BusinessException("更新失败:" + e.getMessage(), e);
		}
	}
	
	
	/**
	 * 查询一个对象
	 * @param map
	 * @return
	 */
	public Object one(Map map) {
		SqlUtis.prepareSql(map, SqlUtis.getSQLRequired(map, "a." +UserDao.USER_ID, Types.VARCHAR, SqlUtis.EQ));
		Object obj = this.userDao.one(map);
		map.remove(SqlUtis.WHERE_SQL);
		return obj;
	}
	
	
	/**
	 * 分页查询结果集合
	 * @param map
	 * @param page
	 * @return
	 */
	public List list(Map map, Page page,SysSessionUser sysSessionUser) {
		// 管理员可以看全部，非管理员只可以看本部门和子部门
	/*	if (!authDao.isAdmin(sysSessionUser.getUserId())) {
		      map.put("JOIN_SQL",
							"join (select dept_id,name from s_dept start with dept_id ='"
									+ sysSessionUser.getDeptId()
									+ "' connect by prior dept_id = parent_id) authdept on (a.dept_id = authdept.dept_id)");
		}*/
		SqlUtis.prepareSql(map,
				SqlUtis.getSQL(map,"a."+ UserDao.LOGIN_ID, Types.VARCHAR),
				SqlUtis.getSQL(map,"a." + UserDao.NAME, Types.VARCHAR),
				SqlUtis.getSQL(map, "a." + UserDao.PSW, Types.VARCHAR),
				SqlUtis.getSQL(map, "a." + UserDao.TYPE_ID, Types.VARCHAR)
				,SqlUtis.orderBy("a."+UserDao.CREATED_DATE)
				
				);
		List list = this.userDao.list(map, page);
		map.remove(SqlUtis.WHERE_SQL);
		return list;
	}
	
	
	
	
	
	
	/**
	 * 用户密码修改
	 * @param map
	 * @return
	 */
	public String changePsw(Map  map){
		String  msg="用户密码修改成功！";
		Map  userMap = (Map)this.one(map);
		if(userMap== null||userMap.isEmpty()){
			msg="用户不存在";
		}else{
			String encryPsw = com.ssi.framework.utils.EncryptUtil.SHA((String)map.get(UserDao.PSW));
			if(!encryPsw.equals(userMap.get(UserDao.PSW))){
				msg="原始密码输入错误！";
			}else{
				String newpassword =ObjectUtils.toString(map.get("newpas"));
				String encryPs = com.ssi.framework.utils.EncryptUtil.SHA(newpassword);
				map.put(UserDao.PSW, encryPs);
			    int result = this.userDao.update(map);
				if(result !=1 ){
					msg="修改密码失败";
				}
			}
		}
		return msg;
	}
	
    public  boolean checkUnique(Map  map){
    	return this.userDao.checkUnique(map);
	}
	
	
	/**
	 * 用户登录
	 * @param map
	 * @param request
	 * @return
	 */
	public  Map  Login(Map  map,HttpServletRequest request){
		Map resultMap=new  HashMap();
		resultMap.put("URL", "/login.jsp");
		if(map.get(UserDao.LOGIN_ID) == null ||map.get(UserDao.PSW)==null){
			resultMap.put("MSG", "请输入用户名或密码 ");
			return resultMap;
		}
		SqlUtis.prepareSql(map,SqlUtis.getSQL(map,"a."+UserDao.LOGIN_ID,Types.VARCHAR));
		Map  userMap= (Map) this.userDao.one(map);
		
		if(userMap== null||userMap.isEmpty()){
			resultMap.put("MSG", "不存在用户 "+map.get(UserDao.LOGIN_ID));
			return resultMap;
		}
		if(!authDao.isAdmin(ObjectUtils.toString(userMap.get("USER_ID")))){
		String  check_start=ObjectUtils.toString(userMap.get("CHECK_START"));
		if(!"1".equals(check_start)){
			resultMap.put("MSG", "用户 "+map.get(UserDao.LOGIN_ID+"")+"还未生效！");
			return resultMap;
		}
		String  check_end=ObjectUtils.toString(userMap.get("CHECK_END"));		
	    if(!"1".equals(check_end)){
			resultMap.put("MSG", "用户 "+map.get(UserDao.LOGIN_ID+"")+"已经失效！");
			return resultMap;
		}}
		
		String encryPsw = com.ssi.framework.utils.EncryptUtil.SHA((String)map.get(UserDao.PSW));
		if(!encryPsw.equals(userMap.get(UserDao.PSW))){
			resultMap.put("MSG", "密码不正确 ");
			return resultMap;
		}
		
		SysSessionUser sessionUser = new SysSessionUser();
		Map<String, Object> attributes = new HashMap<String, Object>();
		sessionUser.setAttributes(userMap);
		sessionUser.setAttribute(LoginLogDao.IP, this.getIp(request));
		sessionUser.setAttribute(LoginLogDao.BROWSER, this.getBrowser(request));
		HttpSession session=request.getSession();
		session.setAttribute(SysSessionUser.SESSION_KEY, sessionUser);
		String main_page=this.dictDao.getSysParam("MAIN_PAGE");	
		//查询菜单
		
		
		
	     List<Map> resultList=this.authDao.list(null);
		  resultList = TreeUtils.tree(resultList, authDao.PARENT_ID,authDao.AUTH_ID);// 父子树形结构
		  resultMap.put("resultList", resultList);
		resultMap.put("URL", "/system/admin/index.jsp");
	   // resultMap.put("URL", "!"+main_page);
		return resultMap;
		
	}
	

	
	
	
	
	
	/**
	 * 获取IP地址
	 * @param request
	 * @return
	 */
	private String getIp(HttpServletRequest request){
		String ip = request.getHeader("x-forwarded-for");  
	    if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
	        ip = request.getHeader("Proxy-Client-IP");  
	    }  
	    if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
	        ip = request.getHeader("WL-Proxy-Client-IP");  
	    }  
	    if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
	        ip = request.getRemoteAddr();  
	    }  
	    return ip;
	}
	/**
	 * 获取浏览器版本
	 * @param request
	 * @return
	 */
	private String getBrowser(HttpServletRequest request){
		String agent = request.getHeader("USER-AGENT");//
		String userbrowser ="";
		StringTokenizer st = null;
		//IE
		if (null != agent && -1 != agent.indexOf("MSIE")){
			st = new StringTokenizer(agent,";");
			st.nextToken();
			userbrowser += st.nextToken();
		}else{
			//谷歌Chrome
			if (null != agent && -1 != agent.indexOf("Chrome"))
				userbrowser = "Chrome";
			//苹果Safari
			else if(null != agent && -1 != agent.indexOf("Safari"))
				userbrowser = "Safari";
			//火狐Firefox
			else if(null != agent && -1 != agent.indexOf("Firefox"))
				userbrowser = "Firefox";
			//Opera
			else if(null != agent && -1 != agent.indexOf("Opera"))
				userbrowser = "Opera";
			else{
				userbrowser ="unknow";
			}
		}
		return userbrowser.trim();
	}
	
	
	
	
	
}
