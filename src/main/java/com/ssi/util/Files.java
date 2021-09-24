package com.ssi.util;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.FileInputStream;
import java.io.FileOutputStream;

public class Files {
	public static final byte[] KEYVALUE = "6^)(9-p35@%3#4S!4S0)$Y%%^&5(j.&^&o(*0)$Y%!#O@*GpG@=+@j.&6^)(0-=+"
			.getBytes();
	public static final int BUFFERLEN = 1024;

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		try {

			String oldFile = new String("D:\\1.docx");
			encryptFile(oldFile, "123456");

			System.out.println("ok");

			// decryptFile(oldFile,"123456");

			System.out.println("good");

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	/**
	 * 加密方法 将文件内容做加密 加密内容覆盖原内容
	 * 
	 * @param file
	 * @param password
	 */
	public static void encryptFile(String file, String password)
			throws Exception {

		// 密码的字节数组 用来异或操作
		byte[] PASSVALUE = password.getBytes();
		int papos = 0;
		for (int i = 0; i < KEYVALUE.length; i++) {
			KEYVALUE[i] ^= PASSVALUE[papos];
			papos++;
			if (papos == PASSVALUE.length)
				papos = 0;
		}

		FileInputStream in = new FileInputStream(file);
		ByteArrayOutputStream baos = new ByteArrayOutputStream();

		int c, pos, keylen;
		pos = 0;
		keylen = KEYVALUE.length;
		byte buffer[] = new byte[BUFFERLEN];
		while ((c = in.read(buffer)) != -1) {
			for (int i = 0; i < c; i++) {
				buffer[i] ^= KEYVALUE[pos];
				baos.write(buffer[i]);
				pos++;
				if (pos == keylen)
					pos = 0;
			}
		}
		// 关闭打开的流
		in.close();
		baos.close();

		// 缓冲区的有效内容已复制到该数组中
		buffer = baos.toByteArray();

		FileOutputStream out = new FileOutputStream(file);

		// 将位数组内容存回文件
		ByteArrayInputStream bais = new ByteArrayInputStream(buffer);
		byte[] temp = new byte[BUFFERLEN];
		while ((c = bais.read(temp)) != -1) {
			for (int i = 0; i < c; i++) {
				out.write(temp[i]);
			}
		}

		// 关闭打开的流
		bais.close();
		out.flush();
		out.close();
	}

	/***
	 * 解密方法 将加密后的文件内容做解密 解密后的内容覆盖原内容
	 * 
	 * @param file
	 * @param password
	 * @throws Exception
	 */
	public static void decryptFile(String file, String password)
			throws Exception {
		// 密码的字节数组 用来异或操作
		byte[] PASSVALUE = password.getBytes();
		int papos = 0;
		for (int i = 0; i < KEYVALUE.length; i++) {
			KEYVALUE[i] ^= PASSVALUE[papos];
			papos++;
			if (papos == PASSVALUE.length)
				papos = 0;
		}

		FileInputStream in = new FileInputStream(file);
		ByteArrayOutputStream baos = new ByteArrayOutputStream();

		int c, pos, keylen;
		pos = 0;
		keylen = KEYVALUE.length;
		byte buffer[] = new byte[BUFFERLEN];
		while ((c = in.read(buffer)) != -1) {
			for (int i = 0; i < c; i++) {
				buffer[i] ^= KEYVALUE[pos];
				baos.write(buffer[i]);
				pos++;
				if (pos == keylen)
					pos = 0;
			}
		}
		// 关闭打开的流
		in.close();
		baos.close();

		// 缓冲区的有效内容已复制到该数组中
		buffer = baos.toByteArray();

		FileOutputStream out = new FileOutputStream(file);

		// 将位数组内容存回文件
		ByteArrayInputStream bais = new ByteArrayInputStream(buffer);
		byte[] temp = new byte[BUFFERLEN];
		while ((c = bais.read(temp)) != -1) {
			for (int i = 0; i < c; i++) {
				out.write(temp[i]);
			}
		}
		// 关闭打开的流
		bais.close();
		out.flush();
		out.close();
	}

	/***
	 * 解密方法 将加密后的文件内容做解密 解密后的内容覆盖原内容
	 * 
	 * @param file
	 * @param password
	 * @throws Exception
	 */
	public static byte[] decryptByteFile(String filePath, String password)
			throws Exception {
		// 密码的字节数组 用来异或操作
		byte[] PASSVALUE = password.getBytes();
		int papos = 0;
		for (int i = 0; i < KEYVALUE.length; i++) {
			KEYVALUE[i] ^= PASSVALUE[papos];
			papos++;
			if (papos == PASSVALUE.length)
				papos = 0;
		}
		FileInputStream in = new FileInputStream(filePath);
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		int c, pos, keylen;
		pos = 0;
		keylen = KEYVALUE.length;
		byte buffer[] = new byte[BUFFERLEN];
		while ((c = in.read(buffer)) != -1) {
			for (int i = 0; i < c; i++) {
				buffer[i] ^= KEYVALUE[pos];
				baos.write(buffer[i]);
				pos++;
				if (pos == keylen)
					pos = 0;
			}
		}
		// 关闭打开的流
		in.close();
		baos.close();

		// 缓冲区的有效内容已复制到该数组中
		buffer = baos.toByteArray();
		return buffer;
	}

}
