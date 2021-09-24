package com.ssi.util;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class StringTools {
	public StringTools() {
	}

	/**
	 * 字符串按字节截取
	 * 
	 * @param str
	 *            原字符
	 * @param len
	 *            截取长度
	 * @return String Create DateTime: 2011-7-25上午10:37:23
	 */

	public static String splitString(String str, int len) {
		return splitString(str, len, "...");
	}

	/**
	 * 字符串按字节截取
	 * 
	 * @param str
	 *            原字符
	 * @param len
	 *            截取长度
	 * @param elide
	 *            省略符
	 * @return String Create DateTime: 2011-7-25上午10:37:23
	 */
	public static String splitString(String str, int len, String elide) {
		if (str == null) {
			return "";
		}
		byte[] strByte = str.getBytes();
		int strLen = strByte.length;
		int elideLen = (elide.trim().length() == 0) ? 0
				: elide.getBytes().length;
		if (len >= strLen || len < 1) {
			return str;
		}
		if (len - elideLen > 0) {
			len = len - elideLen;
		}
		int count = 0;
		for (int i = 0; i < len; i++) {
			int value = (int) strByte[i];
			if (value < 0) {
				count++;
			}
		}
		if (count % 2 != 0) {
			len = (len == 1) ? len + 1 : len - 1;
		}
		return new String(strByte, 0, len) + elide.trim();
	}

	public static int strByteLen(String str) {
		if (str == null) {
			return 0;
		}
		int strByteLen = str.getBytes().length;
		return strByteLen;
	}

	/**
	 * 去除字符串的特殊字符
	 * 
	 * @param str
	 * @return
	 */
	public static String replaceBlank(String str) {
		String dest = "";
		if (str != null) {
			Pattern p = Pattern.compile("\t|\r|\n");
			Matcher m = p.matcher(str);
			dest = m.replaceAll("");
		}
		return dest;
	}

}
