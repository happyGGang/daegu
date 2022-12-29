package kr.go.gbelib.app.cms.module.pictureBook;

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

public class PictureBookWorkbook {

	protected WritableWorkbook workbookForm(WritableWorkbook workbook, String pay, List<PictureBook> pictureBookLoanList, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String sheetName = "그림책 원화("+pay+")";
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
		workbook.getSheet(0).setColumnView(0,  35);
		workbook.getSheet(0).setColumnView(1,  10);
		workbook.getSheet(0).setColumnView(2,  15);
		workbook.getSheet(0).setColumnView(3,  10);
		workbook.getSheet(0).setColumnView(4,  15);
		workbook.getSheet(0).setColumnView(5,  15);
		workbook.getSheet(0).setColumnView(6,  40);
		workbook.getSheet(0).setColumnView(7,  20);
		workbook.getSheet(0).setColumnView(8,  10);
		
		// 헤더 컬럼 지정
		workbook.getSheet(0).addCell(new Label(0, 0, "원화 꾸러미명", format));
		workbook.getSheet(0).addCell(new Label(1, 0, "대출기간", format));
		workbook.getSheet(0).addCell(new Label(2, 0, "학교명", format));
		workbook.getSheet(0).addCell(new Label(3, 0, "신청자", format));
		workbook.getSheet(0).addCell(new Label(4, 0, "휴대폰", format));
		workbook.getSheet(0).addCell(new Label(5, 0, "학교 연락처", format));
		workbook.getSheet(0).addCell(new Label(5, 0, "택배 배송장소", format));
		workbook.getSheet(0).addCell(new Label(6, 0, "신청사유 및 기타요청사항", format));
		workbook.getSheet(0).addCell(new Label(7, 0, "신청일자", format));
		workbook.getSheet(0).addCell(new Label(8, 0, "진행상태", format));
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		
		int row = 1;
		for(PictureBook one : pictureBookLoanList) {
			workbook.getSheet(0).addCell(new Label(0, row, one.getPicture_book_subject()));
			workbook.getSheet(0).addCell(new Label(1, row, one.getLoan_year() + "-" + one.getLoan_month()));
			workbook.getSheet(0).addCell(new Label(2, row, one.getSchool_name()));
			workbook.getSheet(0).addCell(new Label(3, row, one.getRequest_name()));
			workbook.getSheet(0).addCell(new Label(4, row, one.getPhone()));
			workbook.getSheet(0).addCell(new Label(5, row, one.getSchool_tel()));
			workbook.getSheet(0).addCell(new Label(6, row, one.getRequest_content()));
			workbook.getSheet(0).addCell(new Label(7, row, sdf.format(one.getAdd_date())));
			
			String status = "";
			switch (Integer.valueOf(one.getRequest_status())) {
				case 1 : status = "신청완료";
					break;
				case 2 : status = "대출중";
					break;
				case 3 : status = "반납신청";
					break;
				case 4 : status = "반납요청완료";
					break;
				case 5 : status = "반납완료";
					break;
				case 6 : status = "대출불가";
					break;
				case 7 : status = "예약완료";
					break;
				default :
					break;
			}
			workbook.getSheet(0).addCell(new Label(8, row, status));
			
			row++;
		}
		
		return workbook;
	}
	
}
