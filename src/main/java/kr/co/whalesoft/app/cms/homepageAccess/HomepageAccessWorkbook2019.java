package kr.co.whalesoft.app.cms.homepageAccess;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableWorkbook;

public class HomepageAccessWorkbook2019 {

	protected WritableWorkbook workbookForm(WritableWorkbook workbook, HomepageAccess homepageAccess, List<HomepageAccess> homepageAccessList, String sheetName, HttpServletRequest request, HttpServletResponse response) throws Exception {
		workbook.createSheet(sheetName, 0);	//시트설정

		//bold font
		WritableFont cellFont = new WritableFont(WritableFont.COURIER, 10);
	    cellFont.setBoldStyle(WritableFont.BOLD);
	    WritableCellFormat cellFormat = new WritableCellFormat(cellFont);

		//header
		workbook.getSheet(0).addCell(new Label(0, 0, "일자", cellFormat));
		workbook.getSheet(0).addCell(new Label(1, 0, "PC 접속자 수", cellFormat));
		workbook.getSheet(0).addCell(new Label(2, 0, "모바일 접속자 수", cellFormat));
		workbook.getSheet(0).addCell(new Label(3, 0, "합계", cellFormat));

		long total = 0;
		long pc = 0;
		long mobile = 0;
		for (int i = 0; i < homepageAccessList.size(); i++) {
			HomepageAccess ap = homepageAccessList.get(i);
			workbook.getSheet(0).addCell(new Label(0, i+1, ap.getResult_date()));
			workbook.getSheet(0).addCell(new Label(1, i+1, String.valueOf(ap.getPc_count())));
			workbook.getSheet(0).addCell(new Label(2, i+1, String.valueOf(ap.getMobile_count())));
			workbook.getSheet(0).addCell(new Label(3, i+1, String.valueOf(ap.getTotal_count())));
			pc += ap.getPc_count();
			mobile += ap.getMobile_count();
			total += ap.getTotal_count();
		}

		workbook.getSheet(0).addCell(new Label(0, homepageAccessList.size()+1, "합계", cellFormat));
		workbook.getSheet(0).addCell(new Label(1, homepageAccessList.size()+1, String.valueOf(pc), cellFormat));
		workbook.getSheet(0).addCell(new Label(2, homepageAccessList.size()+1, String.valueOf(mobile), cellFormat));
		workbook.getSheet(0).addCell(new Label(3, homepageAccessList.size()+1, String.valueOf(total), cellFormat));

		workbook.getSheet(0).setColumnView(0, 30);
		workbook.getSheet(0).setColumnView(1, 20);
		workbook.getSheet(0).setColumnView(2, 20);
		workbook.getSheet(0).setColumnView(3, 30);

		return workbook;

	}

}
