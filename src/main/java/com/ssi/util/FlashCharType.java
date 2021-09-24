package com.ssi.util;



public class FlashCharType {
	public static final String XML_CHARTYPE_AREA2D = "Area2D";
	
	public static final String XML_CHARTYPE_BAR2D = "Bar2D";
	
	public static final String XML_CHARTYPE_CANDLESTICK = "Candlestick";
	
	public static final String XML_CHARTYPE_COL2DLINEDY = "MSColumn2DLineDY";
	
	public static final String XML_CHARTYPE_COL3DLINEDY = "MSColumn3DLineDY";
	
	public static final String XML_CHARTYPE_COLUMN2D = "Column2D";
	
	public static final String XML_CHARTYPE_COLUMN3D = "Column3D";
	
	public static final String XML_CHARTYPE_DOUGHNUT2D = "Doughnut2D";
	
	public static final String XML_CHARTYPE_LINE2D = "Line";
	
	public static final String XML_CHARTYPE_MSAREA2D = "MSArea2D";
	
	public static final String XML_CHARTYPE_MSBar2D = "MSBar2D";
	
	public static final String XML_CHARTYPE_MSColumn2D = "MSColumn2D";
	
	public static final String XML_CHARTYPE_MSColumn3D = "MSColumn3D";
	
	public static final String XML_CHARTYPE_MSLine2D = "MSLine";
	
	public static final String XML_CHARTYPE_PIE2D = "Pie2D";
	
	public static final String XML_CHARTYPE_PIE3D = "Pie3D";
	
	public static final String XML_CHARTYPE_StArea2D = "StackedArea2D";
	
	public static final String XML_CHARTYPE_StBar2D = "StackedBar2D";
	
	public static final String XML_CHARTYPE_StColumn2D = "StackedColumn2D";
	
	public static final String XML_CHARTYPE_StColumn3D = "StackedColumn3D";
	
	private static String[] xmlCharTypes;
	
	static{
		xmlCharTypes = new String[]{
			XML_CHARTYPE_AREA2D,
			XML_CHARTYPE_BAR2D,
	//		XML_CHARTYPE_CANDLESTICK,
			XML_CHARTYPE_COL2DLINEDY,
			XML_CHARTYPE_COL3DLINEDY,
			XML_CHARTYPE_COLUMN2D,
			XML_CHARTYPE_COLUMN3D,
			XML_CHARTYPE_DOUGHNUT2D,
			XML_CHARTYPE_LINE2D,
			XML_CHARTYPE_MSAREA2D,
			XML_CHARTYPE_MSBar2D,
			XML_CHARTYPE_MSColumn2D,
			XML_CHARTYPE_MSColumn3D,
			XML_CHARTYPE_MSLine2D,
			XML_CHARTYPE_PIE2D,
			XML_CHARTYPE_PIE3D,
			XML_CHARTYPE_StArea2D,
			XML_CHARTYPE_StBar2D,
			XML_CHARTYPE_StColumn2D,
			XML_CHARTYPE_StColumn3D
		};
	}
	
	public static String[] getXMLCharTypes(){
		if(xmlCharTypes==null){
			throw new RuntimeException("系统错误!读取xmlCharTypes列表失败!");
		}else{
			return xmlCharTypes;
		}
	}

}