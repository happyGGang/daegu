package kr.co.whalesoft.app.cms.menu.menuAccess;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.view.document.AbstractJExcelView;

import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableWorkbook;
import kr.co.whalesoft.framework.utils.AttachmentUtils;

public class MenuAccessSearchView  extends AbstractJExcelView {
	
	@Override
	protected void buildExcelDocument(Map<String, Object> model, WritableWorkbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		@SuppressWarnings("unchecked")
		List<MenuAccess> list = (List<MenuAccess>) model.get("menuAccessResult");
		MenuAccess homepageAccess = (MenuAccess) model.get("menuAccess");
		
		String homepageName = homepageAccess.getHomepage_name();
		String searchTime = homepageAccess.getStart_date()+"~"+homepageAccess.getEnd_date();
		String sheetName = homepageName + " [메뉴 접속자] 메뉴별 접속자 수";	//시트이름
		String fileName = homepageName + "[메뉴 접속자](" + searchTime + ")  메뉴별 접속자 수.xls";
		
		response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(fileName, request.getHeader("user-agent")));
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Pragma", "no-cache");
		response.setContentType("Application/Msexcel");
		
		new MenuAccessWorkbook().workbookForm(workbook, list, sheetName, request, response);
		
	}

}
