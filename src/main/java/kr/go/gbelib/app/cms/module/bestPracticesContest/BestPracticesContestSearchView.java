package kr.go.gbelib.app.cms.module.bestPracticesContest;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.view.document.AbstractJExcelView;

import jxl.write.WritableWorkbook;
import kr.co.whalesoft.framework.utils.AttachmentUtils;

public class BestPracticesContestSearchView  extends AbstractJExcelView {
	
	@Override
	protected void buildExcelDocument(Map<String, Object> model, WritableWorkbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception {
		@SuppressWarnings("unchecked")
		List<BestPracticesContest> bestPracticesContestList = (List<BestPracticesContest>) model.get("bestPracticesContestResult");
		
		String fileName = "독서릴레이 우수 사례 공모 리스트.xls";
		
		response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(fileName, request.getHeader("user-agent")));
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Pragma", "no-cache");
		response.setContentType("Application/Msexcel");
		
		new BestPracticesContestWorkbook().workbookForm(workbook, bestPracticesContestList, request, response);
		
	}
}