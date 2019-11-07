package kr.go.gbelib.app.cms.module.donateBook;

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

public class DonateBookWorkbook {
	
	public WritableWorkbook workbookForm(WritableWorkbook workbook, List<DonateBook> donateBookList, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String sheetName = "도서 기증 리스트";	//시트이름
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
		workbook.getSheet(0).setColumnView( 2, 30 );
		workbook.getSheet(0).setColumnView( 3, 30 );
		workbook.getSheet(0).setColumnView( 4, 40 );
		workbook.getSheet(0).setColumnView( 5, 20 );
		workbook.getSheet(0).setColumnView( 6, 20 );
		workbook.getSheet(0).setColumnView( 7, 20 );
		
		// 헤더 컬럼 지정
		workbook.getSheet(0).addCell( new Label( 0, 0, "번호", format ) );
		workbook.getSheet(0).addCell( new Label( 1, 0, "기증자명", format ) );
		workbook.getSheet(0).addCell( new Label( 2, 0, "전화번호", format ) );
		workbook.getSheet(0).addCell( new Label( 3, 0, "폰번호", format ) );
		workbook.getSheet(0).addCell( new Label( 4, 0, "기증도서정보", format ) );
		workbook.getSheet(0).addCell( new Label( 5, 0, "기증방법", format ) );
		workbook.getSheet(0).addCell( new Label( 6, 0, "기증처리동의여부", format ) );
		workbook.getSheet(0).addCell( new Label( 7, 0, "등록일", format ) );
		
		int row = 1;
		for ( DonateBook org : donateBookList ) {
			workbook.getSheet(0).addCell( new Label( 0, row, String.valueOf(org.getDonate_idx())));
			workbook.getSheet(0).addCell( new Label( 1, row, org.getName(),format1 ) );
			workbook.getSheet(0).addCell( new Label( 2, row, org.getPhone(),format1 ) );
			workbook.getSheet(0).addCell( new Label( 3, row, org.getCell_phone(),format1 ) );
			workbook.getSheet(0).addCell( new Label( 4, row, org.getDonate_book(),format1 ) );
			workbook.getSheet(0).addCell( new Label( 5, row, org.getDonate_method(), format1) );
			workbook.getSheet(0).addCell( new Label( 6, row, org.getDonate_yn(),format1 ) );
			workbook.getSheet(0).addCell( new Label( 7, row, org.getAdd_date(),format1 ) );
			row++;
		}
		
		return workbook;
	}
	
}
