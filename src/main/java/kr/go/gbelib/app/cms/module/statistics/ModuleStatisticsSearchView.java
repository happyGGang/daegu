package kr.go.gbelib.app.cms.module.statistics;

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
import jxl.write.WritableWorkbook;
import kr.co.whalesoft.framework.utils.AttachmentUtils;

public class ModuleStatisticsSearchView extends AbstractJExcelView {
	
	@SuppressWarnings("unchecked")
	@Override
	protected void buildExcelDocument(Map<String, Object> model, WritableWorkbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception {
		@SuppressWarnings("unchecked")
		ModuleStatistics moduleStatistics = (ModuleStatistics) model.get("moduleStatistics");
		String moduleType = moduleStatistics.getModule_type();
		
		List<ModuleStatistics> statisticsList 		= null;
		List<ModuleStatistics> statisticsListMonth 	= null;
        List<ModuleStatistics> statisticsListYear 	= null;
        
        String sheetName 	= "통계";
        
        String fileName 	= "(%s~%s)[%s]통계.xls";
		if ( "LOCKER".equals(moduleType) ) {
			sheetName 			= "사물함 " + sheetName;
			fileName 			= "[사물함]통계.xls";
			statisticsList 		= (List<ModuleStatistics>) model.get("statisticsList");
		}
		else if ( "EXCURSIONS".equals(moduleType) ) {
			sheetName 			= "견학 일별" + sheetName;
			fileName 			= String.format(fileName, moduleStatistics.getStart_date(), moduleStatistics.getEnd_date(), "견학");
			statisticsList 		= (List<ModuleStatistics>) model.get("statisticsList");
			statisticsListMonth = (List<ModuleStatistics>) model.get("statisticsListMonth");
			statisticsListYear 	= (List<ModuleStatistics>) model.get("statisticsListYear");
		}
		else if ( "FACILITY".equals(moduleType) ) {
			sheetName 			= "시설물 일별" + sheetName;
			fileName 			= String.format(fileName, moduleStatistics.getStart_date(), moduleStatistics.getEnd_date(), "시설물");
			statisticsList 		= (List<ModuleStatistics>) model.get("statisticsList");
			statisticsListMonth = (List<ModuleStatistics>) model.get("statisticsListMonth");
			statisticsListYear 	= (List<ModuleStatistics>) model.get("statisticsListYear");
		}
		
		response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(fileName, request.getHeader("user-agent")));
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Pragma", "no-cache");
		response.setContentType("Application/Msexcel");
		
		new ModuleStatisticsWorkbook().workbookForm(workbook, statisticsList, statisticsListMonth, statisticsListYear, sheetName, moduleType, request, response);
	}
}
