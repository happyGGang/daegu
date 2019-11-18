package kr.co.whalesoft.app.cms.module.calendarStatus;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.view.document.AbstractJExcelView;

import jxl.write.WritableWorkbook;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.module.calendarManage.CalendarManage;
import kr.co.whalesoft.framework.utils.AttachmentUtils;

public class CalendarStatusView  extends AbstractJExcelView {

	@Override
	protected void buildExcelDocument(Map<String, Object> model, WritableWorkbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception {

		@SuppressWarnings("unchecked")
		List<CalendarManage> calendarList = (List<CalendarManage>) model.get("calendarList");
		@SuppressWarnings("unchecked")
		List<CalendarStatus> excursionsList = (List<CalendarStatus>) model.get("excursionsList");
		@SuppressWarnings("unchecked")
		List<CalendarStatus> facilityList = (List<CalendarStatus>) model.get("facilityList");
		@SuppressWarnings("unchecked")
		List<CalendarStatus> lockerList = (List<CalendarStatus>) model.get("lockerList");
		@SuppressWarnings("unchecked")
		List<CalendarStatus> boardList = (List<CalendarStatus>) model.get("boardList");
		CalendarStatus calendarStatus = (CalendarStatus) model.get("calendarStatus");
		Homepage homepage = (Homepage) model.get("homepage");

		String homepageName = homepage.getHomepage_name();

		String fileName = homepageName + "_이달의 행사 현황_"+calendarStatus.getStart_date()+"~"+calendarStatus.getEnd_date()+".xls";

		response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(fileName, request.getHeader("user-agent")));
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Pragma", "no-cache");
		response.setContentType("Application/Msexcel");

		new CalendarStatusWorkbook().workbookForm(workbook, calendarList, excursionsList, facilityList, lockerList, boardList, request, response);
	}

}
