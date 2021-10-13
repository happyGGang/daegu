package kr.go.gbelib.app.cms.module.untactBook.untactBookBlackList;

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

public class UntactBookBlackListWorkbook {
	
	protected WritableWorkbook workbookForm(WritableWorkbook workbook, List<UntactBookBlackList> untactBookBlackListList, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String sheetName = "비대면 전체 블랙리스트 내역";	//시트이름
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
//		workbook.getSheet(0).setColumnView( 0, 15 );
		workbook.getSheet(0).setColumnView( 1, 15 );
		workbook.getSheet(0).setColumnView( 2, 15 );
		workbook.getSheet(0).setColumnView( 3, 15 );
		workbook.getSheet(0).setColumnView( 4, 30 );
		workbook.getSheet(0).setColumnView( 5, 30 );
		workbook.getSheet(0).setColumnView( 6, 30 );
		workbook.getSheet(0).setColumnView( 7, 15 );
		workbook.getSheet(0).setColumnView( 8, 15 );
		workbook.getSheet(0).setColumnView( 9, 15 );
				
		int column = 0;
		// 헤더 컬럼 지정
//		workbook.getSheet(0).addCell( new Label(column++, 1, "번호", format ) );
		workbook.getSheet(0).addCell( new Label(column++, 0, "회원아이디", format ) );
		workbook.getSheet(0).addCell( new Label(column++, 0, "회원이름", format ) );
		workbook.getSheet(0).addCell( new Label(column++, 0, "페널티사유", format ) );
		workbook.getSheet(0).addCell( new Label(column++, 0, "등록일", format ) );
		workbook.getSheet(0).addCell( new Label(column++, 0, "등록ID", format ) );
		workbook.getSheet(0).addCell( new Label(column++, 0, "등록IP", format ) );
		
		int row = 1;
		
		for ( UntactBookBlackList one : untactBookBlackListList ) {
			
			column = 0;	
			
//			workbook.getSheet(0).addCell(new Label(column++, row, String.valueOf((row)), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, one.getMember_id(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, one.getMember_name(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, one.getPenalty_reason(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, one.getPenalty_day(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, one.getPenalty_register_id(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, one.getPenalty_register_ip(), format1));
			
			row++;
		}
		
		return workbook;
	}
	
}
