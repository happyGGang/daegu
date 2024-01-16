package kr.go.gbelib.app.cms.module.elib.book;

import java.text.SimpleDateFormat;
import java.util.Date;
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
import jxl.write.NumberFormats;
import jxl.write.WritableCellFormat;
import jxl.write.WritableWorkbook;
import kr.co.whalesoft.framework.utils.AttachmentUtils;

public class BookWorkbook {

	protected WritableWorkbook workbookForm(WritableWorkbook workbook, Book book, List<Book> bookList, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String sheetName = "콘텐츠 목록";	//시트이름
		workbook.createSheet(sheetName, 0);	//시트설정
		
		// 헤더 스타일
		WritableCellFormat format = new WritableCellFormat();
		format.setAlignment( Alignment.CENTRE );
		format.setBackground( Colour.LIGHT_GREEN );

		//중앙정렬
		WritableCellFormat format1 = new WritableCellFormat();		
		format1.setAlignment(Alignment.CENTRE);

		//중앙정렬, 숫자
		WritableCellFormat format4 = new WritableCellFormat(NumberFormats.INTEGER);		
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
		workbook.getSheet(0).setColumnView( 0, 20 );
		workbook.getSheet(0).setColumnView( 1, 20 );
		workbook.getSheet(0).setColumnView( 2, 20 );
		workbook.getSheet(0).setColumnView( 3, 10 );
		workbook.getSheet(0).setColumnView( 4, 10 );
		workbook.getSheet(0).setColumnView( 5, 50 );
		workbook.getSheet(0).setColumnView( 6, 40 );
		workbook.getSheet(0).setColumnView( 7, 20 );
		workbook.getSheet(0).setColumnView( 8, 20 );
		workbook.getSheet(0).setColumnView( 9, 10 );
		workbook.getSheet(0).setColumnView( 10, 30 );
		workbook.getSheet(0).setColumnView( 11, 20 );
//		workbook.getSheet(0).setColumnView( 11, 20 );
//		workbook.getSheet(0).setColumnView( 12, 20 );
//		workbook.getSheet(0).setColumnView( 13, 20 );
		
		String countName = "EBK".equals(book.getType()) ? "대출횟수" : "이용횟수";
		
		// 헤더 컬럼 지정
		workbook.getSheet(0).addCell( new Label( 0, 0, "내부등록번호", format ) );
		workbook.getSheet(0).addCell( new Label( 1, 0, "1차 카테고리", format ) );
		workbook.getSheet(0).addCell( new Label( 2, 0, "2차 카테고리", format ) );
		workbook.getSheet(0).addCell( new Label( 3, 0, countName, format ) );
		workbook.getSheet(0).addCell( new Label( 4, 0, "조회수", format ) );
		workbook.getSheet(0).addCell( new Label( 5, 0, "책제목", format ) );
		workbook.getSheet(0).addCell( new Label( 6, 0, "저자", format ) );
		workbook.getSheet(0).addCell( new Label( 7, 0, "출판사", format ) );
		workbook.getSheet(0).addCell( new Label( 8, 0, "ISBN", format ) );
		workbook.getSheet(0).addCell( new Label( 9, 0, "포맷", format ) );
		workbook.getSheet(0).addCell( new Label( 10, 0, "도서관명", format ) );
		workbook.getSheet(0).addCell( new Label( 11, 0, "유통사", format ) );
//		workbook.getSheet(0).addCell( new Label( 11, 0, "책 소개", format ) );
//		workbook.getSheet(0).addCell( new Label( 12, 0, "저자 소개", format ) );
//		workbook.getSheet(0).addCell( new Label( 13, 0, "목차", format ) );
		
		int row = 1;
		for ( Book org : bookList ) {
			workbook.getSheet(0).addCell( new Label( 0, row, String.valueOf(org.getBook_idx()), format1 ) );
			workbook.getSheet(0).addCell( new Label( 1, row, org.getParent_name(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 2, row, org.getCate_name(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 3, row, String.valueOf(org.getLend_total()), format1 ) );
			workbook.getSheet(0).addCell( new Label( 4, row, String.valueOf(org.getView_count()), format1 ) );
			workbook.getSheet(0).addCell( new Label( 5, row, org.getBook_name(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 6, row, org.getAuthor_name(), format1) );
			workbook.getSheet(0).addCell( new Label( 7, row, org.getBook_pubname(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 8, row, org.getIsbn13(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 9, row, org.getFormat(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 10, row, org.getLibrary_name(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 11, row, org.getComp_name(), format1 ) );
//			workbook.getSheet(0).addCell( new Label( 11, row, org.getBook_info() ) );
//			workbook.getSheet(0).addCell( new Label( 12, row, org.getAuthor_info() ) );
//			workbook.getSheet(0).addCell( new Label( 13, row, org.getBook_table() ) );
			row++;
		}
		
		return workbook;
	}

}
