package kr.co.whalesoft.app.cms.module.survey;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.view.document.AbstractJExcelView;

import jxl.format.Alignment;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.format.Colour;
import jxl.write.WritableCellFormat;
import jxl.write.WritableWorkbook;
import kr.co.whalesoft.app.cms.module.survey.quest.Quest;
import kr.co.whalesoft.framework.utils.AttachmentUtils;

public class SurveyOfflineView extends AbstractJExcelView {

	@Override
	protected void buildExcelDocument(Map<String, Object> model, WritableWorkbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception {
		@SuppressWarnings("unchecked")
		List<Quest> questList = (List<Quest>) model.get("questList");
		Quest quest = (Quest) model.get("quest");
		Survey survey = (Survey) model.get("survey");
		
		String sheetName = survey.getSurvey_title();	//시트이름
		workbook.createSheet(sheetName, 0);	//시트설정
		
		String fileName = survey.getSurvey_title()+".xls";
//		String fileName = "survey.xls";
		
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
		format3.setBackground( Colour.LIGHT_ORANGE );
		format3.setBorder(Border.ALL,BorderLineStyle.MEDIUM);
		
		
		// 컬럼 폭 지정
		workbook.getSheet(0).setColumnView( 0, 50 );
		workbook.getSheet(0).setColumnView( 1, 30 );
		workbook.getSheet(0).setColumnView( 2, 30 );
		
		// 헤더 컬럼 지정
//		workbook.getSheet(0).addCell( new Label( 0, 0, survey.getSurvey_title() +"(총 응답자 수 : " + survey.getAnswer_count() +"명)", format3 ) );
//		
//		workbook.getSheet(0).mergeCells(0, 0, 2, 0);
//		
//		
//		workbook.getSheet(0).addCell( new Label( 0, 1, "문항", format ) );
//		workbook.getSheet(0).addCell( new Label( 1, 1, "보기", format ) );
//		workbook.getSheet(0).addCell( new Label( 2, 1, "응답자 수", format ) );
		
//		int row = 2;
//		for ( Quest org : statisticsList ) {
//			
//			workbook.getSheet(0).addCell( new Label( 0, row, String.valueOf(row)));
//			workbook.getSheet(0).addCell( new Label( 1, row, org.getAdd_user_name(),format1 ) );
//			row++;
//		}
		
		
	}

}

