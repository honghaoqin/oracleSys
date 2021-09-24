package com.ssi.util;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;
public class SystemConfig {
	private static final String cfgFile = "/system.properties";
	private static Properties properties;
	static {
		properties = new Properties();
		InputStream is = SystemConfig.class.getResourceAsStream(cfgFile);
		try {
			properties.load(is);
		} catch (IOException e) {
			e.printStackTrace();
			throw new RuntimeException("读取system.properties配置文件异常");
		}
	}

	/**
	 * 
	 * @param propertyName
	 * @return
	 */
	public static String getProperty(String propertyName) {		
		if (properties == null) {
			throw new RuntimeException("从system.properties配置文件取值异常");
		} else {
			return properties.getProperty(propertyName);
		}
	}
}
