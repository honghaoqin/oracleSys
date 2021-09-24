package com.ssi.sys.tags;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.commons.lang.StringUtils;

import com.ssi.framework.utils.TreeUtils;

public class TreeTag extends TagSupport {

	private String value;
	private String scope = "request";

	private String parentKey;
	private String idKey;

	private String valueKey;
	private String textKey;
	private String checkedKey;
	private int type;

	private String width;
	private String height;
	private boolean body;//仅仅输出数的body
	
	private String urlKey;
	private String targetKey;
	private String target;

	@Override
	public int doStartTag() throws JspException {
		List resultList = null;
		if ("page".equalsIgnoreCase(this.scope)) {
			resultList = (List) this.pageContext.getAttribute(value);
		} else if ("request".equalsIgnoreCase(this.scope)) {
			resultList = (List) this.pageContext.getRequest().getAttribute(value);
		} else if ("session".equalsIgnoreCase(this.scope)) {
			resultList = (List) ((HttpServletRequest) this.pageContext.getRequest()).getAttribute(value);
		} else {
			// TODO
		}
		if (resultList == null || resultList.isEmpty()) {
			return SKIP_BODY;
		}
		JspWriter writer = this.pageContext.getOut();
		String ctx = ((HttpServletRequest)this.pageContext.getRequest()).getContextPath();
		try {
			if(body){
				writer.write(TreeUtils.getTreeHTML(TreeUtils.tree(resultList, parentKey, idKey), 
						valueKey, textKey, checkedKey ,type,urlKey,targetKey,target,ctx,1).toString());
			}else{
				if (StringUtils.isBlank(width)) {
					width = "300px";
				}
				if (StringUtils.isBlank(height)) {
					height = "500px";
				}
				writer.write("<DIV style=\"WIDTH: " + width + "; HEIGHT: " + height + "; OVERFLOW: auto\" class=\"treeview\">");
	
				writer.write(TreeUtils.getTreeHTML(TreeUtils.tree(resultList, parentKey, idKey), 
						valueKey, textKey, checkedKey ,type,urlKey,targetKey,target,ctx,1).toString());
				
				writer.write("</DIV>");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SKIP_BODY;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public String getScope() {
		return scope;
	}

	public void setScope(String scope) {
		this.scope = scope;
	}

	public String getParentKey() {
		return parentKey;
	}

	public void setParentKey(String parentKey) {
		this.parentKey = parentKey;
	}

	public String getIdKey() {
		return idKey;
	}

	public void setIdKey(String idKey) {
		this.idKey = idKey;
	}

	public String getValueKey() {
		return valueKey;
	}

	public void setValueKey(String valueKey) {
		this.valueKey = valueKey;
	}

	public String getTextKey() {
		return textKey;
	}

	public void setTextKey(String textKey) {
		this.textKey = textKey;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public String getWidth() {
		return width;
	}

	public void setWidth(String width) {
		this.width = width;
	}

	public String getHeight() {
		return height;
	}

	public void setHeight(String height) {
		this.height = height;
	}

	public String getCheckedKey() {
		return checkedKey;
	}

	public void setCheckedKey(String checkedKey) {
		this.checkedKey = checkedKey;
	}

	public boolean isBody() {
		return body;
	}

	public void setBody(boolean body) {
		this.body = body;
	}

	public String getUrlKey() {
		return urlKey;
	}

	public void setUrlKey(String urlKey) {
		this.urlKey = urlKey;
	}

	public String getTargetKey() {
		return targetKey;
	}

	public void setTargetKey(String targetKey) {
		this.targetKey = targetKey;
	}

	public String getTarget() {
		return target;
	}

	public void setTarget(String target) {
		this.target = target;
	}


}
