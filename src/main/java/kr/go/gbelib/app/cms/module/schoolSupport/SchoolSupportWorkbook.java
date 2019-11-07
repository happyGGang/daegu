package kr.go.gbelib.app.cms.module.schoolSupport;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.web.servlet.view.document.AbstractJExcelView;

import jxl.format.Alignment;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.format.Colour;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableWorkbook;
import kr.co.whalesoft.framework.utils.AttachmentUtils;

public class SchoolSupportWorkbook {
	
	protected WritableWorkbook workbookForm(WritableWorkbook workbook, SchoolSupport schoolSupport, Map<String, List<SchoolSupport>> repo, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String sheetName = "학교도서관지원 리스트";	//시트이름
		workbook.createSheet(sheetName, 0);	//시트설정
		
		// 헤더 스타일
		WritableCellFormat format = new WritableCellFormat();
		format.setAlignment( Alignment.CENTRE );
		format.setBackground( Colour.LIGHT_GREEN );

		//중앙정렬
		WritableCellFormat format1 = new WritableCellFormat();		
		format1.setAlignment(Alignment.CENTRE);
		format1.setWrap(true);

		//테두리선,중앙정렬
		WritableCellFormat format2 = new WritableCellFormat();		
		format2.setBorder(Border.ALL,BorderLineStyle.MEDIUM);
		
		//중앙정렬,배경색,테두리 색
		WritableCellFormat format3 = new WritableCellFormat();
		format3.setAlignment( Alignment.CENTRE );
		format3.setBackground( Colour.LIGHT_GREEN );
		format3.setBorder(Border.ALL,BorderLineStyle.MEDIUM);
		
		// 컬럼 폭 지정
		workbook.getSheet(0).setColumnView( 0, 10 );
		workbook.getSheet(0).setColumnView( 1, 10 );
		workbook.getSheet(0).setColumnView( 2, 10 );
		workbook.getSheet(0).setColumnView( 3, 10 );
		workbook.getSheet(0).setColumnView( 4, 10 );
		workbook.getSheet(0).setColumnView( 5, 10 );
		
		
		String plan_year = schoolSupport.getPlan_date();
		// 헤더 컬럼 지정
		workbook.getSheet(0).addCell( new Label(0, 0, "학교 도서관 지원신청 현황", format));
		workbook.getSheet(0).mergeCells(0, 0, 3, 0);
		workbook.getSheet(0).addCell( new Label(0, 1, "월\\일", format));
		for ( int i = 1; i <= 12; i ++ ) {
			workbook.getSheet(0).addCell( new Label(0, i + 1, String.valueOf(i), format));
		}
		
		for ( int i = 1; i <= 31; i ++ ) {
			workbook.getSheet(0).addCell( new Label(i, 1, String.valueOf(i), format));
		}
		
		for ( int month = 1; month <= 12; month ++ ) {
			for ( int date = 1; date <= 31; date ++ ) {
				String key = String.format("%s-%02d-%02d", plan_year, month, date);

				if ( repo.containsKey(key) ) {
					List<SchoolSupport> list = repo.get(key);
					List<String> schoolNameList = new ArrayList<String>();
					
					for ( SchoolSupport one : list ) {
						schoolNameList.add(one.getSchool_name());
					}
					workbook.getSheet(0).addCell( new Label(date, month + 1, StringUtils.join(schoolNameList, "\n"), format1));
				}
			}
		}
		
		return workbook;
	}

}
