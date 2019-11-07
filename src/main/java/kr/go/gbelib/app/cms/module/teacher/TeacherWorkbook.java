package kr.go.gbelib.app.cms.module.teacher;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.text.StyledEditorKit.BoldAction;

import org.apache.commons.lang.StringUtils;
import org.springframework.web.servlet.view.document.AbstractJExcelView;

import jxl.format.Alignment;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.format.Colour;
import jxl.format.VerticalAlignment;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableWorkbook;
import kr.co.whalesoft.framework.utils.AttachmentUtils;

public class TeacherWorkbook {
	
	protected WritableWorkbook workbookForm(WritableWorkbook workbook, List<Teacher> teacherList, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String sheetName = "강사 리스트";	//시트이름
		workbook.createSheet(sheetName, 0);	//시트설정
		
		//중앙정렬
		WritableCellFormat title = new WritableCellFormat();		
		title.setAlignment(Alignment.CENTRE);
		title.setVerticalAlignment(VerticalAlignment.CENTRE);
		
		// 헤더 스타일
		WritableCellFormat format = new WritableCellFormat();
		format.setAlignment( Alignment.CENTRE );
		format.setBackground( Colour.LIGHT_GREEN );
		
		//좌측정렬
		WritableCellFormat format4 = new WritableCellFormat();
		format4.setAlignment( Alignment.LEFT );
		format4.setVerticalAlignment(VerticalAlignment.CENTRE);
		//중앙정렬
		WritableCellFormat format1 = new WritableCellFormat();		
		format1.setAlignment(Alignment.CENTRE);
		format1.setVerticalAlignment(VerticalAlignment.CENTRE);
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
		workbook.getSheet(0).setColumnView( 1, 15 );
		workbook.getSheet(0).setColumnView( 2, 15 );
		workbook.getSheet(0).setColumnView( 3, 10 );
		workbook.getSheet(0).setColumnView( 4, 20 );
		workbook.getSheet(0).setColumnView( 5, 20 );
		workbook.getSheet(0).setColumnView( 6, 20 );
		workbook.getSheet(0).setColumnView( 7, 20 );
		workbook.getSheet(0).setColumnView( 8, 40 );
		workbook.getSheet(0).setColumnView( 9, 20 );
		workbook.getSheet(0).setColumnView( 10, 15 );
		workbook.getSheet(0).setColumnView( 11, 15 );
		workbook.getSheet(0).setColumnView( 12, 20 );
		workbook.getSheet(0).setColumnView( 13, 20 );
		workbook.getSheet(0).setColumnView( 14, 30 );
		workbook.getSheet(0).setColumnView( 15, 20 );
		
		workbook.getSheet(0).addCell( new Label( 0, 0, "강사 채용 대장", format1 ) );
		workbook.getSheet(0).mergeCells(0, 0, 15, 0);
		
		// 헤더 컬럼 지정
		workbook.getSheet(0).addCell( new Label( 0, 1, "번 호", format ) );
		workbook.getSheet(0).mergeCells(0, 1, 0, 2);
		workbook.getSheet(0).addCell( new Label( 1, 1, "성 명", format ) );
		workbook.getSheet(0).mergeCells(1, 1, 1, 2);
		workbook.getSheet(0).addCell( new Label( 2, 1, "생년월일", format ) );
		workbook.getSheet(0).mergeCells(2, 1, 2, 2);
		workbook.getSheet(0).addCell( new Label( 3, 1, "성별", format ) );
		workbook.getSheet(0).mergeCells(3, 1, 3, 2);
		workbook.getSheet(0).addCell( new Label( 4, 1, "전화번호", format ) );
		workbook.getSheet(0).mergeCells(4, 1, 5, 1);
		workbook.getSheet(0).addCell( new Label( 4, 2, "집전화", format ) );
		workbook.getSheet(0).addCell( new Label( 5, 2, "휴대폰", format ) );
		workbook.getSheet(0).addCell( new Label( 6, 1, "E-MAIL", format ) );
		workbook.getSheet(0).mergeCells(6, 1, 6, 2);
		workbook.getSheet(0).addCell( new Label( 7, 1, "주소", format ) );
		workbook.getSheet(0).mergeCells(7, 1, 7, 2);
		workbook.getSheet(0).addCell( new Label( 8, 1, "강의기간", format ) );
		workbook.getSheet(0).mergeCells(8, 1, 8, 2);
		workbook.getSheet(0).addCell( new Label( 9, 1, "강의일수", format ) );
		workbook.getSheet(0).mergeCells(9, 1, 9, 2);
		workbook.getSheet(0).addCell( new Label( 10, 1, "강의시간", format ) );
		workbook.getSheet(0).mergeCells(10, 1, 10, 2);
		workbook.getSheet(0).addCell( new Label( 11, 1, "강의횟수 (시간)", format ) );
		workbook.getSheet(0).mergeCells(11, 1, 11, 2);
		workbook.getSheet(0).addCell( new Label( 12, 1, "강의 관련 사항", format ) );
		workbook.getSheet(0).mergeCells(12, 1, 13, 1);
		workbook.getSheet(0).addCell( new Label( 12, 2, "학과,경력", format ) );
		workbook.getSheet(0).addCell( new Label( 13, 2, "자격증", format ) );
		workbook.getSheet(0).addCell( new Label( 14, 1, "강의 과목", format ) );
		workbook.getSheet(0).mergeCells(14, 1, 14, 2);
		workbook.getSheet(0).addCell( new Label( 15, 1, "비고", format ) );
		workbook.getSheet(0).mergeCells(15, 1, 15, 2);

		int row = 3;
		
		int beforeTeacherIdx = 0;
		int totalTeachCount = 0;
		int totalTeachHourCount = 0;
		int seqNum = 0;
		int startLow = 0;
		for ( Teacher one : teacherList ) {
			
			if ( one.getTeacher_idx() != beforeTeacherIdx) {
				startLow = row;
				seqNum ++;
				totalTeachCount = 0;
				totalTeachHourCount = 0;
				workbook.getSheet(0).addCell( new Label( 0, row, String.valueOf(seqNum)));
				workbook.getSheet(0).addCell( new Label( 1, row, one.getTeacher_name(),format1 ) );
				workbook.getSheet(0).addCell( new Label( 2, row, one.getTeacher_birth(),format1 ) );
				workbook.getSheet(0).addCell( new Label( 3, row, one.getTeacher_sex(),format1 ) );
				workbook.getSheet(0).addCell( new Label( 4, row, one.getTeacher_phone(),format1 ) );
				workbook.getSheet(0).addCell( new Label( 5, row, one.getTeacher_cell_phone(),format1 ) );
				workbook.getSheet(0).addCell( new Label( 6, row, one.getTeacher_email(),format1 ) );
				workbook.getSheet(0).addCell( new Label( 7, row, one.getTeacher_address(),format4 ) );
				workbook.getSheet(0).addCell( new Label( 12, row, one.getTeacher_history_manage(),format4 ) );
				workbook.getSheet(0).addCell( new Label( 13, row, one.getTeacher_history_manage2(),format4 ) );
			}
			else {
				workbook.getSheet(0).mergeCells(0, startLow, 0, row);
				workbook.getSheet(0).mergeCells(1, startLow, 1, row);
				workbook.getSheet(0).mergeCells(2, startLow, 2, row);
				workbook.getSheet(0).mergeCells(3, startLow, 3, row);
				workbook.getSheet(0).mergeCells(4, startLow, 4, row);
				workbook.getSheet(0).mergeCells(5, startLow, 5, row);
				workbook.getSheet(0).mergeCells(6, startLow, 6, row);
				workbook.getSheet(0).mergeCells(7, startLow, 7, row);
				workbook.getSheet(0).mergeCells(11, startLow, 11, row);
				workbook.getSheet(0).mergeCells(12, startLow, 12, row);
				workbook.getSheet(0).mergeCells(13, startLow, 13, row);
			}

			totalTeachCount = totalTeachCount + one.getTeach_count();
			totalTeachHourCount = totalTeachHourCount + one.getTotal_time();
			workbook.getSheet(0).addCell( new Label( 11, startLow, String.format("%s(%s)", totalTeachCount, totalTeachHourCount),format1 ) );
			workbook.getSheet(0).addCell( new Label( 8, row, String.format("%s ~ %s (%s ~ %s)", one.getStart_date(), one.getEnd_date(), one.getStart_time(), one.getEnd_time()),format1 ) );
			workbook.getSheet(0).addCell( new Label( 9, row, String.valueOf(one.getTeach_count()),format1 ) );
			workbook.getSheet(0).addCell( new Label( 10, row, String.valueOf(one.getTotal_time()),format1 ) );
			workbook.getSheet(0).addCell( new Label( 14, row, one.getTeach_name(),format4 ) );
			workbook.getSheet(0).addCell( new Label( 15, row, String.format("[%s] %s", one.getGroup_name(), one.getCategory_name()),format4 ) );
			
			beforeTeacherIdx = one.getTeacher_idx();
			row++;
		}
		
		return workbook;
	}
}
