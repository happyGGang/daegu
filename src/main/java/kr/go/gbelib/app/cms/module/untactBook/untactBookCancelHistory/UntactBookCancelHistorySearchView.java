package kr.go.gbelib.app.cms.module.untactBook.untactBookCancelHistory;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.view.document.AbstractJExcelView;

import jxl.write.WritableWorkbook;
import kr.co.whalesoft.framework.utils.AttachmentUtils;

public class UntactBookCancelHistorySearchView  extends AbstractJExcelView {

	@Override
	protected void buildExcelDocument(Map<String, Object> model, WritableWorkbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception {

		@SuppressWarnings("unchecked")
		List<UntactBookCancelHistory> list = (List<UntactBookCancelHistory>) model.get("untactBookCancelHistoryList");

		String fileName = "비대면전체취소내역.xls";

		response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(fileName, request.getHeader("user-agent")));
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Pragma", "no-cache");
		response.setContentType("Application/Msexcel");

		new UntactBookCancelHistoryWorkbook().workbookForm(workbook, list, request, response);

	}

}
