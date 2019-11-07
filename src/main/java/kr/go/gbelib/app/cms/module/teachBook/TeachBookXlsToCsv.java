package kr.go.gbelib.app.cms.module.teachBook;

import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.xmlbeans.impl.xb.xsdschema.Public;

import jxl.Workbook;
import jxl.write.WritableWorkbook;
import kr.co.whalesoft.app.cms.code.Code;
import kr.co.whalesoft.app.cms.module.calendarManage.CalendarManage;
import kr.co.whalesoft.framework.utils.AttachmentUtils;
import kr.co.whalesoft.framework.utils.HangulEnDecoder;
import kr.go.gbelib.app.cms.module.teach.Teach;
import kr.go.gbelib.app.cms.module.teach.student.Student;

public class TeachBookXlsToCsv {

	public TeachBookXlsToCsv(List<Student> studentList, List<Code> codeList, Teach teachOne, List<CalendarManage> calendar, TeachBook teachBook,
			Map<Integer, Map<String, String>> teachBookRepo, String fileName, HttpServletRequest request, HttpServletResponse response) {
		try {
			OutputStream out = response.getOutputStream();
			WritableWorkbook workbook = Workbook.createWorkbook(out);
			workbook = new TeachBookWorkbook().buildExcelDocument(workbook, teachOne, studentList, calendar, teachBook, teachBookRepo, request, response);
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
