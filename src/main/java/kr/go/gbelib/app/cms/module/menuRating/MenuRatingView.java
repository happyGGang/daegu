package kr.go.gbelib.app.cms.module.menuRating;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.view.document.AbstractJExcelView;

import jxl.write.WritableWorkbook;
import kr.co.whalesoft.framework.utils.AttachmentUtils;


public class MenuRatingView extends AbstractJExcelView {
	
	@Override
	protected void buildExcelDocument(Map<String, Object> model, WritableWorkbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception {

		@SuppressWarnings("unchecked")
		List<MenuRating> list = (List<MenuRating>) model.get("menuRatingList");
		MenuRating menuRating = (MenuRating) model.get("menuRating");

		String searchTime = menuRating.getSearch_start_date()+"~"+menuRating.getSearch_end_date();
		String fileName = "메뉴 만족도(" + searchTime + ").xls";

		response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(fileName, request.getHeader("user-agent")));
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Pragma", "no-cache");
		response.setContentType("Application/Msexcel");


		new MenuRatingWorkbook().workbookForm(workbook, menuRating, list, request, response);
	}

}
