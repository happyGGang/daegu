package kr.co.whalesoft.app.cms.snsStatistics;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.view.document.AbstractJExcelView;

import jxl.write.Label;
import jxl.write.WritableWorkbook;
import kr.co.whalesoft.framework.utils.AttachmentUtils;

public class SnsStatisticsWorkbook {
	
	protected WritableWorkbook workbookForm(WritableWorkbook workbook, List<SnsStatistics> statisticsList, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String sheetName = "SNS 퍼가기 통계";	//시트이름
		workbook.createSheet(sheetName, 0);	//시트설정
		
		List<SnsStatistics> list = statisticsList;
		
		/*String AM = "09:00";
		String PM = "13:10";*/
		
		//header
		workbook.getSheet(0).addCell(new Label(0, 0, "메뉴명"));
		workbook.getSheet(0).addCell(new Label(1, 0, "트위터"));
		workbook.getSheet(0).addCell(new Label(2, 0, "페이스북"));
		workbook.getSheet(0).addCell(new Label(3, 0, "카카오스토리"));
		
		for (int i = 0; i < list.size(); i++) {
			SnsStatistics ap = list.get(i);
			workbook.getSheet(0).addCell(new Label(0, i+1, ap.getMenu_name()));
			workbook.getSheet(0).addCell(new Label(1, i+1, String.valueOf(ap.getTwitter())));
			workbook.getSheet(0).addCell(new Label(2, i+1, String.valueOf(ap.getFacebook())));
			workbook.getSheet(0).addCell(new Label(3, i+1, String.valueOf(ap.getKakaostory())));
		}
		
		workbook.getSheet(0).setColumnView(0, 100);
		workbook.getSheet(0).setColumnView(1, 20);
		workbook.getSheet(0).setColumnView(2, 20);
		workbook.getSheet(0).setColumnView(3, 20);
		
		/*workbook.getSheet(0).setColumnView(0, 20);*/
		
		return workbook;
	}

}
