package kr.go.gbelib.app.cms.module.statistics;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.view.document.AbstractJExcelView;

import jxl.format.Alignment;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.format.Colour;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableWorkbook;
import kr.co.whalesoft.framework.utils.AttachmentUtils;

public class ModuleStatisticsWorkbook {
	
	protected WritableWorkbook workbookForm(WritableWorkbook workbook, List<ModuleStatistics> statisticsList, List<ModuleStatistics> statisticsListMonth, List<ModuleStatistics> statisticsListYear,
			String sheetName, String moduleType, HttpServletRequest request, HttpServletResponse response) throws Exception {
		workbook.createSheet(sheetName, 0);
		
		// 헤더 스타일
		WritableCellFormat format = new WritableCellFormat();
		format.setAlignment( Alignment.CENTRE );
		format.setBackground( Colour.LIGHT_GREEN );

		//중앙정렬
		WritableCellFormat format1 = new WritableCellFormat();		
		format1.setAlignment(Alignment.CENTRE);

		//테두리선,중앙정렬
		WritableCellFormat format2 = new WritableCellFormat();		
		format2.setBorder(Border.ALL,BorderLineStyle.MEDIUM);
		
		//중앙정렬,배경색,테두리 색
		WritableCellFormat format3 = new WritableCellFormat();
		format3.setAlignment( Alignment.CENTRE );
		format3.setBackground( Colour.LIGHT_GREEN );
		format3.setBorder(Border.ALL,BorderLineStyle.MEDIUM);
		
		int row = 1;
		
		if ( "LOCKER".equals(moduleType) ) {
			workbook.getSheet(0).setColumnView( 0, 20 );
			workbook.getSheet(0).setColumnView( 1, 10 );
			workbook.getSheet(0).setColumnView( 2, 30 );
			workbook.getSheet(0).setColumnView( 3, 10 );
			workbook.getSheet(0).setColumnView( 4, 10 );
			workbook.getSheet(0).setColumnView( 5, 10 );
			workbook.getSheet(0).setColumnView( 6, 10 );
			workbook.getSheet(0).setColumnView( 7, 10 );
			
			workbook.getSheet(0).addCell( new Label( 0, 0, "사물함 설정명", format ) );
			workbook.getSheet(0).addCell( new Label( 1, 0, "배정방식", format ) );
			workbook.getSheet(0).addCell( new Label( 2, 0, "사용기간", format ) );
			workbook.getSheet(0).addCell( new Label( 3, 0, "사물함 수", format ) );
			workbook.getSheet(0).addCell( new Label( 4, 0, "사물함 사용 수", format ) );
			workbook.getSheet(0).addCell( new Label( 5, 0, "사물함 미사용 수", format ) );
			workbook.getSheet(0).addCell( new Label( 6, 0, "사물함 신청 수", format ) );
			workbook.getSheet(0).addCell( new Label( 7, 0, "사물함 예약 수", format ) );
			
			int totalLockerCount 	= 0;
			int totalApplyCount 	= 0;
			int totalUseCount 		= 0;
			int totalNoUseCount 	= 0;
			for ( ModuleStatistics org : statisticsList ) {
				workbook.getSheet(0).addCell( new Label( 0, row, org.getLocker_pre_name(), format1));
				workbook.getSheet(0).addCell( new Label( 1, row, getLockerPreTypeToKorean(org.getLocker_pre_type()), format1));
				workbook.getSheet(0).addCell( new Label( 2, row, String.format("%s ~ %s", org.getStart_date(), org.getEnd_date()), format1));
				workbook.getSheet(0).addCell( new Label( 3, row, String.valueOf(org.getLocker_count()), format1));
				workbook.getSheet(0).addCell( new Label( 4, row, String.valueOf(org.getLocker_use_count()), format1));
				workbook.getSheet(0).addCell( new Label( 5, row, String.valueOf(org.getLocker_count() - org.getLocker_use_count()), format1));
				workbook.getSheet(0).addCell( new Label( 6, row, String.valueOf(org.getLocker_req_count()), format1));
				workbook.getSheet(0).addCell( new Label( 7, row, String.valueOf(org.getLocker_req_count() - org.getLocker_use_count()), format1));
				
				totalLockerCount 	= totalLockerCount + org.getLocker_count();
				totalApplyCount 	= totalApplyCount + org.getLocker_req_count();
				totalUseCount 		= totalUseCount + org.getLocker_use_count();
				totalNoUseCount 	= totalNoUseCount + (org.getLocker_count() - org.getLocker_use_count());
				
				row++;
			}
			workbook.getSheet(0).addCell( new Label( 0, row, String.format("전체 사물함 수 : %s, 전체 사물함 신청 수 : %s, 전체 사물함 사용 수 : %s, 전체 사물함 미사용 수 : %s", totalLockerCount, totalApplyCount, totalUseCount, totalNoUseCount), format1));
			workbook.getSheet(0).mergeCells(0, row, 7, row);
		}
		else if ( "EXCURSIONS".equals(moduleType) ) {
			// 시트 1 - 일별
			workbook.getSheet(0).setColumnView(0, 20);
			workbook.getSheet(0).setColumnView(1, 20);
			workbook.getSheet(0).setColumnView(2, 20);
			workbook.getSheet(0).setColumnView(3, 20);
			
			workbook.getSheet(0).addCell(new Label(0, 0, "일별", format));
			workbook.getSheet(0).addCell(new Label(1, 0, "견학 신청 수", format));
			workbook.getSheet(0).addCell(new Label(2, 0, "견학 승인처리 수", format));
			
			int totalExcursionsCount 	= statisticsList.size();
			int totalApplyCount 		= 0;
			int totalApplyOkCount 		= 0;
			
			for ( ModuleStatistics org : statisticsList ) {
				workbook.getSheet(0).addCell(new Label(0, row, org.getStart_date(), format1));
				workbook.getSheet(0).addCell(new Label(1, row, String.valueOf(org.getApply_count()), format1));
				workbook.getSheet(0).addCell(new Label(2, row, String.valueOf(org.getApply_ok_count()), format1));

				totalApplyCount 	= totalApplyCount + org.getApply_count();
				totalApplyOkCount 	= totalApplyOkCount + org.getApply_ok_count();
				
				row++;
			}
			workbook.getSheet(0).addCell(new Label(0, row, String.format("전체 견학일 : %s, 전체 견학 신청수 : %s, 전체 승인처리 수 : %s", totalExcursionsCount, totalApplyCount, totalApplyOkCount), format1));
			workbook.getSheet(0).mergeCells(0, row, 2, row);
			row += 2;
			
			// 시트 2 - 월별
			workbook.getSheet(0).addCell(new Label(0, row, "월별", format));
			workbook.getSheet(0).addCell(new Label(1, row, "견학 등록 수", format));
			workbook.getSheet(0).addCell(new Label(2, row, "견학 신청 수", format));
			workbook.getSheet(0).addCell(new Label(3, row, "견학 승인처리 수", format));
			row ++;
			
			totalExcursionsCount 	= 0;
			totalApplyCount 		= 0;
			totalApplyOkCount 		= 0;
			
			for ( ModuleStatistics org : statisticsListMonth ) {
				workbook.getSheet(0).addCell(new Label(0, row, org.getStart_date(), format1));
				workbook.getSheet(0).addCell(new Label(1, row, String.valueOf(org.getExcursions_count()), format1));
				workbook.getSheet(0).addCell(new Label(2, row, String.valueOf(org.getApply_count()), format1));
				workbook.getSheet(0).addCell(new Label(3, row, String.valueOf(org.getApply_ok_count()), format1));
				
				totalExcursionsCount 	= totalExcursionsCount + org.getExcursions_count();
				totalApplyCount 		= totalApplyCount + org.getApply_count();
				totalApplyOkCount 		= totalApplyOkCount + org.getApply_ok_count();
				
				row++;
			}
			workbook.getSheet(0).addCell(new Label(0, row, String.format("전체 견학일 : %s, 전체 견학 신청수 : %s, 전체 승인처리 수 : %s", totalExcursionsCount, totalApplyCount, totalApplyOkCount), format1));
			workbook.getSheet(0).mergeCells(0, row, 3, row);
			row += 2;
			
			// 시트 2 - 연별
			workbook.getSheet(0).addCell(new Label(0, row, "연별", format));
			workbook.getSheet(0).addCell(new Label(1, row, "견학 등록 수", format));
			workbook.getSheet(0).addCell(new Label(2, row, "견학 신청 수", format));
			workbook.getSheet(0).addCell(new Label(3, row, "견학 승인처리 수", format));
			row ++;
			
			totalExcursionsCount 	= 0;
			totalApplyCount 		= 0;
			totalApplyOkCount 		= 0;
			
			for ( ModuleStatistics org : statisticsListYear ) {
				workbook.getSheet(0).addCell(new Label(0, row, org.getStart_date(), format1));
				workbook.getSheet(0).addCell(new Label(1, row, String.valueOf(org.getExcursions_count()), format1));
				workbook.getSheet(0).addCell(new Label(2, row, String.valueOf(org.getApply_count()), format1));
				workbook.getSheet(0).addCell(new Label(3, row, String.valueOf(org.getApply_ok_count()), format1));
				
				totalExcursionsCount 	= totalExcursionsCount + org.getExcursions_count();
				totalApplyCount 		= totalApplyCount + org.getApply_count();
				totalApplyOkCount 		= totalApplyOkCount + org.getApply_ok_count();
				
				row++;
			}
			workbook.getSheet(0).addCell(new Label(0, row, String.format("전체 견학일 : %s, 전체 견학 신청수 : %s, 전체 승인처리 수 : %s", totalExcursionsCount, totalApplyCount, totalApplyOkCount), format1));
			workbook.getSheet(0).mergeCells(0, row, 3, row);
		}
		else if ( "FACILITY".equals(moduleType) ) {
			// 시트 1 - 일별
			workbook.getSheet(0).setColumnView(0, 30);
			workbook.getSheet(0).setColumnView(1, 10);
			workbook.getSheet(0).setColumnView(2, 10);
			workbook.getSheet(0).setColumnView(3, 10);
			
			workbook.getSheet(0).addCell(new Label(0, 0, "시설물명", format));
			workbook.getSheet(0).addCell(new Label(1, 0, "이용가능일", format));
			workbook.getSheet(0).addCell(new Label(2, 0, "신청제한 수", format));
			workbook.getSheet(0).addCell(new Label(3, 0, "신청 수", format));
			
			int totalFacilityCount 	= statisticsList.size();
			int totalLimitCount 	= 0;
			int totalApplyCount 	= 0;
			
			for ( ModuleStatistics org : statisticsList ) {
				workbook.getSheet(0).addCell(new Label(0, row, org.getFacility_name(), format1));
				workbook.getSheet(0).addCell(new Label(1, row, org.getUse_date(), format1));
				workbook.getSheet(0).addCell(new Label(2, row, String.valueOf(org.getLimit_count()), format1));
				workbook.getSheet(0).addCell(new Label(3, row, String.valueOf(org.getApply_count()), format1));
				
				totalLimitCount = totalLimitCount + org.getLimit_count(); 
				totalApplyCount = totalApplyCount + org.getApply_count(); 
				row++;
			}
			workbook.getSheet(0).addCell(new Label(0, row, String.format("전체 시설물 수 : %s, 전체 신청 제한 수 : %s, 전체 신청 수 : %s", totalFacilityCount, totalLimitCount, totalApplyCount), format1));
			workbook.getSheet(0).mergeCells(0, row, 3, row);
			row += 2;
			
			// 시트 2 - 월별
			workbook.getSheet(0).addCell(new Label(0, row, "시설물명", format));
			workbook.getSheet(0).addCell(new Label(1, row, "이용가능일", format));
			workbook.getSheet(0).addCell(new Label(2, row, "신청제한 수", format));
			workbook.getSheet(0).addCell(new Label(3, row, "신청 수", format));
			row ++;
			
			totalFacilityCount 	= 0;
			totalLimitCount 	= 0;
			totalApplyCount 	= 0;
			
			for ( ModuleStatistics org : statisticsListMonth ) {
				workbook.getSheet(0).addCell(new Label(0, row, org.getFacility_name(), format1));
				workbook.getSheet(0).addCell(new Label(1, row, org.getUse_date(), format1));
				workbook.getSheet(0).addCell(new Label(2, row, String.valueOf(org.getLimit_count()), format1));
				workbook.getSheet(0).addCell(new Label(3, row, String.valueOf(org.getApply_count()), format1));
				
				totalFacilityCount 	= org.getFacility_count();
				totalLimitCount 	= totalLimitCount + org.getLimit_count(); 
				totalApplyCount 	= totalApplyCount + org.getApply_count();
				
				row++;
			}
			workbook.getSheet(0).addCell(new Label(0, row, String.format("전체 시설물 수 : %s, 전체 신청 제한 수 : %s, 전체 신청 수 : %s", totalFacilityCount, totalLimitCount, totalApplyCount), format1));
			workbook.getSheet(0).mergeCells(0, row, 3, row);
			row += 2;
			
			// 시트 2 - 연별
			workbook.getSheet(0).addCell(new Label(0, row, "시설물명", format));
			workbook.getSheet(0).addCell(new Label(1, row, "이용가능일", format));
			workbook.getSheet(0).addCell(new Label(2, row, "신청제한 수", format));
			workbook.getSheet(0).addCell(new Label(3, row, "신청 수", format));
			row ++;
			
			totalFacilityCount 	= 0;
			totalLimitCount 	= 0;
			totalApplyCount 	= 0;
			
			for ( ModuleStatistics org : statisticsListYear ) {
				workbook.getSheet(0).addCell(new Label(0, row, org.getFacility_name(), format1));
				workbook.getSheet(0).addCell(new Label(1, row, org.getUse_date(), format1));
				workbook.getSheet(0).addCell(new Label(2, row, String.valueOf(org.getLimit_count()), format1));
				workbook.getSheet(0).addCell(new Label(3, row, String.valueOf(org.getApply_count()), format1));
				
				totalFacilityCount 	= org.getFacility_count();
				totalLimitCount 	= totalLimitCount + org.getLimit_count(); 
				totalApplyCount 	= totalApplyCount + org.getApply_count();
				
				row++;
			}
		workbook.getSheet(0).addCell(new Label(0, row, String.format("전체 시설물 수 : %s, 전체 신청 제한 수 : %s, 전체 신청 수 : %s", totalFacilityCount, totalLimitCount, totalApplyCount), format1));
		workbook.getSheet(0).mergeCells(0, row, 3, row);
		}
		
		return workbook;
	}
	
	private String getLockerPreTypeToKorean(String type) {
		if ( "SELECT".equals(type) ) {
			return "선택배정";
		}
		else if ( "FIFO".equals(type) ) {
			return "순차배정";
		}
		else if ( "RANDOM".equals(type) ) {
			return "랜덤배정";
		}
		else if ( "LOTTERY".equals(type) ) {
			return "추첨배정";
		}
		else {
			return "";
		}
	}

}
