package kr.go.gbelib.app.cms.module.humanBook.apply;

import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateUtils;

import jxl.format.Alignment;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.format.Colour;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableWorkbook;
import kr.go.gbelib.app.cms.module.bookReview.BookReview;

public class HumanApplyWorkbook {

	protected WritableWorkbook workbookForm(WritableWorkbook workbook, List<HumanApply> humanScheduleList, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String sheetName = "휴먼북열람신청";	//시트이름
		workbook.createSheet(sheetName, 0);	//시트설정

		// 헤더 스타일
		WritableCellFormat format = new WritableCellFormat();
		format.setAlignment(Alignment.CENTRE);
		format.setBackground(Colour.LIGHT_GREEN);

		// 중앙정렬
		WritableCellFormat format1 = new WritableCellFormat();
		format1.setAlignment(Alignment.CENTRE);

		// 테두리선,중앙정렬
		WritableCellFormat format2 = new WritableCellFormat();
		format2.setBorder(Border.ALL, BorderLineStyle.MEDIUM);

		// 중앙정렬,배경색,테두리 색
		WritableCellFormat format3 = new WritableCellFormat();
		format3.setAlignment(Alignment.CENTRE);
		format3.setBackground(Colour.LIGHT_GREEN);
		format3.setBorder(Border.ALL, BorderLineStyle.MEDIUM);

		// 컬럼 폭 지정
		workbook.getSheet(0).setColumnView(0,  25);
		workbook.getSheet(0).setColumnView(1,  20);
		workbook.getSheet(0).setColumnView(2,  20);
		workbook.getSheet(0).setColumnView(3,  20);
		workbook.getSheet(0).setColumnView(4,  20);
		workbook.getSheet(0).setColumnView(5,  20);
		workbook.getSheet(0).setColumnView(6,  15);

		
		workbook.getSheet(0).addCell(new Label(0, 0, "열람일", format));
		workbook.getSheet(0).addCell(new Label(1, 0, "열람장소", format));
		workbook.getSheet(0).addCell(new Label(2, 0, "사람책", format));
		workbook.getSheet(0).addCell(new Label(3, 0, "신청자", format));
		workbook.getSheet(0).addCell(new Label(4, 0, "열람인원", format));
		workbook.getSheet(0).addCell(new Label(5, 0, "질문사항", format));
		workbook.getSheet(0).addCell(new Label(6, 0, "상태", format));
		// 헤더 컬럼 지정
		
//		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		int row = 1;
		for(HumanApply one : humanScheduleList) {
			workbook.getSheet(0).addCell(new Label(0, row, one.getHuman_apply_hope_date()));
			workbook.getSheet(0).addCell(new Label(1, row, one.getHuman_apply_place()));
			workbook.getSheet(0).addCell(new Label(2, row, one.getHuman_book_title()));
			workbook.getSheet(0).addCell(new Label(3, row, one.getHuman_apply_name()));
			workbook.getSheet(0).addCell(new Label(4, row, String.valueOf(one.getHuman_apply_people())));
			workbook.getSheet(0).addCell(new Label(5, row, one.getHuman_apply_content()));
			
			String human_apply_status = "";
			if (one.getHuman_apply_status().equals("0")) {
				human_apply_status = "신청";
			} else if (one.getHuman_apply_status().equals("1")) {
				human_apply_status = "승인";
			} else if (one.getHuman_apply_status().equals("2")) {
				human_apply_status = "취소";
			} else if (one.getHuman_apply_status().equals("3")) {
				human_apply_status = "미승인";
			}
			workbook.getSheet(0).addCell(new Label(6, row, human_apply_status));
			
			row++;
		}
		
		return workbook;
	}
	
}
