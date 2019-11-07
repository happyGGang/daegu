package kr.go.gbelib.app.intro.search;

import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateUtils;

import jxl.format.Alignment;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.format.Colour;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableWorkbook;

public class LibrarySearchWorkbook {

	protected WritableWorkbook workbookForm(WritableWorkbook workbook, LibrarySearch librarySearch, Map<String, Object> result, String sheetName, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String excelType = librarySearch.getExcel_type();
		String excelTypeDetail = librarySearch.getExcel_type_detail();
		
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
		if ( "OUT".equals(excelType) ) {
			workbook.getSheet(0).setColumnView(1,  70);
		} else {
			workbook.getSheet(0).setColumnView(1,  20);
		}
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

		
		if ( "HOPE".equals(excelType) ) {
			workbook.getSheet(0).addCell(new Label(0, 0, "번호", format));
			workbook.getSheet(0).addCell(new Label(1, 0, "서명", format));
			workbook.getSheet(0).addCell(new Label(2, 0, "저자", format));
			workbook.getSheet(0).addCell(new Label(3, 0, "출판사", format));
			workbook.getSheet(0).addCell(new Label(4, 0, "출판년도", format));
			workbook.getSheet(0).addCell(new Label(5, 0, "소장처", format));
			workbook.getSheet(0).addCell(new Label(6, 0, "신청일", format));
			workbook.getSheet(0).addCell(new Label(7, 0, "처리일", format));
			workbook.getSheet(0).addCell(new Label(8, 0, "처리결과", format));
			workbook.getSheet(0).addCell(new Label(9, 0, "비고사항", format));
		}
		else if ( "LOAN".equals(excelType) ) {
			workbook.getSheet(0).addCell(new Label(0, 0, "번호", format));
			workbook.getSheet(0).addCell(new Label(1, 0, "서명", format));
			workbook.getSheet(0).addCell(new Label(2, 0, "저자", format));
			workbook.getSheet(0).addCell(new Label(3, 0, "출판사", format));
			workbook.getSheet(0).addCell(new Label(4, 0, "소장처", format));
			workbook.getSheet(0).addCell(new Label(5, 0, "상태", format));
			workbook.getSheet(0).addCell(new Label(6, 0, "대출일", format));
			workbook.getSheet(0).addCell(new Label(7, 0, "반납예정일", format));
			
			if ( excelTypeDetail == null ) {
				workbook.getSheet(0).addCell(new Label(8, 0, "반납일", format));
			}
		}
		else if ( "RESVE".equals(excelType) ) {
			workbook.getSheet(0).addCell(new Label(0, 0, "번호", format));
			workbook.getSheet(0).addCell(new Label(1, 0, "서명", format));
			workbook.getSheet(0).addCell(new Label(2, 0, "저자", format));
			workbook.getSheet(0).addCell(new Label(3, 0, "출판사", format));
			workbook.getSheet(0).addCell(new Label(4, 0, "비치처", format));
			workbook.getSheet(0).addCell(new Label(5, 0, "예약일", format));
			workbook.getSheet(0).addCell(new Label(6, 0, "예약유효일", format));
			workbook.getSheet(0).addCell(new Label(7, 0, "도착통보일", format));
			workbook.getSheet(0).addCell(new Label(8, 0, "예약순위", format));
			workbook.getSheet(0).addCell(new Label(9, 0, "예약상태", format));
		}
		else if ( "POUCH".equals(excelType) ) {
			workbook.getSheet(0).addCell(new Label(0, 0, "번호", format));
			workbook.getSheet(0).addCell(new Label(1, 0, "서명", format));
			workbook.getSheet(0).addCell(new Label(2, 0, "저자", format));
			workbook.getSheet(0).addCell(new Label(3, 0, "출판사", format));
			workbook.getSheet(0).addCell(new Label(4, 0, "비치처", format));
			workbook.getSheet(0).addCell(new Label(5, 0, "신청일", format));
			workbook.getSheet(0).addCell(new Label(6, 0, "상태", format));
		}
		else if ( "SEARCH".equals(excelType) ) {
			workbook.getSheet(0).addCell(new Label(0, 0, "번호", format));
			workbook.getSheet(0).addCell(new Label(1, 0, "서명", format));
			workbook.getSheet(0).addCell(new Label(2, 0, "저자", format));
			workbook.getSheet(0).addCell(new Label(3, 0, "출판사", format));
			workbook.getSheet(0).addCell(new Label(4, 0, "출판년도", format));
			workbook.getSheet(0).addCell(new Label(5, 0, "소장처", format));
			workbook.getSheet(0).addCell(new Label(6, 0, "청구기호", format));
		}
		else if ( "NEWBOOK".equals(excelType) ) {
			workbook.getSheet(0).addCell(new Label(0, 0, "번호", format));
			workbook.getSheet(0).addCell(new Label(1, 0, "서명", format));
			workbook.getSheet(0).addCell(new Label(2, 0, "저자", format));
			workbook.getSheet(0).addCell(new Label(3, 0, "출판사", format));
			workbook.getSheet(0).addCell(new Label(4, 0, "출판년도", format));
			workbook.getSheet(0).addCell(new Label(5, 0, "소장도서관", format));
			workbook.getSheet(0).addCell(new Label(6, 0, "소장위치", format));
			workbook.getSheet(0).addCell(new Label(7, 0, "청구기호", format));
			workbook.getSheet(0).addCell(new Label(8, 0, "등록정보", format));
			workbook.getSheet(0).addCell(new Label(9, 0, "상태", format));
		}
		else if ( "OUT".equals(excelType) ) {
			workbook.getSheet(0).addCell(new Label(0, 0, "번호", format));
			workbook.getSheet(0).addCell(new Label(1, 0, "서명", format));
			workbook.getSheet(0).addCell(new Label(2, 0, "제공도서관", format));
			workbook.getSheet(0).addCell(new Label(3, 0, "수령도서관", format));
			workbook.getSheet(0).addCell(new Label(4, 0, "신청일", format));
			workbook.getSheet(0).addCell(new Label(5, 0, "신청시간", format));
			workbook.getSheet(0).addCell(new Label(6, 0, "상태변경일", format));
			workbook.getSheet(0).addCell(new Label(7, 0, "상태변경시간", format));
			workbook.getSheet(0).addCell(new Label(8, 0, "상태", format));
			workbook.getSheet(0).addCell(new Label(9, 0, "취소사유", format));
		}
		else if ( "CLOSE".equals(excelType) ) {
			workbook.getSheet(0).addCell(new Label(0, 0, "번호", format));
			workbook.getSheet(0).addCell(new Label(1, 0, "서명", format));
			workbook.getSheet(0).addCell(new Label(2, 0, "소장처명", format));
			workbook.getSheet(0).addCell(new Label(3, 0, "신청일", format));
			workbook.getSheet(0).addCell(new Label(4, 0, "상태", format));
		}
		// 헤더 컬럼 지정

		int row = 1;

		String[] patternDateTime = {"yyyyMMddHHmmss"};
		String[] patternDate = {"yyyyMMdd"};
		String[] patternTime = {"HHmmss"};
		SimpleDateFormat sfDateTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		SimpleDateFormat sfDate = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat sfTime = new SimpleDateFormat("HH:mm:ss");
		if ( result != null ) {
			List<Object> list = null;
			if ( "POUCH".equals(excelType) ) {
				list = (List<Object>) result.get("dsPouchList");
			} else if ( "SEARCH".equals(excelType) ) {
				list = (List<Object>) result.get("data");
			} else if ( "NEWBOOK".equals(excelType) ) {
				list = (List<Object>) result.get("newBook");
			} else {
				list = (List<Object>) result.get("dsMyLibraryList");
			}
			for ( Object oneInfo : list ) {
				Map<String, Object> oneInfoData = (Map<String, Object>) oneInfo;
				if ( "HOPE".equals(excelType) ) {
					workbook.getSheet(0).addCell(new Label(0, row, (String) oneInfoData.get("SELECT_NO")));
					workbook.getSheet(0).addCell(new Label(1, row, (String) oneInfoData.get("TITLE")));
					workbook.getSheet(0).addCell(new Label(2, row, (String) oneInfoData.get("AUTHOR")));
					workbook.getSheet(0).addCell(new Label(3, row, (String) oneInfoData.get("PUBLER")));
					workbook.getSheet(0).addCell(new Label(4, row, (String) oneInfoData.get("PUBLER_YEAR")));
					workbook.getSheet(0).addCell(new Label(5, row, (String) oneInfoData.get("LOCA_NAME")));
					workbook.getSheet(0).addCell(new Label(6, row, StringUtils.isEmpty((String) oneInfoData.get("INSERT_DATE")) ? "" : sfDate.format(DateUtils.parseDate((String) oneInfoData.get("INSERT_DATE"), patternDateTime))));
					workbook.getSheet(0).addCell(new Label(7, row, StringUtils.isEmpty((String) oneInfoData.get("PROCESS_DATE")) ? "" : sfDate.format(DateUtils.parseDate((String) oneInfoData.get("PROCESS_DATE"), patternDateTime))));
					workbook.getSheet(0).addCell(new Label(8, row, (String) oneInfoData.get("STATUS_FLAG_DISPLAY")));
					workbook.getSheet(0).addCell(new Label(9, row, (String) oneInfoData.get("USER_REMARK")));
				}
				else if ( "LOAN".equals(excelType)) {
					workbook.getSheet(0).addCell(new Label(0, row, (String) oneInfoData.get("LOAN_NO")));
					workbook.getSheet(0).addCell(new Label(1, row, (String) oneInfoData.get("TITLE")));
					workbook.getSheet(0).addCell(new Label(2, row, (String) oneInfoData.get("AUTHOR")));
					workbook.getSheet(0).addCell(new Label(3, row, (String) oneInfoData.get("PUBLER")));
					workbook.getSheet(0).addCell(new Label(4, row, (String) oneInfoData.get("LOAN_LOCA_NAME")));
					workbook.getSheet(0).addCell(new Label(5, row, (String) oneInfoData.get("RETURN_TYPE_NAME")));
					workbook.getSheet(0).addCell(new Label(6, row, StringUtils.isEmpty((String) oneInfoData.get("LOAN_DATE")) ? "" : sfDate.format(DateUtils.parseDate((String) oneInfoData.get("LOAN_DATE"), patternDate))));
					workbook.getSheet(0).addCell(new Label(7, row, StringUtils.isEmpty((String) oneInfoData.get("RETURN_PLAN_DATE")) ? "" : sfDate.format(DateUtils.parseDate((String) oneInfoData.get("RETURN_PLAN_DATE"), patternDate))));
					if ( excelTypeDetail == null ) {
						workbook.getSheet(0).addCell(new Label(8, row, StringUtils.isEmpty((String) oneInfoData.get("RETURN_DATE")) ? "" : sfDate.format(DateUtils.parseDate((String) oneInfoData.get("RETURN_DATE"), patternDate))));
					}
				}
				else if ( "RESVE".equals(excelType) ) {
					workbook.getSheet(0).addCell(new Label(0, row, (String) oneInfoData.get("RESVE_NO")));
					workbook.getSheet(0).addCell(new Label(1, row, (String) oneInfoData.get("TITLE")));
					workbook.getSheet(0).addCell(new Label(2, row, (String) oneInfoData.get("AUTHOR")));
					workbook.getSheet(0).addCell(new Label(3, row, (String) oneInfoData.get("PUBLER")));
					workbook.getSheet(0).addCell(new Label(4, row, (String) oneInfoData.get("LOCA_NAME")));
					workbook.getSheet(0).addCell(new Label(5, row, StringUtils.isEmpty((String) oneInfoData.get("RESVE_DATE")) ? "" : sfDate.format(DateUtils.parseDate((String) oneInfoData.get("RESVE_DATE"), patternDate))));
					workbook.getSheet(0).addCell(new Label(6, row, StringUtils.isEmpty((String) oneInfoData.get("RESVE_VALID_DATE")) ? "" : sfDate.format(DateUtils.parseDate((String) oneInfoData.get("RESVE_VALID_DATE"), patternDate))));
					workbook.getSheet(0).addCell(new Label(7, row, StringUtils.isEmpty((String) oneInfoData.get("RPT_DATE")) ? "" : sfDate.format(DateUtils.parseDate((String) oneInfoData.get("RPT_DATE"), patternDate))));
					workbook.getSheet(0).addCell(new Label(8, row, (String) oneInfoData.get("RESVE_RANK")));
					workbook.getSheet(0).addCell(new Label(9, row, (String) oneInfoData.get("STATUS_NAME")));
				}
				else if ( "POUCH".equals(excelType) ) {
					workbook.getSheet(0).addCell(new Label(0, row, (String) oneInfoData.get("SEQ_NO")));
					workbook.getSheet(0).addCell(new Label(1, row, (String) oneInfoData.get("TITLE")));
					workbook.getSheet(0).addCell(new Label(2, row, (String) oneInfoData.get("AUTHOR")));
					workbook.getSheet(0).addCell(new Label(3, row, (String) oneInfoData.get("PUBLISHER")));
					workbook.getSheet(0).addCell(new Label(4, row, (String) oneInfoData.get("LOCA_NAME")));
					workbook.getSheet(0).addCell(new Label(5, row, StringUtils.isEmpty((String) oneInfoData.get("REQST_DATE")) ? "" : sfDate.format(DateUtils.parseDate((String) oneInfoData.get("REQST_DATE"), patternDate))));
					workbook.getSheet(0).addCell(new Label(6, row, (String) oneInfoData.get("STATUS_NAME")));
				}
				else if ( "SEARCH".equals(excelType) ) {
					for (String a : librarySearch.getPrint_param()) {
						String[] lib_recKey_tid = a.split("_");
						String tid = (String) oneInfoData.get("tid");
						if (tid.equals(lib_recKey_tid[2])) {
							workbook.getSheet(0).addCell(new Label(0, row, (String.valueOf(row)) ));
							workbook.getSheet(0).addCell(new Label(1, row, (String) oneInfoData.get("title")));
							workbook.getSheet(0).addCell(new Label(2, row, (String) oneInfoData.get("author")));
							workbook.getSheet(0).addCell(new Label(3, row, (String) oneInfoData.get("publisher")));
							workbook.getSheet(0).addCell(new Label(4, row, (String) oneInfoData.get("year")));
							workbook.getSheet(0).addCell(new Label(5, row, (String) oneInfoData.get("libName")));
							workbook.getSheet(0).addCell(new Label(6, row, (String) oneInfoData.get("callno")));
						}
					}
				}
				else if ( "NEWBOOK".equals(excelType) ) {
					workbook.getSheet(0).addCell(new Label(0, row, (String.valueOf(row)) ));
					workbook.getSheet(0).addCell(new Label(1, row, (String) oneInfoData.get("TITLE")));
					workbook.getSheet(0).addCell(new Label(2, row, (String) oneInfoData.get("AUTHOR")));
					workbook.getSheet(0).addCell(new Label(3, row, (String) oneInfoData.get("PUBLISHER")));
					workbook.getSheet(0).addCell(new Label(4, row, (String) oneInfoData.get("PUBLISHER_YEAR")));
					workbook.getSheet(0).addCell(new Label(5, row, (String) oneInfoData.get("LOCA_NAME")));
					workbook.getSheet(0).addCell(new Label(6, row, (String) oneInfoData.get("SUB_LOCA_NAME")));
					String tmp = (String) oneInfoData.get("LABEL_PLACE_NO_NAME");
					if (StringUtils.isNotEmpty(tmp)) {
						workbook.getSheet(0).addCell(new Label(7, row, tmp + " " + (String) oneInfoData.get("CALL_NO")));
					} else {
						workbook.getSheet(0).addCell(new Label(7, row, (String) oneInfoData.get("CALL_NO")));
					}
					workbook.getSheet(0).addCell(new Label(8, row, (String) oneInfoData.get("PRINT_ACSSON_NO")));
					workbook.getSheet(0).addCell(new Label(9, row, (String) oneInfoData.get("DISPLAY_ITEM_STATUS")));
				}
				else if ( "OUT".equals(excelType) ) {
					workbook.getSheet(0).addCell(new Label(0, row, (String.valueOf(row)) ));
					workbook.getSheet(0).addCell(new Label(1, row, (String) oneInfoData.get("TITLE")));
					workbook.getSheet(0).addCell(new Label(2, row, (String) oneInfoData.get("BOOK_LOCA_NAME")));
					workbook.getSheet(0).addCell(new Label(3, row, (String) oneInfoData.get("RECPT_LOCA_NAME")));
					workbook.getSheet(0).addCell(new Label(4, row, 	 StringUtils.isEmpty((String) oneInfoData.get("REQST_DATE")) ? "" : sfDate.format(DateUtils.parseDate((String) oneInfoData.get("REQST_DATE"), patternDate))));
					workbook.getSheet(0).addCell(new Label(5, row, 	 StringUtils.isEmpty((String) oneInfoData.get("REQST_TIME")) ? "" : sfTime.format(DateUtils.parseDate((String) oneInfoData.get("REQST_TIME"), patternTime))));
					workbook.getSheet(0).addCell(new Label(6, row, StringUtils.isEmpty((String) oneInfoData.get("STATUS_CHANGE_DATE")) ? "" : sfDate.format(DateUtils.parseDate((String) oneInfoData.get("STATUS_CHANGE_DATE"), patternDate))));
					workbook.getSheet(0).addCell(new Label(7, row, StringUtils.isEmpty((String) oneInfoData.get("STATUS_CHANGE_TIME")) ? "" : sfTime.format(DateUtils.parseDate((String) oneInfoData.get("STATUS_CHANGE_TIME"), patternTime))));
					workbook.getSheet(0).addCell(new Label(8, row, (String) oneInfoData.get("STATUS_NAME")));
					workbook.getSheet(0).addCell(new Label(9, row, (String) oneInfoData.get("CANCEL_REASON")));
				}
				else if ( "CLOSE".equals(excelType) ) {
					workbook.getSheet(0).addCell(new Label(0, row, (String.valueOf(row)) ));
					workbook.getSheet(0).addCell(new Label(1, row, (String) oneInfoData.get("TITLE")));
					workbook.getSheet(0).addCell(new Label(2, row, (String) oneInfoData.get("BOOK_LOCA_NAME")));
					String date = StringUtils.isEmpty((String) oneInfoData.get("REQST_DATE")) ? "" : sfDate.format(DateUtils.parseDate((String) oneInfoData.get("REQST_DATE"), patternDate));
					String time = StringUtils.isEmpty((String) oneInfoData.get("REQST_TIME")) ? "" : sfTime.format(DateUtils.parseDate((String) oneInfoData.get("REQST_TIME"), patternTime));
					workbook.getSheet(0).addCell(new Label(3, row, date + " " + time));
					workbook.getSheet(0).addCell(new Label(4, row, (String) oneInfoData.get("STATUS_NAME")));
				}
				row ++;
			}
		}
		
		return workbook;
	}
	
}
