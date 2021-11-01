package kr.go.gbelib.app.cms.module.untactBook.statistics;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.view.document.AbstractJExcelView;

import jxl.write.WritableWorkbook;
import kr.co.whalesoft.framework.utils.AttachmentUtils;

public class UntactBookStatisticsSearchView  extends AbstractJExcelView {

	@Override
	protected void buildExcelDocument(Map<String, Object> model, WritableWorkbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception {

		@SuppressWarnings("unchecked")
		List<UntactBookStatistics> list = (List<UntactBookStatistics>) model.get("untactBookStatisticsList");

		String fileName = "비대면도서대출통계.xls";

		response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(fileName, request.getHeader("user-agent")));
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Pragma", "no-cache");
		response.setContentType("Application/Msexcel");

		new UntactBookStatisticsWorkbook().workbookForm(workbook, list, (UntactBookStatistics)model.get("untactBookStatistics"), request, response);

	}

}
