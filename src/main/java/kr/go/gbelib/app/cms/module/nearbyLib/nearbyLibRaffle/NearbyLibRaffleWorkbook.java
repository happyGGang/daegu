package kr.go.gbelib.app.cms.module.nearbyLib.nearbyLibRaffle;

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

public class NearbyLibRaffleWorkbook {
	
	protected WritableWorkbook workbookForm(WritableWorkbook workbook, List<NearbyLibRaffle> nearbyLibRaffleExcelList, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String sheetName = "내집앞도서관 추첨내역";	//시트이름
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
		workbook.getSheet(0).setColumnView( 0, 15 );
		workbook.getSheet(0).setColumnView( 1, 20 );
		workbook.getSheet(0).setColumnView( 2, 20 );
		workbook.getSheet(0).setColumnView( 3, 20 );
		workbook.getSheet(0).setColumnView( 4, 30 );
		workbook.getSheet(0).setColumnView( 5, 30 );
				
		int column = 0;
		// 헤더 컬럼 지정
		workbook.getSheet(0).addCell( new Label(column++, 0, "번호", format ) );
		workbook.getSheet(0).addCell( new Label(column++, 0, "당첨자아이디", format ) );
		workbook.getSheet(0).addCell( new Label(column++, 0, "당첨자이름", format ) );
		workbook.getSheet(0).addCell( new Label(column++, 0, "휴대폰번호", format ) );
		workbook.getSheet(0).addCell( new Label(column++, 0, "내집앞도서관예약일", format ) );
		workbook.getSheet(0).addCell( new Label(column++, 0, "당첨일", format ) );
		
		int row = 1;
		
		for ( NearbyLibRaffle one : nearbyLibRaffleExcelList ) {
			
			column = 0;	
			
			workbook.getSheet(0).addCell(new Label(column++, row, String.valueOf((row)), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, one.getMember_id(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, one.getName(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, one.getMember_phone(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, one.getReserve_date(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, one.getAdd_date(), format1));
			
			row++;
		}
		
		return workbook;
	}
	
}
