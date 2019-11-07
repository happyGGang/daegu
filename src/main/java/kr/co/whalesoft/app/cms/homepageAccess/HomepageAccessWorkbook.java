package kr.co.whalesoft.app.cms.homepageAccess;

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
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.framework.utils.AttachmentUtils;

public class HomepageAccessWorkbook {
	
	protected WritableWorkbook workbookForm(WritableWorkbook workbook, HomepageAccess homepageAccess, List<HomepageAccess> homepageAccessList, String sheetName, HttpServletRequest request, HttpServletResponse response) throws Exception {
		workbook.createSheet(sheetName, 0);	//시트설정
		
		/*String AM = "09:00";
		String PM = "13:10";*/
		
		//bold font
		WritableFont cellFont = new WritableFont(WritableFont.COURIER, 10);
	    cellFont.setBoldStyle(WritableFont.BOLD);
	    WritableCellFormat cellFormat = new WritableCellFormat(cellFont);
	    
		//header
		workbook.getSheet(0).addCell(new Label(0, 0, "일자", cellFormat));
		workbook.getSheet(0).addCell(new Label(1, 0, "접속자수", cellFormat));
		workbook.getSheet(0).addCell(new Label(2, 0, "백분율", cellFormat));
		if ( homepageAccess.getSearch_type().equals("OS") ) {
			workbook.getSheet(0).addCell(new Label(3, 0, "OS", cellFormat));
		}
		else if ( homepageAccess.getSearch_type().equals("BROWSER") ) {
			workbook.getSheet(0).addCell(new Label(3, 0, "BROWSER", cellFormat));
			workbook.getSheet(0).addCell(new Label(4, 0, "BROWSER-VERSION", cellFormat));
		} else if ( homepageAccess.getSearch_type().equals("DEVICE") ) {
			workbook.getSheet(0).addCell(new Label(3, 0, "DEVICE", cellFormat));
		}
		
		for (int i = 0; i < homepageAccessList.size(); i++) {
			HomepageAccess ap = homepageAccessList.get(i);
			int percent = (int)((new Double(ap.getResult_count()) / new Double(homepageAccessList.get(0).getTotal_count())) * 100);
			workbook.getSheet(0).addCell(new Label(0, i+1, ap.getResult_date()));
			workbook.getSheet(0).addCell(new Label(1, i+1, String.valueOf(ap.getResult_count())));
			workbook.getSheet(0).addCell(new Label(2, i+1, String.valueOf(percent) + "%"));
			
			if ( homepageAccess.getSearch_type().equals("OS") ) {
				workbook.getSheet(0).addCell(new Label(3, i+1, ap.getOperating_system()));
			}
			else if ( homepageAccess.getSearch_type().equals("BROWSER") ) {
				workbook.getSheet(0).addCell(new Label(3, i+1, ap.getBrowser_type()));
				workbook.getSheet(0).addCell(new Label(4, i+1, ap.getBrowser_version()));
			} else if ( homepageAccess.getSearch_type().equals("DEVICE") ) {
				workbook.getSheet(0).addCell(new Label(3, i+1, ap.getAccess_system()));
			}
		}
		
		workbook.getSheet(0).addCell(new Label(0, homepageAccessList.size()+1, "합계", cellFormat));
		workbook.getSheet(0).addCell(new Label(1, homepageAccessList.size()+1, String.valueOf(homepageAccessList.get(0).getTotal_count()), cellFormat));
		workbook.getSheet(0).addCell(new Label(2, homepageAccessList.size()+1, "100%", cellFormat));
		
		workbook.getSheet(0).setColumnView(0, 30);
		workbook.getSheet(0).setColumnView(1, 20);
		workbook.getSheet(0).setColumnView(2, 20);
		
		return workbook;
		
	}

}
