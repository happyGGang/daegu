package kr.go.gbelib.app.cms.module.newelib.statistics;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jxl.format.Alignment;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.format.Colour;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;

public class ElibStatisticsBookWorkbook {

	protected WritableSheet workbookForm(WritableWorkbook workbook, ElibStatistics elibStatistics, List<ElibStatistics> elibStatisticsList, Map<String, String> providers, Map<String, String> libraries,
				String typeName, HttpServletRequest request, HttpServletResponse response) throws Exception {
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
		
		int i=0;
		// 컬럼 폭 지정
		sheet.setColumnView( i++, 100 );
		sheet.setColumnView( i++, 50 );
		sheet.setColumnView( i++, 20 );
		sheet.setColumnView( i++, 20 );
		sheet.setColumnView( i++, 20 );
		sheet.setColumnView( i++, 20 );
		sheet.setColumnView( i++, 20 );
		sheet.setColumnView( i++, 20 );
		sheet.setColumnView( i++, 20 );
		sheet.setColumnView( i++, 20 );
		sheet.setColumnView( i++, 20 );
		sheet.setColumnView( i++, 20 );
		
		String library = "전체";
		
		if(libraries.containsKey(elibStatistics.getLibrary_code())) {
			library = libraries.get(elibStatistics.getLibrary_code());
		}
		
		sheet.addCell(new Label( 0, 0,
				String.format("%s 도서별 대출통계 [ 조회일자: %s, 도서관: %s, 조회기간: %s ~ %s ]", typeName, new SimpleDateFormat("yyyy-MM-dd").format(new Date()), library, elibStatistics.getSearch_sdt(), elibStatistics.getSearch_edt())));
		sheet.mergeCells(0, 0, 3, 0);
		
		i=0;
		// 헤더 컬럼 지정
		sheet.addCell( new Label( i++, 1, "콘텐츠명", format ) );
		sheet.addCell( new Label( i++, 1, "소장도서관", format ) );
		sheet.addCell( new Label( i++, 1, "PC 대출 수", format ) );
		sheet.addCell( new Label( i++, 1, "Android 대출 수", format ) );
		sheet.addCell( new Label( i++, 1, "iOS 대출 수", format ) );
		sheet.addCell( new Label( i++, 1, "(구 스마트폰 대출 수)", format ) );
		sheet.addCell( new Label( i++, 1, "스마트폰 합계", format ) );
		sheet.addCell( new Label( i++, 1, "기타(불명) 대출 수", format ) );
		sheet.addCell( new Label( i++, 1, "전체 대출 수", format ) );
		sheet.addCell( new Label( i++, 1, "예약 누적 수", format ) );
		sheet.addCell( new Label( i++, 1, "서평 수", format ) );
		sheet.addCell( new Label( i++, 1, "현재 예약 수", format ) );
		
		int row = 2;
		for ( ElibStatistics org : elibStatisticsList ) {
			int p_cnt = org.getP_cnt();
			int s_cnt = org.getS_cnt();
			int a_cnt = org.getA_cnt();
			int i_cnt = org.getI_cnt();
			int e_cnt = org.getE_cnt();
			i=0;
			sheet.addCell( new Label( i++, row, org.getBook_name(), format1 ) );
			sheet.addCell( new Label( i++, row, org.getLibrary_name(), format1 ) );
			sheet.addCell( new Label( i++, row, String.valueOf(p_cnt), format1 ) );
			sheet.addCell( new Label( i++, row, String.valueOf(a_cnt), format1 ) );
			sheet.addCell( new Label( i++, row, String.valueOf(i_cnt), format1 ) );
			sheet.addCell( new Label( i++, row, String.valueOf(s_cnt), format1 ) );
			sheet.addCell( new Label( i++, row, String.valueOf(a_cnt + i_cnt + s_cnt), format1 ) );
			sheet.addCell( new Label( i++, row, String.valueOf(e_cnt), format1 ) );
			sheet.addCell( new Label( i++, row, String.valueOf(p_cnt + a_cnt + i_cnt + s_cnt + e_cnt), format1 ) );
			sheet.addCell( new Label( i++, row, String.valueOf(org.getTotal_reserves_cnt()), format1 ) );
			sheet.addCell( new Label( i++, row, String.valueOf(org.getComments_cnt()), format1 ) );
			sheet.addCell( new Label( i++, row, String.valueOf(org.getReserves_cnt()), format1 ) );
			row++;
		}
		
		return sheet;
	}
	
}
