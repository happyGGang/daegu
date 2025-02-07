package kr.go.gbelib.app.cms.module.thinkPocketPackage;

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

public class ThinkPocketPackageWorkbook {

	protected WritableWorkbook workbookForm(WritableWorkbook workbook, String editMode, List<ThinkPocketPackage> thinkPocketPackageList, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String sheetName = "";
		if(editMode.equals("thinkPocketPackage")) {
			sheetName = "책 꾸러미 리스트";	//시트이름
		} else if(editMode.equals("thinkPocketPackageLoan")) {
			sheetName = "책 꾸러미 대출신청";	//시트이름
		}
		
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

		if(editMode.equals("thinkPocketPackage")) {
			// 컬럼 폭 지정
			workbook.getSheet(0).setColumnView(0,  35);
			workbook.getSheet(0).setColumnView(1,  10);
			workbook.getSheet(0).setColumnView(2,  15);
			workbook.getSheet(0).setColumnView(3,  10);
			workbook.getSheet(0).setColumnView(4,  12);
			workbook.getSheet(0).setColumnView(5,  5);
			workbook.getSheet(0).setColumnView(6,  15);
			workbook.getSheet(0).setColumnView(7,  10);
			
			// 헤더 컬럼 지정
			workbook.getSheet(0).addCell(new Label(0, 0, "생각 주머니명", format));
			workbook.getSheet(0).addCell(new Label(1, 0, "작가", format));
			workbook.getSheet(0).addCell(new Label(2, 0, "출판사", format));
			workbook.getSheet(0).addCell(new Label(3, 0, "출판년도", format));
			workbook.getSheet(0).addCell(new Label(4, 0, "대출가능권수", format));
			workbook.getSheet(0).addCell(new Label(5, 0, "수준", format));
			workbook.getSheet(0).addCell(new Label(6, 0, "상태", format));
			
			
			int row = 1;
			for(ThinkPocketPackage one : thinkPocketPackageList) {
				workbook.getSheet(0).addCell(new Label(0, row, one.getThink_pocket_package_subject()));
				workbook.getSheet(0).addCell(new Label(1, row, one.getAuthor()));
				workbook.getSheet(0).addCell(new Label(2, row, one.getPublisher()));
				workbook.getSheet(0).addCell(new Label(3, row, String.valueOf(one.getPublish_year())));
				workbook.getSheet(0).addCell(new Label(4, row, one.getLoan_count() + "권"));

				String grade = "";
				if(one.getGrade() != null) {
          switch (one.getGrade()) {
            case "1":
              grade = "유아";
              break;
            case "2":
              grade = "초등";
              break;
          }
				} else {
					grade = "";
				}
				workbook.getSheet(0).addCell(new Label(5, row, grade));
				
				workbook.getSheet(0).addCell(new Label(6, row, one.getLender_count() > 0 ? "예약신청" : "대출신청"));
				
				row++;
			}
		} else if(editMode.equals("thinkPocketPackageLoan")) {
			// 컬럼 폭 지정
			workbook.getSheet(0).setColumnView(0,  10);
			workbook.getSheet(0).setColumnView(1,  35);
			workbook.getSheet(0).setColumnView(2,  25);
			workbook.getSheet(0).setColumnView(3,  30);
			workbook.getSheet(0).setColumnView(4,  20);
			workbook.getSheet(0).setColumnView(5,  15);
			workbook.getSheet(0).setColumnView(6,  20);
			workbook.getSheet(0).setColumnView(7,  15);
			workbook.getSheet(0).setColumnView(8,  30);
			workbook.getSheet(0).setColumnView(9,  15);

			// 헤더 컬럼 지정
			workbook.getSheet(0).addCell(new Label(1, 0, "생각 주머니명", format));
			workbook.getSheet(0).addCell(new Label(2, 0, "대출기간", format));
			workbook.getSheet(0).addCell(new Label(3, 0, "신청자", format));
			workbook.getSheet(0).addCell(new Label(4, 0, "휴대폰", format));
			workbook.getSheet(0).addCell(new Label(5, 0, "수령 및 반납장소", format));
			workbook.getSheet(0).addCell(new Label(6, 0, "신청사유", format));
			workbook.getSheet(0).addCell(new Label(7, 0, "신청일자", format));
			workbook.getSheet(0).addCell(new Label(8, 0, "상태", format));
			workbook.getSheet(0).addCell(new Label(9, 0, "권수", format));
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
			
			int row = 1;
			for(ThinkPocketPackage one : thinkPocketPackageList) {
				workbook.getSheet(0).addCell(new Label(1, row, one.getThink_pocket_package_subject()));
				workbook.getSheet(0).addCell(new Label(2, row, one.getLoan_start_date() + " ~ " + one.getLoan_end_date()));
				workbook.getSheet(0).addCell(new Label(3, row, one.getRequest_name()));
				workbook.getSheet(0).addCell(new Label(4, row, one.getPhone()));
				workbook.getSheet(0).addCell(new Label(5, row, one.getLoan_place()));
				workbook.getSheet(0).addCell(new Label(6, row, one.getRequest_content()));
				workbook.getSheet(0).addCell(new Label(7, row, sdf.format(one.getAdd_date())));
				String request_status = "";
				switch (Integer.parseInt(one.getRequest_status())) {
					case 0 :
						request_status = "신청중";
						break;
					case 1 :
						request_status = "예약상담중";
						break;
					case 2 :
						request_status = "대출중";
						break;
					case 3 :
						request_status = "반납완료";
						break;
					case 4 :
						request_status = "관리자취소";
						break;
					case 5 :
						request_status = "반납요청완료";
						break;
					case 6 :
						request_status = "승인";
						break;
				}
				workbook.getSheet(0).addCell(new Label(8, row, request_status));
				workbook.getSheet(0).addCell(new Label(9, row, one.getLoan_count() + "권"));
				
				row++;
			}
		}
		
		return workbook;
	}
	
}
