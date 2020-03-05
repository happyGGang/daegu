package kr.go.gbelib.app.module.teach;

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
import kr.go.gbelib.app.cms.module.teach.Teach;

public class TeachApplySearchView  extends AbstractJExcelView {

	@Override
	protected void buildExcelDocument(Map<String, Object> model, WritableWorkbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception {
		@SuppressWarnings("unchecked")
		List<Teach> teachList = (List<Teach>) model.get("teachList");
		String sheetName = "강의신청이력 리스트";	//시트이름
		workbook.createSheet(sheetName, 0);	//시트설정

		String fileName = "강의신청이력 리스트.xls";

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
		workbook.getSheet(0).setColumnView( 0, 10 );
		workbook.getSheet(0).setColumnView( 1, 20 );
		workbook.getSheet(0).setColumnView( 2, 40 );
		workbook.getSheet(0).setColumnView( 3, 20 );
		workbook.getSheet(0).setColumnView( 4, 20 );
		workbook.getSheet(0).setColumnView( 5, 30 );
		workbook.getSheet(0).setColumnView( 6, 20 );
		workbook.getSheet(0).setColumnView( 7, 10 );
		workbook.getSheet(0).setColumnView( 8, 10 );
		workbook.getSheet(0).setColumnView( 9, 10 );
		workbook.getSheet(0).setColumnView( 10, 20 );
		workbook.getSheet(0).setColumnView( 11, 20 );
		workbook.getSheet(0).setColumnView( 12, 20 );

		// 헤더 컬럼 지정
		workbook.getSheet(0).addCell( new Label( 0, 0, "번호", format ) );
		workbook.getSheet(0).addCell( new Label( 1, 0, "강의명", format ) );
		workbook.getSheet(0).addCell( new Label( 2, 0, "강의설명", format ) );
		workbook.getSheet(0).addCell( new Label( 3, 0, "모집대상", format ) );
		workbook.getSheet(0).addCell( new Label( 4, 0, "강사명", format ) );
		workbook.getSheet(0).addCell( new Label( 5, 0, "강의날짜", format ) );
		workbook.getSheet(0).addCell( new Label( 6, 0, "강의장소", format ) );
		workbook.getSheet(0).addCell( new Label( 7, 0, "모집", format ) );
		workbook.getSheet(0).addCell( new Label( 8, 0, "후보", format ) );
		workbook.getSheet(0).addCell( new Label( 9, 0, "참여", format ) );
		workbook.getSheet(0).addCell( new Label( 10, 0, "수강생-이름", format ) );
		workbook.getSheet(0).addCell( new Label( 11, 0, "수강생-생년월일", format ) );
		workbook.getSheet(0).addCell( new Label( 12, 0, "수강생-성별", format ) );

		int row = 1;
		for ( Teach org : teachList ) {
			workbook.getSheet(0).addCell( new Label( 0, row, String.valueOf(row)));
			workbook.getSheet(0).addCell( new Label( 1, row, org.getTeach_name(),format1 ) );
			workbook.getSheet(0).addCell( new Label( 2, row, org.getTeach_desc(),format1 ) );
			workbook.getSheet(0).addCell( new Label( 3, row, org.getTeach_target(),format1 ) );
			workbook.getSheet(0).addCell( new Label( 4, row, org.getTeacher_name(),format1 ) );
			workbook.getSheet(0).addCell( new Label( 5, row, String.format("%s %s ~ %s %s", org.getStart_date(), org.getStart_time(), org.getEnd_date(), org.getEnd_time()),format1 ) );
			workbook.getSheet(0).addCell( new Label( 6, row, org.getTeach_stage(),format1 ) );
			workbook.getSheet(0).addCell( new Label( 7, row, String.valueOf(org.getTeach_limit_count()),format1 ) );
			workbook.getSheet(0).addCell( new Label( 8, row, String.valueOf(org.getTeach_backup_count()),format1 ) );
			workbook.getSheet(0).addCell( new Label( 9, row, String.valueOf(org.getTeach_join_count()),format1 ) ); //현원 넣기
			workbook.getSheet(0).addCell( new Label( 10, row, org.getStudent_name(),format1 ) );
			workbook.getSheet(0).addCell( new Label( 11, row, org.getStudent_birth(),format1 ) );
			workbook.getSheet(0).addCell( new Label( 12, row, org.getStudent_sex().equals("M") ? "남자" : "여자",format1 ) );
			row++;
		}
	}
}
