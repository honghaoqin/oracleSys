package com.ssi.sys.action;

import java.sql.Types;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import com.ssi.framework.utils.SqlUtis;
import com.ssi.sys.service.FileService;

public class FileAction extends com.ssi.sys.action.SysBaseAction {

	@Autowired
	FileService fileService;
	
	/**
	 * 采用单个对象下载文件。
	 * @path /sys/File/downLoad.do?formMap.ID= 
	 * @return
	 */
	public String downLoad() {
		try {
			Map map = (Map)this.fileService.one(formMap);
			if (null != map && !map.isEmpty()) {
				this.fileService.downLoad(request, response, map);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return null;
	}
	
}
