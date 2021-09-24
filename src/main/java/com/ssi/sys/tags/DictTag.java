package com.ssi.sys.tags;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.commons.lang.StringUtils;

import com.ssi.framework.spring.SpringUtils;
import com.ssi.sys.dao.DictDao;

/**
 * 获取字典的文本
 * @author yuan
 *
 */
public class DictTag extends TagSupport {
	
	private String type;
	private String value;
	static DictDao dictDao = SpringUtils.getBean(DictDao.class);
	
	@Override
	public int doStartTag() throws JspException {
		String text = this.getText();
		if (StringUtils.isBlank(text)) {
			text = value==null?"":value;
		}
		try {
			this.pageContext.getOut().write(text);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return SKIP_BODY;
	}
	public static String getText(String type,String value){
		return dictDao.getText(type,value);
	}
	/**
	 * 获取字典的文本
	 * @return
	 */
	protected String getText() {
		if (StringUtils.isBlank(getType())) {
			return null;
		}
		if(StringUtils.isBlank(getValue())){
			return getValue();
		}
		
		return getText(getType(), getValue());
	}

	public String getType() {
		return type;
	}


	public void setType(String type) {
		this.type = type;
	}


	public String getValue() {
		return value;
	}


	public void setValue(String value) {
		this.value = value;
	}
	
	
}
