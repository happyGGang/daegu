package kr.co.whalesoft.app.cms.module.survey.answer;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormatter;
import org.springframework.web.servlet.view.document.AbstractJExcelView;

import jxl.write.WritableWorkbook;
import kr.co.whalesoft.app.cms.module.survey.Survey;
import kr.co.whalesoft.app.cms.module.survey.quest.Quest;
import kr.co.whalesoft.framework.utils.AttachmentUtils;

public class AnswerSearchView extends AbstractJExcelView {

	private static final DateTimeFormatter FMT = org.joda.time.format.DateTimeFormat.forPattern("yyyy-MM-dd");
	
	@Override
	protected void buildExcelDocument(Map<String, Object> model, WritableWorkbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception {
		@SuppressWarnings("unchecked")
		List<Quest> statisticsList = (List<Quest>) model.get("statistics");
//		List<Answer> descriptionList = (List<Answer>) model.get("description");		
		Survey survey = (Survey) model.get("survey");
		@SuppressWarnings("unchecked")
		List<Answer> answerList = (List<Answer>) model.get("answerList");
		
		DateTime dt = new DateTime();
		
		String fileName = "설문조사_리스트(" + FMT.print(dt) + ").xls";
		
		response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(fileName, request.getHeader("user-agent")));
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Pragma", "no-cache");
		response.setContentType("Application/Msexcel");
		
		new AnswerWorkbook().workbookForm(workbook, statisticsList, answerList, survey, request, response);
	}

}

