package kr.go.gbelib.app.cms.module.nearbyLib;

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

public class NearbyLibWorkbook {
	
	protected WritableWorkbook workbookForm(WritableWorkbook workbook, List<NearbyLib> nearbyLibList, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String sheetName = "내집앞도서관 대출관리(전체내역)";	//시트이름
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
		workbook.getSheet(0).setColumnView( 1, 20 );
		workbook.getSheet(0).setColumnView( 2, 15 );
		workbook.getSheet(0).setColumnView( 3, 15 );
		workbook.getSheet(0).setColumnView( 4, 20 );
		workbook.getSheet(0).setColumnView( 5, 30 );
		workbook.getSheet(0).setColumnView( 6, 30 );
		workbook.getSheet(0).setColumnView( 7, 25 );
		workbook.getSheet(0).setColumnView( 8, 30 );
		workbook.getSheet(0).setColumnView( 9, 20 );
		workbook.getSheet(0).setColumnView( 10, 20 );
		workbook.getSheet(0).setColumnView( 11, 15 );
		workbook.getSheet(0).setColumnView( 12, 15 );
		workbook.getSheet(0).setColumnView( 13, 15 );
		workbook.getSheet(0).setColumnView( 14, 15 );
				
		int column = 0;
		// 헤더 컬럼 지정
		workbook.getSheet(0).addCell( new Label(column++, 0, "번호", format ) );
		workbook.getSheet(0).addCell( new Label(column++, 0, "소장처", format ) );
		workbook.getSheet(0).addCell( new Label(column++, 0, "사물함", format ) );
		workbook.getSheet(0).addCell( new Label(column++, 0, "비밀번호", format ) );
		workbook.getSheet(0).addCell( new Label(column++, 0, "회원ID", format ) );
		workbook.getSheet(0).addCell( new Label(column++, 0, "등록번호", format ) );
		workbook.getSheet(0).addCell( new Label(column++, 0, "청구기호", format ) );
		workbook.getSheet(0).addCell( new Label(column++, 0, "수령장소", format ) );
		workbook.getSheet(0).addCell( new Label(column++, 0, "도서명", format ) );
		workbook.getSheet(0).addCell( new Label(column++, 0, "신청날짜", format ) );
		workbook.getSheet(0).addCell( new Label(column++, 0, "예약확정시간", format ) );
		workbook.getSheet(0).addCell( new Label(column++, 0, "취소여부", format ) );
		workbook.getSheet(0).addCell( new Label(column++, 0, "SMS발송여부", format ) );
		workbook.getSheet(0).addCell( new Label(column++, 0, "대출상태", format ) );
		workbook.getSheet(0).addCell( new Label(column++, 0, "찾음여부", format ) );
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		
		int row = 1;
		
		for ( NearbyLib one : nearbyLibList ) {
			
			column = 0;	
			
			workbook.getSheet(0).addCell(new Label(column++, row, String.valueOf((row)), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, one.getLib_name(), format1));
			if(one.getLocker_idx() > 0) {
				workbook.getSheet(0).addCell(new Label(column++, row, Integer.toString(one.getLocker_idx()), format1));
			} else {
				workbook.getSheet(0).addCell(new Label(column++, row, "", format1));
			}
			if(one.getDevice_password() > 0) {
				workbook.getSheet(0).addCell(new Label(column++, row, Integer.toString(one.getDevice_password()), format1));
			} else {
				workbook.getSheet(0).addCell(new Label(column++, row, "", format1));
			}
			workbook.getSheet(0).addCell(new Label(column++, row, one.getMember_id(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, one.getReg_no(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, one.getCall_no(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, one.getDevice_name(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, one.getBook_name(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, sdf.format(one.getAdd_date()), format1));
			if(one.getLend_date() != null) {
				workbook.getSheet(0).addCell(new Label(column++, row, sdf.format(one.getLend_date()), format1));
			} else {
				workbook.getSheet(0).addCell(new Label(column++, row, "", format1));
			}
			if("Y".equals(one.getCancel_yn())) {
				workbook.getSheet(0).addCell(new Label(column++, row, "취소", format1));
			} else {
				workbook.getSheet(0).addCell(new Label(column++, row, "", format1));
			}
			if("Y".equals(one.getSms_send_yn())) {
				workbook.getSheet(0).addCell(new Label(column++, row, "발송완료", format1));
			} else {
				workbook.getSheet(0).addCell(new Label(column++, row, "미발송", format1));
			}
			if("1".equals(one.getReserve_status())){
				workbook.getSheet(0).addCell(new Label(column++, row, "예약", format1));
			} else if("2".equals(one.getReserve_status())) {
				workbook.getSheet(0).addCell(new Label(column++, row, "예약확정", format1));
			} else if("3".equals(one.getReserve_status())) {
				workbook.getSheet(0).addCell(new Label(column++, row, "사물함투입", format1));
			} else if("4".equals(one.getReserve_status())) {
				workbook.getSheet(0).addCell(new Label(column++, row, "대출", format1));
			} else if("5".equals(one.getReserve_status())){
				workbook.getSheet(0).addCell(new Label(column++, row, "회수대기", format1));
			} else if("6".equals(one.getReserve_status())) {
				workbook.getSheet(0).addCell(new Label(column++, row, "회수중", format1));
			} else if("7".equals(one.getReserve_status())) {
				workbook.getSheet(0).addCell(new Label(column++, row, "회수완료", format1));
			} else if("8".equals(one.getReserve_status())) {
				workbook.getSheet(0).addCell(new Label(column++, row, "취소", format1));
			} else if("9".equals(one.getReserve_status())){
				workbook.getSheet(0).addCell(new Label(column++, row, "반납", format1));
			} else {
				workbook.getSheet(0).addCell(new Label(column++, row, "반납완료", format1));
			}
			workbook.getSheet(0).addCell(new Label(column++, row, one.getCheck_yn(), format1));
			
			row++;
		}
		
		return workbook;
	}
	
}
