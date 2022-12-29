package kr.go.gbelib.app.cms.module.libraryCheck;

import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;

import jxl.format.Alignment;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.format.Colour;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableWorkbook;

public class LibraryCheckWorkbook {

	protected WritableWorkbook workbookForm(WritableWorkbook workbook, List<LibraryCheck> libraryCheckLoanList, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String sheetName = "장서점검기 신청리스트";
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
		workbook.getSheet(0).setColumnView(0,  12);
		workbook.getSheet(0).setColumnView(1,  25);
//		workbook.getSheet(0).setColumnView(2,  20);
		workbook.getSheet(0).setColumnView(2,  20);
		workbook.getSheet(0).setColumnView(3,  10);
		workbook.getSheet(0).setColumnView(4,  15);
		workbook.getSheet(0).setColumnView(5,  15);
		workbook.getSheet(0).setColumnView(6,  20);
		workbook.getSheet(0).setColumnView(7,  10);
		workbook.getSheet(0).setColumnView(8,  20);
		
		// 헤더 컬럼 지정
		workbook.getSheet(0).addCell(new Label(0, 0, "장서점검기", format));
		workbook.getSheet(0).addCell(new Label(1, 0, "대출기간", format));
//		workbook.getSheet(0).addCell(new Label(2, 0, "방문예정일자", format));
		workbook.getSheet(0).addCell(new Label(2, 0, "학교명", format));
		workbook.getSheet(0).addCell(new Label(3, 0, "신청자", format));
		workbook.getSheet(0).addCell(new Label(4, 0, "휴대폰", format));
		workbook.getSheet(0).addCell(new Label(5, 0, "학교연락처", format));
		workbook.getSheet(0).addCell(new Label(6, 0, "신청일자", format));
		workbook.getSheet(0).addCell(new Label(7, 0, "상태", format));
		workbook.getSheet(0).addCell(new Label(8, 0, "비고", format));
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		
		int row = 1;
		for(LibraryCheck one : libraryCheckLoanList) {
			workbook.getSheet(0).addCell(new Label(0, row, "장서점검기" + one.getLibrary_check_number()));
			workbook.getSheet(0).addCell(new Label(1, row, one.getLoan_start_date() + " ~ " + one.getLoan_end_date()));
//			if(StringUtils.isNotEmpty(one.getHope_start_time())) {
//				workbook.getSheet(0).addCell(new Label(2, row, one.getHope_date() + " " + one.getHope_start_time() + ":" + one.getHope_start_minute()));
//			} else {
//				workbook.getSheet(0).addCell(new Label(2, row, one.getHope_date()));
//			}
			workbook.getSheet(0).addCell(new Label(2, row, one.getSchool_name()));
			workbook.getSheet(0).addCell(new Label(3, row, one.getRequest_name()));
			workbook.getSheet(0).addCell(new Label(4, row, one.getPhone()));
			workbook.getSheet(0).addCell(new Label(5, row, one.getSchool_tel()));
			workbook.getSheet(0).addCell(new Label(6, row, sdf.format(one.getAdd_date())));
			
			String status = "";
			switch (Integer.valueOf(one.getRequest_status())) {
				case 0 : status = "신청중";
					break;
				case 1 : status = "예약중";
					break;
				case 2 : status = "대출중";
					break;
				case 3 : status = "반납완료";
					break;
				case 4 : status = "관리자취소";
					break;
				case 5 : status = "반납요청완료";
					break;
				case 6 : status = "수리중";
				break;
				default :
					break;
			}
			workbook.getSheet(0).addCell(new Label(7, row, status));
			workbook.getSheet(0).addCell(new Label(8, row, one.getRemark()));
			
			row++;
		}
		
		return workbook;
	}
	
}
