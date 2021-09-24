package com.ssi.util;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.ObjectUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.ssi.sys.model.SysSessionUser;
public class SessionDataUtil {

	private static final  Log logger = LogFactory.getLog(SessionDataUtil.class);
    /**
     * 
     * Description:从 Session获取登陆信息 <br>
     * @param request
     * @return
     */

	public static Map getLoginInfoFromSession(HttpServletRequest request) {
		if(null!=request.getSession().getAttribute(SysSessionUser.SESSION_KEY)){
			SysSessionUser sessionUser=(SysSessionUser)request.getSession().getAttribute(SysSessionUser.SESSION_KEY);
			if(null!=sessionUser.getAttributes()){
				return  sessionUser.getAttributes();	
			}
		}
		return  null;
	}
	/**
	 * 
	 * Description:获取userId <br>
	 * @param request
	 * @return
	 */
	public static String getUserIdFromSession(HttpServletRequest request) {
	  if(null!=getLoginInfoFromSession(request)&&!getLoginInfoFromSession(request).isEmpty()){
		  return ObjectUtils.toString(getLoginInfoFromSession(request).get("USER_ID")); 
	  }
	  return "";
		}

	/**
	 * 
	 * Description: 获取用户userName<br>
	 * @param request
	 * @return
	 */
	public static String getUserNameFromSession(HttpServletRequest request) {
      if(null!=getLoginInfoFromSession(request)&&!getLoginInfoFromSession(request).isEmpty()){
		  return ObjectUtils.toString(getLoginInfoFromSession(request).get("NAME")); 
	  }
	  return "";
	}

	
	
	
	

}
