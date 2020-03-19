package kr.go.gbelib.app.cms.module.teach.student;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.view.document.AbstractJExcelView;

import jxl.write.WritableWorkbook;
import kr.co.whalesoft.app.cms.terms.Terms;
import kr.co.whalesoft.framework.utils.AttachmentUtils;
import kr.go.gbelib.app.cms.module.teach.Teach;

public class StudentSearchView extends AbstractJExcelView {

	@Override
	@SuppressWarnings("unchecked")
	protected void buildExcelDocument(Map<String, Object> model, WritableWorkbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		List<Student> studentList = (List<Student>) model.get("studentResult");
		Teach teach = (Teach) model.get("teach");
		workbook.createSheet(teach.getTeach_name(), 0); // 시트설정
		List<Terms> termsList = (List<Terms>)model.get("termsList");

		String fileName = "Student.xls";

		response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(fileName, request.getHeader("user-agent")));
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Pragma", "no-cache");
		response.setContentType("Application/Msexcel");

		new StudentWorkbook().workbookForm(workbook, studentList, teach, termsList, request, response);
		
	}
}
