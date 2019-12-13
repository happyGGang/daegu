package kr.co.whalesoft.app.cms.module.survey.answer;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jxl.format.Alignment;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.format.Colour;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import kr.co.whalesoft.app.cms.module.survey.Survey;
import kr.co.whalesoft.app.cms.module.survey.quest.Quest;
import kr.co.whalesoft.app.cms.module.survey.statistics.Statistics;

public class AnswerWorkbook {

	protected WritableWorkbook workbookForm(WritableWorkbook workbook, List<Quest> questList, List<Answer> answerList, Survey surveyBean, HttpServletRequest request, HttpServletResponse response) throws Exception {
		List<Quest> statisticsList = questList;
		Survey survey = surveyBean;
		
		workbook.createSheet("설문조사현황 리스트", 0);	//시트설정
		workbook.createSheet("응답자 리스트", 1);
		
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
		format3.setBackground( Colour.LIGHT_ORANGE );
		format3.setBorder(Border.ALL,BorderLineStyle.MEDIUM);
		
		WritableCellFormat format4 = new WritableCellFormat();
		format4.setBorder(Border.TOP,BorderLineStyle.MEDIUM);
		
		WritableSheet sheet = workbook.getSheet(0);
		
		// 컬럼 폭 지정
		sheet.setColumnView( 0, 50 );
		sheet.setColumnView( 1, 30 );
		sheet.setColumnView( 2, 30 );
		
		// 헤더 컬럼 지정
		sheet.addCell( new Label( 0, 0, survey.getSurvey_title() +"(총 응답자 수 : " + survey.getAnswer_count() +"명)", format3 ) );
		
		sheet.mergeCells(0, 0, 3, 0);
		
		
		sheet.addCell( new Label( 0, 1, "문항", format ) );
		sheet.addCell( new Label( 1, 1, "보기", format ) );
		sheet.addCell( new Label( 2, 1, "응답자 수(명)", format ) );
		sheet.addCell( new Label( 3, 1, "백분율", format ) );
		
		int row = 2;
//		for ( Quest org : statisticsList ) {
//			
//			sheet.addCell( new Label( 0, row, String.valueOf(row)));
//			sheet.addCell( new Label( 1, row, org.getAdd_user_name(),format1 ) );
//			row++;
//		}
		
		for(int i=0; i < statisticsList.size(); i++) {
			
			Quest quest = statisticsList.get(i);
			
			if(quest.getQuest_type().equals("ONE")) {
				int oneCount = 0;
				double oneRatio = 0.0;
				for(int j=0; j<quest.getQuest_detail_list().size(); j++) {
					if(j == 0) {
						sheet.addCell( new Label( 0, row, quest.getQuest_content()));
					}
					
					sheet.addCell( new Label( 1, row, quest.getQuest_detail_list().get(j).getQuest_detail_title()));
					sheet.addCell( new Label( 2, row, quest.getQuest_detail_list().get(j).getCnt()+"",format1 ) );
					sheet.addCell( new Label( 3, row, quest.getQuest_detail_list().get(j).getRatio()+"%",format1 ) );
					oneCount += quest.getQuest_detail_list().get(j).getCnt();
					oneRatio += quest.getQuest_detail_list().get(j).getRatio();
					row++;
				}
				if (quest.getQuest_detail_free_yn().equals("Y")) {
					sheet.addCell( new Label( 1, row, "기타"));
					sheet.addCell( new Label( 2, row, (survey.getAnswer_count()-oneCount)+"",format1 ) );
					sheet.addCell( new Label( 3, row, String.format("%.2f", (100.00 - oneRatio))+"%",format1 ) );
					row++;
					for ( Answer a : quest.getAnswer_list() ) {
						sheet.addCell( new Label( 2, row, a.getShort_answer()));	
						row++;
					}
				}
				
			}
			
			if(quest.getQuest_type().equals("MULTI")) {
				int multiCount = 0;
				double multiRatio = 0.0;
				for(int j=0; j<quest.getQuest_detail_list().size(); j++) {
					
					if(j == 0) {
						sheet.addCell( new Label( 0, row, quest.getQuest_content()));
					}
					
					sheet.addCell( new Label( 1, row, quest.getQuest_detail_list().get(j).getQuest_detail_title()));					
					sheet.addCell( new Label( 2, row, quest.getQuest_detail_list().get(j).getCnt()+"",format1 ) );
					sheet.addCell( new Label( 3, row, quest.getQuest_detail_list().get(j).getRatio()+"%",format1 ) );
					multiCount += quest.getQuest_detail_list().get(j).getCnt();
					multiRatio += quest.getQuest_detail_list().get(j).getRatio();
					row++;
				}
				if (quest.getQuest_detail_free_yn().equals("Y")) {
					sheet.addCell( new Label( 1, row, "기타"));
					sheet.addCell( new Label( 2, row, (quest.getQuest_detail_list().get(0).getTotal_cnt()-multiCount)+"",format1 ) );
					sheet.addCell( new Label( 3, row, String.format("%.2f", (100.00 - multiRatio))+"%",format1 ) );
					row++;
					for ( Answer a : quest.getAnswer_list() ) {
						sheet.addCell( new Label( 2, row, a.getShort_answer()));	
						row++;
					}
				}
			}
			
			if(quest.getQuest_type().equals("MATRIX")) {
				sheet.addCell( new Label( 0, row, quest.getQuest_content()));
				row++;
				for(int j=0; j<quest.getQuest_matrix_list().size(); j++) {
					List<Statistics> matrixStatisticsList = quest.getQuest_matrix_list().get(j).getStatisticsList();
					for(int k=0; k<matrixStatisticsList.size(); k++) {
						Statistics matrixStatisticsOne = matrixStatisticsList.get(k);
						if (k==0) {
							sheet.addCell( new Label( 0, row, quest.getQuest_matrix_list().get(j).getMatrix_title()));
						}

						sheet.addCell( new Label( 1, row, quest.getQuest_detail_list().get(k).getQuest_detail_title()));
						sheet.addCell( new Label( 2, row, matrixStatisticsOne.getCnt()+"",format1 ) );
						sheet.addCell( new Label( 3, row, matrixStatisticsOne.getRatio()+"%",format1 ) );
						
						row++;
					}
				}
			}
			
			if(quest.getQuest_type().equals("DESCRIPTION")) {
				
				for(int j=0; j<quest.getDesc_list().size(); j++) {
					
					if(j == 0) {
						sheet.addCell( new Label( 0, row, quest.getQuest_content()));
					}
					sheet.addCell( new Label( 2, row, quest.getDesc_list().get(j).getShort_answer()));
					
					row++;
				}
			}
			
			row++;
		}
		
		sheet = workbook.getSheet(1); 
		
		//헤더
		sheet.addCell( new Label( 0, 0, "아이디", format ) );
		sheet.addCell( new Label( 1, 0, "일시", format ) );
		sheet.addCell( new Label( 2, 0, "당첨자 여부", format ) );
		sheet.setColumnView( 0, 30 );
		sheet.setColumnView( 1, 30 );
		sheet.setColumnView( 2, 10 );

		// 컬럼 폭 지정
		for(int i=0; i < statisticsList.size(); i++) {
			Quest quest = statisticsList.get(i);
			int columnSize = quest.getQuest_type().equals("DESCRIPTION") ? 100 : 30;
			sheet.setColumnView( (i+3), columnSize );
			sheet.addCell( new Label( i+3, 0, (i+1)+"번 문항", format ) );
		}
		
		row = 1;

		for (Answer answer : answerList) {
			List<Statistics> statisticsPerUser = answer.getStatisticsList();
			sheet.addCell( new Label( 0, row, answer.getAdd_id(), format1 ) );
			sheet.addCell( new Label( 1, row, answer.getAdd_date_str(), format1 ) );
			sheet.addCell( new Label( 2, row, answer.getChosen_yn(), format1 ) );
			
			for (int j = 0; j < statisticsPerUser.size(); j++) {
				Statistics statistics = statisticsPerUser.get(j);

				String choiceAnswers = statistics.getChoice_answer();
				String shortAnswer = statistics.getShort_answer();

				choiceAnswers = choiceAnswers.replaceAll("99", "기타("+shortAnswer+")");

				String answerStr = choiceAnswers.equals("0") ? shortAnswer : choiceAnswers;
				
				sheet.addCell( new Label( j+3, row, answerStr, format1 ) );
			}
			row++;
		}
		
		return workbook;
	}

}

