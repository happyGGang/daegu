package kr.co.whalesoft.app.cms.module.eventReq;

import jxl.write.WritableWorkbook;
import kr.co.whalesoft.app.cms.module.eventQuestion.EventQuestion;
import kr.co.whalesoft.framework.utils.AttachmentUtils;
import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormatter;
import org.springframework.web.servlet.view.document.AbstractJExcelView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

public class EventReqSearchView extends AbstractJExcelView {

	@Override
	protected void buildExcelDocument(Map<String, Object> model, WritableWorkbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception {
		@SuppressWarnings("unchecked")
		List<EventReq> eventReqList = (List<EventReq>) model.get("eventQuestionResult");
		@SuppressWarnings("unchecked")
		List<EventQuestion> eventQuestionList = (List<EventQuestion>) model.get("eventQuestionList");
		
		DateTimeFormatter fmt = org.joda.time.format.DateTimeFormat.forPattern("yyyy-MM-dd");
		DateTime dt = new DateTime();
		
		String fileName = "독서퀴즈_신청현황_리스트(" + fmt.print(dt) + ").xls";
		
		response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(fileName, request.getHeader("user-agent")));
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Pragma", "no-cache");
		response.setContentType("Application/Msexcel");
		
		new EventReqWorkbook().workbookForm(workbook, eventReqList, eventQuestionList, request, response);
	}

}
