package kr.go.gbelib.app.cms.module.bookDelivery;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.view.document.AbstractJExcelView;

import jxl.write.WritableWorkbook;
import kr.co.whalesoft.framework.utils.AttachmentUtils;

public class BookDeliveryExcelView extends AbstractJExcelView {

	@Override
	protected void buildExcelDocument(Map<String, Object> model, WritableWorkbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		@SuppressWarnings("unchecked")
		List<BookDelivery> list = (List<BookDelivery>) model.get("bookDeliveryExcelList");
		String name  = "관리자용 택배 페이지.xls";
		
		response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(name, request.getHeader("user-agent")));
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Pragma", "no-cache");
		response.setContentType("Application/Msexcel");

		new BookDeliveryExcelWorkBook().workbookForm(workbook, list, request, response);
	}
}
