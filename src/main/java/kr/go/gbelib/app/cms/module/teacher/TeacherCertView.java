package kr.go.gbelib.app.cms.module.teacher;

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

public class TeacherCertView  extends AbstractJExcelView {
	
	@Override
	protected void buildExcelDocument(Map<String, Object> model, WritableWorkbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception {
		@SuppressWarnings("unchecked")
		Teacher teacher = (Teacher) model.get("teacher");
		List<Teacher> teacherList = (List<Teacher>) model.get("teacherResult");
		
		String sheetName = "경력증명서";	//시트이름
		workbook.createSheet(sheetName, 0);	//시트설정
		
		String fileName = "경력증명서.xls";
		
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
		workbook.getSheet(0).setColumnView( 2, 10 );
		workbook.getSheet(0).setColumnView( 3, 30 );
		workbook.getSheet(0).setColumnView( 4, 30 );
		
		// 헤더 컬럼 지정
		workbook.getSheet(0).addCell( new Label( 0, 0, "번호", format ) );
		workbook.getSheet(0).addCell( new Label( 1, 0, "강사명", format ) );
		workbook.getSheet(0).addCell( new Label( 2, 0, "성별", format ) );
		workbook.getSheet(0).addCell( new Label( 3, 0, "전화번호", format ) );
		workbook.getSheet(0).addCell( new Label( 4, 0, "폰번호", format ) );
		
		int row = 1;
		for ( Teacher org : teacherList ) {
			workbook.getSheet(0).addCell( new Label( 0, row, String.valueOf(org.getTeacher_idx())));
			workbook.getSheet(0).addCell( new Label( 1, row, org.getTeacher_name(),format1 ) );
			workbook.getSheet(0).addCell( new Label( 2, row, org.getTeacher_sex(),format1 ) );
			workbook.getSheet(0).addCell( new Label( 3, row, org.getTeacher_phone(),format1 ) );
			workbook.getSheet(0).addCell( new Label( 4, row, org.getTeacher_cell_phone(),format1 ) );
			row++;
		}
	}
}
