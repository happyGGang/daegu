package kr.go.gbelib.app.cms.module.teach;

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
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.framework.utils.AttachmentUtils;
import kr.go.gbelib.app.cms.module.teacher.Teacher;

public class TeachWorkbook {
	
	protected WritableWorkbook workbookForm(WritableWorkbook workbook, List<Teach> teachList, Homepage homepage, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String sheetName = "강의 리스트";	//시트이름
		workbook.createSheet(sheetName, 0);	//시트설정
		
		String fileName = "Teach.xls";
		
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
		workbook.getSheet(0).setColumnView( 0,  20 );
		workbook.getSheet(0).setColumnView( 1,  10 );
		workbook.getSheet(0).setColumnView( 2,  10 );
		workbook.getSheet(0).setColumnView( 3,  10 );
		workbook.getSheet(0).setColumnView( 4,  10 );
		workbook.getSheet(0).setColumnView( 5,  10 );
		workbook.getSheet(0).setColumnView( 6,  20 );
		workbook.getSheet(0).setColumnView( 7,  20 );
		workbook.getSheet(0).setColumnView( 8,  10 );
		workbook.getSheet(0).setColumnView( 9,  10 );
		workbook.getSheet(0).setColumnView( 10, 20 );
		workbook.getSheet(0).setColumnView( 11, 10 );
		workbook.getSheet(0).setColumnView( 12, 10 );
		workbook.getSheet(0).setColumnView( 13, 30 );
		workbook.getSheet(0).setColumnView( 14, 20 );
		workbook.getSheet(0).setColumnView( 15, 20 );
		workbook.getSheet(0).setColumnView( 16, 10 );
		workbook.getSheet(0).setColumnView( 17, 10 );
		workbook.getSheet(0).setColumnView( 18, 10 );
		workbook.getSheet(0).setColumnView( 19, 10 );
		workbook.getSheet(0).setColumnView( 20, 30 );
		workbook.getSheet(0).setColumnView( 21, 10 );
		workbook.getSheet(0).setColumnView( 22, 10 );
		workbook.getSheet(0).setColumnView( 23, 10 );
		workbook.getSheet(0).setColumnView( 24, 10 );
		workbook.getSheet(0).setColumnView( 25, 10 );
		workbook.getSheet(0).setColumnView( 26, 10 );
		workbook.getSheet(0).setColumnView( 27, 10 );
		workbook.getSheet(0).setColumnView( 28, 10 );
		workbook.getSheet(0).setColumnView( 29, 10 );
		
		// 헤더 컬럼 지정
		workbook.getSheet(0).addCell( new Label( 0, 0, "강좌명", format ) );
		workbook.getSheet(0).addCell( new Label( 1, 0, "강사명", format ) );
		workbook.getSheet(0).addCell( new Label( 2, 0, "교육시작일자", format ) );
		workbook.getSheet(0).addCell( new Label( 3, 0, "교육종료일자", format ) );
		workbook.getSheet(0).addCell( new Label( 4, 0, "교육시작시각", format ) );
		workbook.getSheet(0).addCell( new Label( 5, 0, "교육종료시각", format ) );
		workbook.getSheet(0).addCell( new Label( 6, 0, "강좌내용", format ) );
		workbook.getSheet(0).addCell( new Label( 7, 0, "교육대상구분", format ) );
		workbook.getSheet(0).addCell( new Label( 8, 0, "교육방법구분", format ) );
		workbook.getSheet(0).addCell( new Label( 9,  0, "운영요일", format ) );
		workbook.getSheet(0).addCell( new Label( 10, 0, "교육장소", format ) );
		workbook.getSheet(0).addCell( new Label( 11, 0, "강좌정원수", format ) );
		workbook.getSheet(0).addCell( new Label( 12, 0, "수강료", format ) );
		workbook.getSheet(0).addCell( new Label( 13, 0, "교육장소도로주소", format ) );
		workbook.getSheet(0).addCell( new Label( 14, 0, "운영기관명", format ) );
		workbook.getSheet(0).addCell( new Label( 15, 0, "운영기관전화번호", format ) );
		workbook.getSheet(0).addCell( new Label( 16, 0, "접수시작일자", format ) );
		workbook.getSheet(0).addCell( new Label( 17, 0, "접수종료일자", format ) );
		workbook.getSheet(0).addCell( new Label( 18, 0, "접수방법구분", format ) );
		workbook.getSheet(0).addCell( new Label( 19, 0, "선정방법구분", format ) );
		workbook.getSheet(0).addCell( new Label( 20, 0, "홈페이지주소", format ) );
		workbook.getSheet(0).addCell( new Label( 21, 0, "직업능력개발훈련비지원강좌여부", format ) );
		workbook.getSheet(0).addCell( new Label( 22, 0, "학점은행제평가(학점)인정여부", format ) );
		workbook.getSheet(0).addCell( new Label( 23, 0, "평생학습계좌제평가인정여부", format ) );
		workbook.getSheet(0).addCell( new Label( 24, 0, "데이터기준일자", format ) );
		workbook.getSheet(0).addCell( new Label( 25, 0, "학점은행제평가인정여부", format ) );
		workbook.getSheet(0).addCell( new Label( 26, 0, "교육종료시작", format ) );
		workbook.getSheet(0).addCell( new Label( 27, 0, "직업능력개발훈련지원강좌여부", format ) );
		workbook.getSheet(0).addCell( new Label( 28, 0, "학점은행제평가학점인정여부", format ) );
		workbook.getSheet(0).addCell( new Label( 29, 0, "직원능력개발훈련비지원강좌여부", format ) );
		
		int row = 1;
		for ( Teach one : teachList ) {
			workbook.getSheet(0).addCell( new Label( 0,  row, one.getTeach_name(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 1,  row, one.getTeacher_name(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 2,  row, one.getStart_date(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 3,  row, one.getEnd_date(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 4,  row, one.getStart_time(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 5,  row, one.getEnd_time(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 6,  row, one.getTeach_desc(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 7,  row, one.getTeach_target(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 8,  row, "오프라인", format1 ) );
			workbook.getSheet(0).addCell( new Label( 9,  row, getDayToString(one.getTeach_day()), format1 ) );
			workbook.getSheet(0).addCell( new Label( 10, row, one.getTeach_stage(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 11, row, String.valueOf(one.getTeach_limit_count()), format1 ) );
			workbook.getSheet(0).addCell( new Label( 12, row, one.getTeach_etc(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 13, row, homepage.getAddress1(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 14, row, homepage.getHomepage_name(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 15, row, homepage.getHomepage_tell(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 16, row, one.getStart_join_date(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 17, row, one.getEnd_join_date(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 18, row, "온라인", format1 ) );
			workbook.getSheet(0).addCell( new Label( 19, row, "선착순", format1 ) );
			workbook.getSheet(0).addCell( new Label( 20, row, String.format("http://www.gbelib.kr/%s/index.do", homepage.getContext_path()), format1 ) );
			workbook.getSheet(0).addCell( new Label( 21, row, "N", format1 ) );
			workbook.getSheet(0).addCell( new Label( 22, row, "N", format1 ) );
			workbook.getSheet(0).addCell( new Label( 23, row, "N", format1 ) );
			workbook.getSheet(0).addCell( new Label( 24, row, one.getAdd_date(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 25, row, "N", format1 ) );
			workbook.getSheet(0).addCell( new Label( 26, row, "", format1 ) );
			workbook.getSheet(0).addCell( new Label( 27, row, "N", format1 ) );
			workbook.getSheet(0).addCell( new Label( 28, row, "N", format1 ) );
			workbook.getSheet(0).addCell( new Label( 29, row, "N", format1 ) );
			
			row++;
		}
		
		return workbook;
	}
	
	private String getDayToString(String days) {
		List<String> result	= new ArrayList<String>();
		String[] arr 		= days.split(",");
		
		for ( String one : arr ) {
			if ( "1".equals(one) ) {
				result.add("일");
			}
			else if ( "2".equals(one) ) {
				result.add("월");
			}
			else if ( "3".equals(one) ) {
				result.add("화");
			}
			else if ( "4".equals(one) ) {
				result.add("수");
			}
			else if ( "5".equals(one) ) {
				result.add("목");
			}
			else if ( "6".equals(one) ) {
				result.add("금");
			}
			else if ( "7".equals(one) ) {
				result.add("토");
			}
		}
		
		return StringUtils.join(result, ",");
	}
}
