/*---------代码生成请勿手工修改---------*/
package com.ssi.sys.dao;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.ssi.framework.dao.BaseDao;
import com.ssi.framework.exceptions.BusinessException;
import com.ssi.framework.utils.ZipUtils;

@Repository
public class BackupDao extends BaseDao{

	@Override
	public String getNamespace() {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Value("${jdbc.username}")
	String username;
	@Value("${jdbc.password}")
	String password;
	
	@Autowired
	DictDao dictDao;
	
	/**
	 * 点击数据备份(具体实现)
	 */
	public String beiFen(Map formMap) throws IOException, InterruptedException{
		//获取当前时间
		Date currentTime = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
		String dateString = formatter.format(currentTime);
		File backupDir = this.getBackupDir();
		String dmpFile = StringUtils.replace(backupDir.getAbsolutePath(), "\\", "/");
		if(dmpFile.endsWith("/")){
			dmpFile = dmpFile.substring(0,dmpFile.length()-1);
		}
		dmpFile += "/"+dateString+".dmp";
		String zipFile = dmpFile+".zip";
		String listener = this.dictDao.getSysParam("ORACLE_LISTENER");
		if(StringUtils.isEmpty(listener)){
			throw new BusinessException("请在字典维护设置系统参数 ORACLE_LISTENER");
		}
		if(StringUtils.isBlank(listener)){
			listener = "";
		}else{
			listener = "@"+listener;
		}
		String cmds= "exp "+username+"/"+password+listener+" owner="+username+" file=" + dmpFile;
		log.info("备份数据库命令: "+cmds);
        boolean error=false;
        StringBuffer msg=new StringBuffer();
        //执行oracle命令
        Process process = null;
        try {
        	process  =  Runtime.getRuntime().exec(cmds);
            InputStreamReader isr = new InputStreamReader(process.getErrorStream());
            BufferedReader br = new BufferedReader(isr);
            String line = null;
            while ((line = br.readLine()) != null){
            	msg.append(line).append("\r\n<br/>");
            	//这个出错的信息根据不同的oracle版本做相应的改动
                if((line.indexOf("error")!=-1)||(line.indexOf("错误")!=-1)){
//                	error=true;
                    //break;
                }
            }
        }
        catch (IOException ioe) {
        	log.error(ioe.getMessage());
        	ioe.printStackTrace();
        	msg.append("IO异常："+ioe.getMessage()).append("\r\n<br/>");
        	error=true;
        }
        log.info(msg.toString());
        formMap.put("MSG", msg.toString());
        formMap.put("ERROR", error);
        if(error){
            try{
            	process.destroy();
            }catch (Exception e) {
            	e.printStackTrace();
            }
            throw new BusinessException("请在字典维护设置系统参数 ORACLE_LISTENER");
        }else{
        	try{
            	process.destroy();
            }catch (Exception e) {
            	e.printStackTrace();
            }
        	formMap.put("dmpFile",zipFile);//压缩文件名
        	ZipUtils.zip(new File(dmpFile), new File(zipFile));//压缩文件
        	FileUtils.deleteQuietly(new File(dmpFile));//删除dmp文件
        }
        return "";
	}
	
	/**
	 * 
	 * @return 数据库备份的目录
	 */
	public File getBackupDir(){
		String fileRoot = this.dictDao.getSysParam("FILE_ROOT");
		if(StringUtils.isBlank(fileRoot)){
			throw new BusinessException("请在字典维护设置系统参数 FILE_ROOT");
		}
		File file = new File(fileRoot,"backup");
		if (!file.exists()) {
			file.mkdirs();
		}
		
		return file;
	}
	
}
