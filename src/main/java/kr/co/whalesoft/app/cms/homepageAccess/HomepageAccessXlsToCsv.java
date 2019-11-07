package kr.co.whalesoft.app.cms.homepageAccess;

import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;

import jxl.Workbook;
import jxl.write.WritableWorkbook;
import kr.co.whalesoft.app.cms.module.excursions.apply.ApplyWorkbook;
import kr.co.whalesoft.framework.utils.AttachmentUtils;
import kr.co.whalesoft.framework.utils.HangulEnDecoder;

public class HomepageAccessXlsToCsv {

	public HomepageAccessXlsToCsv(HomepageAccess homepageAccess, List<HomepageAccess> homepageAccessList, HttpServletRequest request, HttpServletResponse response) {
		try {
			String homepageName = StringUtils.defaultString(StringUtils.trimToEmpty(homepageAccess.getHomepage_name()), "전체");
			String searchTime = homepageAccess.getStart_date() + "~" + homepageAccess.getEnd_date();
			String sheetName = homepageName + " [홈페이지 접속자] 접속자 수"; //시트이름
			String fileName = homepageName + "[홈페이지 접속자](" + searchTime + ") 접속자 수.csv";

			OutputStream out = response.getOutputStream();
			WritableWorkbook workbook = Workbook.createWorkbook(out);
			workbook = new HomepageAccessWorkbook().workbookForm(workbook, homepageAccess, homepageAccessList, sheetName, request, response);
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

	public HomepageAccessXlsToCsv(HomepageAccess homepageAccess, List<HomepageAccess> homepageAccessList, int version, HttpServletRequest request, HttpServletResponse response) {
		try {
			String homepageName = StringUtils.defaultString(StringUtils.trimToEmpty(homepageAccess.getHomepage_name()), "전체");
			String searchTime = homepageAccess.getStart_date() + "~" + homepageAccess.getEnd_date();
			String sheetName = homepageName + " [홈페이지 접속자] 접속자 수"; //시트이름
			String fileName = homepageName + "[홈페이지 접속자](" + searchTime + ") 접속자 수.csv";

			OutputStream out = response.getOutputStream();
			WritableWorkbook workbook = Workbook.createWorkbook(out);
			if (version == 2019) {
				workbook = new HomepageAccessWorkbook2019().workbookForm(workbook, homepageAccess, homepageAccessList, sheetName, request, response);
			} else {

			}
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
