package kr.go.gbelib.app.cms.module.expReservation.expReservationApply;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.view.document.AbstractJExcelView;

import jxl.write.WritableWorkbook;
import kr.co.whalesoft.framework.utils.AttachmentUtils;

@SuppressWarnings("deprecation")
public class ExpReservationApplySearchView extends AbstractJExcelView {

	@Override
	protected void buildExcelDocument(Map<String, Object> model, WritableWorkbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception {
		@SuppressWarnings("unchecked")
		List<ExpReservationApply> expApplyList = (List<ExpReservationApply>) model.get("expUserApplyList");
		ExpReservationApply expApply = (ExpReservationApply) model.get("expApply");
		
		String fileName = expApply.getPlan_date() + "프로그램신청현황 리스트.xls";

		response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(fileName, request.getHeader("user-agent")));
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Pragma", "no-cache");
		response.setContentType("Application/Msexcel");

		new ExpReservationApplyWorkbook().workbookForm(workbook, expApplyList, request, response);
		
	}

}