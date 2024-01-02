package kr.go.gbelib.app.cms.module.checkInOut;

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
import jxl.write.WriteException;

public class HourOfUseWorkbook {
	
	protected WritableWorkbook workbookForm(WritableWorkbook workbook, List<CheckInOut> checkInOutList, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String sheetName = "전체입출입내역";	//시트이름
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
		workbook.getSheet(0).setColumnView( 2, 20 );
		workbook.getSheet(0).setColumnView( 3, 20 );
		workbook.getSheet(0).setColumnView( 4, 20 );
		workbook.getSheet(0).setColumnView( 5, 15 );
		workbook.getSheet(0).setColumnView( 6, 20 );
		workbook.getSheet(0).setColumnView( 7, 20 );
		workbook.getSheet(0).setColumnView( 8, 20 );
		workbook.getSheet(0).setColumnView( 9, 20 );
		workbook.getSheet(0).setColumnView( 10, 15 );
		workbook.getSheet(0).setColumnView( 11, 15 );
				
		int column = 0;
		// 헤더 컬럼 지정
		workbook.getSheet(0).addCell( new Label(column++, 1, "번호", format ) );
		workbook.getSheet(0).addCell( new Label(column++, 0, "대출자번호", format ) );
		workbook.getSheet(0).addCell( new Label(column++, 0, "ID", format ) );
		workbook.getSheet(0).addCell( new Label(column++, 0, "이름", format ) );
		workbook.getSheet(0).addCell( new Label(column++, 0, "생일연도", format ) );
		workbook.getSheet(0).addCell( new Label(column++, 0, "성별", format ) );
		workbook.getSheet(0).addCell( new Label(column++, 0, "지역구", format ) );
		workbook.getSheet(0).addCell( new Label(column++, 0, "체크인 시간", format ) );
		workbook.getSheet(0).addCell( new Label(column++, 0, "체크아웃 시간", format ) );
		workbook.getSheet(0).addCell( new Label(column++, 0, "이용시간", format ) );
		workbook.getSheet(0).addCell( new Label(column++, 0, "상태", format ) );
		workbook.getSheet(0).addCell( new Label(column++, 0, "방문구분", format ) );
		
		int row = 1;
		
		for ( CheckInOut one : checkInOutList ) {
			
			column = 0;	
			
			workbook.getSheet(0).addCell(new Label(column++, row, String.valueOf((row)), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, one.getUser_no(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, one.getMember_id(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, one.getMember_name(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, one.getMember_birth(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, one.getMember_sex(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, one.getMember_area(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, one.getCheckIn_time(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, one.getCheckOut_time(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, one.getCheckInOut_time() + "분", format1));
			
			if(StringUtils.isEmpty(one.getCheckOut_time())) {
				workbook.getSheet(0).addCell(new Label(column++, row, "이용중", format1));
			} else {
				workbook.getSheet(0).addCell(new Label(column++, row, "이용완료", format1));
			}
			
			if("1".equals(one.getGubun())) {
				workbook.getSheet(0).addCell(new Label(column++, row, "재방문", format1));
			} else {
				workbook.getSheet(0).addCell(new Label(column++, row, "처음방문", format1));
			}
			
			row++;
		}
		
		return workbook;
	}

	public WritableWorkbook workbookForm(WritableWorkbook workbook, CheckInOut checkInOut, List<CheckInOut> cscList, String sheetName, HttpServletRequest request, HttpServletResponse response) throws WriteException {
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
		workbook.getSheet(0).setColumnView( 2, 20 );
		workbook.getSheet(0).setColumnView( 3, 20 );
		workbook.getSheet(0).setColumnView( 4, 20 );
		workbook.getSheet(0).setColumnView( 5, 15 );
		workbook.getSheet(0).setColumnView( 6, 20 );
		workbook.getSheet(0).setColumnView( 7, 20 );
		workbook.getSheet(0).setColumnView( 8, 20 );
		workbook.getSheet(0).setColumnView( 9, 20 );
		workbook.getSheet(0).setColumnView( 10, 15 );
		workbook.getSheet(0).setColumnView( 11, 15 );
				
		int column = 0;
		// 헤더 컬럼 지정
		workbook.getSheet(0).addCell( new Label(column++, 1, "번호", format ) );
		workbook.getSheet(0).addCell( new Label(column++, 0, "대출자번호", format ) );
		workbook.getSheet(0).addCell( new Label(column++, 0, "ID", format ) );
		workbook.getSheet(0).addCell( new Label(column++, 0, "이름", format ) );
		workbook.getSheet(0).addCell( new Label(column++, 0, "생일연도", format ) );
		workbook.getSheet(0).addCell( new Label(column++, 0, "성별", format ) );
		workbook.getSheet(0).addCell( new Label(column++, 0, "지역구", format ) );
		workbook.getSheet(0).addCell( new Label(column++, 0, "체크인 시간", format ) );
		workbook.getSheet(0).addCell( new Label(column++, 0, "체크아웃 시간", format ) );
		workbook.getSheet(0).addCell( new Label(column++, 0, "이용시간", format ) );
		workbook.getSheet(0).addCell( new Label(column++, 0, "상태", format ) );
		workbook.getSheet(0).addCell( new Label(column++, 0, "방문구분", format ) );
		
		int row = 1;
		
		for ( CheckInOut one : cscList ) {
			
			column = 0;	
			
			workbook.getSheet(0).addCell(new Label(column++, row, String.valueOf((row)), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, one.getUser_no(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, one.getMember_id(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, one.getMember_name(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, one.getMember_birth(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, one.getMember_sex(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, one.getMember_area(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, one.getCheckIn_time(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, one.getCheckOut_time(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, one.getCheckInOut_time() + "분", format1));
			
			if(StringUtils.isEmpty(one.getCheckOut_time())) {
				workbook.getSheet(0).addCell(new Label(column++, row, "이용중", format1));
			} else {
				workbook.getSheet(0).addCell(new Label(column++, row, "이용완료", format1));
			}
			
			if("1".equals(one.getGubun())) {
				workbook.getSheet(0).addCell(new Label(column++, row, "처음방문", format1));
			} else {
				workbook.getSheet(0).addCell(new Label(column++, row, "재방문", format1));
			}
			
			row++;
		}
		
		return workbook;
	}
	
}
