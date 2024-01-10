package kr.go.gbelib.app.cms.module.checkInOut;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.view.document.AbstractJExcelView;

import jxl.write.WritableWorkbook;
import kr.co.whalesoft.framework.utils.AttachmentUtils;

public class HourOfUseExcelView extends AbstractJExcelView {
	@Override
	protected void buildExcelDocument(Map<String, Object> model, WritableWorkbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception {

		@SuppressWarnings("unchecked")
		List<CheckInOut> list = (List<CheckInOut>) model.get("checkInOutExcelList");

		String fileName = "이용시간통계.xls";

		response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(fileName, request.getHeader("user-agent")));
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Pragma", "no-cache");
		response.setContentType("Application/Msexcel");

		new HourOfUseWorkbook().workbookForm(workbook, list, request, response);

	}
}
