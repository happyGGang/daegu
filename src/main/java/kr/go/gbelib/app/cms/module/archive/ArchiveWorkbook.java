package kr.go.gbelib.app.cms.module.archive;

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
import kr.co.whalesoft.framework.utils.AttachmentUtils;

public class ArchiveWorkbook {
	
	protected WritableWorkbook workbookForm(WritableWorkbook workbook, List<Archive> archiveList, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String sheetName = "아카이브 리스트";	//시트이름
		workbook.createSheet(sheetName, 0);	//시트설정
		
		String fileName = "Archive.xls";
		
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
		workbook.getSheet(0).setColumnView( 0,  20 ); //관리번호
		workbook.getSheet(0).setColumnView( 1,  30 ); //제목
		workbook.getSheet(0).setColumnView( 2,  10 ); //생산연도
		workbook.getSheet(0).setColumnView( 3,  20 ); //생산일자
		workbook.getSheet(0).setColumnView( 4,  25 ); //생산자명
		workbook.getSheet(0).setColumnView( 5,  25 ); //원본소장처
		workbook.getSheet(0).setColumnView( 6,  25 ); //지역
		workbook.getSheet(0).setColumnView( 7,  25 ); //인물
		workbook.getSheet(0).setColumnView( 8,  50 ); //설명
		workbook.getSheet(0).setColumnView( 9,  10 ); //유형
		workbook.getSheet(0).setColumnView( 10, 10 ); //형태
		workbook.getSheet(0).setColumnView( 11, 25 ); //제공방법
		workbook.getSheet(0).setColumnView( 12, 10 ); //공개여부
		workbook.getSheet(0).setColumnView( 13, 30 ); //조회수
		
		// 헤더 컬럼 지정
		workbook.getSheet(0).addCell( new Label( 0, 0, "관리번호", format ) );
		workbook.getSheet(0).addCell( new Label( 1, 0, "제목", format ) );
		workbook.getSheet(0).addCell( new Label( 2, 0, "생산연도", format ) );
		workbook.getSheet(0).addCell( new Label( 3, 0, "생산일자", format ) );
		workbook.getSheet(0).addCell( new Label( 4, 0, "생산자명", format ) );
		workbook.getSheet(0).addCell( new Label( 5, 0, "원본소장처", format ) );
		workbook.getSheet(0).addCell( new Label( 6, 0, "지역", format ) );
		workbook.getSheet(0).addCell( new Label( 7, 0, "인물", format ) );
		workbook.getSheet(0).addCell( new Label( 8, 0, "설명", format ) );
		workbook.getSheet(0).addCell( new Label( 9, 0, "유형", format ) );
		workbook.getSheet(0).addCell( new Label( 10, 0, "형태", format ) );
		workbook.getSheet(0).addCell( new Label( 11, 0, "제공방법", format ) );
		workbook.getSheet(0).addCell( new Label( 12, 0, "공개여부", format ) );
		workbook.getSheet(0).addCell( new Label( 13, 0, "조회수", format ) );
		
		int row = 1;
		for ( Archive one : archiveList ) {
			workbook.getSheet(0).addCell( new Label( 0,  row, one.getManage_num(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 1,  row, one.getTitle(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 2,  row, one.getProduct_year(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 3,  row, one.getProduct_date(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 4,  row, one.getProducer_name(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 5,  row, one.getOriginal_owner(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 6,  row, one.getRegion(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 7,  row, one.getPerson(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 8,  row, one.getDescription(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 9,  row, one.getType(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 10, row, one.getData_type(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 11, row, one.getProvide_method(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 12, row, (one.getPublic_yn().equals("Y")) ? "공개" : "비공개", format1 ) );
			workbook.getSheet(0).addCell( new Label( 13, row, String.valueOf(one.getView_count()), format1 ) );
			
			row++;
		}
		
		return workbook;
	}
}
