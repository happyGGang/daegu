package kr.go.gbelib.app.cms.module.relayLecture.relayLectureApply;

import java.text.SimpleDateFormat;
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
import kr.go.gbelib.app.cms.module.relayLecture.RelayLecture;

public class RelayLectureApplyWorkbook {
	
	protected WritableWorkbook workbookForm(WritableWorkbook workbook, List<RelayLectureApply> relayList, RelayLecture relayLecture, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		workbook.createSheet(relayLecture.getEvent_name(), 0); // 시트설정
		
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
		workbook.getSheet(0).setColumnView(0, 10);
		workbook.getSheet(0).setColumnView(1, 20);
		workbook.getSheet(0).setColumnView(2, 20);
		workbook.getSheet(0).setColumnView(3, 20);
		workbook.getSheet(0).setColumnView(4, 20);
		workbook.getSheet(0).setColumnView(5, 20);
		workbook.getSheet(0).setColumnView(6, 20);
		workbook.getSheet(0).setColumnView(7, 20);

		workbook.getSheet(0).addCell(new Label(0, 0, String.format(relayLecture.getEvent_name()), format1));
		workbook.getSheet(0).mergeCells(0, 0, 7, 0);
		
		int column = 0;
		// 헤더 컬럼 지정
		workbook.getSheet(0).addCell(new Label(column++, 1, "번호", format));
		workbook.getSheet(0).addCell(new Label(column++, 1, "이름", format));
		workbook.getSheet(0).addCell(new Label(column++, 1, "성별", format));
		workbook.getSheet(0).addCell(new Label(column++, 1, "연령대", format));
		workbook.getSheet(0).addCell(new Label(column++, 1, "핸드폰", format));
		workbook.getSheet(0).addCell(new Label(column++, 1, "소속", format));
		workbook.getSheet(0).addCell(new Label(column++, 1, "접수상태", format));
		workbook.getSheet(0).addCell(new Label(column++, 1, "신청일", format));
		
		int row = 2;
		for (RelayLectureApply org : relayList) {
			
			String applicantSex = "";
			if (org.getApplicant_sex().equals("M")) {
				applicantSex = "남";
			} else if (org.getApplicant_sex().equals("W")) {
				applicantSex = "여";
			}
			
			String applicantAge = "";
			if (org.getApplicant_age().equals("0")) {
				applicantAge = "영유아(0~7세)";
			} else if (org.getReception_status().equals("1")) {
				applicantAge = "초등학생(8~13세)";
			} else if (org.getReception_status().equals("2")) {
				applicantAge = "청소년(14~19세)";
			} else if (org.getReception_status().equals("3")) {
				applicantAge = "20대(20~29세)";
			} else if (org.getReception_status().equals("4")) {
				applicantAge = "30대(30~39세)";
			} else if (org.getReception_status().equals("5")) {
				applicantAge = "40대(40~49세)";
			} else if (org.getReception_status().equals("6")) {
				applicantAge = "50대(50~59세)";
			} else {
				applicantAge = "60대이상";
			} 
			
			String receptionStatus = "";
			if (org.getReception_status().equals("Y")) {
				receptionStatus = "접수";
			} else if (org.getReception_status().equals("N")) {
				receptionStatus = "취소";
			}
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String addDate = sdf.format(org.getAdd_date());

			column = 0;
			workbook.getSheet(0).addCell(new Label(column++, row, String.valueOf((row-1)), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, org.getApplicant_name(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, applicantSex, format1));
			workbook.getSheet(0).addCell(new Label(column++, row, applicantAge, format1));
			workbook.getSheet(0).addCell(new Label(column++, row, org.getApplicant_phone(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, org.getApplicant_belong(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, receptionStatus, format1));
			workbook.getSheet(0).addCell(new Label(column++, row, addDate, format1));
			
			row++;
		}
		
		return workbook;
	}
	
}
