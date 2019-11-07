package kr.co.whalesoft.app.cms.module.quizReq;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormatter;
import org.springframework.web.servlet.view.document.AbstractJExcelView;

import jxl.format.Alignment;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.format.Colour;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableWorkbook;
import kr.co.whalesoft.app.cms.module.quizQuestion.QuizQuestion;
import kr.co.whalesoft.framework.utils.AttachmentUtils;

public class QuizReqSearchView extends AbstractJExcelView {

	@Override
	protected void buildExcelDocument(Map<String, Object> model, WritableWorkbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception {
		@SuppressWarnings("unchecked")
		List<QuizReq> quizReqList = (List<QuizReq>) model.get("quizQuestionResult");
		@SuppressWarnings("unchecked")
		List<QuizQuestion> quizQuestionList = (List<QuizQuestion>) model.get("quizQuestionList");
		
		DateTimeFormatter fmt = org.joda.time.format.DateTimeFormat.forPattern("yyyy-MM-dd");
		DateTime dt = new DateTime();
		
		String fileName = "독서퀴즈_신청현황_리스트(" + fmt.print(dt) + ").xls";
		
		response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(fileName, request.getHeader("user-agent")));
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Pragma", "no-cache");
		response.setContentType("Application/Msexcel");
		
		new QuizReqWorkbook().workbookForm(workbook, quizReqList, quizQuestionList, request, response);
	}

}
