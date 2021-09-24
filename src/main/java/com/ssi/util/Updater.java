package com.ssi.util;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.sql.DataSource;

import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Component;

/**
 * 自动更新数据库
 * 
 * @author yuan
 * 
 */
@Component
public class Updater implements ApplicationContextAware {
	
	public static final String NOT_EXISTS = "000";

	DataSource dataSource;
	
	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
	}
	
	public void setApplicationContext(ApplicationContext applicationContext) {/*
		Connection conn = null;
		try {
			conn = dataSource.getConnection();
			
			String version = this.getVersion(conn);//当前版本
			String latestVersion = version;
			String encoding = null;
			
			ResourcePatternResolver resolver = new PathMatchingResourcePatternResolver();
			Resource[] resources = resolver.getResources("classpath:db/sql/update/*.sql");
			if (resources != null && resources.length > 0) {
				for (int i = 0; i < resources.length; i++) {
					Resource resource = resources[i];
					
					String filename = resource.getFilename();//文件名
					filename = filename.substring(0,filename.length()-4);//去除.sql
					if (StringUtils.isEmpty(latestVersion) || latestVersion.compareTo(filename)<0) {//版本号是空，或版本号小于当前文件，就执行
						
						Reader reader = null;
						if (encoding == null) {
							reader = new InputStreamReader(resource.getInputStream());
						} else {
							reader = new InputStreamReader(resource.getInputStream(),encoding);
						}
						
						try {
							CodeGen.runSql(conn, reader);//执行SQL
						} finally {
							reader.close();
						}
						
						latestVersion = filename;//最新版本
					}
				}
			}
			//更新最新版本到s_dict
			if (latestVersion!=null && !latestVersion.equals(version)) {
				System.out.println("数据库版本"+latestVersion);
				this.saveVersion(conn, latestVersion, NOT_EXISTS.equals(version));
			}
		} catch (Exception e) {
			System.out.println("升级数据库失败");
			e.printStackTrace();
		}finally{
			if(conn!=null){
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	*/}
	
	
	
	private String getVersion(Connection conn) throws SQLException{
		Statement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT TEXT FROM S_DICT WHERE TYPE = 'sysparam' and VALUE='UPDATE_VERSION'";
		try{
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next()) {
				return rs.getString("TEXT");
			}
			return NOT_EXISTS;
		}finally{
			try {
				rs.close();
			} catch (Exception e) {
			}
			try {
				stmt.close();
			} catch (Exception e) {
			}
		}
	}
	private void saveVersion(Connection conn,String version,boolean insert) throws SQLException{
		Statement stmt = null;
		String sql = null;
		if (insert) {
			sql = "INSERT INTO S_DICT (DICT_ID,TYPE,VALUE,TEXT,DES,CACHE) values (SYS_GUID(),'sysparam','UPDATE_VERSION','"+version+"','数据库版本','1')";
		}else{
			sql = "UPDATE S_DICT SET TEXT='"+version+"' WHERE TYPE='sysparam' AND VALUE='UPDATE_VERSION'";
		}
		try{
			stmt = conn.createStatement();
			stmt.executeUpdate(sql);
			conn.commit();
		}finally{
			try {
				stmt.close();
			} catch (Exception e) {
			}
		}
	}
}
