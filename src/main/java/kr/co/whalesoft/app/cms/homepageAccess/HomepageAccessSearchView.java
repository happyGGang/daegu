package kr.co.whalesoft.app.cms.homepageAccess;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.web.servlet.view.document.AbstractJExcelView;

import jxl.write.WritableWorkbook;
import kr.co.whalesoft.framework.utils.AttachmentUtils;

public class HomepageAccessSearchView  extends AbstractJExcelView {

	@Override
	protected void buildExcelDocument(Map<String, Object> model, WritableWorkbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception {

		@SuppressWarnings("unchecked")
		List<HomepageAccess> list = (List<HomepageAccess>) model.get("homepageAccessList");
		HomepageAccess homepageAccess = (HomepageAccess) model.get("homepageAccess");

		String homepageName = StringUtils.defaultString(StringUtils.trimToEmpty(homepageAccess.getHomepage_name()), "전체");
		String searchTime = homepageAccess.getStart_date()+"~"+homepageAccess.getEnd_date();
		String sheetName = homepageName + " [홈페이지 접속자] 접속자 수";	//시트이름

		String fileName = homepageName + "[홈페이지 접속자](" + searchTime + ") 접속자 수.xls";

		response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(fileName, request.getHeader("user-agent")));
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Pragma", "no-cache");
		response.setContentType("Application/Msexcel");


		new HomepageAccessWorkbook().workbookForm(workbook, homepageAccess, list, sheetName, request, response);
	}

}
