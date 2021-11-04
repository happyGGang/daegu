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

public class ElibStatisticsAgeExcelView extends AbstractJExcelView {

	@Override
	protected void buildExcelDocument(Map<String, Object> model, WritableWorkbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception {
		@SuppressWarnings("unchecked")
		ElibStatistics elibStatistics = (ElibStatistics) model.get("elibStatistics");
		List<ElibStatistics> elibStatisticsList = (List<ElibStatistics>) model.get("elibStatisticsList");
		String type = elibStatistics.getType();
		String typeName = "미분류";
		String columnName = "대출횟수";
		
		if("EBK".equals(type)) {
			typeName = "전자책";
		} else if("WEB".equals(type)) {
			typeName = "온라인강좌";
			columnName = "이용횟수";
		} else if("ADO".equals(type)) {
			typeName = "오디오북";
			columnName = "이용횟수";
		}
		
		String sheetName = typeName;	//시트이름
		workbook.createSheet(sheetName, 0);	//시트설정
		WritableSheet sheet = workbook.getSheet(0);
		
		String fileName = typeName + "_" + "연령별통계_" + new SimpleDateFormat("yyyyMMdd").format(new Date()) + ".xls";
		
		response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(fileName, request.getHeader("user-agent")));
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Pragma", "no-cache");
		response.setContentType("Application/Msexcel");
		
		// 헤더 스타일
		WritableCellFormat format = new WritableCellFormat();
		format.setAlignment( Alignment.CENTRE );
		format.setBackground( Colour.LIGHT_GREEN );

		//중앙정렬
		WritableCellFormat format1 = new WritableCellFormat();		
		format1.setAlignment(Alignment.CENTRE);

		//테두리선,중앙정렬
		WritableCellFormat format2 = new WritableCellFormat();		
		format2.setBorder(Border.ALL,BorderLineStyle.MEDIUM);
		
		//중앙정렬,배경색,테두리 색
		WritableCellFormat format3 = new WritableCellFormat();
		format3.setAlignment( Alignment.CENTRE );
		format3.setBackground( Colour.LIGHT_GREEN );
		format3.setBorder(Border.ALL,BorderLineStyle.MEDIUM);
		
		// 컬럼 폭 지정
		sheet.setColumnView( 0, 30 );
		sheet.setColumnView( 1, 30 );
		
		Map<String, String> providers = (Map<String, String>) model.get("providers");
		Map<String, String> libraries = (Map<String, String>) model.get("libraries");
		
		String provider = "전체";
		String library = "전체";
		
		if(providers.containsKey(elibStatistics.getCom_code())) {
			provider = providers.get(elibStatistics.getCom_code());
		}
		if(libraries.containsKey(elibStatistics.getLibrary_code())) {
			library = libraries.get(elibStatistics.getLibrary_code());
		}
		
		sheet.addCell(new Label( 0, 0,
				String.format("%s 회원별 대출통계 [ 조회일자: %s, 공급사: %s, 도서관: %s ]", typeName, new SimpleDateFormat("yyyy-MM-dd").format(new Date()), provider, library)));
		sheet.mergeCells(0, 0, 3, 0);
		
		// 헤더 컬럼 지정
		sheet.addCell( new Label( 0, 1, "연령대", format ) );
		sheet.addCell( new Label( 1, 1, "대출횟수", format ) );
		
		int row = 2;
		for ( ElibStatistics org : elibStatisticsList ) {
			int age = org.getAge();
			String legend = age < 10 ? "1세 ~ 10세" : String.valueOf(age) + "대";
			sheet.addCell( new Label( 0, row, legend, format1 ) );
			sheet.addCell( new Label( 1, row, String.valueOf(org.getLend_cnt()), format1 ) );
			row++;
		}
	}

}
