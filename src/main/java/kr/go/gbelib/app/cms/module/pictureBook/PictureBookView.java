package kr.go.gbelib.app.cms.module.pictureBook;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.view.document.AbstractJExcelView;

import jxl.write.WritableWorkbook;
import kr.co.whalesoft.framework.utils.AttachmentUtils;

public class PictureBookView extends AbstractJExcelView {
	
	@Override
	protected void buildExcelDocument(Map<String, Object> model, WritableWorkbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception {
		@SuppressWarnings ("unchecked")
		List<PictureBook> pictureBookLoanList = (List<PictureBook>) model.get("pictureBookLoanList");
		PictureBook pictureBook = (PictureBook)model.get("pictureBook");
		
		String pay = pictureBook.getPay_yn().equals("Y") ? "유료" : "무료";
		String name = "그림책 원화("+pay+").xls";
		
		response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(name, request.getHeader("user-agent")));
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Pragma", "no-cache");
		response.setContentType("Application/Msexcel");

		new PictureBookWorkbook().workbookForm(workbook, pay, pictureBookLoanList, request, response);
	}
}
