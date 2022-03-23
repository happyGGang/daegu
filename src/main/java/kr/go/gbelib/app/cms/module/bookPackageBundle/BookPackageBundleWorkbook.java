package kr.go.gbelib.app.cms.module.bookPackageBundle;

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

public class BookPackageBundleWorkbook {

	protected WritableWorkbook workbookForm(WritableWorkbook workbook, String editMode, List<BookPackageBundle> bookPackageBundleList, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String sheetName = "";
		if(editMode.equals("bookPackage")) {
			sheetName = "책 꾸러미 리스트";
		} else if(editMode.equals("bookPackageLoan")) {
			sheetName = "책 꾸러미 대출신청";
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

		if(editMode.equals("bookPackage")) {
			// 컬럼 폭 지정
			workbook.getSheet(0).setColumnView(0,  15);
			workbook.getSheet(0).setColumnView(1,  35);
			workbook.getSheet(0).setColumnView(2,  10);
			workbook.getSheet(0).setColumnView(3,  10);
			workbook.getSheet(0).setColumnView(4,  10);
			workbook.getSheet(0).setColumnView(5,  10);
			workbook.getSheet(0).setColumnView(6,  10);
			workbook.getSheet(0).setColumnView(7,  5);
			workbook.getSheet(0).setColumnView(8,  10);
			workbook.getSheet(0).setColumnView(9,  10);
			
			// 헤더 컬럼 지정
			workbook.getSheet(0).addCell(new Label(0, 0, "책꾸러미명", format));
			workbook.getSheet(0).addCell(new Label(1, 0, "도서명", format));
			workbook.getSheet(0).addCell(new Label(2, 0, "작가", format));
			workbook.getSheet(0).addCell(new Label(3, 0, "출판사", format));
			workbook.getSheet(0).addCell(new Label(4, 0, "출판년도", format));
			workbook.getSheet(0).addCell(new Label(5, 0, "대출가능권수", format));
			workbook.getSheet(0).addCell(new Label(6, 0, "소장권수", format));
			workbook.getSheet(0).addCell(new Label(7, 0, "수준", format));
			workbook.getSheet(0).addCell(new Label(8, 0, "주류", format));
			workbook.getSheet(0).addCell(new Label(9, 0, "상태", format));
			
			
			int row = 1;
			for(BookPackageBundle one : bookPackageBundleList) {
				workbook.getSheet(0).addCell(new Label(0, row, one.getBook_package_bundle_title()));
				workbook.getSheet(0).addCell(new Label(1, row, one.getBook_package_name()));
				workbook.getSheet(0).addCell(new Label(2, row, one.getAuthor()));
				workbook.getSheet(0).addCell(new Label(3, row, one.getPublisher()));
				workbook.getSheet(0).addCell(new Label(4, row, String.valueOf(one.getPublish_year())));
				workbook.getSheet(0).addCell(new Label(5, row, one.getLoan_count() + "권"));
				workbook.getSheet(0).addCell(new Label(6, row, (one.getQuantity() != null ? one.getQuantity() : "0") + "권"));
				
				String grade = "";
				if(one.getGrade() != null) {
					if(one.getGrade().equals("3")) {
						grade = "초등";
					} else if(one.getGrade().equals("4")) {
						grade = "중등";
					} else if(one.getGrade().equals("5")) {
						grade = "고등";
					}
				} else {
					grade = "";
				}
				workbook.getSheet(0).addCell(new Label(7, row, grade));
				
				String category = "";
				if(one.getCategory() != null) {
					String[] cateArr = one.getCategory().split(",");
					for(int i = 0; i < cateArr.length; i++) {
						String cate = cateArr[i];
						if(cate.equals("000")) {
							category += "총류";
						} else if(cate.equals("100")) {
							category += "철학";
						} else if(cate.equals("200")) {
							category += "종교";
						} else if(cate.equals("300")) {
							category += "사회과학";
						} else if(cate.equals("400")) {
							category += "자연과학";
						} else if(cate.equals("500")) {
							category += "기술과학";
						} else if(cate.equals("600")) {
							category += "예술";
						} else if(cate.equals("700")) {
							category += "언어";
						} else if(cate.equals("800")) {
							category += "문학";
						} else if(cate.equals("900")) {
							category += "역사";
						}
						category += i != cateArr.length-1 ? "," : "";
					}
				}
				workbook.getSheet(0).addCell(new Label(8, row, category));
				String request_status = "";
				if (one.getRequest_status() != null) {
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
					}
				} else {
					request_status = "";
				}
				
				workbook.getSheet(0).addCell(new Label(9, row, request_status));
				row++;
			}
		} else if(editMode.equals("bookPackageLoan")) {
			// 컬럼 폭 지정
			workbook.getSheet(0).setColumnView(0,  10);
			workbook.getSheet(0).setColumnView(1,  10);
			workbook.getSheet(0).setColumnView(2,  35);
			workbook.getSheet(0).setColumnView(3,  25);
			workbook.getSheet(0).setColumnView(4,  30);
			workbook.getSheet(0).setColumnView(5,  20);
			workbook.getSheet(0).setColumnView(6,  15);
			workbook.getSheet(0).setColumnView(7,  15);
			workbook.getSheet(0).setColumnView(8,  30);
			workbook.getSheet(0).setColumnView(9,  15);
			workbook.getSheet(0).setColumnView(10,  10);
			workbook.getSheet(0).setColumnView(11, 10);
			
			// 헤더 컬럼 지정
			workbook.getSheet(0).addCell(new Label(0, 0, "주제", format));
			workbook.getSheet(0).addCell(new Label(1, 0, "책꾸러미명", format));
			workbook.getSheet(0).addCell(new Label(2, 0, "책제목", format));
			workbook.getSheet(0).addCell(new Label(3, 0, "대출기간", format));
			workbook.getSheet(0).addCell(new Label(4, 0, "학교명", format));
			workbook.getSheet(0).addCell(new Label(5, 0, "신청자", format));
			workbook.getSheet(0).addCell(new Label(6, 0, "휴대폰", format));
			workbook.getSheet(0).addCell(new Label(7, 0, "학교 연락처", format));
			workbook.getSheet(0).addCell(new Label(8, 0, "신청사유", format));
			workbook.getSheet(0).addCell(new Label(9, 0, "신청일자", format));
			workbook.getSheet(0).addCell(new Label(10, 0, "상태", format));
			workbook.getSheet(0).addCell(new Label(11, 0, "권수", format));
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
			
			int row = 1;
			for(BookPackageBundle one : bookPackageBundleList) {
				String category = "";
				if(one.getCategory() != null) {
					String[] cateArr = one.getCategory().split(",");
					for(int i = 0; i < cateArr.length; i++) {
						String cate = cateArr[i];
						if(cate.equals("000")) {
							category += "총류";
						} else if(cate.equals("100")) {
							category += "철학";
						} else if(cate.equals("200")) {
							category += "종교";
						} else if(cate.equals("300")) {
							category += "사회과학";
						} else if(cate.equals("400")) {
							category += "자연과학";
						} else if(cate.equals("500")) {
							category += "기술과학";
						} else if(cate.equals("600")) {
							category += "예술";
						} else if(cate.equals("700")) {
							category += "언어";
						} else if(cate.equals("800")) {
							category += "문학";
						} else if(cate.equals("900")) {
							category += "역사";
						}
						category += i != cateArr.length-1 ? "," : "";
					}
				}
				workbook.getSheet(0).addCell(new Label(0, row, category));
				workbook.getSheet(0).addCell(new Label(1, row, one.getBook_package_bundle_title()));
				workbook.getSheet(0).addCell(new Label(2, row, one.getBook_package_name()));
				workbook.getSheet(0).addCell(new Label(3, row, one.getLoan_start_date() + " ~ " + one.getLoan_end_date()));
				workbook.getSheet(0).addCell(new Label(4, row, one.getSchool_name()));
				workbook.getSheet(0).addCell(new Label(5, row, one.getRequest_name()));
				workbook.getSheet(0).addCell(new Label(6, row, one.getPhone()));
				workbook.getSheet(0).addCell(new Label(7, row, one.getSchool_tel()));
				workbook.getSheet(0).addCell(new Label(8, row, one.getRequest_content()));
				workbook.getSheet(0).addCell(new Label(9, row, sdf.format(one.getAdd_date())));
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
				}
				workbook.getSheet(0).addCell(new Label(10, row, request_status));
				workbook.getSheet(0).addCell(new Label(11, row, one.getLoan_count() + "권"));
				
				row++;
			}
		}
		return workbook;
	}
	
}
