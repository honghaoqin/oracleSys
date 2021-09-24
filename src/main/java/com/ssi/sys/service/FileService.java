/*---------代码生成请勿手工修改---------*/
package com.ssi.sys.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.sql.Types;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang.ObjectUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ssi.framework.service.BaseService;
import com.ssi.framework.spring.SpringUtils;
import com.ssi.framework.utils.SqlUtis;
import com.ssi.sys.dao.DictDao;
import com.ssi.sys.dao.FileDao;
/**
 * 上传文件工具类
 */
@Service
public class FileService extends BaseService{
	@Autowired
	DictDao dictDao;
	@Autowired
	FileDao fileDao;
	
	
	/**
	 * 查询一个对象
	 * @param map
	 * @return
	 */
	public Object one(Map map) {
		SqlUtis.prepareSql(map, SqlUtis.getSQLRequired(map,"a."+FileDao.ID,Types.VARCHAR,SqlUtis.EQ));
		Object obj = this.fileDao.one(map);
		map.remove(SqlUtis.WHERE_SQL);
		return obj;
	}
	/**
	 * 上传附件.
	 * 必须条件:
	 * 1:字典表配置:FILE_ROOT 
	 * 2:formMap.APPCODE  -- 项目编码
	 * 3:formMap.MODULECODE  -- 模块编码
	 * 4:formMap.OBJ_ID  -- 实体编号
	 * 5:formMap.USER_ID  -- 上传人||创建人
	 * @param formMap
	 */
	@Transactional
	public void  upload(Map formMap,String  filePath,String filePathFileName ){
		if(null!=filePath&&!"".equals(filePath)){
			String objId = ObjectUtils.toString(formMap.get("OBJ_ID")).trim();
			String userId = ObjectUtils.toString(formMap.get("USER_ID")).trim();
			String appcode = ObjectUtils.toString(formMap.get("APPCODE")).trim();
			String modulecode = ObjectUtils.toString(formMap.get("MODULECODE")).trim();
			String pid = ObjectUtils.toString(formMap.get("P_ID")).trim();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
			String tempdir= new SimpleDateFormat("yyyyMMdd").format(new Date());
			String fileroot = this.dictDao.getSysParam("FILE_ROOT");
			String[] filePathArr=filePath.split(",");
			if(null!=filePathArr&&filePathArr.length>0){
				  String[] filePathFileNameArr=filePathFileName.split(",");	
	               for(int i=0;i<filePathArr.length;i++){
						File  file=new  File(filePathArr[i]);
						String  fileName=filePathFileNameArr[i];
						String filetype = FilenameUtils.getExtension(fileName);
					     if(file.isFile()){
					    	 String  id=fileDao.UUID();
					         String  name=id+"."+filetype;
							 String newfilePath="/"+appcode+"/"+modulecode+"/"+name;
							 File destFile =new File(fileroot+newfilePath); //new File(fileroot+newfilePath, name);
							   	try {
							   		long fileSize = (file.length())/1024;//获取当前文件的大小,单位为KB
									FileUtils.copyFile(file, destFile);
									Map map = new HashMap();
									map.put("ID", id);
									map.put("APPCODE", appcode);
									map.put("MODULECODE", modulecode);
									map.put("P_ID",pid);
									map.put("OBJ_ID", objId);
									map.put("FILEPATH", newfilePath);
									map.put("FILENAME", fileName);
									map.put("FILESIZE", fileSize);
									map.put("FILETYPE", filetype);
									map.put("UPLOADTYPE", "1");
									map.put("STATUS", "0");
									map.put("ISCONVERT", "0");
									map.put("VERSION", "1");
									map.put("CREATE_BY", userId);
									map.put("FTP_PATH","");
									this.fileDao.insert(map);
									
								} catch (IOException e) {
									// TODO Auto-generated catch block
									e.printStackTrace();
								}
						}
					}
				}
		}
	}
	@Transactional
	public  void  delete(Map formMap){
		SqlUtis.prepareSql(formMap,SqlUtis.getSQLRequired(formMap, "a.ID", Types.VARCHAR, SqlUtis.EQ));
		Map  map=(Map)this.fileDao.one(formMap);
		if(null!=map&&!map.isEmpty()){
			String filepath=ObjectUtils.toString(map.get("FILEPATH"));
			String fileroot = this.dictDao.getSysParam("FILE_ROOT");
			FileUtils.deleteQuietly(new File(fileroot+filepath));
		    this.fileDao.delete(formMap);
		}
		formMap.remove(SqlUtis.WHERE_SQL);
		
	}
	
	/**
	 * 文件下载
	 * @param request
	 * @param response
	 * @param formMap
	 */
	public void downLoad(HttpServletRequest request,HttpServletResponse response,Map formMap) {
		String fileRoot = SpringUtils.getBean(DictDao.class)
				.getSysParam("FILE_ROOT");
		String path = (fileRoot + ObjectUtils.toString(formMap
				.get("FILEPATH"))).replace("/", "\\\\");
		String fileName = ObjectUtils.toString(formMap.get("FILENAME"));
		// path是指欲下载的文件的路径。
		File file = new File(path);
		if(file.isFile()){
		try {
			formMap.put("filename", new String(fileName.getBytes("UTF-8"), "ISO8859-1"));
		} catch (UnsupportedEncodingException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}	
		
		ServletOutputStream output = null;
		FileInputStream in = null;
		String filename = file.getName();
		String name = ObjectUtils.toString(formMap.get("filename"));
		if("".equals(name.trim())){
			name = request.getParameter("filename");
			name = ObjectUtils.toString(name);
		}
		if(!"".equals(name.trim())){
			filename = name;
		}
		try {
			filename = new String( filename.getBytes("UTF-8"), "ISO8859-1");
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}
		// 定义下载的文件字符集,以及当前页面为下载页面
		try {
		    response.setContentType("application/x-download; charset=UTF-8");
		    // 设置报头信息,定义下载的文件的保存文件名为fileName
		    response.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\"");
		    /** *************************************需要设置以下的头信息,否则IE6会下载不了的。*************************************** */
		    response.setHeader("Expires", new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date()));
		    response.setHeader("Pragma", "public");
		    response.setHeader("Cache-Control", "must-revalidate,post-check=0,pre-check=0");
		    /** *************************************end*************************************** */
		    output = response.getOutputStream();
		    in = new FileInputStream(file);
		    if (in != null) {
			byte[] buff = new byte[2048];
			int len = -1;
			// 从in中读取二进制流
			while ((len = in.read(buff)) > 0) {
			    // 将读取的二进制流放入output 输出流对象中去
			    output.write(buff, 0, len);
			    output.flush();
			}
			// 写完,就输出以供下载
			output.flush();
		    }
		} catch (IOException e) {
		    e.printStackTrace();
		    throw new RuntimeException("下载出错!" + e);
		} finally {
		    closeServletOutputStream(output);
		    closeFileInputStream(in);
		    String deleteFlag = ObjectUtils.toString(formMap.get("deleteFlag"));
		    if("y".equalsIgnoreCase(deleteFlag)){
		    	file.delete();
		    }
		}}
    }
	/**
	 * @param sos
	 */
	private static void closeServletOutputStream(ServletOutputStream sos) {
		if (sos != null) {
		    try {
		    	sos.close();
		    } catch (IOException e) {
				e.printStackTrace();
		    }
		    sos = null;
		}
    }
	/**
	 * @param fis
	 */
  private static void closeFileInputStream(FileInputStream fis) {
		if (fis != null) {
		    try {
		    	fis.close();
		    } catch (IOException e) {
		    	e.printStackTrace();
		    }
		    fis = null;
		}
    }
	
	
	
	
	
}
