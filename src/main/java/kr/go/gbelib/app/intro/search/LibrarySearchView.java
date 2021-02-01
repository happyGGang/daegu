package kr.go.gbelib.app.intro.search;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.view.document.AbstractJExcelView;

import jxl.write.WritableWorkbook;
import kr.co.whalesoft.framework.utils.AttachmentUtils;

public class LibrarySearchView extends AbstractJExcelView {

	@Override
	protected void buildExcelDocument(Map<String, Object> model, WritableWorkbook workbook, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		@SuppressWarnings("unchecked")
		List<Map<String, Object>> resultList = (List<Map<String, Object>>) model.get("resultList");
		LibrarySearch librarySearch = (LibrarySearch) model.get("librarySearch");
		
		String excelType = librarySearch.getExcel_type();
		String name = "sample";
		
		
		if(excelType.equals("LOAN")) {
			name = "대출중도서 리스트";
		} else if(excelType.equals("HISTORY")) {
			name = "대출이력 리스트";
		} else if(excelType.equals("RESVE")) {
			name = "예약현황 리스트";
		} else if(excelType.equals("HOPE")) {
			name = "희망도서 신청현황 리스트";
		}
		
		String sheetName = name;
		name += ".xls";
		
		response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(name, request.getHeader("user-agent")));
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Pragma", "no-cache");
		response.setContentType("Application/Msexcel");

		new LibrarySearchWorkbook().workbookForm(workbook, librarySearch, resultList, sheetName, request, response);
	}
}
