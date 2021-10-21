package kr.go.gbelib.app.cms.module.lecture.courseInfo;

import jxl.format.Alignment;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.format.Colour;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableWorkbook;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.framework.utils.AttachmentUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

public class CourseInfoWorkbook {
	
	protected WritableWorkbook workbookForm(WritableWorkbook workbook, List<CourseInfo> courseInfoList, Homepage homepage, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String sheetName = "강의 리스트";	//시트이름
		workbook.createSheet(sheetName, 0);	//시트설정
		
		String fileName = "CourseInfo.xls";
		
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
		workbook.getSheet(0).setColumnView( 0,  30 );	// 과정고유번호
		workbook.getSheet(0).setColumnView( 1,  30 );	// 과정명
		workbook.getSheet(0).setColumnView( 2,  15 );	// 과정노출시작기간
		workbook.getSheet(0).setColumnView( 3,  15);	// 과정노출종료기간
		workbook.getSheet(0).setColumnView( 4,  15);	// 1인 최대 수강신청
		workbook.getSheet(0).setColumnView( 5,  10);	// 사용여부
		workbook.getSheet(0).setColumnView( 6,  15 );	// 등록일
		workbook.getSheet(0).setColumnView( 7,  15 );	// 등록ID

		// 헤더 컬럼 지정
		workbook.getSheet(0).addCell( new Label( 0, 0, "과정고유번호", format ) );
		workbook.getSheet(0).addCell( new Label( 1, 0, "과정명", format ) );
		workbook.getSheet(0).addCell( new Label( 2, 0, "과정노출시작기간", format ) );
		workbook.getSheet(0).addCell( new Label( 3, 0, "과정노출종료기간", format ) );
		workbook.getSheet(0).addCell( new Label( 4, 0, "1인 최대 수강신청", format ) );
		workbook.getSheet(0).addCell( new Label( 5, 0, "사용여부", format ) );
		workbook.getSheet(0).addCell( new Label( 6, 0, "등록일", format ) );
		workbook.getSheet(0).addCell( new Label( 7, 0, "등록ID", format ) );

		int row = 1;
		for ( CourseInfo one : courseInfoList ) {
			workbook.getSheet(0).addCell( new Label( 0,  row, one.getCourse_id(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 1,  row, one.getCourse_title(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 2,  row, one.getView_start_date(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 3,  row, one.getView_end_date(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 4,  row, one.getUse_yn(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 5,  row, one.getLimit_count() >= 9999 ? "무제한" : Integer.toString(one.getLimit_count()), format1 ) );
			workbook.getSheet(0).addCell( new Label( 6,  row, one.getView_start_date(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 7,  row, one.getView_end_date(), format1 ) );

			row++;
		}

		return workbook;
	}

}
