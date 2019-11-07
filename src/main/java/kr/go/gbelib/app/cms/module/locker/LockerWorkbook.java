package kr.go.gbelib.app.cms.module.locker;

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

public class LockerWorkbook {
	
	protected WritableWorkbook workbookForm(WritableWorkbook workbook, List<Locker> lockerList, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String sheetName = "사물함현황 리스트";	//시트이름
		workbook.createSheet(sheetName, 0);	//시트설정
		
		// 헤더 스타일
		WritableCellFormat format = new WritableCellFormat();
		format.setAlignment(Alignment.CENTRE);
		format.setBackground(Colour.LIGHT_GREEN);

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
		workbook.getSheet(0).setColumnView( 1, 50 );
		workbook.getSheet(0).setColumnView( 2, 100 );
		workbook.getSheet(0).setColumnView( 3, 40 );		
		
		// 헤더 컬럼 지정
		workbook.getSheet(0).addCell( new Label( 0, 0, "번호", format ) );
		workbook.getSheet(0).addCell( new Label( 1, 0, "사물함명", format ) );
		workbook.getSheet(0).addCell( new Label( 2, 0, "설명", format ) );
		workbook.getSheet(0).addCell( new Label( 3, 0, "상태", format ) );		
		
		int row = 1;
		for ( Locker org : lockerList ) {
			String status = "";
			if(org.getStatus().equals("1")) {
				status = "비어있음";
			} else {
				status = "신청완료";
			}
			workbook.getSheet(0).addCell( new Label( 0, row, String.valueOf(row)));
			workbook.getSheet(0).addCell( new Label( 1, row, org.getLocker_name(),format1 ) );
			workbook.getSheet(0).addCell( new Label( 2, row, org.getLocker_desc(),format1 ) );
			workbook.getSheet(0).addCell( new Label( 3, row, status,format1 ) );			
			row++;
		}
		
		return workbook;
	}

}

