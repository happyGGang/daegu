package kr.co.whalesoft.app.cms.menu.menuAccess;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.view.document.AbstractJExcelView;

import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableWorkbook;
import kr.co.whalesoft.framework.utils.AttachmentUtils;

public class MenuAccessWorkbook {
	
	protected WritableWorkbook workbookForm(WritableWorkbook workbook, List<MenuAccess> menuAccessList, String sheetName, HttpServletRequest request, HttpServletResponse response) throws Exception {
		workbook.createSheet(sheetName, 0);	//시트설정
		List<MenuAccess> list = menuAccessList;
		
		/*String AM = "09:00";
		String PM = "13:10";*/
		
		//bold font
		WritableFont cellFont = new WritableFont(WritableFont.COURIER, 10);
	    cellFont.setBoldStyle(WritableFont.BOLD);
	    WritableCellFormat cellFormat = new WritableCellFormat(cellFont);
		
		//header
		workbook.getSheet(0).addCell(new Label(0, 0, "메뉴명", cellFormat));
		workbook.getSheet(0).addCell(new Label(1, 0, "접속자수", cellFormat));
		workbook.getSheet(0).addCell(new Label(2, 0, "백분율", cellFormat));
		
		for (int i = 0; i < list.size(); i++) {
			MenuAccess ap = list.get(i);
			int percent = (int)((new Double(ap.getAccess_count()) / new Double(list.get(0).getTotal_count())) * 100);
			workbook.getSheet(0).addCell(new Label(0, i+1, ap.getMenu_name()));
			workbook.getSheet(0).addCell(new Label(1, i+1, String.valueOf(ap.getAccess_count())));
			workbook.getSheet(0).addCell(new Label(2, i+1, String.valueOf(percent) + "%"));
		}
		
		workbook.getSheet(0).addCell(new Label(0, list.size()+1, "합계", cellFormat));
		workbook.getSheet(0).addCell(new Label(1, list.size()+1, String.valueOf(list.get(0).getTotal_count()), cellFormat));
		workbook.getSheet(0).addCell(new Label(2, list.size()+1, "100%", cellFormat));
		
		workbook.getSheet(0).setColumnView(0, 100);
		workbook.getSheet(0).setColumnView(1, 20);
		workbook.getSheet(0).setColumnView(2, 20);
		
		/*workbook.getSheet(0).setColumnView(0, 20);*/
		
		return workbook;
	}

}
