package com.ssi.sys.tags;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;
import org.apache.commons.lang.ObjectUtils;
import org.apache.commons.lang.StringUtils;
import com.ssi.framework.spring.SpringUtils;
import com.ssi.framework.utils.SqlUtis;
import com.ssi.sys.dao.AuthDao;
import com.ssi.sys.dao.DeptDao;
import com.ssi.sys.dao.ListboxDao;
import com.ssi.sys.model.SysSessionUser;
import com.ssi.util.Constants;
public class ListboxTag extends TagSupport {
	static DeptDao deptDao = SpringUtils.getBean(DeptDao.class);
	static AuthDao authDao = SpringUtils.getBean(AuthDao.class);
	static ListboxDao listboxDao = SpringUtils.getBean(ListboxDao.class);
	private String value;
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	private String id;//值
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	private String options;
	
	private String noParam;
	public String getNoParam() {
		return noParam;
	}
	public void setNoParam(String noParam) {
		this.noParam = noParam;
	}
	public String getOptions() {
		return options;
	}
	public void setOptions(String options) {
		this.options = options;
	}
	@Override
	public int doStartTag() throws JspException {
		HttpServletRequest request = (HttpServletRequest) this.pageContext.getRequest();
		SysSessionUser sessionUser = (SysSessionUser) request.getSession().getAttribute(SysSessionUser.SESSION_KEY);
		if (sessionUser==null) {
			return SKIP_PAGE;
		}
		try{
			JspWriter writer = this.pageContext.getOut();
//			var zbly = [
//			        	{ code: "1", detail: "下拨",spell:"XB" },
//			        	{ code: "2", detail: "自购",spell:"ZG" },
//			        	{ code: "3", detail: "调拨",spell:"DB" },
//			        	{ code: "4", detail: "回收",spell:"HSS" }
//			        ];
		
//			$(document).ready(function(){
//				 $("#aaaa").jqautocomplete(dept);
//			});		
		
			writer.write("<script type='text/javascript'>");
			writer.write("var "+this.getId()+"_urlOrData = [");
			
			if("dept".equalsIgnoreCase(this.value)){//所有部门
				Map formMap = new HashMap();
				List<Map> deptList = deptDao.list(formMap);
				if(deptList!=null && !deptList.isEmpty()){
					int i=0;
					for (Map row : deptList) {
						writer.write("{ code:\""+ObjectUtils.toString(row.get(DeptDao.DEPT_ID),"").trim()
								+"\", detail:\""+ObjectUtils.toString(row.get(DeptDao.NAME),"").trim()
								+"\""+", spell:\""+ObjectUtils.toString(row.get(DeptDao.SPELL),"").trim()+"\"}");
						if(i!=deptList.size()-1){
							writer.write(",");
						}
						writer.write(" \n");
						i++;
					}
				}
			}else if("deptAuth".equalsIgnoreCase(this.value)){//有权限的部门
				Map formMap = new HashMap();
				if(authDao.isAdmin(sessionUser.getUserId())){
				}else{
				//	SqlUtis.prepareSql(formMap, " start with a.dept_id='"+sessionUser.getDeptId()+"' connect by prior a.dept_id = a.parent_id ");
				}
				List<Map> deptList = deptDao.list(formMap);
				if(deptList!=null && !deptList.isEmpty()){
					int i=0;
					for (Map row : deptList) {
						writer.write("{ code:\""+ObjectUtils.toString(row.get(DeptDao.DEPT_ID),"").trim()
								+"\", detail:\""+ObjectUtils.toString(row.get(DeptDao.NAME),"").trim()+"\""
								+", spell:\""+ObjectUtils.toString(row.get(DeptDao.SPELL),"").trim()+"\"}");
						if(i!=deptList.size()-1){
							writer.write(",");
						}
						writer.write(" \n");
						i++;
					}
				}
			}else if("branchAuth".equalsIgnoreCase(this.value)){//有权限的部门
				Map formMap = new HashMap();
				if(authDao.isAdmin(sessionUser.getUserId())){
				}else{
				//	SqlUtis.prepareSql(formMap, " start with a.dept_id='"+sessionUser.getDeptId()+"' connect by prior a.dept_id = a.parent_id ");
				}
				SqlUtis.prepareSql(formMap, " and  a.type_ID= '"+Constants.BRANCH+"'");
				
				List<Map> deptList = deptDao.list(formMap);
				if(deptList!=null && !deptList.isEmpty()){
					int i=0;
					for (Map row : deptList) {
						writer.write("{ code:\""+ObjectUtils.toString(row.get(DeptDao.DEPT_ID),"").trim()
								+"\", detail:\""+ObjectUtils.toString(row.get(DeptDao.NAME),"").trim()+"\""
								+", spell:\""+ObjectUtils.toString(row.get(DeptDao.SPELL),"").trim()+"\"}");
						if(i!=deptList.size()-1){
							writer.write(",");
						}
						writer.write(" \n");
						i++;
					}
				}
			}else if("auth".equalsIgnoreCase(this.value)){//所有权限
				List<Map> authList = authDao.list(null);
				if(authList!=null && !authList.isEmpty()){
					int i=0;
					for (Map row : authList) {
						writer.write("{ code:\""+ObjectUtils.toString(row.get(AuthDao.AUTH_ID),"").trim()
								      +"\", detail:\""+ObjectUtils.toString(row.get(AuthDao.NAME),"").trim()+"\""+", spell:\"\"}");
						if(i!=authList.size()-1){
							writer.write(",");
						}
						writer.write(" \n");
						i++;
					}
				}
			}
			
			
			writer.write("];");
			
			writer.write("$(document).ready(function(){");
			if (StringUtils.isBlank(options)) {
				writer.write("$(\"#"+this.getId()+"\").jqautocomplete("+this.getId()+"_urlOrData);");
			}else{
				writer.write("$(\"#"+this.getId()+"\").jqautocomplete("+this.getId()+"_urlOrData).setOptions("+options+");");
			}
			writer.write("});");
			
			writer.write("</script>");
		}catch (Exception e) {
			e.printStackTrace();
		}
		return SKIP_BODY;
	}
}
