package com.ssi.util;

import javax.servlet.http.*;
import java.util.*;
/**
 * 保证一个用户只使用一个系统的，后面登录的踢掉前面的登录的
 * 逻辑：每次登录的时候，删除用户的session信息(踢掉以前的)，再把本此登录的session保存起来
 * 
 * @author xietz
 * @date   2012-9-28
 *
 */
public class SessionLoginListener implements HttpSessionListener {
	
	/**
	 * hasUser :
	 * 	保存登录的用户id和session的对应关系。key:user_id ,value:这次登录的session对象
	 *  每次登录的时候，通过hasUser.get(user_id)找session,然后删除用户session信息，踢掉以前的，再把本地登录的session保存起来 
	 */
	@SuppressWarnings("unchecked")
	private static java.util.Hashtable hasUser = new Hashtable();

	public void sessionCreated(HttpSessionEvent se) {
	}

	public void sessionDestroyed(HttpSessionEvent se) {
		hasUser.remove(se.getSession());
	}

	@SuppressWarnings("unchecked")
	public synchronized static boolean kickoff(HttpSession session,String user_id) {
		if (hasUser.containsKey(user_id)) {
			HttpSession vsession = (HttpSession) hasUser.get(user_id);
			try {
				vsession.invalidate();// 踢掉以前的的此user_id的session
			} catch (Exception ex) {
			}
		} else {
		}
		hasUser.remove(user_id);//删除先前的session
		hasUser.put(user_id, session);//保存本次最新的登录的session
		return true;
	}
}