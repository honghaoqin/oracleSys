package com.ssi.util;
import jxl.Cell;
import jxl.Range;
import jxl.write.Label;
import jxl.write.WritableCell;
import jxl.write.WritableSheet;
import jxl.write.WriteException;
import jxl.write.biff.RowsExceededException;


/**
 * 
 * 输出EXCEL公共类
 */
public class ExcelCommonMethod {
	
	public Range[] getRangeInFiled(WritableSheet sheet , int startedIndex,
			int rowSpan) {
		Range[] changeRange=sheet.getMergedCells();
		Range[] result = new Range[200];
		
		int r = 0;
		for (int i = 0; i < changeRange.length; i++) {
			Range mergerdCell = changeRange[i];
//			Cell cellBR = mergerdCell.getBottomRight();
			Cell cellTL = mergerdCell.getTopLeft();
//			int rowBR = cellBR.getRow();
			int rowTL = cellTL.getRow();
			if (startedIndex - 1 < rowTL && rowTL < startedIndex + rowSpan) {
				result[r] = changeRange[i];
				r++;
			}
		}
		Range[] returnResult = new Range[r];
		for (int i = 0; i < r; i++) {
			returnResult[i] = result[i];
		}
		return returnResult;

	}


	public WritableSheet copyExlRows(WritableSheet sheet,
			int StartRow, int standardIndex, int modelRows,int copyTimes) {
		sheet=copyExcelRows(sheet,StartRow+modelRows-1,standardIndex-1,modelRows,copyTimes-1);
		return sheet;
	}	
	/**
	 * 
	 * @param sheet  所要编辑Sheet
	 * @param toPositionRow  从那一行开始循环插入
	 * @param standardIndex   插入那一行的样式开始
	 * @param modelRows   共几行
	 * @param copyTimes
	 * @return
	 */
	public WritableSheet copyExcelRows(WritableSheet sheet,
			int toPositionRow, int standardIndex, int modelRows,int copyTimes) {
		for (int j = 0; j < copyTimes; j++) {
			for (int c = 1; c < modelRows + 1; c++) {
//				int ss= c - 1 +toPositionRow +(j) * modelRows;
				sheet.insertRow( c - 1 +toPositionRow +(j) * modelRows);//每次循环从第几行插入--复制的行数*数据的条数
				for (int i = 0; i < sheet.getColumns(); i++) {
					jxl.write.WritableCellFormat wcsB = new jxl.write.WritableCellFormat();
					try {
						wcsB.setBorder(jxl.format.Border.BOTTOM,jxl.format.BorderLineStyle.THIN);
						Label lb = new Label(i,  c-1 +toPositionRow+(j)* modelRows,"", wcsB);
						sheet.addCell(lb);
					} catch (RowsExceededException e) {
						e.printStackTrace();
					} catch (WriteException e) {
						e.printStackTrace();
					}
				}
			}
		}
		Range[] mergedCell = this.getRangeInFiled(sheet, standardIndex, modelRows);
		for (int j = 0; j < copyTimes; j++) {
			for (int r = 0; r < mergedCell.length; r++) {
				Range rangeCell = mergedCell[r];
				Cell cellBR = rangeCell.getBottomRight();
				Cell cellTL = rangeCell.getTopLeft();
				int colBR = cellBR.getColumn();
				int rowBR = cellBR.getRow() + (j) * modelRows+toPositionRow-standardIndex;
				int colTL = cellTL.getColumn();
				int rowTL = cellTL.getRow() + (j) * modelRows+toPositionRow-standardIndex;
				try {
					sheet.mergeCells(colTL, rowTL, colBR, rowBR);
				} catch (RowsExceededException e) {
					e.printStackTrace();
				} catch (WriteException e) {
					e.printStackTrace();
				}
			}
			for(int f=1;f<modelRows+1;f++){
				int rowIndexStard= standardIndex+f-1;
				int rowFormatIndex=toPositionRow+f-1;
				for(int cc=0;cc<sheet.getRow(rowIndexStard).length;cc++){
					WritableCell cell = sheet.getWritableCell(cc,rowIndexStard);
					WritableCell cellNew = sheet.getWritableCell(cc,rowFormatIndex+(j)*modelRows);
					Label lb = (Label) cellNew;	 
					String content=cell.getContents().toString();
					lb.setString(content);
					lb.setCellFormat(cell.getCellFormat());
				}
				try {
					//sheet.setRowView(rowFormatIndex+modelRows*(j),(sheet.getRowHeight(rowIndexStard)));
					sheet.setRowView(rowFormatIndex+modelRows*(j),sheet.getRowHeight(rowIndexStard));
				} catch (RowsExceededException e) {
					e.printStackTrace();
				}
			}
		}
		return sheet;
	}
	
	/**
	 * 
	 * @param sheet  所要编辑Sheet
	 * @param toPositionRow  从那一行开始循环插入
	 * @param standardIndex   插入那一行的样式开始
	 * @param modelRows   共几行
	 * @param copyTimes
	 * @param cols        共几列
	 * @return
	 */
	public WritableSheet copyExcelRowsAndCols(WritableSheet sheet,int toPositionRow, int standardIndex, int modelRows,int copyTimes,int cols) {
		for (int j = 0; j < copyTimes; j++) {
			for (int c = 1; c < modelRows + 1; c++) {
//				int ss= c - 1 +toPositionRow +(j) * modelRows;
				sheet.insertRow( c - 1 +toPositionRow +(j) * modelRows);//每次循环从第几行插入--复制的行数*数据的条数
				//for (int i = 0; i < sheet.getColumns(); i++) {
				for (int i = 0; i < cols; i++) {
					jxl.write.WritableCellFormat wcsB = new jxl.write.WritableCellFormat();
					try {
						//wcsB.setBorder(jxl.format.Border.BOTTOM,jxl.format.BorderLineStyle.THIN);
						wcsB.setBorder(jxl.format.Border.ALL,jxl.format.BorderLineStyle.THIN);
						//Label lb = new Label(i,  c-1 +toPositionRow+(j)* modelRows,"", wcsB);
						Label lb = null;
						if(c>1){
							//最后一行空行不用设置格式(如果是n行间隔空行,则是c-1-n)
							lb = new Label(i,  c-2 +toPositionRow+(j)* modelRows,"", wcsB);
						}else{
							lb = new Label(i,  c-1 +toPositionRow+(j)* modelRows,"", wcsB);
						}
						sheet.addCell(lb);
					} catch (RowsExceededException e) {
						e.printStackTrace();
					} catch (WriteException e) {
						e.printStackTrace();
					}
				}
			}
		}
		Range[] mergedCell = this.getRangeInFiled(sheet, standardIndex, modelRows);
		for (int j = 0; j < copyTimes; j++) {
			for (int r = 0; r < mergedCell.length; r++) {
				Range rangeCell = mergedCell[r];
				Cell cellBR = rangeCell.getBottomRight();
				Cell cellTL = rangeCell.getTopLeft();
				int colBR = cellBR.getColumn();
				int rowBR = cellBR.getRow() + (j) * modelRows+toPositionRow-standardIndex;
				int colTL = cellTL.getColumn();
				int rowTL = cellTL.getRow() + (j) * modelRows+toPositionRow-standardIndex;
				try {
					sheet.mergeCells(colTL, rowTL, colBR, rowBR);
				} catch (RowsExceededException e) {
					e.printStackTrace();
				} catch (WriteException e) {
					e.printStackTrace();
				}
			}
			for(int f=1;f<modelRows+1;f++){
				int rowIndexStard= standardIndex+f-1;
				int rowFormatIndex=toPositionRow+f-1;
				for(int cc=0;cc<sheet.getRow(rowIndexStard).length;cc++){
					WritableCell cell = sheet.getWritableCell(cc,rowIndexStard);
					WritableCell cellNew = sheet.getWritableCell(cc,rowFormatIndex+(j)*modelRows);
					Label lb = (Label) cellNew;	 
					String content=cell.getContents().toString();
					lb.setString(content);
					lb.setCellFormat(cell.getCellFormat());
				}
				try {
					//sheet.setRowView(rowFormatIndex+modelRows*(j),(sheet.getRowHeight(rowIndexStard)));
					sheet.setRowView(rowFormatIndex+modelRows*(j),sheet.getRowHeight(rowIndexStard));
				} catch (RowsExceededException e) {
					e.printStackTrace();
				}
			}
		}
		return sheet;
	}
	
}
