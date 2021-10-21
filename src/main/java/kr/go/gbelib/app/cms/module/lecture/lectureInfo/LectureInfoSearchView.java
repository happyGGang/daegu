package kr.go.gbelib.app.cms.module.lecture.lectureInfo;

import jxl.write.WritableWorkbook;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.framework.utils.AttachmentUtils;
import org.springframework.web.servlet.view.document.AbstractJExcelView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

public class LectureInfoSearchView extends AbstractJExcelView {
	
	@Override
	protected void buildExcelDocument(Map<String, Object> model, WritableWorkbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) model.get("homepage");
		
		@SuppressWarnings("unchecked")
		List<LectureInfo> lectureInfoList = (List<LectureInfo>) model.get("lectureInfoList");
		
		String fileName = "LectureInfo.xls";
		
		response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(fileName, request.getHeader("user-agent")));
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Pragma", "no-cache");
		response.setContentType("Application/Msexcel");
		
		new LectureInfoWorkbook().workbookForm(workbook, lectureInfoList, homepage, request, response);
	}
}
