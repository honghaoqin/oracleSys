package com.ssi.sys.tags;

import java.io.IOException;

import javax.servlet.jsp.JspException;

import org.apache.commons.lang.StringUtils;

import com.ssi.sys.dao.DictDao;
/**
 * 
 * 系统参数
 * @author Administrator
 *
 */
public class ParamTag extends DictTag {
	private String def="";//默认值
	
	@Override
	public String getType() {
		return DictDao.SYSPARAM;
	}
	
	@Override
	public int doStartTag() throws JspException {
		String text = this.getText();
		
		if (StringUtils.isBlank(text)) {
			text = def==null?"":def;
		}
		try {
			this.pageContext.getOut().write(text);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return SKIP_BODY;
	}

	public String getDef() {
		return def;
	}

	public void setDef(String def) {
		this.def = def;
	}

}
