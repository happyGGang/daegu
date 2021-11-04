package kr.go.gbelib.app.cms.module.newelib.statistics;

import java.io.OutputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jxl.Workbook;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import kr.co.whalesoft.framework.utils.AttachmentUtils;
import kr.co.whalesoft.framework.utils.HangulEnDecoder;

public class ElibStatisticsXlsToCsv {

	public ElibStatisticsXlsToCsv(ElibStatistics elibStatistics, List<ElibStatistics> elibStatisticsList, Map<String, String> libraries, Map<String, String> providers,
			String library_code, HttpServletRequest request, HttpServletResponse response) {
		try {
			OutputStream out = response.getOutputStream();
			WritableWorkbook workbook = Workbook.createWorkbook(out);
			WritableSheet sheet = null;
			
			String typeName = "미분류";
			String menuName = "";
			
			String type = elibStatistics.getType();
			String menu = elibStatistics.getMenu();
			
			if("EBK".equals(type)) {
				typeName = "전자책";
			} else if("WEB".equals(type)) {
				typeName = "온라인강좌";
			} else if("ADO".equals(type)) {
				typeName = "오디오북";
			}
			
			if("HOUR".equals(menu)) {
				menuName = "시간대";
			} else if("DAY".equals(menu)) {
				menuName = "일";
			} else if("MONTH".equals(menu)) {
				menuName = "월";
			} else if("PERIOD".equals(menu)) {
				menuName = "기간";
			} else if("CATEGORY".equals(menu)) {
				menuName = "카테고리";
			} else if("BOOK".equals(menu)) {
				menuName = "도서";
			}
			
			String fileName = typeName + "_" + menuName + "별통계_" + new SimpleDateFormat("yyyyMMdd").format(new Date()) + ".csv";
			
			if("HOUR".equals(menu) || "DAY".equals(menu) || "MONTH".equals(menu) || "PERIOD".equals(menu)) {
				sheet = new ElibStatisticsTimeWorkbook().workbookForm(workbook, elibStatistics, elibStatisticsList, providers, libraries, typeName, menuName, request, response);
			} else if("CATEGORY".equals(menu)) {
				sheet = new ElibStatisticsCategoryWorkbook().workbookForm(workbook, elibStatistics, elibStatisticsList, providers, libraries, typeName, request, response);
			} else if("BOOK".equals(menu)) {
				sheet = new ElibStatisticsBookWorkbook().workbookForm(workbook, elibStatistics, elibStatisticsList, providers, libraries, typeName, request, response);
			} else if("MEMBER".equals(menu)) {
				sheet = new ElibStatisticsMemberWorkbook().workbookForm(workbook, elibStatistics, elibStatisticsList, providers, libraries, typeName, request, response);
			} else if("AGE".equals(menu)) {
//				elibStatisticsList = service.getStatisticsByAge(elibStatistics);
			}
			response.reset();
			
			response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(fileName, request.getHeader("user-agent")));
			response.setHeader("Content-Transfer-Encoding", "binary");
			response.setHeader("Pragma", "no-cache");
			response.setContentType("text/csv; charset=CP949");
			
			StringBuffer data = new StringBuffer();
			
			for(int rowNum=0; rowNum<sheet.getRows(); rowNum++) {
				for(int colNUm=0; colNUm<sheet.getColumns(); colNUm++) {
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
