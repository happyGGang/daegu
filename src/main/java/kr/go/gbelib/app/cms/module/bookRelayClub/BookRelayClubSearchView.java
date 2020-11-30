package kr.go.gbelib.app.cms.module.bookRelayClub;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.view.document.AbstractJExcelView;

import jxl.write.WritableWorkbook;
import kr.co.whalesoft.framework.utils.AttachmentUtils;
import kr.go.gbelib.app.cms.module.bookRelayClub.bookRelayClubList.BookRelayClubList;

public class BookRelayClubSearchView  extends AbstractJExcelView {
	
	@Override
	protected void buildExcelDocument(Map<String, Object> model, WritableWorkbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception {
		@SuppressWarnings("unchecked")
		List<BookRelayClub> bookRelayClubList = (List<BookRelayClub>) model.get("bookRelayClubResult");
		@SuppressWarnings("unchecked")
		List<BookRelayClubList> relayList = (List<BookRelayClubList>) model.get("relayList");
		
		String fileName = "독서릴레이-동아리 리스트.xls";
		
		response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(fileName, request.getHeader("user-agent")));
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Pragma", "no-cache");
		response.setContentType("Application/Msexcel");
		
		new BookRelayClubWorkbook().workbookForm(workbook, bookRelayClubList, relayList, request, response);
		
	}
}