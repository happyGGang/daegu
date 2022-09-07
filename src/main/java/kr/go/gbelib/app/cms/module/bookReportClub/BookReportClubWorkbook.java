package kr.go.gbelib.app.cms.module.bookReportClub;

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

public class BookReportClubWorkbook {
	
	protected WritableWorkbook workbookForm(WritableWorkbook workbook, List<BookReportClub> bookReportContestList, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String sheetName = "독서동아리경연대회 공모 리스트";	//시트이름
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
		workbook.getSheet(0).setColumnView(3, 30);
		workbook.getSheet(0).setColumnView(4, 20);
		workbook.getSheet(0).setColumnView(5, 20);
		workbook.getSheet(0).setColumnView(6, 30);
		workbook.getSheet(0).setColumnView(7, 50);
		workbook.getSheet(0).setColumnView(8, 20);
		workbook.getSheet(0).setColumnView(9, 10);


		workbook.getSheet(0).addCell(new Label(0, 0, String.format(sheetName), format1));
		workbook.getSheet(0).mergeCells(0, 0, 9, 0);
		
		int column = 0;
		// 헤더 컬럼 지정
		workbook.getSheet(0).addCell(new Label(column++, 1, "번호", format));
		workbook.getSheet(0).addCell(new Label(column++, 1, "참여분야", format));
		workbook.getSheet(0).addCell(new Label(column++, 1, "동아리명", format));
		workbook.getSheet(0).addCell(new Label(column++, 1, "대표자명", format));
		workbook.getSheet(0).addCell(new Label(column++, 1, "휴대폰(제1 연락처)", format));
		workbook.getSheet(0).addCell(new Label(column++, 1, "휴대폰(제2 연락처)", format));
		workbook.getSheet(0).addCell(new Label(column++, 1, "이메일", format));
		workbook.getSheet(0).addCell(new Label(column++, 1, "주소", format));
		workbook.getSheet(0).addCell(new Label(column++, 1, "등록일", format));
		workbook.getSheet(0).addCell(new Label(column++, 1, "상태", format));
		
		int row = 2;
		for (BookReportClub org : bookReportContestList) {
			
			String participationField = "";
			if (org.getParticipation_field().equals("0")) {
				participationField = "소년부(초등~중등)";
			} else if (org.getParticipation_field().equals("1")) {
				participationField = "장년부(고등~일반)";
			}
			
			String address = "(" + org.getPostcode() + ") " + org.getAddress_base() + " " + org.getAddress_detailed();
			
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
			workbook.getSheet(0).addCell(new Label(column++, row, participationField, format1));
			workbook.getSheet(0).addCell(new Label(column++, row, org.getClub_name(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, org.getRep_name(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, org.getUser_phone(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, org.getUser_phone2(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, org.getUser_email(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, address, format1));
			workbook.getSheet(0).addCell(new Label(column++, row, addDate, format1));
			workbook.getSheet(0).addCell(new Label(column++, row, approvalStatus, format1));
			
			row++;
		}
		
		return workbook;
	}
}
