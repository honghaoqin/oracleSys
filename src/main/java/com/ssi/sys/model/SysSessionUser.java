package com.ssi.sys.model;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpSessionBindingEvent;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import com.ssi.framework.bean.SessionUser;
import com.ssi.framework.spring.SpringUtils;
import com.ssi.sys.dao.LoginLogDao;
import com.ssi.sys.dao.UserDao;
public class SysSessionUser extends SessionUser{
	
	
	private final Log LOG = LogFactory.getLog(getClass());
	
	@Override
	protected void afterLogin(HttpSessionBindingEvent event) {
		// 设置session超时时间(秒)
		//event.getSession().setMaxInactiveInterval();
		try {
			LoginLogDao loginLogDao = SpringUtils.getBean(LoginLogDao.class);
			Map map = new HashMap();
			map.put(LoginLogDao.SESSION_ID, event.getSession().getId());
			map.put(LoginLogDao.USER_ID, this.getUserId());
			map.put(LoginLogDao.USER_NAME, this.getName());
			map.put(LoginLogDao.IP, this.getIp());
			map.put(LoginLogDao.BROWSER, this.getBrowser());
			map.put(LoginLogDao.LOGIN_TIME,new Timestamp(System.currentTimeMillis()));
			loginLogDao.insert(map);
		} catch (Exception e) {
			LOG.warn(e.getMessage());
			e.printStackTrace();
		}
		LOG.debug("+++++++++++++++++++++++++++++++++++++++++ 登录系统 ");
	}
	
	@Override
	protected void afterLogout(HttpSessionBindingEvent event) {
		try {
			//记录退出日志
			LoginLogDao loginLogDao = SpringUtils.getBean(LoginLogDao.class);
			Map map = new HashMap();
			map.put(LoginLogDao.SESSION_ID, event.getSession().getId());
			loginLogDao.update(loginLogDao.getNamespace()+".updateLogout",map);
		} catch (Exception e) {
		}
		LOG.debug("+++++++++++++++++++++++++++++++++++++++++ 退出系统 ");
	}
	
	public String getUserId(){
		return (String) this.getAttribute(UserDao.USER_ID);
	}
	public String getName(){
		return (String) this.getAttribute(UserDao.NAME);
	}
	public String getPsw(){
		return (String) this.getAttribute(UserDao.PSW);
	}
	public String getZw(){
		return (String) this.getAttribute(UserDao.ZW);
	}

	public String getTypeId(){
		return (String) this.getAttribute(UserDao.TYPE_ID);
	}
	public String getIp(){
		return (String) this.getAttribute(LoginLogDao.IP);
	}
	public String getBrowser(){
		return (String) this.getAttribute(LoginLogDao.BROWSER);
	}
	public String getLoginId(){
		return (String) this.getAttribute(UserDao.LOGIN_ID);
	}
	public String getPageSize(){
		return this.getAttribute(UserDao.PAGE_SIZE).toString();
	}
	public String getStylesheet(){
		return (String) this.getAttribute(UserDao.STYLESHEET);
	}
	public String getDeptId(){
		return (String) this.getAttribute(UserDao.DEPT_ID);
	}
	public String getDeptName(){
		return (String) this.getAttribute("DEPT_NAME");
	}
	public String getCityId(){
		return (String) this.getAttribute("CITY_ID");
	}
	public String getAreaId(){
		return (String) this.getAttribute("AREA_ID");
	}
	public String getProvinceId(){
		return (String) this.getAttribute("PROVINCE_ID");
	}
	public String getOrgId(){
		return (String) this.getAttribute("ORG_ID");
	}
	public String getOrgName(){
		return (String) this.getAttribute("ORG_NAME");
	}
	
	
}
