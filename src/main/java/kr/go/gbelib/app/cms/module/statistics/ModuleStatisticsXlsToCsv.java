package kr.go.gbelib.app.cms.module.statistics;

import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jxl.Workbook;
import jxl.write.WritableWorkbook;
import kr.co.whalesoft.framework.utils.AttachmentUtils;
import kr.co.whalesoft.framework.utils.HangulEnDecoder;

public class ModuleStatisticsXlsToCsv {

	public ModuleStatisticsXlsToCsv(ModuleStatistics moduleStatistics, List<ModuleStatistics> statisticsList, List<ModuleStatistics> statisticsListMonth, List<ModuleStatistics> statisticsListYear,
			HttpServletRequest request, HttpServletResponse response) {
		try {
			String moduleType = moduleStatistics.getModule_type();
			String sheetName 	= "통계";
			String fileName 	= "(%s~%s)[%s]통계.csv";
			if ( "LOCKER".equals(moduleType) ) {
				sheetName 			= "사물함 " + sheetName;
				fileName 			= "[사물함]통계.csv";
			} else if ( "EXCURSIONS".equals(moduleType) ) {
				sheetName 			= "견학 일별" + sheetName;
				fileName 			= String.format(fileName, moduleStatistics.getStart_date(), moduleStatistics.getEnd_date(), "견학");
			} else if ( "FACILITY".equals(moduleType) ) {
				sheetName 			= "시설물 일별" + sheetName;
				fileName 			= String.format(fileName, moduleStatistics.getStart_date(), moduleStatistics.getEnd_date(), "시설물");
			}
			
			OutputStream out = response.getOutputStream();
			WritableWorkbook workbook = Workbook.createWorkbook(out);
			workbook = new ModuleStatisticsWorkbook().workbookForm(workbook, statisticsList, statisticsListMonth, statisticsListYear, sheetName, moduleType, request, response);
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
