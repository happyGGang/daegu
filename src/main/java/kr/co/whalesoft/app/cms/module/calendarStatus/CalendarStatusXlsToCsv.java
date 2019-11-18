package kr.co.whalesoft.app.cms.module.calendarStatus;

import java.io.OutputStream;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jxl.Workbook;
import jxl.write.WritableWorkbook;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.module.calendarManage.CalendarManage;
import kr.co.whalesoft.framework.utils.AttachmentUtils;
import kr.co.whalesoft.framework.utils.HangulEnDecoder;

public class CalendarStatusXlsToCsv {

	public CalendarStatusXlsToCsv(Homepage homepage, CalendarStatus calendarStatus, List<CalendarManage> calendarList, List<CalendarStatus> excursionsList,
			List<CalendarStatus> facilityList, List<CalendarStatus> lockerList, List<CalendarStatus> boardList, HttpServletRequest request, HttpServletResponse response) {
		try {
			OutputStream out = response.getOutputStream();
			WritableWorkbook workbook = Workbook.createWorkbook(out);
			workbook = new CalendarStatusWorkbook().workbookForm(workbook, calendarList, excursionsList, facilityList, lockerList, boardList, request, response);
			response.reset();


			String homepageName = homepage.getHomepage_name();
			String fileName = homepageName + "_이달의 행사 현황_"+calendarStatus.getStart_date()+"~"+calendarStatus.getEnd_date()+".csv";


			response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(fileName, request.getHeader("user-agent")));
			response.setHeader("Content-Transfer-Encoding", "binary");
			response.setHeader("Pragma", "no-cache");
			response.setContentType("text/csv; charset=CP949");

			StringBuffer data = new StringBuffer();
//			WritableSheet[] sheet = workbook.getSheets();

			for(int sheet=0; sheet<workbook.getSheets().length; sheet++) {
				for(int rowNum=0; rowNum<workbook.getSheet(sheet).getRows(); rowNum++) {
					for(int colNUm=0; colNUm<workbook.getSheet(sheet).getColumns(); colNUm++) {
						jxl.Cell cell = workbook.getSheet(sheet).getCell(colNUm, rowNum);
						String cellStr = cell.getContents() == null ? "" : cell.getContents();
						data.append("\""+cellStr+ "\"");
						if(colNUm + 1 != workbook.getSheet(0).getColumns()) {
							data.append(",");
						}
					}
					data.append("\n");
				}
				data.append("\n\n");
			}

			HangulEnDecoder.encodeDataOutput(data, "UTF-8", "CP949", response);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
