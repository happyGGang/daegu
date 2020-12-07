package kr.go.gbelib.app.cms.module.expReservation.expReservationApply;

import java.text.SimpleDateFormat;
import java.util.Date;
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

public class ExpReservationApplyWorkbook {
	
	protected WritableWorkbook workbookForm(WritableWorkbook workbook, List<ExpReservationApply> expApplyList, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String sheetName = "프로그램신청현황 리스트";	//시트이름
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
		workbook.getSheet(0).setColumnView( 2, 30 );
		workbook.getSheet(0).setColumnView( 3, 20 );
		workbook.getSheet(0).setColumnView( 4, 30 );
		workbook.getSheet(0).setColumnView( 5, 20 );
		workbook.getSheet(0).setColumnView( 6, 30 );
		workbook.getSheet(0).setColumnView( 7, 20 );
		workbook.getSheet(0).setColumnView( 8, 20 );
		workbook.getSheet(0).setColumnView( 9, 10 );
		workbook.getSheet(0).setColumnView( 10, 20 );	
		workbook.getSheet(0).setColumnView( 11, 20 );	
		workbook.getSheet(0).setColumnView( 12, 10 );	
		workbook.getSheet(0).setColumnView( 13, 10 );	
		workbook.getSheet(0).setColumnView( 14, 20 );	
		
		// 헤더 컬럼 지정
		workbook.getSheet(0).addCell( new Label( 0, 0, "번호", format ) );
		workbook.getSheet(0).addCell( new Label( 1, 0, "프로그램명", format ) );
		workbook.getSheet(0).addCell( new Label( 2, 0, "비회원 신청여부", format) );
		workbook.getSheet(0).addCell( new Label( 3, 0, "신청 구분", format ) );
		workbook.getSheet(0).addCell( new Label( 4, 0, "아이디", format ) );
		workbook.getSheet(0).addCell( new Label( 5, 0, "성명", format ) );
		workbook.getSheet(0).addCell( new Label( 6, 0, "연락처", format ) );
		workbook.getSheet(0).addCell( new Label( 7, 0, "예약일", format ) );
		workbook.getSheet(0).addCell( new Label( 8, 0, "이용시간", format ) );
		workbook.getSheet(0).addCell( new Label( 9, 0, "신청인원", format ) );
		workbook.getSheet(0).addCell( new Label( 10, 0, "신청일", format ) );
		workbook.getSheet(0).addCell( new Label( 11, 0, "신청시간", format ) );
		workbook.getSheet(0).addCell( new Label( 12, 0, "승인여부", format ) );
		workbook.getSheet(0).addCell( new Label( 13, 0, "취소여부", format ) );
		workbook.getSheet(0).addCell( new Label( 14, 0, "참고사항", format ) );
		
		int row = 1;
		for ( ExpReservationApply org : expApplyList ) {
			
			workbook.getSheet(0).addCell( new Label( 0, row, String.valueOf(row)));
			workbook.getSheet(0).addCell( new Label( 1, row, org.getProgram_name(),format1 ) );
			String member_yn = "";
			if (StringUtils.equals(org.getMember_yn(), "Y")) {
				member_yn = "예";
			}else {
				member_yn = "아니요";
			}
			workbook.getSheet(0).addCell( new Label( 2, row, member_yn,format1 ) );
			String reservation_type = "";
			if (StringUtils.equals(org.getReservation_type(), "individual")) {
				reservation_type = "개인신청";
			}else if (StringUtils.equals(org.getReservation_type(), "team")) {
				reservation_type = "단체신청";
			}
			workbook.getSheet(0).addCell( new Label( 3, row, reservation_type,format1));
			workbook.getSheet(0).addCell( new Label( 4, row, org.getMember_id(),format1));
			workbook.getSheet(0).addCell( new Label( 5, row, org.getMember_name(),format1 ) );
			workbook.getSheet(0).addCell( new Label( 6, row, org.getMember_phone(),format1 ) );
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			Date ReservationDate = sdf.parse(org.getReservation_date());
			sdf = new SimpleDateFormat("yyyy-MM-dd");
			workbook.getSheet(0).addCell( new Label( 7, row, sdf.format(ReservationDate),format1 ) );
			workbook.getSheet(0).addCell( new Label( 8, row, org.getUse_time(), format1) );
			workbook.getSheet(0).addCell( new Label( 9, row, Integer.toString(org.getApplication_people()),format1 ) );
			workbook.getSheet(0).addCell( new Label( 10, row, sdf.format(org.getAdd_date()), format1 ) );
			SimpleDateFormat sdfTime = new SimpleDateFormat("HH:mm:ss");
			workbook.getSheet(0).addCell( new Label( 11, row, sdfTime.format(org.getAdd_date()), format1) );
			String applyState = "";
			if (StringUtils.equals(org.getApprove_yn(), "Y")) {
				applyState = "승인";
			} else if (StringUtils.equals(org.getApprove_yn(), "N")) {
				applyState = "대기";
			} 
			workbook.getSheet(0).addCell( new Label( 12, row, applyState,format1 ) );
			String applyCancel = "";
			if (StringUtils.equals(org.getCancel_yn(), "Y")) {
				applyCancel = "취소";
			} else if (StringUtils.equals(org.getCancel_yn(), "N")) {
				applyCancel = "";
			} 
			workbook.getSheet(0).addCell( new Label( 13, row, applyCancel,format1 ) );
			workbook.getSheet(0).addCell( new Label( 14, row, org.getReference(),format1 ) );
			row++;
		}
		
		return workbook;
	
	}
}
