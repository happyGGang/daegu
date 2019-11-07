package kr.co.whalesoft.app.cms.webpageAccess;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.servlet.view.document.AbstractJExcelView;

import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableWorkbook;
import kr.co.whalesoft.framework.utils.AttachmentUtils;

public class WebpageAccessWorkbook {
	
	protected WritableWorkbook workbookForm(WritableWorkbook workbook, WebpageAccess webpageAccess, List<WebpageAccess> webpageAccessList, String sheetName, HttpServletRequest request, HttpServletResponse response) throws Exception {
		workbook.createSheet(sheetName, 0);	//시트설정
		List<WebpageAccess> list = webpageAccessList;
		
		/*String AM = "09:00";
		String PM = "13:10";*/
		
		//bold font
		WritableFont cellFont = new WritableFont(WritableFont.COURIER, 10);
	    cellFont.setBoldStyle(WritableFont.BOLD);
	    WritableCellFormat cellFormat = new WritableCellFormat(cellFont);
	    
		//header
		workbook.getSheet(0).addCell(new Label(0, 0, "일자", cellFormat));
		workbook.getSheet(0).addCell(new Label(1, 0, "횟수", cellFormat));
		workbook.getSheet(0).addCell(new Label(2, 0, "백분율", cellFormat));
		if ( webpageAccess.getSearch_type().equals("OS") ) {
			workbook.getSheet(0).addCell(new Label(3, 0, "OS", cellFormat));
		}
		else if ( webpageAccess.getSearch_type().equals("BROWSER") ) {
			workbook.getSheet(0).addCell(new Label(3, 0, "BROWSER", cellFormat));
			workbook.getSheet(0).addCell(new Label(4, 0, "BROWSER-VERSION", cellFormat));
		} 
		
		for (int i = 0; i < list.size(); i++) {
			WebpageAccess ap = list.get(i);
			int percent = (int)((new Double(ap.getResult_count()) / new Double(list.get(0).getTotal_count())) * 100);
			workbook.getSheet(0).addCell(new Label(0, i+1, ap.getResult_date()));
			workbook.getSheet(0).addCell(new Label(1, i+1, String.valueOf(ap.getResult_count())));
			workbook.getSheet(0).addCell(new Label(2, i+1, String.valueOf(percent) + "%"));
			
			if ( webpageAccess.getSearch_type().equals("OS") ) {
				workbook.getSheet(0).addCell(new Label(3, i+1, ap.getOperating_system()));
			}
			else if ( webpageAccess.getSearch_type().equals("BROWSER") ) {
				workbook.getSheet(0).addCell(new Label(3, i+1, ap.getBrowser_type()));
				workbook.getSheet(0).addCell(new Label(4, i+1, ap.getBrowser_version()));
			} 
		}
		
		workbook.getSheet(0).addCell(new Label(0, list.size()+1, "합계", cellFormat));
		workbook.getSheet(0).addCell(new Label(1, list.size()+1, String.valueOf(list.get(0).getTotal_count()), cellFormat));
		workbook.getSheet(0).addCell(new Label(2, list.size()+1, "100%", cellFormat));
		
		workbook.getSheet(0).setColumnView(0, 30);
		workbook.getSheet(0).setColumnView(1, 20);
		workbook.getSheet(0).setColumnView(2, 20);
		
		return workbook;
	}

}
