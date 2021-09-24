package com.ssi.sys.action;

import java.io.BufferedReader;
import java.io.File;
import java.io.FilenameFilter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Comparator;
import java.util.Date;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;

import com.ssi.framework.exceptions.BusinessException;
import com.ssi.framework.utils.ZipUtils;
import com.ssi.sys.dao.DictDao;

/**
 * 数据备份
 */
public class BackupAction extends com.ssi.sys.action.SysBaseAction {
	public static final String AUTH_LIST="S_BACKUP";
	
	protected final Log log = LogFactory.getLog(getClass());
	
	@Autowired
	DictDao dictDao;
	
	@Value("${jdbc.username}")
	String username;
	@Value("${jdbc.password}")
	String password;
	
	/**
	 * 点击菜单中的“数据备份”按钮实现跳转
	 */
	public String list() {
		this.checkAuth(AUTH_LIST);
		File backupDir = this.getBackupDir();
		File[] zips = backupDir.listFiles(new FilenameFilter() {
			public boolean accept(File dir, String name) {
				return name!=null && name.toLowerCase().endsWith(".zip");//只返回zip文件
			}
		});
		//排序
		Arrays.sort(zips, new Comparator<File>() {

			public int compare(File f1, File f2) {
				if(f1 ==null && f2 == null){
					return 0;
				}
				if(f1 == null){
					return -1;
				}
				if(f2 == null){
					return 1;
				}
				return f1.lastModified() >= f2.lastModified() ? -1:1;
			}
		});
		this.request.setAttribute("zips", zips);
		return "/WEB-INF/jsp/sys/backup/backup.jsp";
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
	
	/**
	 * 点击数据备份(具体实现)
	 */
	public String beiFen() throws IOException, InterruptedException{
		
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
                	error=true;
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
        this.formMap.put("MSG", msg.toString());
        this.formMap.put("ERROR", error);
        if(error){
            try{
            	process.destroy();
            }catch (Exception e) {
            	e.printStackTrace();
            }
            
            this.saveActionMessage("数据备份失败。可能是没有在字典维护设置Oracle连接字符串。请检查系统参数 ORACLE_LISTENER。");
        }else{
            if(process!= null && process.waitFor()==0){
            	try{
                	process.destroy();
                }catch (Exception e) {
                	e.printStackTrace();
                }
            	this.formMap.put("dmpFile",zipFile);//压缩文件名
            	ZipUtils.zip(new File(dmpFile), new File(zipFile));//压缩文件
            	FileUtils.deleteQuietly(new File(dmpFile));//删除dmp文件
                this.saveActionMessage("数据备份成功");
            }else{
            	//??????
            }
        }
        return this.list();
	}
}
