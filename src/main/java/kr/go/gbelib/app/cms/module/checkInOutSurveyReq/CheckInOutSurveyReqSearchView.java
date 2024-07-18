package kr.go.gbelib.app.cms.module.checkInOutSurveyReq;

import jxl.write.WritableWorkbook;
import kr.co.whalesoft.framework.utils.AttachmentUtils;
import kr.go.gbelib.app.cms.module.checkInOutSurveyQuestion.CheckInOutSurveyQuestion;
import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormatter;
import org.springframework.web.servlet.view.document.AbstractJExcelView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

public class CheckInOutSurveyReqSearchView extends AbstractJExcelView {

	@Override
	protected void buildExcelDocument(Map<String, Object> model, WritableWorkbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception {
		@SuppressWarnings("unchecked")
		List<CheckInOutSurveyReq> checkInOutSurveyReqList = (List<CheckInOutSurveyReq>) model.get("quizQuestionResult");
		@SuppressWarnings("unchecked")
		List<CheckInOutSurveyQuestion> checkInOutSurveyQuestionList = (List<CheckInOutSurveyQuestion>) model.get("quizQuestionList");
		
		DateTimeFormatter fmt = org.joda.time.format.DateTimeFormat.forPattern("yyyy-MM-dd");
		DateTime dt = new DateTime();
		
		String fileName = "독서퀴즈_신청현황_리스트(" + fmt.print(dt) + ").xls";
		
		response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(fileName, request.getHeader("user-agent")));
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Pragma", "no-cache");
		response.setContentType("Application/Msexcel");
		
		new CheckInOutSurveyReqWorkbook().workbookForm(workbook, checkInOutSurveyReqList, checkInOutSurveyQuestionList, request, response);
	}

}
