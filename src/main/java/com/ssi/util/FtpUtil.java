package com.ssi.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.SocketException;

import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPFile;
import org.apache.commons.net.ftp.FTPReply;

public class FtpUtil {
	private FTPClient ftpClient;

	public FtpUtil() {
		String host = SystemConfig.getProperty("ftp_host");
		int port = Integer.parseInt(SystemConfig.getProperty("ftp_port"));
		String userName = SystemConfig.getProperty("ftp_username");
		String passWord = SystemConfig.getProperty("ftp_passWord");
		ftpClient = new FTPClient();
		try {
			ftpClient.connect(host, port);// 连接FTP服务器
			ftpClient.login(userName, passWord);// 登陆FTP服务器
			if (!FTPReply.isPositiveCompletion(ftpClient.getReplyCode())) {
				System.out.println("未连接到FTP，用户名或密码错误。");
				// ftpClient.disconnect();
				this.closeCon();
			} else {
				System.out.println("FTP连接成功。");
			}
		} catch (SocketException e) {
			e.printStackTrace();
			System.out.println("FTP的IP地址可能错误，请正确配置。");
			this.closeCon();
		} catch (IOException e) {
			e.printStackTrace();
			System.out.println("FTP的端口错误,请正确配置。");
			this.closeCon();
		}
	}

	/**
	 * FTPClient构造函数,主要进行初始化配置连接FTP服务器。
	 * 
	 * @param host
	 *            FTP服务器的IP地址
	 * @param port
	 *            FTP服务器的端口
	 * @param userName
	 *            FTP服务器的用户名
	 * @param passWord
	 *            FTP服务器的密码
	 */
	public FtpUtil(String host, int port, String userName, String passWord) {
		ftpClient = new FTPClient();
		try {
			ftpClient.connect(host, port);// 连接FTP服务器
			ftpClient.login(userName, passWord);// 登陆FTP服务器
			if (!FTPReply.isPositiveCompletion(ftpClient.getReplyCode())) {
				System.out.println("未连接到FTP，用户名或密码错误。");
				// ftpClient.disconnect();
				this.closeCon();
			} else {
				System.out.println("FTP连接成功。");
			}
		} catch (SocketException e) {
			e.printStackTrace();
			System.out.println("FTP的IP地址可能错误，请正确配置。");
			this.closeCon();
		} catch (IOException e) {
			e.printStackTrace();
			System.out.println("FTP的端口错误,请正确配置。");
			this.closeCon();
		}
	}

	/**
	 * 上传文件到FTP服务器
	 * 
	 * @param local
	 *            本地文件名称，绝对路径
	 * @param remote
	 *            远程文件路径,支持多级目录嵌套，支持递归创建不存在的目录结构
	 * @throws IOException
	 */
	public void upload(String local, String remote) throws IOException {
		remote=remote.replaceAll("\\\\", "/");
		local=local.replaceAll("\\\\", "/");
		System.out.println("local"+local);
		System.out.println("remote"+local);
		// 设置PassiveMode传输
		ftpClient.enterLocalPassiveMode();
		// 设置以二进制流的方式传输
		ftpClient.setFileType(FTP.BINARY_FILE_TYPE);
		// 对远程目录的处理
		String remoteFileName = remote;
		if (remote.contains("/")) {
			remoteFileName = remote.substring(remote.lastIndexOf("/") + 1);
			// 创建服务器远程目录结构，创建失败直接返回
			if (!CreateDirecroty(remote)) {
				System.out.println("创建服务器远程目录结构失败直接返回");
				return;
			}
		}
		FTPFile[] files = ftpClient.listFiles(new String(remoteFileName));
		File f = new File(local);
		uploadFile(remoteFileName, f);
	}

	public void uploadFile(String remoteFile, File localFile)
			throws IOException {
		InputStream in = new FileInputStream(localFile);
		if(null!=in){
			ftpClient.storeFile(remoteFile, in);	
			System.out.println("文件上传完毕");
		}else{
			System.out.println("本地文件流异常");
		}
		
		in.close();
		
	}

	/** */
	/**
	 * 递归创建远程服务器目录
	 * 
	 * @param remote
	 *            远程服务器文件绝对路径
	 * 
	 * @return 目录创建是否成功
	 * @throws IOException
	 */
	public boolean CreateDirecroty(String remote) throws IOException {
		boolean success = true;
		String directory = remote.substring(0, remote.lastIndexOf("/") + 1);
		// 如果远程目录不存在，则递归创建远程服务器目录
		if (!directory.equalsIgnoreCase("/")
				&& !ftpClient.changeWorkingDirectory(new String(directory))) {
			int start = 0;
			int end = 0;
			if (directory.startsWith("/")) {
				start = 1;
			} else {
				start = 0;
			}
			end = directory.indexOf("/", start);
			while (true) {
				String subDirectory = new String(remote.substring(start, end));
				if (!ftpClient.changeWorkingDirectory(subDirectory)) {
					if (ftpClient.makeDirectory(subDirectory)) {
						ftpClient.changeWorkingDirectory(subDirectory);
					} else {
						System.out.println("创建目录失败");
						success = false;
						return success;
					}
				}
				start = end + 1;
				end = directory.indexOf("/", start);
				// 检查所有目录是否创建完毕
				if (end <= start) {
					break;
				}
			}
		}
		return success;
	}

	public boolean uploadAll(String filename, String uploadpath)
			throws Exception {
		boolean success = false;
		File file = new File(filename);
		// 要上传的是否存在
		if (!file.exists()) {
			return success;
		}
		// 要上传的是否是文件夹
		if (!file.isDirectory()) {
			return success;
		}
		File[] flles = file.listFiles();
		for (File files : flles) {
			if (files.exists()) {
				if (files.isDirectory()) {
					this.uploadAll(files.getAbsoluteFile().toString(),
							uploadpath);
				} else {
					String local = files.getCanonicalPath().replaceAll("\\\\",
							"/");
					String remote = uploadpath
							+ local.substring(local.indexOf("/") + 1);
					upload(local, remote);
					ftpClient.changeWorkingDirectory("/");
				}
			}
		}
		return true;
	}

	/**
	 * 
	 * <p>
	 * 删除ftp上的文件
	 * </p>
	 * 
	 * @param srcFname
	 * @return true || false
	 */
	public boolean removeFile(String srcFname) {
		boolean flag = false;
		if (ftpClient != null) {
			try {
				flag = ftpClient.deleteFile(srcFname);
			} catch (IOException e) {
				e.printStackTrace();
				this.closeCon();
			}
		}
		return flag;
	}

	/**
	 * <p>
	 * 销毁ftp连接
	 * </p>
	 */
	public void closeCon() {
		if (ftpClient != null) {
			if (ftpClient.isConnected()) {
				try {
					ftpClient.logout();
					ftpClient.disconnect();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}

	public static void main(String[] args) throws Exception {
		// FileInputStream in = new FileInputStream(new File("D:/text.txt"));
		FtpUtil ftp = new FtpUtil();
		ftp.upload("C:/upload/temp/20141204/p_0004.jpg", "/hpi/blsc/a11/ZYBASY/201412/p_0004.jpg");
		// ftp.upload("bb/cc", "text.txt", in);
		// ftp.uploadAll("D:/texx", "/bb/aa/");
		// ftp.removeFile("/smh/qwqwqw.tif");
	}

}
