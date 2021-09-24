package com.ssi.sys.action;

import org.springframework.beans.factory.annotation.Autowired;

import com.ssi.sys.service.ExcelDownService;

/**
 * 导出excel功能.
 * formMap必须有:
 * -- formMap.templateName 模板名称,不带后缀.xls
 * 可选 :
 * -- formMap.SQL 用于查询数据
 * -- formMap.fileName 下载的文件名,不带后缀.xls, 不给的话,默认是模板的名称
 * -- formMap.startNum 开始填充数据的行, 不给的话,默认是2
 * 
 * @author 谢霆子
 * @date   2013-2-14
 */
public class ExcelDownAction extends com.ssi.sys.action.SysBaseAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@Autowired
	ExcelDownService excelDownService;
	
	/**
	 * 下载excel文件
	 * 
	 * @return
	 */
	public String printExcel(){
		this.excelDownService.expDownExcel(request, response, formMap,resultList);
		return null;
	}
}
