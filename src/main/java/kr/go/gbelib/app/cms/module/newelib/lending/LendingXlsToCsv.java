package kr.go.gbelib.app.cms.module.newelib.lending;

import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jxl.Workbook;
import jxl.write.WritableWorkbook;
import kr.co.whalesoft.framework.utils.AttachmentUtils;
import kr.co.whalesoft.framework.utils.HangulEnDecoder;

public class LendingXlsToCsv {

	public LendingXlsToCsv(Lending lending, List<Lending> lendingList, HttpServletRequest request, HttpServletResponse response) {
		try {
			String isReserve = lending.getIsReserve();
			String menuName = "미분류";
			
			if(!"Y".equals(isReserve)) {
				menuName = "대출현황";
			} else {
				menuName = "예약현황";
			}
			
			OutputStream out = response.getOutputStream();
			WritableWorkbook workbook = Workbook.createWorkbook(out);
			workbook = new LendingWorkbook().workbookForm(workbook, lending, lendingList, menuName, isReserve, request, response);
			response.reset();
			
			String fileName = menuName + "_" + new SimpleDateFormat("yyyyMMdd").format(new Date()) + ".csv";
			
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
