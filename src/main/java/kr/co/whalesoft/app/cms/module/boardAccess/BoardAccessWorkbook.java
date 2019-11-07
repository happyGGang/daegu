package kr.co.whalesoft.app.cms.module.boardAccess;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableWorkbook;

public class BoardAccessWorkbook {
	
	public WritableWorkbook workbookForm(WritableWorkbook workbook, List<BoardAccess> boardList, int total_count, String sheetName, HttpServletRequest request, HttpServletResponse response) throws Exception {
		workbook.createSheet(sheetName, 0);	//시트설정
		List<BoardAccess> list = boardList;
		
		/*String AM = "09:00";
		String PM = "13:10";*/
		
		//bold font
		WritableFont cellFont = new WritableFont(WritableFont.COURIER, 10);
	    cellFont.setBoldStyle(WritableFont.BOLD);
	    WritableCellFormat cellFormat = new WritableCellFormat(cellFont);
	    
	  //header
  		workbook.getSheet(0).addCell(new Label(0, 0, "도서관명", cellFormat));
  		workbook.getSheet(0).addCell(new Label(1, 0, "게시판명", cellFormat));
  		workbook.getSheet(0).addCell(new Label(2, 0, "글 등록 수", cellFormat));
  		workbook.getSheet(0).addCell(new Label(3, 0, "백분율", cellFormat));
  		
  		
  		for (int i = 0; i < list.size(); i++) {
  			BoardAccess ap = list.get(i);
  			double percent = (new Double(ap.getCount()) / new Double(total_count)) * 100;
  			workbook.getSheet(0).addCell(new Label(0, i+1, ap.getHomepage_name()));
  			workbook.getSheet(0).addCell(new Label(1, i+1, ap.getBoard_name()));
  			workbook.getSheet(0).addCell(new Label(2, i+1, String.valueOf(ap.getCount())));
  			workbook.getSheet(0).addCell(new Label(3, i+1, String.format("%.2f", percent) + "%"));
  		}
  		
  		workbook.getSheet(0).addCell(new Label(0, list.size()+1, "합계", cellFormat));
  		workbook.getSheet(0).addCell(new Label(2, list.size()+1, String.valueOf(total_count), cellFormat));
  		workbook.getSheet(0).addCell(new Label(3, list.size()+1, "100%", cellFormat));
  		
  		workbook.getSheet(0).setColumnView(0, 50);
  		workbook.getSheet(0).setColumnView(1, 50);
  		workbook.getSheet(0).setColumnView(2, 20);
  		workbook.getSheet(0).setColumnView(3, 20);
		
  		return workbook;
	}

}
