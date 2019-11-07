package kr.co.whalesoft.app.cms.webpageAccess;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.servlet.view.document.AbstractJExcelView;

import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableWorkbook;
import kr.co.whalesoft.framework.utils.AttachmentUtils;

public class WebpageAccessSearchView  extends AbstractJExcelView {
	
	@Override
	protected void buildExcelDocument(Map<String, Object> model, WritableWorkbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		@SuppressWarnings("unchecked")
		List<WebpageAccess> list = (List<WebpageAccess>) model.get("webpageAccessList");
		WebpageAccess webpageAccess = (WebpageAccess) model.get("webpageAccess");
		
		String homepageName = StringUtils.defaultString(StringUtils.trimToEmpty(webpageAccess.getHomepage_name()), "전체") ;
		String searchTime = webpageAccess.getStart_date()+"~"+webpageAccess.getEnd_date();
		String sheetName = homepageName + " [웹페이지 접속 카운트] 카운트";	//시트이름
		
		String fileName = homepageName + "[웹페이지 접속 카운트](" + searchTime + ") 카운트.xls";
		
		response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(fileName, request.getHeader("user-agent")));
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Pragma", "no-cache");
		response.setContentType("Application/Msexcel");
		
		new WebpageAccessWorkbook().workbookForm(workbook, webpageAccess, list, sheetName, request, response);
		
	}

}
