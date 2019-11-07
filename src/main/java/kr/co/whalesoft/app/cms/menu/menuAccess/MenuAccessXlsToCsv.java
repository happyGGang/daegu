package kr.co.whalesoft.app.cms.menu.menuAccess;

import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jxl.Workbook;
import jxl.write.WritableWorkbook;
import kr.co.whalesoft.framework.utils.AttachmentUtils;
import kr.co.whalesoft.framework.utils.HangulEnDecoder;

public class MenuAccessXlsToCsv {

	public MenuAccessXlsToCsv(MenuAccess menuAccess, List<MenuAccess> menuAccessList, HttpServletRequest request, HttpServletResponse response) {
		try {
			String homepageName = menuAccess.getHomepage_name();
			String searchTime = menuAccess.getStart_date()+"~"+menuAccess.getEnd_date();
			String sheetName = homepageName + " [메뉴 접속자] 메뉴별 접속자 수";	//시트이름
			String fileName = homepageName + "[메뉴 접속자](" + searchTime + ")  메뉴별 접속자 수.csv";
			
			OutputStream out = response.getOutputStream();
			WritableWorkbook workbook = Workbook.createWorkbook(out);
			workbook = new MenuAccessWorkbook().workbookForm(workbook, menuAccessList, sheetName, request, response);
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
