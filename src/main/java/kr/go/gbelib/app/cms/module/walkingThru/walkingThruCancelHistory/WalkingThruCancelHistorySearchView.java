package kr.go.gbelib.app.cms.module.walkingThru.walkingThruCancelHistory;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.view.document.AbstractJExcelView;

import jxl.write.WritableWorkbook;
import kr.co.whalesoft.framework.utils.AttachmentUtils;

public class WalkingThruCancelHistorySearchView  extends AbstractJExcelView {

	@Override
	protected void buildExcelDocument(Map<String, Object> model, WritableWorkbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception {

		@SuppressWarnings("unchecked")
		List<WalkingThruCancelHistory> list = (List<WalkingThruCancelHistory>) model.get("walkingThruCancelHistoryList");

		String fileName = "비대면전체취소내역.xls";

		response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(fileName, request.getHeader("user-agent")));
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Pragma", "no-cache");
		response.setContentType("Application/Msexcel");

		new WalkingThruCancelHistoryWorkbook().workbookForm(workbook, list, request, response);

	}

}
