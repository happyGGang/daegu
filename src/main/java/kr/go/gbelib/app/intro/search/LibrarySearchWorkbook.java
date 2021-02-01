package kr.go.gbelib.app.intro.search;

import java.util.List;
import java.util.Map;

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
import kr.co.whalesoft.app.cms.homepage.Homepage;

public class LibrarySearchWorkbook {

	protected WritableWorkbook workbookForm(WritableWorkbook workbook, LibrarySearch librarySearch, List<Map<String, Object>> resultList, String sheetName, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String excelType = librarySearch.getExcel_type();
		Homepage homepage = (Homepage)request.getSession().getAttribute("homepage");
		
		workbook.createSheet(sheetName, 0); // 시트설정

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
		workbook.getSheet(0).setColumnView(0,  20);
		workbook.getSheet(0).setColumnView(1,  20);
		workbook.getSheet(0).setColumnView(2,  20);
		workbook.getSheet(0).setColumnView(3,  20);
		workbook.getSheet(0).setColumnView(4,  20);
		workbook.getSheet(0).setColumnView(5,  20);
		workbook.getSheet(0).setColumnView(6,  20);
		workbook.getSheet(0).setColumnView(7,  20);
		workbook.getSheet(0).setColumnView(8,  20);
		workbook.getSheet(0).setColumnView(9,  20);
		workbook.getSheet(0).setColumnView(10, 20);
		workbook.getSheet(0).setColumnView(11, 20);
		workbook.getSheet(0).setColumnView(12, 20);
		workbook.getSheet(0).setColumnView(13, 20);
		workbook.getSheet(0).setColumnView(14, 20);
		workbook.getSheet(0).setColumnView(15, 20);
		
		if (excelType.equals("LOAN")) {
			workbook.getSheet(0).addCell(new Label(0, 0, "번호", format));
			workbook.getSheet(0).addCell(new Label(1, 0, "서명", format));
			workbook.getSheet(0).addCell(new Label(2, 0, "저자", format));
			workbook.getSheet(0).addCell(new Label(3, 0, "출판사", format));
			workbook.getSheet(0).addCell(new Label(4, 0, "도서관", format));
			workbook.getSheet(0).addCell(new Label(5, 0, "대출유형", format));
			workbook.getSheet(0).addCell(new Label(6, 0, "대출일", format));
			workbook.getSheet(0).addCell(new Label(7, 0, "반납예정일", format));
			workbook.getSheet(0).addCell(new Label(8, 0, "상태", format));
		} else if(excelType.equals("HISTORY")) {
			workbook.getSheet(0).addCell(new Label(0, 0, "번호", format));
			workbook.getSheet(0).addCell(new Label(1, 0, "서명", format));
			workbook.getSheet(0).addCell(new Label(2, 0, "소장처", format));
			workbook.getSheet(0).addCell(new Label(3, 0, "대출일", format));
			workbook.getSheet(0).addCell(new Label(4, 0, "반납일", format));
		} else if(excelType.equals("RESVE")) {
			workbook.getSheet(0).addCell(new Label(0, 0, "번호", format));
			workbook.getSheet(0).addCell(new Label(1, 0, "서명", format));
			workbook.getSheet(0).addCell(new Label(2, 0, "저자", format));
			workbook.getSheet(0).addCell(new Label(3, 0, "출판사", format));
			workbook.getSheet(0).addCell(new Label(4, 0, "도서관", format));
			workbook.getSheet(0).addCell(new Label(5, 0, "예약일", format));
			workbook.getSheet(0).addCell(new Label(6, 0, "예약순위", format));
			workbook.getSheet(0).addCell(new Label(7, 0, "예약만기일", format));
			workbook.getSheet(0).addCell(new Label(8, 0, "예약상태", format));
		} else if(excelType.equals("HOPE")) {
			workbook.getSheet(0).addCell(new Label(0, 0, "번호", format));
			workbook.getSheet(0).addCell(new Label(1, 0, "서명", format));
			workbook.getSheet(0).addCell(new Label(2, 0, "저자", format));
			workbook.getSheet(0).addCell(new Label(3, 0, "출판사", format));
			workbook.getSheet(0).addCell(new Label(4, 0, "출판년도", format));
			workbook.getSheet(0).addCell(new Label(5, 0, "도서관", format));
			workbook.getSheet(0).addCell(new Label(6, 0, "신청일", format));
			workbook.getSheet(0).addCell(new Label(7, 0, "처리일", format));
			workbook.getSheet(0).addCell(new Label(8, 0, "비치상태", format));
			workbook.getSheet(0).addCell(new Label(9, 0, "취소사유", format));
		}
		
		// 헤더 컬럼 지정

		int row = 1;
		if ( resultList != null ) {
			for ( Map<String, Object> oneInfoData : resultList ) {
				if (excelType.equals("LOAN")) {
					workbook.getSheet(0).addCell(new Label(0, row, String.valueOf(oneInfoData.get("RNUM"))));
					workbook.getSheet(0).addCell(new Label(1, row, String.valueOf(oneInfoData.get("TITLE_INFO"))));
					workbook.getSheet(0).addCell(new Label(2, row, String.valueOf(oneInfoData.get("AUTHOR"))));
					workbook.getSheet(0).addCell(new Label(3, row, String.valueOf(oneInfoData.get("PUBLISHER"))));
					workbook.getSheet(0).addCell(new Label(4, row, String.valueOf(oneInfoData.get("LIB_NAME"))));
					
					String loan_type = (String)oneInfoData.get("LOAN_TYPE_CODE");
					if(loan_type.equals("0")) {
						loan_type = "일반대출";
					} else if(loan_type.equals("1")) {
						loan_type = "특별대출";
					} else if(loan_type.equals("2")) {
						loan_type = "관내대출";
					} else if(loan_type.equals("3")) {
						loan_type = "무인대출";
					} else if(loan_type.equals("4")) {
						loan_type = "장기대출";
					}
					workbook.getSheet(0).addCell(new Label(5, row, loan_type));
					workbook.getSheet(0).addCell(new Label(6, row, String.valueOf(oneInfoData.get("LOAN_DATE"))));
					workbook.getSheet(0).addCell(new Label(7, row, String.valueOf(oneInfoData.get("RETURN_PLAN_DATE"))));
					
					String status = (String)oneInfoData.get("STATUS");
					if(status.equals("0")) {
						status = "대출";
					} else if(status.equals("1")) {
						status = "반납";
					} else if(status.equals("2")) {
						status = "반납연기";
					} else if(status.equals("3")) {
						status = "예약";
					} else if(status.equals("4")) {
						status = "예약취소";
					}
					workbook.getSheet(0).addCell(new Label(8, row, status));
				} else if(excelType.equals("HISTORY")) {
					workbook.getSheet(0).addCell(new Label(0, row, String.valueOf(oneInfoData.get("RNUM"))));
					workbook.getSheet(0).addCell(new Label(1, row, String.valueOf(oneInfoData.get("TITLE"))));
					workbook.getSheet(0).addCell(new Label(2, row, String.valueOf(oneInfoData.get("LIB_NAME"))));
					workbook.getSheet(0).addCell(new Label(3, row, String.valueOf(oneInfoData.get("LOAN_DATE"))));
					workbook.getSheet(0).addCell(new Label(4, row, String.valueOf(oneInfoData.get("RETURN_DATE"))));
				} else if(excelType.equals("RESVE")) {
					workbook.getSheet(0).addCell(new Label(0, row, String.valueOf(oneInfoData.get("RNUM"))));
					workbook.getSheet(0).addCell(new Label(1, row, String.valueOf(oneInfoData.get("TITLE_INFO"))));
					workbook.getSheet(0).addCell(new Label(2, row, String.valueOf(oneInfoData.get("AUTHOR"))));
					workbook.getSheet(0).addCell(new Label(3, row, String.valueOf(oneInfoData.get("PUBLISHER"))));
					workbook.getSheet(0).addCell(new Label(4, row, String.valueOf(oneInfoData.get("LIB_NAME"))));
					workbook.getSheet(0).addCell(new Label(5, row, String.valueOf(oneInfoData.get("RESERVATION_DATE"))));
					workbook.getSheet(0).addCell(new Label(6, row, String.valueOf(oneInfoData.get("RESERVE_RANK"))));
					
					String expire = String.valueOf(oneInfoData.get("RESERVATION_EXPIRE_DATE"));
					workbook.getSheet(0).addCell(new Label(7, row, expire != null && !expire.equals("null") ? expire : ""));
					
					String unmanned = String.valueOf(oneInfoData.get("UNMANNED_RESERVATION_LOAN"));
					String night = String.valueOf(oneInfoData.get("NIGHT_RESERVATION_LOAN"));
					String resve_state;
					if(unmanned.equals("Y")) {
						if(homepage.getContext_path().equals("dmsl")) {
							resve_state = "별관 이동도서관 신청";
						} else {
							resve_state = "무인예약신청";
						}
					} else if(unmanned.equals("O")) {
						if(homepage.getContext_path().equals("dmsl")) {
							resve_state = "별관 이동도서관 신청 예약대기";
						} else {
							resve_state = "무인예약대기";
						}
					} else if(night.equals("Y")) {
						resve_state = "워킹스루예약신청";
					} else if(night.equals("O")) {
						resve_state = "워킹스루예약대기";
					} else {
						resve_state = "일반예약";
					}
					workbook.getSheet(0).addCell(new Label(8, row, resve_state));
				} else if(excelType.equals("HOPE")) {
					workbook.getSheet(0).addCell(new Label(0, row, String.valueOf(oneInfoData.get("RNUM"))));
					workbook.getSheet(0).addCell(new Label(1, row, String.valueOf(oneInfoData.get("TITLE"))));
					workbook.getSheet(0).addCell(new Label(2, row, String.valueOf(oneInfoData.get("AUTHOR"))));
					workbook.getSheet(0).addCell(new Label(3, row, String.valueOf(oneInfoData.get("PUBLISHER"))));
					workbook.getSheet(0).addCell(new Label(4, row, String.valueOf(oneInfoData.get("PUBLISH_YEAR"))));
					workbook.getSheet(0).addCell(new Label(5, row, String.valueOf(oneInfoData.get("LIB_NAME"))));
					workbook.getSheet(0).addCell(new Label(6, row, String.valueOf(oneInfoData.get("APPLICANT_DATE"))));
					String furnish = String.valueOf(oneInfoData.get("FURNISH_DATE"));
					workbook.getSheet(0).addCell(new Label(7, row, furnish != null ? furnish : ""));
					workbook.getSheet(0).addCell(new Label(8, row, String.valueOf(oneInfoData.get("FURNISH_STATUS"))));
					workbook.getSheet(0).addCell(new Label(9, row, String.valueOf(oneInfoData.get("CANCEL_REASON"))));
				}
				
				row ++;
			}
		}
		
		return workbook;
	}
	
}
