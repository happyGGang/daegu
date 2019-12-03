package kr.co.whalesoft.app.cms.snsStatistics;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.view.document.AbstractJExcelView;

import jxl.write.WritableWorkbook;
import kr.co.whalesoft.framework.utils.AttachmentUtils;

public class SnsStatisticsSearchView  extends AbstractJExcelView {

	@Override
	protected void buildExcelDocument(Map<String, Object> model, WritableWorkbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception {

		@SuppressWarnings("unchecked")
		List<SnsStatistics> list = (List<SnsStatistics>) model.get("statisticsList");
		SnsStatistics snsStatistics = (SnsStatistics) model.get("snsStatistics");

		String searchTime = snsStatistics.getStartDate()+"~"+snsStatistics.getEndDate();
		String fileName = "(" + searchTime + ") SNS 퍼가기 통계.xls";

		response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(fileName, request.getHeader("user-agent")));
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Pragma", "no-cache");
		response.setContentType("Application/Msexcel");

		new SnsStatisticsWorkbook().workbookForm(workbook, list, request, response);

	}

}
