package kr.go.gbelib.app.intro.search;

import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jxl.Workbook;
import jxl.write.WritableWorkbook;
import kr.co.whalesoft.framework.utils.AttachmentUtils;
import kr.co.whalesoft.framework.utils.HangulEnDecoder;

public class LibrarySearchXlsToCsv {

	public LibrarySearchXlsToCsv(LibrarySearch librarySearch, List<Map<String, Object>> result, HttpServletRequest request, HttpServletResponse response) {
		try {
			String excelType = librarySearch.getExcel_type();
			String excelTypeDetail = librarySearch.getExcel_type_detail();
			String name = "sample";
			
			if ( "HOPE".equals(excelType) ) {
				name = "희망도서 신청리스트";
			} else if ( "LOAN".equals(excelType) && excelTypeDetail != null ) {
				name = "대출중도서 리스트";
			} else if ( "LOAN".equals(excelType) && excelTypeDetail == null ) {
				name = "대출이력 리스트";
			} else if ( "RESVE".equals(excelType) ) {
				name = "예약중도서 신청리스트";
			} else if ( "POUCH".equals(excelType) ) {
				name = "야간대출 신청리스트";
			} else if ( "SEARCH".equals(excelType) ) {
				name = "검색결과 리스트";
			} else if ( "NEWBOOK".equals(excelType) ) {
				name = "신착도서 리스트";
			} else if ( "OUT".equals(excelType) ) {
				name = "상호대차 신청리스트";
			} else if ( "CLOSE".equals(excelType) ) {
				name = "보존서고 신청내역리스트";
			}
			
			OutputStream out = response.getOutputStream();
			WritableWorkbook workbook = Workbook.createWorkbook(out);
			workbook = new LibrarySearchWorkbook().workbookForm(workbook, librarySearch, result, name, request, response);
			response.reset();
			
			name += ".csv";
			response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(name, request.getHeader("user-agent")));
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
