package kr.co.whalesoft.app.cms.module.survey.answer;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.view.document.AbstractJExcelView;

import jxl.format.Alignment;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.format.Colour;
import jxl.format.UnderlineStyle;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableWorkbook;
import kr.co.whalesoft.app.cms.module.survey.quest.Quest;
import kr.co.whalesoft.framework.utils.AttachmentUtils;

public class SampleSearchView extends AbstractJExcelView {

	@SuppressWarnings("unchecked")
	@Override
	protected void buildExcelDocument(Map<String, Object> model, WritableWorkbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception {
		int questSize = (Integer)model.get("questCnt");
		List<Quest> questForm = (List<Quest>)model.get("questForm");

		String fileName = "설문조사 결과 양식.xls";

		response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(fileName, request.getHeader("user-agent")));
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Pragma", "no-cache");
		response.setContentType("Application/Msexcel");

		String sheetName = "설문조사현황 리스트"; //시트이름
		workbook.createSheet(sheetName, 0); //시트설정

		// 헤더 스타일
		WritableCellFormat format = new WritableCellFormat();
		format.setAlignment(Alignment.CENTRE);
		format.setBackground(Colour.LIGHT_GREEN);

		//중앙정렬
		WritableCellFormat format1 = new WritableCellFormat();
		format1.setAlignment(Alignment.CENTRE);

		//테두리선,중앙정렬
		WritableCellFormat format2 = new WritableCellFormat();
		format2.setBorder(Border.ALL, BorderLineStyle.MEDIUM);

		//중앙정렬,배경색,테두리 색
		WritableCellFormat format3 = new WritableCellFormat();
		format3.setAlignment(Alignment.CENTRE);
		format3.setBackground(Colour.LIGHT_ORANGE);
		format3.setBorder(Border.ALL, BorderLineStyle.MEDIUM);

		WritableCellFormat format4 = new WritableCellFormat();
		format4.setBorder(Border.TOP, BorderLineStyle.MEDIUM);
		
		WritableFont font = new WritableFont(WritableFont.ARIAL, 10, WritableFont.NO_BOLD, false, UnderlineStyle.NO_UNDERLINE, Colour.RED);
		WritableCellFormat format5 = new WritableCellFormat();
		format5.setFont(font);

		// 컬럼 폭 지정
		workbook.getSheet(0).setColumnView(0, 10);
		workbook.getSheet(0).setColumnView(1, 20);
		for(int i = 0; i < questSize; i++) {
			workbook.getSheet(0).setColumnView(i + 2, 15);
		}

		// 헤더 컬럼 지정
		workbook.getSheet(0).addCell(new Label(0, 0, "번호", format));
		workbook.getSheet(0).addCell(new Label(1, 0, "이름", format));
		for(int i = 0; i < questForm.size(); i++) {
			String colType = "";
			if(questForm.get(i).getQuest_type().equals("ONE")) {
				colType = "(단일)";
			} else if(questForm.get(i).getQuest_type().equals("MULTI")) {
				colType = "(복수)";
			} else if(questForm.get(i).getQuest_type().equals("MATRIX")) {
				colType = "(매트릭스)";
			} else if(questForm.get(i).getQuest_type().equals("DESCRIPTION") && questForm.get(i).getRequired_yn().equals("Y")) {
				colType = "(서술-필수)";
			} else if(questForm.get(i).getQuest_type().equals("DESCRIPTION") && questForm.get(i).getRequired_yn().equals("N")) {
				colType = "(서술-선택)";
			}
			workbook.getSheet(0).addCell(new Label(i + 2, 0, "Q" + (i + 1) + colType, format));
		}
		
		workbook.getSheet(0).addCell(new Label(0, 1, "* 아래는 예시입니다. 반드시 삭제 후 입력하세요", format5));

		workbook.getSheet(0).addCell(new Label(0, 2, "1"));
		workbook.getSheet(0).addCell(new Label(1, 2, "홍길동", format1));
		workbook.getSheet(0).addCell(new Label(0, 3, "2"));
		workbook.getSheet(0).addCell(new Label(1, 3, "이순신", format1));
		for(int i = 0; i < questForm.size(); i++) {
			String valueStr = "";
			String valueStr2 = "";
			Quest quest = questForm.get(i);
			if(quest.getQuest_type().equals("ONE")) {
				valueStr = "2";
				valueStr2 = "단일형 자유응답 입니다.";
			} else if(quest.getQuest_type().equals("MULTI")) {
				valueStr = "1,3,복수형 자유응답 입니다.";
				valueStr2 = "2, 3, 4";
			} else if(quest.getQuest_type().equals("MATRIX")) {
				valueStr = "3, 1, 4";
				valueStr2 = "2,2, 3";
			} else if(quest.getQuest_type().equals("DESCRIPTION") && quest.getRequired_yn().equals("Y")) {
				valueStr = "서술형 필수 입력입니다.";
				valueStr2 = "서술형 필수 입력입니다.";
			} else if(quest.getQuest_type().equals("DESCRIPTION") && quest.getRequired_yn().equals("N")) {
				valueStr = "서술형 선택 입력입니다.";
				valueStr2 = "";
			}
			
			workbook.getSheet(0).addCell(new Label(i + 2, 2, valueStr));
			workbook.getSheet(0).addCell(new Label(i + 2, 3, valueStr2));
		}
	}

}
