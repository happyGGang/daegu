package kr.go.gbelib.app.cms.module.bookDelivery;

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

public class BookDeliveryExcelWorkBook {

	protected WritableWorkbook workbookForm(WritableWorkbook workbook, List<BookDelivery> list, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String sheetName = "관리자용 택배 페이지";
		
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
		workbook.getSheet(0).setColumnView(0,  15);
		workbook.getSheet(0).setColumnView(1,  25);
		workbook.getSheet(0).setColumnView(2,  25);
		workbook.getSheet(0).setColumnView(3,  10);
		workbook.getSheet(0).setColumnView(4,  15);
		workbook.getSheet(0).setColumnView(5,  15);
		workbook.getSheet(0).setColumnView(6,  10);
		workbook.getSheet(0).setColumnView(7,  25);
		workbook.getSheet(0).setColumnView(8,  20);
		workbook.getSheet(0).setColumnView(9,  10);
		workbook.getSheet(0).setColumnView(10,  10);
		workbook.getSheet(0).setColumnView(11,  15);
		workbook.getSheet(0).setColumnView(12,  15);
		
		int column = 0;
		// 헤더 컬럼 지정
		workbook.getSheet(0).addCell(new Label(0, 0, "발송요청일", format));
		workbook.getSheet(0).addCell(new Label(1, 0, "주제", format));
		workbook.getSheet(0).addCell(new Label(2, 0, "책꾸러미명", format));
		workbook.getSheet(0).addCell(new Label(3, 0, "대출기간", format));
		workbook.getSheet(0).addCell(new Label(4, 0, "학교명", format));
		workbook.getSheet(0).addCell(new Label(5, 0, "신청자", format));
		workbook.getSheet(0).addCell(new Label(6, 0, "휴대폰", format));
		workbook.getSheet(0).addCell(new Label(7, 0, "주소", format));
		workbook.getSheet(0).addCell(new Label(8, 0, "수령 및 반납장소", format));
		workbook.getSheet(0).addCell(new Label(9, 0, "학교연락처", format));
		workbook.getSheet(0).addCell(new Label(10, 0, "권수", format));
		workbook.getSheet(0).addCell(new Label(11, 0, "반송요청일", format));
		workbook.getSheet(0).addCell(new Label(12, 0, "상태", format));
		
		int row = 1;
		
		for ( BookDelivery one : list ) {
			
			column = 0;	
			
			workbook.getSheet(0).addCell(new Label(column++, row, one.getRequest_date(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, one.getSubject(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, one.getBook_package_name(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, one.getLoan_date(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, one.getSchool_name(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, one.getMember_name(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, one.getPhone(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, one.getAddress(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, one.getReturn_plan_place(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, one.getSchool_phone(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, Integer.toString(one.getBook_count()), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, one.getReturn_plan_date(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, one.getStatus(), format1));
			
			row++;
		}
		
		return workbook;
	}
	
}
