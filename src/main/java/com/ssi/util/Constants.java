package com.ssi.util;
public class Constants {
	/**
	 * 静态化数据字典
	 * @deprecated 请使用DictService.getDict(String type,String value) 或 DictService.getText(String type,String value)
	 */
	//public static Map dictMap=DictService.getCacheMap();
	/**
	 * @param dictMap
	 *@deprecated 请使用DictService.getDict(String type,String value) 或 DictService.getText(String type,String value)
	 */
	/*public static void setDictMap(Map dictMap) {
		throw new UnsupportedOperationException("请使用DictService");
	}*/
	
	
	
	public static final String SYSTEM = "SYSTEM";// 系统管理
	public static final String B_CASECENTER = "B_CASECENTER";// 案管
	public static final String SUGUAN = "SUGUAN";// 诉管
	public static final String B_INSURANCE = "B_INSURANCE";// 保险公司
	public static final String B_GOVERNMENT = "B_GOVERNMENT";// 政府
	public static final String B_COMMITTEE = "B_COMMITTEE";// 医调委
	public static final String B_HOSPITAL = "B_HOSPITAL";// 医院
	public static final String HEAD = "HEAD";//  hpi中心 
	public static final String BRANCH = "BRANCH";// 医院
}
