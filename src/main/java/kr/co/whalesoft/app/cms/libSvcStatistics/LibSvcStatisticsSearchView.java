package kr.co.whalesoft.app.cms.libSvcStatistics;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.view.document.AbstractJExcelView;

import jxl.write.WritableWorkbook;
import kr.co.whalesoft.app.cms.code.Code;
import kr.co.whalesoft.framework.utils.AttachmentUtils;

public class LibSvcStatisticsSearchView  extends AbstractJExcelView {
	
	
	@Override
	@SuppressWarnings("unchecked")
	protected void buildExcelDocument(Map<String, Object> model, WritableWorkbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		List<Map<String, Object>> listMap = (List<Map<String, Object>>) model.get("listMap");
		List<Code> codeList = (List<Code>)model.get("codeList");
		
		String fileName = "도서관 서비스 통계.xls";
		
		response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(fileName, request.getHeader("user-agent")));
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Pragma", "no-cache");
		response.setContentType("Application/Msexcel");
		
		new LibSvcStatisticsWorkbook().workbookForm(workbook, listMap, codeList, request, response);
	}

}
