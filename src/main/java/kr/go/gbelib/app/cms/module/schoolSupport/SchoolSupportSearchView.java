package kr.go.gbelib.app.cms.module.schoolSupport;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.view.document.AbstractJExcelView;

import jxl.write.WritableWorkbook;
import kr.co.whalesoft.framework.utils.AttachmentUtils;

public class SchoolSupportSearchView extends AbstractJExcelView {
	
	@Override
	protected void buildExcelDocument(Map<String, Object> model, WritableWorkbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception {
		@SuppressWarnings("unchecked")
		Map<String, List<SchoolSupport>> repo = (Map<String, List<SchoolSupport>>) model.get("result");
		SchoolSupport schoolSupport = (SchoolSupport) model.get("schoolSupport");
		
		String fileName = "학교도서관지원 리스트.xls";
		
		response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(fileName, request.getHeader("user-agent")));
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Pragma", "no-cache");
		response.setContentType("Application/Msexcel");
		
		new SchoolSupportWorkbook().workbookForm(workbook, schoolSupport, repo, request, response);
	}

}
