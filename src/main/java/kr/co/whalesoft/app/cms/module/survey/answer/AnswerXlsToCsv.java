package kr.co.whalesoft.app.cms.module.survey.answer;

import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;

import jxl.Workbook;
import jxl.write.WritableWorkbook;
import kr.co.whalesoft.app.cms.module.survey.Survey;
import kr.co.whalesoft.app.cms.module.survey.quest.Quest;
import kr.co.whalesoft.framework.utils.AttachmentUtils;
import kr.co.whalesoft.framework.utils.HangulEnDecoder;

public class AnswerXlsToCsv {

	private static final DateTimeFormatter FMT = DateTimeFormat.forPattern("yyyy-MM-dd");
	
	public AnswerXlsToCsv(List<Quest> questList, List<Answer> answerList, Survey surveyBean, HttpServletRequest request, HttpServletResponse response) {
		try {
			OutputStream out = response.getOutputStream();
			WritableWorkbook workbook = Workbook.createWorkbook(out);
			workbook = new AnswerWorkbook().workbookForm(workbook, questList, answerList, surveyBean, request, response);
			response.reset();

			DateTime dt = new DateTime();
			String fileName = "설문조사_리스트(" + FMT.print(dt) + ").csv";

			response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(fileName, request.getHeader("user-agent")));
			response.setHeader("Content-Transfer-Encoding", "binary");
			response.setHeader("Pragma", "no-cache");
			response.setContentType("text/csv; charset=CP949");

			StringBuffer data = new StringBuffer();

			for(int rowNum = 0; rowNum < workbook.getSheet(0).getRows(); rowNum++) {
				for(int colNum = 0; colNum < workbook.getSheet(0).getColumns(); colNum++) {
					jxl.Cell cell = workbook.getSheet(0).getCell(colNum, rowNum);
					String cellStr = cell.getContents() == null ? "" : cell.getContents();
					data.append("\"" + cellStr + "\"");
					if(colNum + 1 != workbook.getSheet(0).getColumns()) {
						data.append(",");
					}
				}
				data.append("\n");
			}

			HangulEnDecoder.encodeDataOutput(data, "UTF-8", "CP949", response);

		} catch(Exception e) {
			e.printStackTrace();
		}
	}

}
