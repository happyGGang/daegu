package kr.go.gbelib.app.cms.module.menuRating;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jxl.format.Alignment;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.format.Colour;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableWorkbook;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.go.gbelib.app.cms.module.facility.Facility;
import kr.go.gbelib.app.cms.module.facilityReq.FacilityReq;

public class MenuRatingWorkbook {
	
	protected WritableWorkbook workbookForm(WritableWorkbook workbook, MenuRating menuRating, List<MenuRating> menuRatingList, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String sheetName = "메뉴만족도";	//시트이름
		workbook.createSheet(sheetName, 0);	//시트설정
		
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
		workbook.getSheet(0).setColumnView( 0, 10 );
		workbook.getSheet(0).setColumnView( 1, 20 );
		workbook.getSheet(0).setColumnView( 2, 30 );
		workbook.getSheet(0).setColumnView( 3, 30 );
		workbook.getSheet(0).setColumnView( 4, 20 );
		workbook.getSheet(0).setColumnView( 5, 20 );
		
		// 헤더 컬럼 지정
		workbook.getSheet(0).addCell( new Label( 0, 0, "번호", format ) );
		workbook.getSheet(0).addCell( new Label( 1, 0, "날짜", format ) );
		workbook.getSheet(0).addCell( new Label( 2, 0, "홈페이지", format ) );
		workbook.getSheet(0).addCell( new Label( 3, 0, "메뉴번호", format ) );
		workbook.getSheet(0).addCell( new Label( 4, 0, "메뉴", format ) );
		workbook.getSheet(0).addCell( new Label( 5, 0, "점수", format ) );
		
		@SuppressWarnings ("unchecked")
		List<Homepage> homepageList = (List<Homepage>)request.getSession().getAttribute("homepageList");
		
		int row = 1;
		for ( MenuRating one : menuRatingList ) {
			workbook.getSheet(0).addCell( new Label( 0, row, String.valueOf(row)));
			workbook.getSheet(0).addCell( new Label( 1, row, one.getResult_date(), format1 ) );
			for(int i = 0; i < homepageList.size(); i++) {
				if(homepageList.get(i).getHomepage_id().equals(one.getHomepage_id())) {
					workbook.getSheet(0).addCell( new Label( 2, row, homepageList.get(i).getHomepage_name(), format1 ) );
				}
			}
			workbook.getSheet(0).addCell( new Label( 3, row, String.valueOf(one.getMenu_idx()), format1 ) );
			workbook.getSheet(0).addCell( new Label( 4, row, one.getMenu_name(), format1) );
			workbook.getSheet(0).addCell( new Label( 5, row, String.valueOf(one.getRating_average_score()), format1 ) );
			row++;
		}
		
		return workbook;
	}

}
