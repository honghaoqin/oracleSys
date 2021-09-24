package com.ssi.sys.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jxl.Cell;
import jxl.CellType;
import jxl.Workbook;
import jxl.write.Label;
import jxl.write.WritableCell;
import jxl.write.WritableCellFormat;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import jxl.write.WriteException;
import jxl.write.biff.RowsExceededException;

import org.apache.commons.lang.ObjectUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import com.ssi.framework.exceptions.BusinessException;
import com.ssi.framework.service.BaseService;
import com.ssi.framework.utils.POIUtils;
import com.ssi.util.ExcelCommonMethod;

/**
 * 下载excel服务类
 * 只需要注入该类,调用expDownExcel方法,即可下载文件
 * excel模板必须用纯office2003新建的,而且是没有安装过2007插件的和office2007的
 * 
 * formMap必须有:
 * -- formMap.templateName 模板名称,不带后缀.xls
 * 可选 :
 * -- formMap.SQL 用于查询数据
 * -- formMap.fileName 下载的文件名,不带后缀.xls, 不给的话,默认是模板的名称
 * -- formMap.startNum 开始填充数据的行, 不给的话,默认是2
 * 
 * 下载例子:
 * if(download){//下载
		formMap.put("templateName", "ydkhpf");
		formMap.put("startNum", "5");
		excelDownService.expDownExcel(request, response, formMap,resultList);
		return null;
	}else{
		return "/WEB-INF/jsp/sys/ydkhpf/list.jsp";
	}
 * 
 * @author 谢霆子
 * @version 1.0
 * @date 2013-2-14
 *
 */
@Service
public class ExcelDownService extends BaseService {

	
	// 模板的目录:
	private final static String templateDir = "excelTemplate";
	// 临时文件目录
	private final static String tmpDir = "";
	
	/**
	 * 将数据写入到临时文件
	 * 然后下载文件
	 * 
	 * * formMap必须有:
	 * -- formMap.templateName 模板名称,不带后缀.xls
	 * 可选 :
	 * -- formMap.SQL 用于查询数据 ,有resultList的话,就不用SQL,如果resultList没有值的话,就传SQL
	 * -- formMap.fileName 下载的文件名,不带后缀.xls, 不给的话,默认是模板的名称
	 * -- formMap.startNum 开始填充数据的行, 不给的话,默认是2
	 */
	public File expDownExcel(HttpServletRequest request,HttpServletResponse response,Map formMap,List resultList){
		String sql = ObjectUtils.toString(formMap.get("SQL"));
		String fileName = ObjectUtils.toString(formMap.get("fileName"));
		List<Map> data = resultList;
		String templateName = ObjectUtils.toString(formMap.get("templateName"));
		if("".equals(templateName.trim())){
			throw new BusinessException("模板不存在!请联系系统管理员!");
		}
		if("".equals(fileName.trim())){
			fileName = templateName;
		}
		fileName = POIUtils.getXlsFileName(fileName);
		formMap.put("fileName", fileName);
		if(!"".equals(sql.trim()) && (data == null || data.isEmpty())){
			data = listBySql(sql);
		}
		if(data == null || data.isEmpty()){
			throw new BusinessException("没有数据!");
		}
		//excel模板文件（目录+文件名）
		String templateExcel = request.getSession().getServletContext().getRealPath("/"+templateDir)+"/"+templateName+".xls";
		// 临时输出文件（目录+文件名）
		String outputFile = request.getSession().getServletContext().getRealPath("/"+tmpDir)+"/"+ fileName;
		ExcelCommonMethod Excel = new ExcelCommonMethod();
		FileOutputStream fout = null;
		// 输出文件对应的
		WritableWorkbook wwb = null;
		// excel模板对应的
		Workbook rwb = null;
		FileInputStream fis = null;
		try {
			fout = new FileOutputStream(outputFile);
			fis = new FileInputStream(new File(templateExcel));
			// 将excel模板读到workbook中
			rwb = Workbook.getWorkbook(fis);
			// 将excel模板写到输出文件流去。
			wwb = Workbook.createWorkbook(fout, rwb);
			WritableSheet[] ws = wwb.getSheets();
			// 得到要输出的数据
			Map<String, String> map = (Map<String, String>) data.get(0);
			for (int i = 0; i < ws.length; i++) {
				if (map != null) {
					// 填写excel模板中用#key#标识的单元格,这些字段在模板中是唯一的,所以用#区别
					getReadOneCell(ws[i], map);
				}
				if (data.size() > 0) {
					String num = ObjectUtils.toString(formMap.get("startNum"));
					if("".equals(num.trim())){
						num = "2";
					}
					if (!"".equals(num)) {
						if (num.indexOf(":") > -1) {
							String[] nums = num.split(":");
							int numFlag = 0;
							for (int x = 0; x < nums.length; x++) {
								numFlag = Integer.parseInt(nums[x])
										+ (data.size() - 1) * x;
								if (x == 0)
									ws[i] = Excel.copyExcelRows(ws[i], numFlag,
											numFlag - 1, 1, data.size() - 1);
								if (x == 1)
									ws[i] = Excel.copyExcelRows(ws[i], numFlag,
											numFlag - 1, 1, data.size() - 1);
								addListValue(data, numFlag - 1, 1, ws[i]);
							}
						} else {
							int numFlag = Integer.parseInt(num);
							ws[i] = Excel.copyExcelRows(ws[i], numFlag,
									numFlag - 1, 1, data.size() - 1);
							addListValue(data, numFlag - 1, 1, ws[i]);
						}
					}
				}
			}
			wwb.write();
		} catch (Exception e) {
//			throw new RuntimeException("导出文件失败", e);
			throw new BusinessException("导出文件失败:"+e.getMessage()+" ; 请联系系统管理员!");
		} finally {
			closeWritableWorkbook(wwb);
			closeWorkbook(rwb);
			closeFileOutputStream(fout);
			closeFileInputStream(fis);
		}
		formMap.put("deleteFlag", "y"); // 下载完成删除文件.
		this.downLoadExcel(request,new File(outputFile), response,formMap); //下载文件
		return null;
	}
	
	public void downLoadExcel(HttpServletRequest request,File file, HttpServletResponse response,Map formMap) {
		ServletOutputStream output = null;
		FileInputStream in = null;
		String filename = file.getName();
		String name = ObjectUtils.toString(formMap.get("filename"));
		if("".equals(name.trim())){
			name = request.getParameter("filename");
			name = ObjectUtils.toString(name);
		}
		if(!"".equals(name.trim())){
			filename = name;
		}
		// 定义下载的文件字符集,以及当前页面为下载页面
		try {
		    response.setContentType("application/x-download; charset=UTF-8");
		    // 设置报头信息,定义下载的文件的保存文件名为fileName
		    response.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\"");
		    /** *************************************需要设置以下的头信息,否则IE6会下载不了的。*************************************** */
		    response.setHeader("Expires", new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date()));
		    response.setHeader("Pragma", "public");
		    response.setHeader("Cache-Control", "must-revalidate,post-check=0,pre-check=0");
		    /** *************************************end*************************************** */
		    output = response.getOutputStream();
		    in = new FileInputStream(file);
		    if (in != null) {
			byte[] buff = new byte[2048];
			int len = -1;
			// 从in中读取二进制流
			while ((len = in.read(buff)) > 0) {
			    // 将读取的二进制流放入output 输出流对象中去
			    output.write(buff, 0, len);
			    output.flush();
			}
			// 写完,就输出以供下载
			output.flush();
		    }
		} catch (IOException e) {
		    e.printStackTrace();
		    throw new RuntimeException("下载出错!" + e);
		} finally {
		    closeServletOutputStream(output);
		    closeFileInputStream(in);
		    String deleteFlag = ObjectUtils.toString(formMap.get("deleteFlag"));
		    if("y".equalsIgnoreCase(deleteFlag)){
		    	file.delete();
		    }
		}
    }
	
	
	public void downLoad(HttpServletRequest request,File file, HttpServletResponse response,Map formMap) {
		ServletOutputStream output = null;
		FileInputStream in = null;
		String filename = file.getName();
		String name = ObjectUtils.toString(formMap.get("filename"));
		if("".equals(name.trim())){
			name = request.getParameter("filename");
			name = ObjectUtils.toString(name);
		}
		if(!"".equals(name.trim())){
			filename = name;
		}
		try {
			filename = new String( filename.getBytes("UTF-8"), "ISO8859-1");
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}
		// 定义下载的文件字符集,以及当前页面为下载页面
		try {
		    response.setContentType("application/x-download; charset=UTF-8");
		    // 设置报头信息,定义下载的文件的保存文件名为fileName
		    response.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\"");
		    /** *************************************需要设置以下的头信息,否则IE6会下载不了的。*************************************** */
		    response.setHeader("Expires", new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date()));
		    response.setHeader("Pragma", "public");
		    response.setHeader("Cache-Control", "must-revalidate,post-check=0,pre-check=0");
		    /** *************************************end*************************************** */
		    output = response.getOutputStream();
		    in = new FileInputStream(file);
		    if (in != null) {
			byte[] buff = new byte[2048];
			int len = -1;
			// 从in中读取二进制流
			while ((len = in.read(buff)) > 0) {
			    // 将读取的二进制流放入output 输出流对象中去
			    output.write(buff, 0, len);
			    output.flush();
			}
			// 写完,就输出以供下载
			output.flush();
		    }
		} catch (IOException e) {
		    e.printStackTrace();
		    throw new RuntimeException("下载出错!" + e);
		} finally {
		    closeServletOutputStream(output);
		    closeFileInputStream(in);
		    String deleteFlag = ObjectUtils.toString(formMap.get("deleteFlag"));
		    if("y".equalsIgnoreCase(deleteFlag)){
		    	file.delete();
		    }
		}
    }
	
	private static void closeServletOutputStream(ServletOutputStream sos) {
		if (sos != null) {
		    try {
		    	sos.close();
		    } catch (IOException e) {
				e.printStackTrace();
		    }
		    sos = null;
		}
    }
	
	private static void closeFileInputStream(FileInputStream fis) {
		if (fis != null) {
		    try {
		    	fis.close();
		    } catch (IOException e) {
		    	e.printStackTrace();
		    }
		    fis = null;
		}
    }
	
	private void closeFileOutputStream(FileOutputStream fos) {
		if (fos != null) {
		    try {
		    	fos.close();
		    } catch (IOException e) {
		    	e.printStackTrace();
		    }
		    fos = null;
		}
    }
	
	private void closeWorkbook(Workbook wrb) {
		if (wrb != null) {
		    try {
			wrb.close();
		    } catch (Exception e) {
			e.printStackTrace();
		    }
		    wrb = null;
		}
    }
	
	private void closeWritableWorkbook(WritableWorkbook wwb) {
		if (wwb != null) {
		    try {
			wwb.close();
		    } catch (Exception e) {
			e.printStackTrace();
		    }
		    wwb = null;
		}
    }
	
	private void addListValue(List data, int startRow, int rangeMuch, WritableSheet doSheet) {
		for (int i = 0; i < data.size(); i++) {
		    addValue((HashMap) data.get(i), startRow + rangeMuch * i, rangeMuch, doSheet, i + 1);
		}
    }
	
	private WritableSheet addValue(HashMap modelData, int startRow, int rangeMuch, WritableSheet doSheet, int strnum) {
		for (int r = startRow; r < startRow + rangeMuch; r++) {
		    Cell[] cells = doSheet.getRow(r);
		    if ((cells != null && cells.length > 1 && cells[0].getContents().length() != 0)
			    || (cells != null && cells.length > 30 && cells[30].getContents().length() != 0)
			    || (cells != null && cells.length > 2 && cells[1].getContents().length() != 0)) {
				for (int c = 0; c < cells.length; c++) {
				    WritableCell cell = doSheet.getWritableCell(c, r);
				    if (cell.getType() == CellType.EMPTY)
					continue;
				    Label lb = (Label) cell;
				    setAutoLine(lb);
				    String signal = cell.getContents().trim().toUpperCase();
//				    if (signal.equals("%STRNUM%")) {
//						lb.setString(strnum + "");
//						continue;
//				    }
				    if (signal.length() > 2) {
				    	signal = signal.substring(1, signal.length() - 1);
				    }
				    if (modelData.containsKey(signal)) {
				    	signal = (modelData.get(signal) == null ? "" : modelData.get(signal).toString());
				    } else {
				    	signal = cell.getContents();
				    }
				    lb.setString(signal);
				}
		    }
		}
		return doSheet;
    }

	/**
	 * 替换一一对应的数据
	 * 
	 * @param wtsh
	 * @param oneOne
	 *            模板与数据库字段对照集合
	 * @param oneData
	 *            替换数据
	 * @return 返回添加数据后的WritableSheet
	 * @throws RowsExceededException
	 * @throws WriteException
	 */
	@SuppressWarnings("unchecked")
	private WritableSheet getReadOneCell(WritableSheet wtsh, Map oneData)
			throws RowsExceededException, WriteException {
		Label lab;
		Set set = oneData.keySet();
		Iterator it = set.iterator();
		while (it.hasNext()) {
			String key = (String) it.next();
			// 循环遍历一页excel中的每一行数据
			for (int i = 0; i < wtsh.getRows(); i++) {
				// 循环遍历一行excel中的每一个单元格数据
				for (int j = 0; j < wtsh.getColumns(); j++) {
					Cell cell = wtsh.getCell(j, i);
					String content = cell.getContents();
					String value = "#" + key + "#";
					/**
					 * 修改目的:让excel模板支持替换插入。
					 */
					if (StringUtils.isNotEmpty(content)
							&& content.toUpperCase().contains(
									value.toUpperCase())) {
						jxl.format.CellFormat cf = cell.getCellFormat();
						Object con = oneData.get(key);
						// 如果该字段的值不为空,用值填写
						if (con != null) {
							int index = content.toUpperCase().indexOf(
									value.toUpperCase());
							String str = content.substring(index,
									index + value.length());
							lab = new Label(cell.getColumn(), cell.getRow(),
									content.replaceFirst(str, con.toString()
											.replace("$", "\\$")), cf);
						}
						// 如果该字段的值为空,用""填写
						else {
							lab = new Label(cell.getColumn(), cell.getRow(),
									"", cf);
						}
						setAutoLine(lab);
						wtsh.addCell(lab);
					}
				}
			}
		}
		return wtsh;
	}
	
	private void setAutoLine(Label label) {
		if (label == null)
		    return;
		/**
         * 设置单元格自动换行
         */
		try {
		    WritableCellFormat cellFormat = new WritableCellFormat();
		    cellFormat.setWrap(true);
		    // label.setCellFormat(cellFormat);
		} catch (WriteException e) {
		    e.printStackTrace();
		}
    }

}
