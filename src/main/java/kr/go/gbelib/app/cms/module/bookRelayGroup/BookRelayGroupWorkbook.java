package kr.go.gbelib.app.cms.module.bookRelayGroup;

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

public class BookRelayGroupWorkbook {
	
	protected WritableWorkbook workbookForm(WritableWorkbook workbook, List<BookRelayGroup> bookRelayGroupList, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String sheetName = "독서릴레이-기관 리스트";	//시트이름
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
		workbook.getSheet(0).setColumnView(2, 20);
		workbook.getSheet(0).setColumnView(3, 20);
		workbook.getSheet(0).setColumnView(4, 20);
		workbook.getSheet(0).setColumnView(5, 20);
		workbook.getSheet(0).setColumnView(6, 60);
		workbook.getSheet(0).setColumnView(7, 15);
		workbook.getSheet(0).setColumnView(8, 15);
		workbook.getSheet(0).setColumnView(9, 20);
		workbook.getSheet(0).setColumnView(10, 15);
		workbook.getSheet(0).setColumnView(11, 20);
		workbook.getSheet(0).setColumnView(12, 10);

		workbook.getSheet(0).addCell(new Label(0, 0, String.format(sheetName), format1));
		workbook.getSheet(0).mergeCells(0, 0, 7, 0);
		
		int column = 0;
		// 헤더 컬럼 지정
		workbook.getSheet(0).addCell(new Label(column++, 1, "번호", format));
		workbook.getSheet(0).addCell(new Label(column++, 1, "기관명", format));
		workbook.getSheet(0).addCell(new Label(column++, 1, "대표번호", format));
		workbook.getSheet(0).addCell(new Label(column++, 1, "담당자명", format));
		workbook.getSheet(0).addCell(new Label(column++, 1, "직장전화", format));
		workbook.getSheet(0).addCell(new Label(column++, 1, "휴대폰", format));
		workbook.getSheet(0).addCell(new Label(column++, 1, "주소", format));
		workbook.getSheet(0).addCell(new Label(column++, 1, "도서영역", format));
		workbook.getSheet(0).addCell(new Label(column++, 1, "독서노트 신청수량", format));
		workbook.getSheet(0).addCell(new Label(column++, 1, "릴레이 계획", format));
		workbook.getSheet(0).addCell(new Label(column++, 1, "릴레이 예상인원", format));
		workbook.getSheet(0).addCell(new Label(column++, 1, "등록일", format));
		workbook.getSheet(0).addCell(new Label(column++, 1, "상태", format));
		
		int row = 2;
		for (BookRelayGroup org : bookRelayGroupList) {
			
			String address = "(" + org.getPostcode() + ") " + org.getAddress_base() + " " + org.getAddress_detailed();
			
			String bookArea = "";
			if (org.getBook_area().equals("0")) {
				bookArea = "성인";
			} else if (org.getBook_area().equals("1")) {
				bookArea = "청소년";
			} else if (org.getBook_area().equals("2")) {
				bookArea = "어린이";
			}
			
			String BookQuantityStr = Integer.toString(org.getBook_quantity()) + "권";
			
			String relayPersonnelStr = Integer.toString(org.getRelay_personnel()) + "명";
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String addDate = sdf.format(org.getAdd_date());
			
			String approvalStatus = "";
			if (org.getApproval_status().equals("0")) {
				approvalStatus = "신청";
			} else if (org.getApproval_status().equals("1")) {
				approvalStatus = "승인";
			} else if (org.getApproval_status().equals("2")) {
				approvalStatus = "취소";
			}

			column = 0;
			workbook.getSheet(0).addCell(new Label(column++, row, String.valueOf((row-1)), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, org.getGroup_name(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, org.getMain_number(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, org.getManager_name(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, org.getWork_number(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, org.getUser_phone(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, address, format1));
			workbook.getSheet(0).addCell(new Label(column++, row, bookArea, format1));
			workbook.getSheet(0).addCell(new Label(column++, row, BookQuantityStr, format1));
			workbook.getSheet(0).addCell(new Label(column++, row, org.getRelay_plan(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, relayPersonnelStr, format1));
			workbook.getSheet(0).addCell(new Label(column++, row, addDate, format1));
			workbook.getSheet(0).addCell(new Label(column++, row, approvalStatus, format1));
			
			row++;
		}
		
		return workbook;
	}
}
