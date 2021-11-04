package kr.go.gbelib.app.cms.module.newelib.statistics;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.view.document.AbstractJExcelView;

import jxl.format.Alignment;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.format.Colour;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import kr.co.whalesoft.framework.utils.AttachmentUtils;

public class ElibStatisticsTimeExcelView extends AbstractJExcelView {

	@Override
	protected void buildExcelDocument(Map<String, Object> model, WritableWorkbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception {
		@SuppressWarnings("unchecked")
		ElibStatistics elibStatistics = (ElibStatistics) model.get("elibStatistics");
		List<ElibStatistics> elibStatisticsList = (List<ElibStatistics>) model.get("elibStatisticsList");
		Map<String, String> providers = (Map<String, String>) model.get("providers");
		Map<String, String> libraries = (Map<String, String>) model.get("libraries");
		String type = elibStatistics.getType();
		String menu = elibStatistics.getMenu();
		String typeName = "미분류";
		String menuName = "";
		
		if("EBK".equals(type)) {
			typeName = "전자책";
		} else if("WEB".equals(type)) {
			typeName = "온라인강좌";
		} else if("ADO".equals(type)) {
			typeName = "오디오북";
		}
		
		if("HOUR".equals(menu)) {
			menuName = "시간대";
		} else if("DAY".equals(menu)) {
			menuName = "일";
		} else if("MONTH".equals(menu)) {
			menuName = "월";
		} else if("PERIOD".equals(menu)) {
			menuName = "기간";
		}
		
		String fileName = typeName + "_" + menuName + "별통계_" + new SimpleDateFormat("yyyyMMdd").format(new Date()) + ".xls";
		
		response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(fileName, request.getHeader("user-agent")));
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Pragma", "no-cache");
		response.setContentType("Application/Msexcel");
		
		new ElibStatisticsTimeWorkbook().workbookForm(workbook, elibStatistics, elibStatisticsList, providers, libraries, typeName, menuName, request, response);
	}

}
