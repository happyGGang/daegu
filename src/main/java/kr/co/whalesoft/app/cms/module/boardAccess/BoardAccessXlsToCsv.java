package kr.co.whalesoft.app.cms.module.boardAccess;

import java.io.OutputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jxl.Workbook;
import jxl.write.WritableWorkbook;
import kr.co.whalesoft.framework.utils.AttachmentUtils;
import kr.co.whalesoft.framework.utils.HangulEnDecoder;

public class BoardAccessXlsToCsv {

	public BoardAccessXlsToCsv(BoardAccess boardAccess, List<BoardAccess> boardList, int total_count, HttpServletRequest request, HttpServletResponse response) {
		try {
			String homepageName = boardAccess.getHomepage_name();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			String toDayStr = sdf.format(new Date());
			String sheetName = homepageName + " (게시물 현황)";	//시트이름
			
			String fileName = homepageName + "_(게시물 현황)_+"+toDayStr+"+.csv";
			
			OutputStream out = response.getOutputStream();
			WritableWorkbook workbook = Workbook.createWorkbook(out);
			workbook = new BoardAccessWorkbook().workbookForm(workbook, boardList, total_count, sheetName, request, response);
			response.reset();
			
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
