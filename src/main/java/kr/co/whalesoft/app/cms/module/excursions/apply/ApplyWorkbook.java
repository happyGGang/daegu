package kr.co.whalesoft.app.cms.module.excursions.apply;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.servlet.view.document.AbstractJExcelView;

import jxl.format.Alignment;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.format.Colour;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableWorkbook;
import kr.co.whalesoft.app.cms.module.calendarManage.CalendarManage;
import kr.co.whalesoft.app.cms.module.calendarStatus.CalendarStatus;
import kr.co.whalesoft.framework.utils.AttachmentUtils;

public class ApplyWorkbook {

	protected WritableWorkbook workbookForm(WritableWorkbook workbook, List<Apply> applyList, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String sheetName = "견학신청현황 리스트";	//시트이름
		workbook.createSheet(sheetName, 0);	//시트설정

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


		// 컬럼 폭 지정
		workbook.getSheet(0).setColumnView( 0, 10 );
		workbook.getSheet(0).setColumnView( 1, 30 );
		workbook.getSheet(0).setColumnView( 2, 20 );
		workbook.getSheet(0).setColumnView( 3, 40 );
		workbook.getSheet(0).setColumnView( 4, 40 );
		workbook.getSheet(0).setColumnView( 5, 40 );
		workbook.getSheet(0).setColumnView( 6, 10 );
		workbook.getSheet(0).setColumnView( 7, 20 );

		// 헤더 컬럼 지정
		workbook.getSheet(0).addCell( new Label( 0, 0, "번호", format ) );
		workbook.getSheet(0).addCell( new Label( 1, 0, "기관명", format ) );
		workbook.getSheet(0).addCell( new Label( 2, 0, "신청자명", format ) );
		workbook.getSheet(0).addCell( new Label( 3, 0, "신청자 전화번호", format ) );
		workbook.getSheet(0).addCell( new Label( 4, 0, "방문일자", format ) );
		workbook.getSheet(0).addCell( new Label( 5, 0, "견학시간", format ) );
		workbook.getSheet(0).addCell( new Label( 6, 0, "방문인원", format ) );
		workbook.getSheet(0).addCell( new Label( 7, 0, "승인여부", format ) );
		workbook.getSheet(0).addCell( new Label( 8, 0, "작성자비고", format ) );
		workbook.getSheet(0).addCell( new Label( 9, 0, "연령대", format ) );

		int row = 1;
		for ( Apply org : applyList ) {
			String applyStatusStr = "";
			if ( "1".equals(org.getApply_state()) ) {
				applyStatusStr = "대기";
			}
			if ( "1".equals(org.getApply_state()) ) {
				applyStatusStr = "불가";
			}
			if ( "1".equals(org.getApply_state()) ) {
				applyStatusStr = "승인";
			}
			workbook.getSheet(0).addCell( new Label( 0, row, String.valueOf(row)));
			workbook.getSheet(0).addCell( new Label( 1, row, org.getAgency_name(),format1 ) );
			workbook.getSheet(0).addCell( new Label( 2, row, org.getApplicant_name(),format1 ) );
			workbook.getSheet(0).addCell( new Label( 3, row, org.getApplicant_tel(),format1 ) );
			workbook.getSheet(0).addCell( new Label( 4, row, org.getStart_date(),format1 ) );
			workbook.getSheet(0).addCell( new Label( 5, row, org.getStart_time()+"~"+org.getEnd_time(), format1) );
			workbook.getSheet(0).addCell( new Label( 6, row, Integer.toString(org.getPersonnel()),format1 ) );
			String applyState = "";
			if (StringUtils.equals(org.getApply_state(), "3")) {
				applyState = "승인";
			} else if (StringUtils.equals(org.getApply_state(), "2")) {
				applyState = "불가";
			} else {
				applyState = "대기";
			}
			workbook.getSheet(0).addCell( new Label( 7, row, applyState,format1 ) );
			workbook.getSheet(0).addCell( new Label( 8, row, org.getRemarks(),format1 ) );
			workbook.getSheet(0).addCell( new Label( 9, row, org.getAge(),format1 ) );
			row++;
		}
		
		return workbook;
	}

}

