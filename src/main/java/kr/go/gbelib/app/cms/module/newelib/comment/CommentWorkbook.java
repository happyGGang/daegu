package kr.go.gbelib.app.cms.module.newelib.comment;

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
import jxl.write.WritableCellFormat;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import kr.co.whalesoft.framework.utils.AttachmentUtils;

public class CommentWorkbook {

	public WritableSheet workbookForm(WritableWorkbook workbook, Comment comment, List<Comment> commentList, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String type = comment.getType();
		String typeName = "전체";
		
		if("EBK".equals(type)) {
			typeName = "전자책";
		} else if("WEB".equals(type)) {
			typeName = "온라인강좌";
		} else if("ADO".equals(type)) {
			typeName = "오디오북";
		}
		
		String sheetName = typeName;	//시트이름
		workbook.createSheet(sheetName, 0);	//시트설정
		WritableSheet sheet = workbook.getSheet(0);
		
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
		
		
		int i=0;
		// 컬럼 폭 지정
		sheet.setColumnView( i++, 15 );
		sheet.setColumnView( i++, 30 );
		sheet.setColumnView( i++, 50 );
		sheet.setColumnView( i++, 20 );
		sheet.setColumnView( i++, 20 );
		sheet.setColumnView( i++, 50 );
		sheet.setColumnView( i++, 30 );
		sheet.setColumnView( i++, 30 );
		
		String categoryName1 = comment.getParent_name() == null ? "전체": comment.getParent_name();
		String categoryName2 = comment.getCate_name() == null ? "전체": comment.getCate_name();
		String search_sdt = comment.getSearch_sdt() == null ? "": comment.getSearch_sdt();
		String search_edt = comment.getSearch_edt() == null ? "": comment.getSearch_edt();
		
		sheet.addCell(new Label( 0, 0,
				String.format("서평내역 [ 유형: %s, 조회일자: %s, 1차 카테고리: %s, 2차 카테고리: %s, 조회기간: %s ~ %s ]", typeName, new SimpleDateFormat("yyyy-MM-dd").format(new Date()), categoryName1, categoryName2, search_sdt, search_edt)));
		sheet.mergeCells(0, 0, 3, 0);
		
		i=0;
		// 헤더 컬럼 지정
		sheet.addCell( new Label( i++, 1, "회원ID", format ) );
		sheet.addCell( new Label( i++, 1, "일시", format ) );
		sheet.addCell( new Label( i++, 1, "서명", format ) );
		sheet.addCell( new Label( i++, 1, "저자", format ) );
		sheet.addCell( new Label( i++, 1, "출판사", format ) );
		sheet.addCell( new Label( i++, 1, "서평", format ) );
		sheet.addCell( new Label( i++, 1, "마지막 대출일", format ) );
		sheet.addCell( new Label( i++, 1, "마지막 반납일", format ) );
		
		int row = 2;
		for ( Comment org : commentList ) {
			i=0;
			sheet.addCell( new Label( i++, row, org.getMember_id(), format1 ) );
			sheet.addCell( new Label( i++, row, org.getAdd_date(), format1 ) );
			sheet.addCell( new Label( i++, row, org.getBook_name(), format1 ) );
			sheet.addCell( new Label( i++, row, org.getAuthor_name(), format1 ) );
			sheet.addCell( new Label( i++, row, org.getBook_pubname(), format1 ) );
			sheet.addCell( new Label( i++, row, org.getUser_comment(), format1 ) );
			sheet.addCell( new Label( i++, row, org.getLast_lend_dt(), format1 ) );
			sheet.addCell( new Label( i++, row, org.getLast_return_dt(), format1 ) );
			row++;
		}
		
		return sheet;
	}

}
