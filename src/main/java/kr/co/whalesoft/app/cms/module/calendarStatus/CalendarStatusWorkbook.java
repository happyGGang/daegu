package kr.co.whalesoft.app.cms.module.calendarStatus;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.view.document.AbstractJExcelView;

import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableWorkbook;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.module.calendarManage.CalendarManage;
import kr.co.whalesoft.framework.utils.AttachmentUtils;

public class CalendarStatusWorkbook {
	
	public WritableWorkbook workbookForm(WritableWorkbook workbook, List<CalendarManage> calendarList, List<CalendarStatus> excursionsList, List<CalendarStatus> supportList,
			List<CalendarStatus> facilityList, List<CalendarStatus> lockerList, List<CalendarStatus> boardList, HttpServletRequest request, HttpServletResponse response) throws Exception {
		int sheetNumber = 0;
		
		//bold font 공통 셀 포맷
		WritableFont cellFont = new WritableFont(WritableFont.COURIER, 10);
	    cellFont.setBoldStyle(WritableFont.BOLD);
	    WritableCellFormat cellFormat = new WritableCellFormat(cellFont);
		
		/**
		 * 일정 시트 시작
		 */
		if (calendarList != null && calendarList.size() > 0) {
			String sheetName = "일정 현황";	//시트이름
			workbook.createSheet(sheetName, sheetNumber);	//시트설정
			
			//header
	  		workbook.getSheet(sheetNumber).addCell(new Label(0, 0, "기간", cellFormat));
	  		workbook.getSheet(sheetNumber).addCell(new Label(1, 0, "건수", cellFormat));
	  		workbook.getSheet(sheetNumber).addCell(new Label(2, 0, "백분율", cellFormat));
	  		
	  		int total_count = 0;
	  		
	  		for (int i = 0; i < calendarList.size(); i++) {
	  			CalendarManage cm = calendarList.get(i);
	  			if (i == 0) {
	  				total_count = cm.getCount();
	  			} else {
	  				double percent = (new Double(cm.getCount()) / new Double(total_count)) * 100;
	  				workbook.getSheet(sheetNumber).addCell(new Label(0, i, cm.getStart_date()));
	  				workbook.getSheet(sheetNumber).addCell(new Label(1, i, String.valueOf(cm.getCount())));
	  				workbook.getSheet(sheetNumber).addCell(new Label(2, i, String.format("%.2f", percent) + "%"));
	  			}
	  		}
	  		
	  		workbook.getSheet(sheetNumber).addCell(new Label(0, calendarList.size(), "합계", cellFormat));
	  		workbook.getSheet(sheetNumber).addCell(new Label(1, calendarList.size(), String.valueOf(total_count), cellFormat));
	  		workbook.getSheet(sheetNumber).addCell(new Label(2, calendarList.size(), "100%", cellFormat));
	  		
//	  		workbook.getSheet(0).setColumnView(0, 50);
//	  		workbook.getSheet(0).setColumnView(1, 50);
//	  		workbook.getSheet(0).setColumnView(2, 20);
	  		sheetNumber++;
		}
		
		/**
		 * 견학/체험 현황
		 */
		if (excursionsList != null && excursionsList.size() > 0) {
			String sheetName = "견학-체험 현황";	//시트이름
			workbook.createSheet(sheetName, sheetNumber);	//시트설정
			
			//header
			workbook.getSheet(sheetNumber).addCell(new Label(0, 0, "기간", cellFormat));
			workbook.getSheet(sheetNumber).addCell(new Label(1, 0, "대기", cellFormat));
			workbook.getSheet(sheetNumber).addCell(new Label(2, 0, "불가", cellFormat));
			workbook.getSheet(sheetNumber).addCell(new Label(3, 0, "승인", cellFormat));
			workbook.getSheet(sheetNumber).addCell(new Label(4, 0, "건수", cellFormat));
			workbook.getSheet(sheetNumber).addCell(new Label(5, 0, "백분율", cellFormat));
			
			int total_count = 0;
			int total_count2 = 0;
			int total_count3 = 0;
			int total_count4 = 0;
			int total_count5 = 0;
			int total_count0 = 0;
			
			for (int i = 0; i < excursionsList.size(); i++) {
				CalendarStatus cs = excursionsList.get(i);
				if (i == 0) {
					total_count = Integer.parseInt(cs.getImsi_v1());
					total_count2 = Integer.parseInt(cs.getImsi_v2());
					total_count3 = Integer.parseInt(cs.getImsi_v3());
					total_count4 = Integer.parseInt(cs.getImsi_v4());
					total_count5 = Integer.parseInt(cs.getImsi_v5());
					total_count0 = total_count + total_count2+total_count3+total_count4; 
				} else {
					double percent = (new Double(total_count0) / new Double(total_count5)) * 100;
					workbook.getSheet(sheetNumber).addCell(new Label(0, i, cs.getStart_date()));
					workbook.getSheet(sheetNumber).addCell(new Label(1, i, cs.getImsi_v1()));
					workbook.getSheet(sheetNumber).addCell(new Label(2, i, cs.getImsi_v2()));
					workbook.getSheet(sheetNumber).addCell(new Label(3, i, cs.getImsi_v3()));
					workbook.getSheet(sheetNumber).addCell(new Label(4, i, cs.getImsi_v4()));
					if (cs.getImsi_v5().equals("0")) {
						workbook.getSheet(sheetNumber).addCell(new Label(5, i, "0%"));
					} else {
						workbook.getSheet(sheetNumber).addCell(new Label(5, i, String.format("%.2f", percent) + "%"));
					}
				}
			}
			
			workbook.getSheet(sheetNumber).addCell(new Label(0, excursionsList.size(), "합계", cellFormat));
			workbook.getSheet(sheetNumber).addCell(new Label(1, excursionsList.size(), String.valueOf(total_count == 0 ? 0 : 100)+"%", cellFormat));
			workbook.getSheet(sheetNumber).addCell(new Label(2, excursionsList.size(), String.valueOf(total_count2 == 0 ? 0 : 100)+"%", cellFormat));
			workbook.getSheet(sheetNumber).addCell(new Label(3, excursionsList.size(), String.valueOf(total_count3 == 0 ? 0 : 100)+"%", cellFormat));
			workbook.getSheet(sheetNumber).addCell(new Label(4, excursionsList.size(), String.valueOf(total_count4 == 0 ? 0 : 100)+"%", cellFormat));
			workbook.getSheet(sheetNumber).addCell(new Label(5, excursionsList.size(), "100%", cellFormat));
			
//	  		workbook.getSheet(0).setColumnView(0, 50);
//	  		workbook.getSheet(0).setColumnView(1, 50);
//	  		workbook.getSheet(0).setColumnView(2, 20);
			sheetNumber++;
		}
		
		
		/**
		 * 현장지원 현황
		 */
		if (supportList != null && supportList.size() > 0) {
			String sheetName = "현장지원 현황";	//시트이름
			workbook.createSheet(sheetName, sheetNumber);	//시트설정
			
			//header
			workbook.getSheet(sheetNumber).addCell(new Label(0, 0, "기간", cellFormat));
			workbook.getSheet(sheetNumber).addCell(new Label(1, 0, "미처리", cellFormat));
			workbook.getSheet(sheetNumber).addCell(new Label(2, 0, "처리완료", cellFormat));
			workbook.getSheet(sheetNumber).addCell(new Label(3, 0, "건수", cellFormat));
			workbook.getSheet(sheetNumber).addCell(new Label(4, 0, "백분율", cellFormat));
			
			int total_count = 0;
			int total_count2 = 0;
			int total_count3 = 0;
			int total_count0 = 0;
			
			for (int i = 0; i < supportList.size(); i++) {
				CalendarStatus cs = supportList.get(i);
				if (i == 0) {
					total_count = Integer.parseInt(cs.getImsi_v1());
					total_count2 = Integer.parseInt(cs.getImsi_v2());
					total_count3 = Integer.parseInt(cs.getImsi_v3());
					total_count0 = total_count + total_count2; 
				} else {
					double percent = (new Double(total_count0) / new Double(total_count3)) * 100;
					workbook.getSheet(sheetNumber).addCell(new Label(0, i, cs.getStart_date()));
					workbook.getSheet(sheetNumber).addCell(new Label(1, i, cs.getImsi_v1()));
					workbook.getSheet(sheetNumber).addCell(new Label(2, i, cs.getImsi_v2()));
					workbook.getSheet(sheetNumber).addCell(new Label(3, i, cs.getImsi_v3()));
					if (cs.getImsi_v3().equals("0")) {
						workbook.getSheet(sheetNumber).addCell(new Label(4, i, "0%"));
					} else {
						workbook.getSheet(sheetNumber).addCell(new Label(4, i, String.format("%.2f", percent) + "%"));
					}
				}
			}
			
			workbook.getSheet(sheetNumber).addCell(new Label(0, supportList.size(), "합계", cellFormat));
			workbook.getSheet(sheetNumber).addCell(new Label(1, supportList.size(), String.valueOf(total_count == 0 ? 0 : 100)+"%", cellFormat));
			workbook.getSheet(sheetNumber).addCell(new Label(2, supportList.size(), String.valueOf(total_count2 == 0 ? 0 : 100)+"%", cellFormat));
			workbook.getSheet(sheetNumber).addCell(new Label(3, supportList.size(), String.valueOf(total_count3 == 0 ? 0 : 100)+"%", cellFormat));
			workbook.getSheet(sheetNumber).addCell(new Label(4, supportList.size(), "100%", cellFormat));
			
//	  		workbook.getSheet(0).setColumnView(0, 50);
//	  		workbook.getSheet(0).setColumnView(1, 50);
//	  		workbook.getSheet(0).setColumnView(2, 20);
			sheetNumber++;
		}
		
		
		/**
		 * 시설물 현황
		 */
		if (facilityList != null && facilityList.size() > 0) {
			String sheetName = "시설물 현황";	//시트이름
			workbook.createSheet(sheetName, sheetNumber);	//시트설정
			
			//header
			workbook.getSheet(sheetNumber).addCell(new Label(0, 0, "기간", cellFormat));
			workbook.getSheet(sheetNumber).addCell(new Label(1, 0, "신청현황", cellFormat));
			workbook.getSheet(sheetNumber).addCell(new Label(2, 0, "백분율", cellFormat));
			
			int total_count = 0;
			
			for (int i = 0; i < facilityList.size(); i++) {
				CalendarStatus cs = facilityList.get(i);
				if (i == 0) {
					total_count = Integer.parseInt(cs.getImsi_v1());
				} else {
					double percent = (new Double(cs.getImsi_v1()) / new Double(total_count)) * 100;
					workbook.getSheet(sheetNumber).addCell(new Label(0, i, cs.getStart_date()));
					workbook.getSheet(sheetNumber).addCell(new Label(1, i, cs.getImsi_v1()));
					if (cs.getImsi_v1().equals("0")) {
						workbook.getSheet(sheetNumber).addCell(new Label(2, i, "0%"));
					} else {
						workbook.getSheet(sheetNumber).addCell(new Label(2, i, String.format("%.2f", percent) + "%"));
					}
				}
			}
			
			workbook.getSheet(sheetNumber).addCell(new Label(0, facilityList.size(), "합계", cellFormat));
			workbook.getSheet(sheetNumber).addCell(new Label(1, facilityList.size(), String.valueOf(total_count == 0 ? 0 : 100)+"%", cellFormat));
			workbook.getSheet(sheetNumber).addCell(new Label(2, facilityList.size(), "100%", cellFormat));
			
//	  		workbook.getSheet(0).setColumnView(0, 50);
//	  		workbook.getSheet(0).setColumnView(1, 50);
//	  		workbook.getSheet(0).setColumnView(2, 20);
			sheetNumber++;
		}
		
		
		
		/**
		 * 사물함 현황
		 */
		if (lockerList != null && lockerList.size() > 0) {
			String sheetName = "사물함 현황";	//시트이름
			workbook.createSheet(sheetName, sheetNumber);	//시트설정
			
			//header
			workbook.getSheet(sheetNumber).addCell(new Label(0, 0, "기간", cellFormat));
			workbook.getSheet(sheetNumber).addCell(new Label(1, 0, "사물함갯수", cellFormat));
			workbook.getSheet(sheetNumber).addCell(new Label(2, 0, "신청현황", cellFormat));
			workbook.getSheet(sheetNumber).addCell(new Label(3, 0, "사용현황", cellFormat));
			workbook.getSheet(sheetNumber).addCell(new Label(4, 0, "신청률", cellFormat));
			workbook.getSheet(sheetNumber).addCell(new Label(5, 0, "백분율", cellFormat));
			
			int total_count = 0;
			int total_count2 = 0;
			int total_count3 = 0;
			
			for (int i = 0; i < lockerList.size(); i++) {
				CalendarStatus cs = lockerList.get(i);
				if (i == 0) {
					total_count = Integer.parseInt(String.valueOf(cs.getTotal_count())) + Integer.parseInt(cs.getImsi_v1());
					total_count2 = Integer.parseInt(String.valueOf(cs.getTotal_count())) + Integer.parseInt(cs.getImsi_v2());
					total_count3 = Integer.parseInt(String.valueOf(cs.getTotal_count())) + Integer.parseInt(cs.getImsi_v3());
				} else {
					
					workbook.getSheet(sheetNumber).addCell(new Label(0, i, cs.getStart_date()));
					workbook.getSheet(sheetNumber).addCell(new Label(1, i, cs.getImsi_v1()));
					workbook.getSheet(sheetNumber).addCell(new Label(2, i, cs.getImsi_v2()));
					workbook.getSheet(sheetNumber).addCell(new Label(3, i, cs.getImsi_v3()));
					if (cs.getImsi_v2().equals("0")) {
						workbook.getSheet(sheetNumber).addCell(new Label(4, i, "0%"));
					} else {
						double percent = (new Double(cs.getImsi_v2()) / new Double(total_count)) * 100;
						workbook.getSheet(sheetNumber).addCell(new Label(4, i, String.format("%.2f", percent) + "%"));
					}
					if (cs.getImsi_v3().equals("0")) {
						workbook.getSheet(sheetNumber).addCell(new Label(5, i, "0%"));
					} else {
						double percent = (new Double(cs.getImsi_v3()) / new Double(total_count)) * 100;
						workbook.getSheet(sheetNumber).addCell(new Label(5, i, String.format("%.2f", percent) + "%"));
					}
				}
			}
			
			workbook.getSheet(sheetNumber).addCell(new Label(0, lockerList.size(), "합계", cellFormat));
			workbook.getSheet(sheetNumber).addCell(new Label(1, lockerList.size(), String.valueOf(total_count)+"%", cellFormat));
			workbook.getSheet(sheetNumber).addCell(new Label(2, lockerList.size(), String.valueOf(total_count2)+"%", cellFormat));
			workbook.getSheet(sheetNumber).addCell(new Label(3, lockerList.size(), String.valueOf(total_count3)+"%", cellFormat));
			if (total_count2 == 0) {
				workbook.getSheet(sheetNumber).addCell(new Label(4, lockerList.size(), "0%", cellFormat));
			} else {
				double percent = (new Double(total_count2) / new Double(total_count)) * 100;
				workbook.getSheet(sheetNumber).addCell(new Label(4, lockerList.size(), String.format("%.2f", percent)+"%", cellFormat));
			}
			if (total_count3 == 0) {
				workbook.getSheet(sheetNumber).addCell(new Label(5, lockerList.size(), "0%", cellFormat));
			} else {
				double percent = (new Double(total_count3) / new Double(total_count)) * 100;
				workbook.getSheet(sheetNumber).addCell(new Label(5, lockerList.size(), String.format("%.2f", percent)+"%", cellFormat));
			}
			
//	  		workbook.getSheet(0).setColumnView(0, 50);
//	  		workbook.getSheet(0).setColumnView(1, 50);
//	  		workbook.getSheet(0).setColumnView(2, 20);
			sheetNumber++;
		}
		
		
		/**
		 * 영화상영 현황
		 */
		if (boardList != null && boardList.size() > 0) {
			String sheetName = "영화상영 현황";	//시트이름
			workbook.createSheet(sheetName, sheetNumber);	//시트설정
			
			//header
			workbook.getSheet(sheetNumber).addCell(new Label(0, 0, "기간", cellFormat));
			workbook.getSheet(sheetNumber).addCell(new Label(1, 0, "건수", cellFormat));
			workbook.getSheet(sheetNumber).addCell(new Label(2, 0, "백분율", cellFormat));
			
			int total_count = 0;
			
			for (int i = 0; i < boardList.size(); i++) {
				CalendarStatus cs = boardList.get(i);
				if (i == 0) {
					total_count = Integer.parseInt(cs.getImsi_v1());
				} else {
					workbook.getSheet(sheetNumber).addCell(new Label(0, i, cs.getStart_date()));
					workbook.getSheet(sheetNumber).addCell(new Label(1, i, cs.getImsi_v1()));
					if (cs.getImsi_v1().equals("0")) {
						workbook.getSheet(sheetNumber).addCell(new Label(2, i, "0%"));
					} else {
						double percent = (new Double(cs.getImsi_v1()) / new Double(total_count)) * 100;
						workbook.getSheet(sheetNumber).addCell(new Label(2, i, String.format("%.2f", percent) + "%"));
					}
				}
			}
			
			workbook.getSheet(sheetNumber).addCell(new Label(0, boardList.size(), "합계", cellFormat));
			workbook.getSheet(sheetNumber).addCell(new Label(1, boardList.size(), String.valueOf(total_count), cellFormat));
			if (total_count == 0) {
				workbook.getSheet(sheetNumber).addCell(new Label(2, boardList.size(), "0%", cellFormat));
			} else {
				double percent = (new Double(total_count) / new Double(total_count)) * 100;
				workbook.getSheet(sheetNumber).addCell(new Label(2, boardList.size(), String.format("%.2f", percent)+"%", cellFormat));
			}
			
//	  		workbook.getSheet(0).setColumnView(0, 50);
//	  		workbook.getSheet(0).setColumnView(1, 50);
//	  		workbook.getSheet(0).setColumnView(2, 20);
			sheetNumber++;
		}
		
		return workbook;
		
	}

}
