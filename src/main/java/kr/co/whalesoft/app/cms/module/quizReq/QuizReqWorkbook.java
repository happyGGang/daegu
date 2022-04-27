package kr.co.whalesoft.app.cms.module.quizReq;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.text.LabelView;

import org.apache.commons.lang.StringUtils;

import jxl.format.Alignment;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.format.Colour;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableWorkbook;
import kr.co.whalesoft.app.cms.module.quizQuestion.QuizQuestion;

public class QuizReqWorkbook {

	protected WritableWorkbook workbookForm(WritableWorkbook workbook, List<QuizReq> quizReqList, List<QuizQuestion> quizQuestionList,
		HttpServletRequest request, HttpServletResponse response) throws Exception {
		String sheetName = "독서퀴즈 신청현황 리스트";	//시트이름
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
		
		
		int i=0;
		// 컬럼 폭 지정
		workbook.getSheet(0).setColumnView( i++, 10 );
		workbook.getSheet(0).setColumnView( i++, 20 );
		workbook.getSheet(0).setColumnView( i++, 10 );
		workbook.getSheet(0).setColumnView( i++, 20 );
		workbook.getSheet(0).setColumnView( i++, 20 );
		workbook.getSheet(0).setColumnView( i++, 10 );
		workbook.getSheet(0).setColumnView( i++, 10 );
		workbook.getSheet(0).setColumnView( i++, 10 );
		workbook.getSheet(0).setColumnView( i++, 10 );
		workbook.getSheet(0).setColumnView( i++, 50 );
		workbook.getSheet(0).setColumnView( i++, 30 );
		workbook.getSheet(0).setColumnView( i++, 20 );
		workbook.getSheet(0).setColumnView( i++, 20 );
		workbook.getSheet(0).setColumnView( i++, 50 );
		
		i=0;
		// 헤더 컬럼 지정
		workbook.getSheet(0).addCell( new Label( i++, 0, "번호", format ) );
		workbook.getSheet(0).addCell( new Label( i++, 0, "등록ID", format ) );
		workbook.getSheet(0).addCell( new Label( i++, 0, "신청자명", format ) );
		workbook.getSheet(0).addCell( new Label( i++, 0, "신청자ID", format ) );
		workbook.getSheet(0).addCell( new Label( i++, 0, "학교", format ) );
		workbook.getSheet(0).addCell( new Label( i++, 0, "학년", format ) );
		workbook.getSheet(0).addCell( new Label( i++, 0, "반", format ) );
		workbook.getSheet(0).addCell( new Label( i++, 0, "성별", format ) );
		workbook.getSheet(0).addCell( new Label( i++, 0, "연령대", format ) );
		workbook.getSheet(0).addCell( new Label( i++, 0, "전화번호", format ) );
		workbook.getSheet(0).addCell( new Label( i++, 0, "등록일시", format ) );
		workbook.getSheet(0).addCell( new Label( i++, 0, "정답자 여부", format ) );
		workbook.getSheet(0).addCell( new Label( i++, 0, "당첨자 여부", format ) );
		
		
		
		int row = 1;
		for ( QuizReq org : quizReqList ) {
			
			i=0;
			workbook.getSheet(0).addCell( new Label( i++,  row, String.valueOf(row)));
			workbook.getSheet(0).addCell( new Label( i++,  row, org.getAdd_id(),format1 ) );
			workbook.getSheet(0).addCell( new Label( i++,  row, org.getName(),format1 ) );
			workbook.getSheet(0).addCell( new Label( i++,  row, org.getApplicant_id(),format1 ) );
			workbook.getSheet(0).addCell( new Label( i++,  row, org.getSchool(),format1 ) );
			workbook.getSheet(0).addCell( new Label( i++,  row, String.valueOf(org.getHak()),format1 ) );
			workbook.getSheet(0).addCell( new Label( i++,  row, String.valueOf(org.getBan()),format1 ) );
			if (StringUtils.equals(org.getGender(), "0")) {
				org.setGender("남");
			} else if (StringUtils.equals(org.getGender(), "1")) {
				org.setGender("여");
			}
			workbook.getSheet(0).addCell( new Label( i++,  row, org.getGender(), format1));
			if (StringUtils.equals(org.getAge(), "20")) {
				org.setAge("성인");
			} else if (StringUtils.equals(org.getAge(), "14")) {
				org.setAge("청소년");
			} else if (StringUtils.equals(org.getAge(), "13")) {
				org.setAge("어린이");
			}
			workbook.getSheet(0).addCell( new Label( i++,  row, org.getAge(), format1));
			workbook.getSheet(0).addCell( new Label( i++,  row, org.getPhone(),format1 ) );
			workbook.getSheet(0).addCell( new Label( i++, row, org.getAdd_date(),format1 ) );
			if ( StringUtils.isNotEmpty(org.getQuiz_answer()) ) {
				String[] answerList = org.getQuiz_answer().trim().split("\\|");
				
				workbook.getSheet(0).addCell( new Label( i++, row, org.getWinner_yn(), format1 ) );
				workbook.getSheet(0).addCell( new Label( i++, row, org.getChosen_yn(), format1 ) );
				
				int j=0;
				for(int count=1; j < answerList.length; j++, count++) {
					String answer = answerList[j];
					
					workbook.getSheet(0).setColumnView( i+j, 50 );
					if(StringUtils.isEmpty(workbook.getSheet(0).getCell(i+j, row).getContents())) {
						workbook.getSheet(0).addCell( new Label( i+j, 0, count + "번", format ) );
					}
					workbook.getSheet(0).addCell( new Label( i+j,  row, answer,format1 ) );
				}
			}
			
			row++;
		}
		
		return workbook;
	}

}
