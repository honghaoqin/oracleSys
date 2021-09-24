/*---------代码生成请勿手工修改---------*/
package com.ssi.sys.dao;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import com.ssi.framework.dao.BaseDao;
/**
 * 上传文件
 */
@Repository
public class FileDao extends BaseDao{
	public static final String NAMESPACE="S_FILE";
	public static final String ID="ID";//编号
	public static final String APPCODE="APPCODE";//项目编码
	public static final String MODULECODE="MODULECODE";//模块编码
	public static final String P_ID="P_ID";//父ID
	public static final String OBJ_ID="OBJ_ID";//实体编号
	public static final String FILEPATH="FILEPATH";//文件地址
	public static final String FILENAME="FILENAME";//原文件名称
	public static final String FILESIZE="FILESIZE";//文件大小(KB)
	public static final String FILETYPE="FILETYPE";//文件类型
	public static final String UPLOADTYPE="UPLOADTYPE";//上传类型
	public static final String STATUS="STATUS";//状态
	public static final String ISCONVERT="ISCONVERT";//是否转换
	public static final String VERSION="VERSION";//版本号
	public static final String CREATE_BY="CREATE_BY";//创建人
	public static final String CREATED_DATE="CREATED_DATE";//创建时间
	public static final String FTP_PATH="FTP_PATH";//ftp路径
	public static final String NAME="NAME";//文件名称
	public static final String THUMBNAIL_PATH="THUMBNAIL_PATH";//缩略图路径
	public static final String  IMG_WIDTH="IMG_WIDTH";
	public static final String  IMG_HEIGHT="IMG_HEIGHT";
	@Override
	public String getNamespace() {
		return NAMESPACE;
	}	
}
