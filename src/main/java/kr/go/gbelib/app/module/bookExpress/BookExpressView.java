package kr.go.gbelib.app.module.bookExpress;

import java.text.SimpleDateFormat;
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
import kr.go.gbelib.app.cms.module.bookReview.BookReview;

public class BookExpressView extends AbstractJExcelView {

	@Override
	protected void buildExcelDocument(Map<String, Object> model, WritableWorkbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception {
		@SuppressWarnings("unchecked")
		List<BookExpress> bookExpressXls = (List<BookExpress>) model.get("bookExpressXls");
		
		String name = "택배요청리스트";
		
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
		workbook.getSheet(0).setColumnView(0,  10);
		workbook.getSheet(0).setColumnView(1,  20);
		workbook.getSheet(0).setColumnView(2,  20);
		workbook.getSheet(0).setColumnView(3,  20);
		workbook.getSheet(0).setColumnView(4,  20);
		workbook.getSheet(0).setColumnView(5,  20);
		workbook.getSheet(0).setColumnView(6,  20);
		workbook.getSheet(0).setColumnView(7,  20);
		workbook.getSheet(0).setColumnView(8,  15);
		workbook.getSheet(0).setColumnView(9,  15);

		
		workbook.getSheet(0).addCell(new Label(0, 0, "번호", format));
		workbook.getSheet(0).addCell(new Label(1, 0, "도서명", format));
		workbook.getSheet(0).addCell(new Label(2, 0, "청구기호", format));
		workbook.getSheet(0).addCell(new Label(3, 0, "등록번호", format));
		workbook.getSheet(0).addCell(new Label(4, 0, "요청학교/신청자", format));
		workbook.getSheet(0).addCell(new Label(5, 0, "신청자", format));
		workbook.getSheet(0).addCell(new Label(6, 0, "연락처", format));
		workbook.getSheet(0).addCell(new Label(7, 0, "상태", format));
		workbook.getSheet(0).addCell(new Label(8, 0, "요청일", format));
		workbook.getSheet(0).addCell(new Label(9, 0, "처리일", format));
		// 헤더 컬럼 지정
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		int row = 1;
		for(BookExpress one : bookExpressXls) {
			workbook.getSheet(0).addCell(new Label(0, row, String.valueOf(row)));
			workbook.getSheet(0).addCell(new Label(1, row, one.getBook_name()));
			workbook.getSheet(0).addCell(new Label(2, row, one.getBook_call_no()));
			workbook.getSheet(0).addCell(new Label(3, row, one.getBook_reg_no()));
			workbook.getSheet(0).addCell(new Label(4, row, one.getAgency_name()));
			workbook.getSheet(0).addCell(new Label(5, row, one.getRequest_name() == null ? "" : one.getRequest_name()));
			workbook.getSheet(0).addCell(new Label(6, row, one.getRequest_phone() == null ? "" : one.getRequest_phone()));
			
			String status = "";
			switch(Integer.parseInt(one.getRequest_status())) {
				case 1 :
					status = "신청중";
					break;
				case 2 :
					status = "처리중";
					break;
				case 3 :
					status = "처리불가/" + (one.getReason() == null ? "" : "사유 : " + one.getReason());
					break;
				case 4 :
					status = "보류";
					break;
				case 5 :
					status = "발송완료";
					break;
				case 6 :
					status = "반납완료";
					break;
			}
			workbook.getSheet(0).addCell(new Label(7, row, status));
			workbook.getSheet(0).addCell(new Label(8, row, sdf.format(one.getRequest_date())));
			workbook.getSheet(0).addCell(new Label(9, row, sdf.format(one.getAdd_date())));
			row++;
		}
		
	}
}
