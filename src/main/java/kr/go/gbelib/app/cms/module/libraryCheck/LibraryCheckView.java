package kr.go.gbelib.app.cms.module.libraryCheck;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.view.document.AbstractJExcelView;

import jxl.write.WritableWorkbook;
import kr.co.whalesoft.framework.utils.AttachmentUtils;

public class LibraryCheckView extends AbstractJExcelView {
	
	@Override
	protected void buildExcelDocument(Map<String, Object> model, WritableWorkbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception {
		@SuppressWarnings ("unchecked")
		List<LibraryCheck> libraryCheckLoanList = (List<LibraryCheck>) model.get("libraryCheckLoanList");
		
		String name = "장서점검기 신청리스트.xls";
		
		response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(name, request.getHeader("user-agent")));
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Pragma", "no-cache");
		response.setContentType("Application/Msexcel");

		new LibraryCheckWorkbook().workbookForm(workbook, libraryCheckLoanList, request, response);
	}
}
