package kr.go.gbelib.app.cms.module.bestPracticesContest;

import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jxl.format.Alignment;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.format.Colour;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableWorkbook;

public class BestPracticesContestWorkbook {
	
	protected WritableWorkbook workbookForm(WritableWorkbook workbook, List<BestPracticesContest> bestPracticesContestList, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String sheetName = "독서릴레이 우수 사례 공모 리스트";	//시트이름
		workbook.createSheet(sheetName, 0);	//시트설정

		// 헤더 스타일
		WritableCellFormat format = new WritableCellFormat();
		format.setAlignment(Alignment.CENTRE);
		format.setBackground(Colour.LIGHT_GREEN);

		// 중앙정렬
		WritableCellFormat format1 = new WritableCellFormat();
		format1.setAlignment(Alignment.CENTRE);

		// 테두리선,중앙정렬
		WritableCellFormat format2 = new WritableCellFormat();
		format2.setBorder(Border.ALL, BorderLineStyle.MEDIUM);

		// 중앙정렬,배경색,테두리 색
		WritableCellFormat format3 = new WritableCellFormat();
		format3.setAlignment(Alignment.CENTRE);
		format3.setBackground(Colour.LIGHT_GREEN);
		format3.setBorder(Border.ALL, BorderLineStyle.MEDIUM);
		
		// 컬럼 폭 지정
		workbook.getSheet(0).setColumnView(0, 10);
		workbook.getSheet(0).setColumnView(1, 30);
		workbook.getSheet(0).setColumnView(2, 80);
		workbook.getSheet(0).setColumnView(3, 20);
		workbook.getSheet(0).setColumnView(4, 20);
		workbook.getSheet(0).setColumnView(5, 30);
		workbook.getSheet(0).setColumnView(6, 80);
		workbook.getSheet(0).setColumnView(7, 20);

		workbook.getSheet(0).addCell(new Label(0, 0, String.format(sheetName), format1));
		workbook.getSheet(0).mergeCells(0, 0, 7, 0);
		
		int column = 0;
		// 헤더 컬럼 지정
		workbook.getSheet(0).addCell(new Label(column++, 1, "번호", format));
		workbook.getSheet(0).addCell(new Label(column++, 1, "공모분야", format));
		workbook.getSheet(0).addCell(new Label(column++, 1, "제목", format));
		workbook.getSheet(0).addCell(new Label(column++, 1, "작성자", format));
		workbook.getSheet(0).addCell(new Label(column++, 1, "연락처", format));
		workbook.getSheet(0).addCell(new Label(column++, 1, "이메일", format));
		workbook.getSheet(0).addCell(new Label(column++, 1, "주소", format));
		workbook.getSheet(0).addCell(new Label(column++, 1, "작성일", format));
		
		int row = 2;
		for (BestPracticesContest org : bestPracticesContestList) {
			
			String contestField = "";
			if (org.getContest_field().equals("1")) {
				contestField = "개인 | 소년부(초등~중등)";
			} else if (org.getContest_field().equals("2")) {
				contestField = "개인 | 장년부(고등~일반)";
			} else if (org.getContest_field().equals("3")) {
				contestField = "단체 | 소년부(초등~중등)";
			} else if (org.getContest_field().equals("4")) {
				contestField = "단체 | 장년부(고등~일반)";
			}
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String addDate = sdf.format(org.getAdd_date());

			column = 0;
			workbook.getSheet(0).addCell(new Label(column++, row, String.valueOf((row-1)), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, contestField, format1));
			workbook.getSheet(0).addCell(new Label(column++, row, org.getTitle(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, org.getUser_name(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, org.getUser_phone(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, org.getUser_email(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, org.getUser_address(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, addDate, format1));
			
			row++;
		}
		
		return workbook;
	}
}
