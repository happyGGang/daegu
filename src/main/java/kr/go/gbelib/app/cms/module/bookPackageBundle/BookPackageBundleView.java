package kr.go.gbelib.app.cms.module.bookPackageBundle;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.view.document.AbstractJExcelView;

import jxl.write.WritableWorkbook;
import kr.co.whalesoft.framework.utils.AttachmentUtils;

public class BookPackageBundleView extends AbstractJExcelView {
	
	@Override
	protected void buildExcelDocument(Map<String, Object> model, WritableWorkbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception {
		@SuppressWarnings ("unchecked")
		List<BookPackageBundle> bookPackageBundleList = (List<BookPackageBundle>) model.get("bookPackageBundleList");
		BookPackageBundle bookPackageBundle = (BookPackageBundle)model.get("bookPackageBundle");
		
		String editMode = bookPackageBundle.getEditMode();
		String name = "";
		
		if(editMode.equals("bookPackage")) {
			name = "학생추천도서꾸러미 리스트.xls";
		} else if(editMode.equals("bookPackageLoan")) {
			name = "학생추천도서꾸러미 대출신청.xls";
		} else {
			name = "학생추천도서꾸러미 책 리스트.xls";
		}
		
		response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(name, request.getHeader("user-agent")));
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Pragma", "no-cache");
		response.setContentType("Application/Msexcel");

		new BookPackageBundleWorkbook().workbookForm(workbook, editMode, bookPackageBundleList, request, response);
	}
}
