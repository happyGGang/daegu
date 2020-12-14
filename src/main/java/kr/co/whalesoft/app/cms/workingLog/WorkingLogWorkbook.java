package kr.co.whalesoft.app.cms.workingLog;

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

public class WorkingLogWorkbook {
	
	protected WritableWorkbook workbookForm(WritableWorkbook workbook, List<WorkingLog> workingLogList, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String sheetName = "작업 이력 리스트";	//시트이름
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
		workbook.getSheet(0).setColumnView(1, 20);
		workbook.getSheet(0).setColumnView(2, 20);
		workbook.getSheet(0).setColumnView(3, 50);
		workbook.getSheet(0).setColumnView(4, 20);
		workbook.getSheet(0).setColumnView(5, 20);
		workbook.getSheet(0).setColumnView(6, 30);
		workbook.getSheet(0).setColumnView(7, 20);
		workbook.getSheet(0).setColumnView(8, 20);

		workbook.getSheet(0).addCell(new Label(0, 0, String.format(sheetName), format1));
		workbook.getSheet(0).mergeCells(0, 0, 8, 0);
		
		int column = 0;
		// 헤더 컬럼 지정
		workbook.getSheet(0).addCell(new Label(column++, 1, "번호", format));
		workbook.getSheet(0).addCell(new Label(column++, 1, "사이트", format));
		workbook.getSheet(0).addCell(new Label(column++, 1, "작업구분", format));
		workbook.getSheet(0).addCell(new Label(column++, 1, "작업내용", format));
		workbook.getSheet(0).addCell(new Label(column++, 1, "작업명령어", format));
		workbook.getSheet(0).addCell(new Label(column++, 1, "작업결과수", format));
		workbook.getSheet(0).addCell(new Label(column++, 1, "작업일시", format));
		workbook.getSheet(0).addCell(new Label(column++, 1, "작성IP", format));
		workbook.getSheet(0).addCell(new Label(column++, 1, "사용자ID", format));
		
		int row = 2;
		for (WorkingLog org : workingLogList) {
			
			String workType = "";
			if (org.getWork_type().equals("W")) {
				workType = "일반작업";
			} else if (org.getWork_type().equals("P")) {
				workType = "개인정보";
			}
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String workDate = sdf.format(org.getWork_date());

			column = 0;
			workbook.getSheet(0).addCell(new Label(column++, row, String.valueOf((row-1)), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, org.getSiteName(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, workType, format1));
			workbook.getSheet(0).addCell(new Label(column++, row, org.getWork_comment(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, org.getWork_command(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, Integer.toString(org.getWork_result_count()), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, workDate, format1));
			workbook.getSheet(0).addCell(new Label(column++, row, org.getWork_ip(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, org.getMember_id(), format1));
			
			row++;
		}
		
		return workbook;
	}
}
