package com.ssi.sys.tags;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.ssi.sys.dao.DictDao;

/**
 * 字典下拉列表SQL
 * @author yuan
 *
 */
public class SelectSqlTag extends SelectTag {
	
	private String sql;
	private boolean dict=true;//是否从字典表获取
	@Override
	public String getType() {
		return DictDao.SQL;
	}
	
	@Override
	protected List<Map> getList() {
		String ftl = this.getText();
		String sqlstr = this.parseSql(ftl);
		List<Map> results = this.dictDao.listBySql(sqlstr);
		return results;
	}
	
	@Override
	protected String getText() {
		if(!isDict()){//不从字典表获取
			return this.getSql();//返回输入的sql
		}
		if (StringUtils.isBlank(getType())) {
			return null;
		}
		return getText(getType(),getSql());
	}
	
	protected String parseSql(String ftl) {
		return ftl;//TODO 解析ftl
	}

	public String getSql() {
		return sql;
	}

	public void setSql(String sql) {
		this.sql = sql;
	}

	public boolean isDict() {
		return dict;
	}

	public void setDict(boolean dict) {
		this.dict = dict;
	}
	
	
}
