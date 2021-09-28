package kr.go.gbelib.app.cms.module.untactBook.untactBookReservation;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.view.document.AbstractJExcelView;

import jxl.format.Alignment;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.format.Colour;
import jxl.format.VerticalAlignment;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableWorkbook;
import kr.co.whalesoft.framework.utils.AttachmentUtils;

public class UntactBookReservationWorkbook {
	
	protected WritableWorkbook workbookForm(WritableWorkbook workbook, List<UntactBookReservation> untactBookReservationList, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String sheetName = "비대면 전체 신청내역";	//시트이름
		workbook.createSheet(sheetName, 0);	//시트설정
		
		// 헤더 스타일
		WritableCellFormat format = new WritableCellFormat();
		format.setAlignment( Alignment.CENTRE );
		format.setBackground( Colour.LIGHT_GREEN );
		
		//좌측정렬
		WritableCellFormat format4 = new WritableCellFormat();
		format4.setAlignment( Alignment.LEFT );
		format4.setVerticalAlignment(VerticalAlignment.CENTRE);
		//중앙정렬
		WritableCellFormat format1 = new WritableCellFormat();		
		format1.setAlignment(Alignment.CENTRE);
		format1.setVerticalAlignment(VerticalAlignment.CENTRE);
	
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
		workbook.getSheet(0).setColumnView( 1, 15 );
		workbook.getSheet(0).setColumnView( 2, 30 );
		workbook.getSheet(0).setColumnView( 3, 20 );
		workbook.getSheet(0).setColumnView( 4, 10 );
		workbook.getSheet(0).setColumnView( 5, 15 );
		workbook.getSheet(0).setColumnView( 6, 15 );
				
		
		// 헤더 컬럼 지정
		workbook.getSheet(0).addCell( new Label( 0, 0, "그룹", format ) );
		workbook.getSheet(0).addCell( new Label( 1, 0, "카테고리", format ) );
		workbook.getSheet(0).addCell( new Label( 2, 0, "강좌명", format ) );
		workbook.getSheet(0).addCell( new Label( 3, 0, "기간", format ) );
		workbook.getSheet(0).addCell( new Label( 4, 0, "강사명", format ) );
		workbook.getSheet(0).addCell( new Label( 5, 0, "모집인원 / 참여인원", format ) );
		workbook.getSheet(0).addCell( new Label( 6, 0, "수료 / 미수료", format ) );
		
		int row = 1;
		
//		for ( UntactBookReservation one : untactBookReservationList ) {
//			workbook.getSheet(0).addCell( new Label( 0, row, one.getGroup_name()));
//			workbook.getSheet(0).addCell( new Label( 1, row, one.getCategory_name()));
//			workbook.getSheet(0).addCell( new Label( 2, row, one.getTeach_name()));
//			workbook.getSheet(0).addCell( new Label( 3, row, String.format("%s ~ %s", one.getStart_date(), one.getEnd_date())));
//			workbook.getSheet(0).addCell( new Label( 4, row, one.getTeacher_name()));
//			workbook.getSheet(0).addCell( new Label( 5, row, String.format("%s / %s", joinTotalCount, one.getJoin_count())));
//			workbook.getSheet(0).addCell( new Label( 6, row, String.format("%s / %s", one.getCert_ok_count(), joinTotalCount - one.getCert_ok_count())));
//			
//			row++;
//		}
		
		return workbook;
	}
	
}
