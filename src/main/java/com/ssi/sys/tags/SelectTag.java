package com.ssi.sys.tags;

import java.io.IOException;
import java.sql.Types;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;

import org.apache.commons.lang.ArrayUtils;
import org.apache.commons.lang.ObjectUtils;
import org.apache.commons.lang.StringUtils;

import com.ssi.framework.spring.SpringUtils;
import com.ssi.framework.utils.SqlUtis;
import com.ssi.sys.dao.AuthDao;
import com.ssi.sys.dao.DictDao;
import com.ssi.sys.model.SysSessionUser;

/**
 * 字典下拉列表
 * @author yuan
 *
 */
public class SelectTag extends DictTag {
	static AuthDao authDao = SpringUtils.getBean(AuthDao.class);
	//是否多选
	private boolean multiple = false;
	public boolean isMultiple() {
		return multiple;
	}

	public void setMultiple(boolean multiple) {
		this.multiple = multiple;
	}
	//是否从字典取值
    private boolean flag= false;
    public boolean isFlag() {
		return flag;
	}
    public void setFlag(boolean flag) {
		this.flag = flag;
	}
    //是否取选择的value
    private boolean fv= false;
    public boolean isFv() {
		return fv;
	}

	public void setFv(boolean fv) {
		this.fv = fv;
	}

	@Override
	public int doStartTag() throws JspException {
		String  getValue=ObjectUtils.toString(this.getValue(),"").trim();	
		if (StringUtils.isBlank(this.getType())) {
			return SKIP_BODY;
		}
		List<Map> list = this.getList();
		if (list==null || list.isEmpty()) {
			return SKIP_BODY;
		}
		
		String[] values = null;
		if (multiple) {//多选
	  		if(StringUtils.isNotBlank(getValue)){
	  			values=StringUtils.split(getValue, ",");
	  		}
		}
		for (Map dict : list) {
			if (dict == null || dict.isEmpty()) {
				continue;
			}
			String v = ObjectUtils.toString(dict.get(DictDao.VALUE),"").trim();
			String t = ObjectUtils.toString(dict.get(DictDao.TEXT),"").trim();
		
			String selected="";
			if (multiple) {//多选
		  		if (values!=null && values.length>0 && ArrayUtils.contains(values, v)) {
		  			selected = "selected";
				}
			}else if (getValue.equals(v)) {//单选
				selected = "selected";
			}
			try {
				if(fv){
				if(selected.equals("selected")){
				this.pageContext.getOut().write(t);	
				}else{
					this.pageContext.getOut().write("");		
				}	
				}else{
				this.pageContext.getOut().write("<option "+selected+"  value="+v+">"+t+"</option>");	
				}
				
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return SKIP_BODY;
	}
	/**
	 * 
	 * @return
	 */
	protected List<Map> getList(){
		List<Map> list =null;
		//是否从字典取值
		if(flag){
			HttpServletRequest request = (HttpServletRequest) this.pageContext.getRequest();
			SysSessionUser sessionUser = (SysSessionUser) request.getSession().getAttribute(SysSessionUser.SESSION_KEY);
			 if("provinceAuth".equalsIgnoreCase(this.getType())){//有权限的省
					String  sql=" select  province_id value ,name  text from  s_province  ";
					list=this.authDao.listBySql(sql);	
			}else if("cityAuth".equals(this.getType())){//有权限的市
				String  sql=" select  city_id value ,name  text from  s_city ";
				list=this.authDao.listBySql(sql);	
			}else if("city".equals(this.getType())){//所有的市
				String  sql=" select  city_id value ,name  text from  s_city  ";
				list=this.authDao.listBySql(sql);	
			}
		}else{
			Map map = new HashMap();
			map.put(DictDao.TYPE, getType());
			SqlUtis.prepareSql(map, ""
					,SqlUtis.getSQL(map,"a."+DictDao.TYPE,Types.VARCHAR)
					,SqlUtis.orderBy(DictDao.SORT)
					);
			 list = dictDao.list(map);//TODO 缓存	
		}
		return list;
	}
}
