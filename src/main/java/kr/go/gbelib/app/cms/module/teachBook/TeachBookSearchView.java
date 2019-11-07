package kr.go.gbelib.app.cms.module.teachBook;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.view.document.AbstractJExcelView;

import jxl.write.WritableWorkbook;
import kr.co.whalesoft.app.cms.module.calendarManage.CalendarManage;
import kr.co.whalesoft.framework.utils.AttachmentUtils;
import kr.go.gbelib.app.cms.module.teach.Teach;
import kr.go.gbelib.app.cms.module.teach.student.Student;

public class TeachBookSearchView extends AbstractJExcelView {

	@Override
	protected void buildExcelDocument(Map<String, Object> model, WritableWorkbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		Teach teach = (Teach) model.get("teach");
		List<Student> studentList = (List<Student>) model.get("studentList");
		List<CalendarManage> calendar = (List<CalendarManage>) model.get("calendar");
		TeachBook teachBook = (TeachBook) model.get("teachBook");
		Map<Integer, Map<String, String>> teachBookRepo = (Map<Integer, Map<String, String>>) model.get("teachBookRepo");
//		
//		String sheetName = teach.getTeach_name(); // 시트이름
//		workbook.createSheet(sheetName, 0); // 시트설정

		String fileName = "TeachBook.xls";

		response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(fileName, request.getHeader("user-agent")));
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Pragma", "no-cache");
		response.setContentType("Application/Msexcel");
		
		new TeachBookWorkbook().buildExcelDocument(workbook, teach, studentList, calendar, teachBook, teachBookRepo, request, response);
	}
}
