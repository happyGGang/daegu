package kr.go.gbelib.app.intro.search;

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
		Map<String, Object> result = (Map<String, Object>) model.get("result");
		LibrarySearch librarySearch = (LibrarySearch) model.get("librarySearch");
		
		String excelType = librarySearch.getExcel_type();
		String excelTypeDetail = librarySearch.getExcel_type_detail();
		String name = "sample";
		
		if ( "HOPE".equals(excelType) ) {
			name = "희망도서 신청리스트";
		} else if ( "LOAN".equals(excelType) && excelTypeDetail != null ) {
			name = "대출중도서 리스트";
		} else if ( "LOAN".equals(excelType) && excelTypeDetail == null ) {
			name = "대출이력 리스트";
		} else if ( "RESVE".equals(excelType) ) {
			name = "예약중도서 신청리스트";
		} else if ( "POUCH".equals(excelType) ) {
			name = "야간대출 신청리스트";
		} else if ( "SEARCH".equals(excelType) ) {
			name = "검색결과 리스트";
		} else if ( "NEWBOOK".equals(excelType) ) {
			name = "신착도서 리스트";
		} else if ( "OUT".equals(excelType)) {
			name = "상호대차 신청리스트";
		} else if ( "CLOSE".equals(excelType)) {
			name = "보존서고 신청내역리스트";
		}
		
		String sheetName = name;
		name += ".xls";
		
		response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(name, request.getHeader("user-agent")));
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Pragma", "no-cache");
		response.setContentType("Application/Msexcel");

		new LibrarySearchWorkbook().workbookForm(workbook, librarySearch, result, sheetName, request, response);
	}
}
