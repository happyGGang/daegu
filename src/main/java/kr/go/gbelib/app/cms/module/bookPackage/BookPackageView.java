package kr.go.gbelib.app.cms.module.bookPackage;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.view.document.AbstractJExcelView;

import jxl.write.WritableWorkbook;
import kr.co.whalesoft.framework.utils.AttachmentUtils;

public class BookPackageView extends AbstractJExcelView {
	
	@Override
	protected void buildExcelDocument(Map<String, Object> model, WritableWorkbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception {
		@SuppressWarnings ("unchecked")
		List<BookPackage> bookPackageList = (List<BookPackage>) model.get("bookPackageList");
		BookPackage bookPackage = (BookPackage)model.get("bookPackage");
		
		String editMode = bookPackage.getEditMode();
		
		String name = "";
		if(editMode.equals("bookPackage")) {
			name = "책 꾸러미 리스트.xls";
		} else if(editMode.equals("bookPackageLoan")) {
			name = "책 꾸러미 대출신청.xls";
		}
		
		response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(name, request.getHeader("user-agent")));
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Pragma", "no-cache");
		response.setContentType("Application/Msexcel");

		new BookPackageWorkbook().workbookForm(workbook, editMode, bookPackageList, request, response);
	}
}
