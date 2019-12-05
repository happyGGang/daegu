package kr.go.gbelib.app.module.bookReview;

import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateUtils;

import jxl.format.Alignment;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.format.Colour;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableWorkbook;
import kr.go.gbelib.app.cms.module.bookReview.BookReview;

public class BookReviewWorkbook {

	protected WritableWorkbook workbookForm(WritableWorkbook workbook, List<BookReview> bookReviewAll, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String sheetName = "서평 내역 리스트";	//시트이름
		workbook.createSheet(sheetName, 0);	//시트설정

		// 헤더 스타일
		WritableCellFormat format = new WritableCellFormat();
		format.setAlignment(Alignment.CENTRE);
		format.setBackground(Colour.LIGHT_GREEN);

		// 중앙정렬
		WritableCellFormat format1 = new WritableCellFormat();
		format1.setAlignment(Alignment.CENTRE);

		// 테두리선,중앙정렬
		WritableCellFormat format2 = new WritableCellFormat();
		format2.setBorder(Border.ALL, BorderLineStyle.MEDIUM);

		// 중앙정렬,배경색,테두리 색
		WritableCellFormat format3 = new WritableCellFormat();
		format3.setAlignment(Alignment.CENTRE);
		format3.setBackground(Colour.LIGHT_GREEN);
		format3.setBorder(Border.ALL, BorderLineStyle.MEDIUM);

		// 컬럼 폭 지정
		workbook.getSheet(0).setColumnView(0,  20);
		workbook.getSheet(0).setColumnView(1,  20);
		workbook.getSheet(0).setColumnView(2,  20);
		workbook.getSheet(0).setColumnView(3,  20);
		workbook.getSheet(0).setColumnView(4,  20);
		workbook.getSheet(0).setColumnView(5,  20);
		workbook.getSheet(0).setColumnView(6,  20);

		
		workbook.getSheet(0).addCell(new Label(0, 0, "별점", format));
		workbook.getSheet(0).addCell(new Label(1, 0, "등록일", format));
		workbook.getSheet(0).addCell(new Label(2, 0, "수정일", format));
		workbook.getSheet(0).addCell(new Label(3, 0, "소장처", format));
		workbook.getSheet(0).addCell(new Label(4, 0, "서명", format));
		workbook.getSheet(0).addCell(new Label(5, 0, "서평", format));
		// 헤더 컬럼 지정
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		int row = 1;
		for(BookReview one : bookReviewAll) {
			workbook.getSheet(0).addCell(new Label(0, row, String.valueOf(one.getBook_review_score())));
			workbook.getSheet(0).addCell(new Label(1, row, sdf.format(one.getAdd_date())));
			workbook.getSheet(0).addCell(new Label(2, row, sdf.format(one.getModify_date())));
			workbook.getSheet(0).addCell(new Label(3, row, one.getDsItemDetail().get("LOCA_NAME").toString()));
			workbook.getSheet(0).addCell(new Label(4, row, one.getDsItemDetail().get("TITLE").toString()));
			workbook.getSheet(0).addCell(new Label(5, row, one.getBook_review_content()));
			
			row++;
		}
		
		return workbook;
	}
	
}
