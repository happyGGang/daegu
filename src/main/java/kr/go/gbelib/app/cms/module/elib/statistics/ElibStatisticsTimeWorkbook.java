package kr.go.gbelib.app.cms.module.elib.statistics;

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

public class ElibStatisticsTimeWorkbook {

	public WritableSheet workbookForm(WritableWorkbook workbook, ElibStatistics elibStatistics, List<ElibStatistics> elibStatisticsList, Map<String, String> providers,
			Map<String, String> libraries, String typeName, String menuName, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String sheetName = typeName;	//시트이름
		workbook.createSheet(sheetName, 0);	//시트설정
		WritableSheet sheet = workbook.getSheet(0);
		
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
		sheet.setColumnView( 0, 15 );
		sheet.setColumnView( 1, 15 );
		sheet.setColumnView( 2, 20 );
		sheet.setColumnView( 3, 15 );
		
		String provider = "전체";
		String library = "전체";
		
		if(providers.containsKey(elibStatistics.getCom_code())) {
			provider = providers.get(elibStatistics.getCom_code());
		}
		if(libraries.containsKey(elibStatistics.getLibrary_code())) {
			library = libraries.get(elibStatistics.getLibrary_code());
		}
		
		sheet.addCell(new Label( 0, 0,
				String.format("%s %s별 대출통계 [ 조회일자: %s, 유통사: %s, 도서관: %s ]", typeName, menuName, new SimpleDateFormat("yyyy-MM-dd").format(new Date()), provider, library)));
		sheet.mergeCells(0, 0, 3, 0);
		
		// 헤더 컬럼 지정
		sheet.addCell( new Label( 0, 1, "시간", format ) );
		sheet.addCell( new Label( 1, 1, "PC 대출 수", format ) );
		sheet.addCell( new Label( 2, 1, "스마트폰 대출 수", format ) );
		sheet.addCell( new Label( 3, 1, "전체 대출 수", format ) );
		
		int row = 2;
		for ( ElibStatistics org : elibStatisticsList ) {
			int lend_pc = org.getLend_pc();
			int lend_smart = org.getLend_smart();
			sheet.addCell( new Label( 0, row, org.getReg_dt(), format1 ) );
			sheet.addCell( new Label( 1, row, String.valueOf(lend_pc), format1 ) );
			sheet.addCell( new Label( 2, row, String.valueOf(lend_smart), format1 ) );
			sheet.addCell( new Label( 3, row, String.valueOf(lend_pc + lend_smart), format1 ) );
			row++;
		}
		
		return sheet;
	}

}
