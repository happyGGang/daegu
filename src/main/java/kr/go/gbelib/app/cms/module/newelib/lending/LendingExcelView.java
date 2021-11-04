package kr.go.gbelib.app.cms.module.newelib.lending;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.view.document.AbstractJExcelView;

import jxl.write.WritableWorkbook;
import kr.co.whalesoft.framework.utils.AttachmentUtils;

public class LendingExcelView extends AbstractJExcelView {

	@Override
	protected void buildExcelDocument(Map<String, Object> model, WritableWorkbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception {
		@SuppressWarnings("unchecked")
		Lending lending = (Lending) model.get("lending");
		List<Lending> lendingList = (List<Lending>) model.get("lendingList");
		String isReserve = lending.getIsReserve();
		String menuName = "미분류";
		
		if(!"Y".equals(isReserve)) {
			menuName = "대출현황";
		} else {
			menuName = "예약현황";
		}
		
		String fileName = menuName + "_" + new SimpleDateFormat("yyyyMMdd").format(new Date()) + ".xls";
		
		response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(fileName, request.getHeader("user-agent")));
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Pragma", "no-cache");
		response.setContentType("Application/Msexcel");
		
		new LendingWorkbook().workbookForm(workbook, lending, lendingList, menuName, isReserve, request, response);
	}

}
