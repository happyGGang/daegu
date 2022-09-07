package kr.go.gbelib.app.cms.module.bookReportClub;

import java.io.OutputStream;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jxl.Workbook;
import jxl.write.WritableWorkbook;
import kr.co.whalesoft.framework.utils.AttachmentUtils;
import kr.co.whalesoft.framework.utils.HangulEnDecoder;

public class BookReportClubXlsToCsv {
	
	public BookReportClubXlsToCsv(List<BookReportClub> bookReportContestList, String fileName, HttpServletRequest request, HttpServletResponse response) {
		try {
			OutputStream out = response.getOutputStream();
			WritableWorkbook workbook = Workbook.createWorkbook(out);
			workbook = new BookReportClubWorkbook().workbookForm(workbook, bookReportContestList, request, response);
			response.reset();
		
			response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(fileName, request.getHeader("user-agent")));
			response.setHeader("Content-Transfer-Encoding", "binary");
			response.setHeader("Pragma", "no-cache");
			response.setContentType("text/csv; charset=CP949");
			
			StringBuffer data = new StringBuffer();

			for(int rowNum = 0; rowNum < workbook.getSheet(0).getRows(); rowNum++) {
				for(int colNUm = 0; colNUm < workbook.getSheet(0).getColumns(); colNUm++) {
					jxl.Cell cell = workbook.getSheet(0).getCell(colNUm, rowNum);
					String cellStr = cell.getContents() == null ? "" : cell.getContents().trim();
					data.append("\"" + cellStr + "\"");
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
