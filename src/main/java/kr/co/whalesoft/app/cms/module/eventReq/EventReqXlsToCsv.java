package kr.co.whalesoft.app.cms.module.eventReq;

import jxl.Workbook;
import jxl.write.WritableWorkbook;
import kr.co.whalesoft.app.cms.module.eventQuestion.EventQuestion;
import kr.co.whalesoft.framework.utils.AttachmentUtils;
import kr.co.whalesoft.framework.utils.HangulEnDecoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.OutputStream;
import java.util.List;

public class EventReqXlsToCsv {

	public EventReqXlsToCsv(EventReq eventReq, List<EventReq> eventReqList, List<EventQuestion> eventQuestionList, HttpServletRequest request, HttpServletResponse response) {
		try {
			OutputStream out = response.getOutputStream();
			WritableWorkbook workbook = Workbook.createWorkbook(out);
			workbook = new EventReqWorkbook().workbookForm(workbook, eventReqList, eventQuestionList, request, response);
			response.reset();
			
			String fileName = "독서퀴즈 신청현황 리스트.csv";
			
			response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(fileName, request.getHeader("user-agent")));
			response.setHeader("Content-Transfer-Encoding", "binary");
			response.setHeader("Pragma", "no-cache");
			response.setContentType("text/csv; charset=CP949");
			
			StringBuffer data = new StringBuffer();
			
			for(int rowNum=0; rowNum<workbook.getSheet(0).getRows(); rowNum++) {
				for(int colNUm=0; colNUm<workbook.getSheet(0).getColumns(); colNUm++) {
					jxl.Cell cell = workbook.getSheet(0).getCell(colNUm, rowNum);
					String cellStr = cell.getContents() == null ? "" : cell.getContents();
					data.append("\""+cellStr+ "\"");
					if(colNUm + 1 != workbook.getSheet(0).getColumns()) {
						data.append(",");
					}
				}
				data.append("\n");
			}
			
			HangulEnDecoder.encodeDataOutput(data, "UTF-8", "CP949", response);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
