package kr.go.gbelib.app.cms.module.checkInOutSurveyReq;

import jxl.Workbook;
import jxl.write.WritableWorkbook;
import kr.co.whalesoft.framework.utils.AttachmentUtils;
import kr.co.whalesoft.framework.utils.HangulEnDecoder;
import kr.go.gbelib.app.cms.module.checkInOutSurveyQuestion.CheckInOutSurveyQuestion;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.OutputStream;
import java.util.List;

public class CheckInOutSurveyReqXlsToCsv {

	public CheckInOutSurveyReqXlsToCsv(CheckInOutSurveyReq checkInOutSurveyReq, List<CheckInOutSurveyReq> checkInOutSurveyReqList, List<CheckInOutSurveyQuestion> checkInOutSurveyQuestionList, HttpServletRequest request, HttpServletResponse response) {
		try {
			OutputStream out = response.getOutputStream();
			WritableWorkbook workbook = Workbook.createWorkbook(out);
			workbook = new CheckInOutSurveyReqWorkbook().workbookForm(workbook, checkInOutSurveyReqList, checkInOutSurveyQuestionList, request, response);
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
