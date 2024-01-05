package kr.go.gbelib.app.cms.module.checkInOut;

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
import jxl.write.WriteException;

public class HourOfUseWorkbook {
	
	protected WritableWorkbook workbookForm(WritableWorkbook workbook, List<CheckInOut> checkInOutList, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String sheetName = "이용시간통계";	//시트이름
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
				
		int column = 0;
		// 헤더 컬럼 지정
		workbook.getSheet(0).addCell( new Label(column++, 0, "시간", format ) );
		workbook.getSheet(0).addCell( new Label(column++, 0, "방문수", format ) );
		workbook.getSheet(0).addCell( new Label(column++, 0, "비율(%)", format ) );
		workbook.getSheet(0).addCell( new Label(column++, 0, "비고", format ) );
		
		int row = 1;
		
		for ( CheckInOut one : checkInOutList ) {
			
			column = 0;	
			
			workbook.getSheet(0).addCell(new Label(column++, row, one.getResult_date(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, one.getResult_count(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, (one.getTotal_count()==0 ? "0.00" : Float.toString(Integer.parseInt(one.getResult_count())/one.getTotal_count()*100)) + "%", format1));
			workbook.getSheet(0).addCell(new Label(column++, row, "", format1));
			
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
				
		int column = 0;
		// 헤더 컬럼 지정
		workbook.getSheet(0).addCell( new Label(column++, 0, "시간", format ) );
		workbook.getSheet(0).addCell( new Label(column++, 0, "방문수", format ) );
		workbook.getSheet(0).addCell( new Label(column++, 0, "비율(%)", format ) );
		workbook.getSheet(0).addCell( new Label(column++, 0, "비고", format ) );
		
		int row = 1;
		
		for ( CheckInOut one : cscList ) {
			
			column = 0;	
			
			workbook.getSheet(0).addCell(new Label(column++, row, one.getResult_date(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, one.getResult_count(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, (one.getTotal_count()==0 ? "0.00" : Float.toString(Integer.parseInt(one.getResult_count())/one.getTotal_count()*100)) + "%", format1));
			workbook.getSheet(0).addCell(new Label(column++, row, "", format1));
			
			row++;
		}
		
		return workbook;
	}
	
}
