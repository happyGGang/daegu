package kr.co.whalesoft.app.cms.module.bookStore;

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

public class BookStoreSearchView extends AbstractJExcelView {

	@Override
	protected void buildExcelDocument(Map<String, Object> model, WritableWorkbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception {
		@SuppressWarnings("unchecked")
		List<BookStore> bookStoreList = (List<BookStore>) model.get("bookStoreResult");
		String sheetName = "책읽는가게 신청현황 리스트";	//시트이름
		workbook.createSheet(sheetName, 0);	//시트설정
		
		String fileName = "책읽는가게 신청현황 리스트.xls";
		
		response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(fileName, request.getHeader("user-agent")));
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Pragma", "no-cache");
		response.setContentType("Application/Msexcel");
		
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
		workbook.getSheet(0).setColumnView( 1, 30 );
		workbook.getSheet(0).setColumnView( 2, 20 );
		workbook.getSheet(0).setColumnView( 3, 40 );
		workbook.getSheet(0).setColumnView( 4, 40 );
		workbook.getSheet(0).setColumnView( 5, 40 );
		workbook.getSheet(0).setColumnView( 6, 40 );
		
		// 헤더 컬럼 지정
		workbook.getSheet(0).addCell( new Label( 0, 0, "번호", format ) );
		workbook.getSheet(0).addCell( new Label( 1, 0, "대출번호", format ) );
		workbook.getSheet(0).addCell( new Label( 2, 0, "대출자명", format ) );
		workbook.getSheet(0).addCell( new Label( 3, 0, "제목", format ) );
		workbook.getSheet(0).addCell( new Label( 4, 0, "등록번호", format ) );
		workbook.getSheet(0).addCell( new Label( 5, 0, "청구기호", format ) );
		workbook.getSheet(0).addCell( new Label( 6, 0, "신청일", format ) );
		
		int row = 1;
		for ( BookStore org : bookStoreList ) {
			
			workbook.getSheet(0).addCell( new Label( 0, row, String.valueOf(row)));
			workbook.getSheet(0).addCell( new Label( 1, row, org.getLoan_seq(),format1 ) );
			workbook.getSheet(0).addCell( new Label( 2, row, org.getLoan_name(),format1 ) );
			workbook.getSheet(0).addCell( new Label( 3, row, org.getTitle(),format1 ) );
			workbook.getSheet(0).addCell( new Label( 4, row, org.getRegist_num(),format1 ) );
			workbook.getSheet(0).addCell( new Label( 5, row, org.getClaim_sign(), format1) );
			workbook.getSheet(0).addCell( new Label( 6, row, org.getAdd_date(),format1 ) );
			row++;
		}
	}

}
