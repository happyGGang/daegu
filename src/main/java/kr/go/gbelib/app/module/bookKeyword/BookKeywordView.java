package kr.go.gbelib.app.module.bookKeyword;

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

public class BookKeywordView extends AbstractJExcelView {

	@Override
	protected void buildExcelDocument(Map<String, Object> model, WritableWorkbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception {
		@SuppressWarnings("unchecked")
		List<Map<String, Object>> bookKeywordXls = (List<Map<String, Object>>) model.get("bookKeywordXls");
		
		String name = "능동형추천도서목록";
		
		response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(name + ".xls", request.getHeader("user-agent")));
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Pragma", "no-cache");
		response.setContentType("Application/Msexcel");

		workbook.createSheet(name, 0);	//시트설정

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
		workbook.getSheet(0).setColumnView(0, 5);
		workbook.getSheet(0).setColumnView(1, 50);
		workbook.getSheet(0).setColumnView(2, 50);
		workbook.getSheet(0).setColumnView(3, 20);

		
		workbook.getSheet(0).addCell(new Label(0, 0, "번호", format3));
		workbook.getSheet(0).addCell(new Label(1, 0, "책제목", format3));
		workbook.getSheet(0).addCell(new Label(2, 0, "저자", format3));
		workbook.getSheet(0).addCell(new Label(3, 0, "isbn", format3));
		// 헤더 컬럼 지정
		
		for (int i = 0; i < bookKeywordXls.size(); i++) {
			workbook.getSheet(0).addCell(new Label(0, i+1, String.valueOf(i+1),format2));
			workbook.getSheet(0).addCell(new Label(1, i+1, bookKeywordXls.get(i).get("bookname").toString(),format2));
			workbook.getSheet(0).addCell(new Label(2, i+1, bookKeywordXls.get(i).get("author").toString(),format2)); 
			workbook.getSheet(0).addCell(new Label(3, i+1, bookKeywordXls.get(i).get("isbn").toString(),format2));
		}
		
	}
}
