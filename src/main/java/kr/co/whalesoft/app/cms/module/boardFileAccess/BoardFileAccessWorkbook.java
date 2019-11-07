package kr.co.whalesoft.app.cms.module.boardFileAccess;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableWorkbook;

public class BoardFileAccessWorkbook {
	
	protected WritableWorkbook workbookForm(WritableWorkbook workbook, List<BoardFileAccess> boardList, String sheetName, HttpServletRequest request, HttpServletResponse response) throws Exception {
		workbook.createSheet(sheetName, 0);	//시트설정
		List<BoardFileAccess> list = boardList;
		
		/*String AM = "09:00";
		String PM = "13:10";*/
		
		//bold font
		WritableFont cellFont = new WritableFont(WritableFont.COURIER, 10);
	    cellFont.setBoldStyle(WritableFont.BOLD);
	    WritableCellFormat cellFormat = new WritableCellFormat(cellFont);
	    
	  //header
  		workbook.getSheet(0).addCell(new Label(0, 0, "게시판명", cellFormat));
  		workbook.getSheet(0).addCell(new Label(1, 0, "다운로드 수", cellFormat));
  		workbook.getSheet(0).addCell(new Label(2, 0, "백분율", cellFormat));
  		
  		for (int i = 1; i < list.size(); i++) {
  			BoardFileAccess ap = list.get(i);
  			double percent = ((new Double(ap.getCount()) / new Double(list.get(0).getCount())) * 100);
  			workbook.getSheet(0).addCell(new Label(0, i, ap.getBoard_name()));
  			workbook.getSheet(0).addCell(new Label(1, i, String.valueOf(ap.getCount())));
  			workbook.getSheet(0).addCell(new Label(2, i, String.format("%.2f", percent) + "%"));
  		}
  		
  		workbook.getSheet(0).addCell(new Label(0, list.size()+1, "합계", cellFormat));
  		workbook.getSheet(0).addCell(new Label(1, list.size()+1, String.valueOf(list.get(0).getCount()), cellFormat));
  		workbook.getSheet(0).addCell(new Label(2, list.size()+1, "100%", cellFormat));
  		
  		workbook.getSheet(0).setColumnView(0, 100);
  		workbook.getSheet(0).setColumnView(1, 20);
  		workbook.getSheet(0).setColumnView(2, 20);
  		
  		return workbook;
		
	}

}
