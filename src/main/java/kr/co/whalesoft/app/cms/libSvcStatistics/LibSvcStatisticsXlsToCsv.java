package kr.co.whalesoft.app.cms.libSvcStatistics;

import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;

import jxl.Workbook;
import jxl.write.WritableWorkbook;
import kr.co.whalesoft.app.cms.code.Code;
import kr.co.whalesoft.app.cms.module.excursions.apply.ApplyWorkbook;
import kr.co.whalesoft.framework.utils.AttachmentUtils;
import kr.co.whalesoft.framework.utils.HangulEnDecoder;

public class LibSvcStatisticsXlsToCsv {

	public LibSvcStatisticsXlsToCsv(List<Map<String, Object>> listMap, List<Code> codeList, HttpServletRequest request, HttpServletResponse response) {
		try {
			String fileName = "도서관 서비스 통계.csv";

			OutputStream out = response.getOutputStream();
			WritableWorkbook workbook = Workbook.createWorkbook(out);
			workbook = new LibSvcStatisticsWorkbook().workbookForm(workbook, listMap, codeList, request, response);
			response.reset();

			response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(fileName, request.getHeader("user-agent")));
			response.setHeader("Content-Transfer-Encoding", "binary");
			response.setHeader("Pragma", "no-cache");
			response.setContentType("text/csv; charset=CP949");

			StringBuffer data = new StringBuffer();

			for(int rowNum = 0; rowNum < workbook.getSheet(0).getRows(); rowNum++) {
				for(int colNUm = 0; colNUm < workbook.getSheet(0).getColumns(); colNUm++) {
					jxl.Cell cell = workbook.getSheet(0).getCell(colNUm, rowNum);
					String cellStr = cell.getContents() == null ? "" : cell.getContents();
					data.append("\"" + cellStr + "\"");
					if(colNUm + 1 != workbook.getSheet(0).getColumns()) {
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
