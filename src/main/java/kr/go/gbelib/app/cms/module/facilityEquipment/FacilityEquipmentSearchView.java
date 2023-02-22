package kr.go.gbelib.app.cms.module.facilityEquipment;

import jxl.write.WritableWorkbook;
import org.springframework.web.servlet.view.document.AbstractJExcelView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class FacilityEquipmentSearchView extends AbstractJExcelView {
	
	@Override
	protected void buildExcelDocument(Map<String, Object> model, WritableWorkbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception {
		/*@SuppressWarnings("unchecked")
		List<FacilityReq> facilityReqList = (List<FacilityReq>) model.get("facilityReqResult");
		String sheetName = "시설물이용 신청자 리스트";	//시트이름
		workbook.createSheet(sheetName, 0);	//시트설정
		
		String fileName = facilityReqList.get(0).getHomepage_name() + "시설물이용 신청자 리스트.xls";
		
		String header = request.getHeader("user-agent");
		if (header.contains("MSIE") || header.contains("Trident")) {
			fileName = java.net.URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "%20");
			response.setHeader("Content-Disposition", "attachment;fileName=" + fileName + ";");
		} else {
			response.setHeader("Content-Disposition", "attachment;fileName=\"" + fileName + "\";");
		}
//		response.setHeader("Content-Disposition", "attachment; filename=\"" + new String(fileName.getBytes("euc-kr"), "8859_1") + "\";charset=\"UTF-8\"");
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
		workbook.getSheet(0).setColumnView( 2, 30 );
		workbook.getSheet(0).setColumnView( 3, 30 );
		workbook.getSheet(0).setColumnView( 4, 40 );
		workbook.getSheet(0).setColumnView( 5, 40 );
		workbook.getSheet(0).setColumnView( 6, 40 );
		workbook.getSheet(0).setColumnView( 7, 20 );
		
		// 헤더 컬럼 지정
		workbook.getSheet(0).addCell( new Label( 0, 0, "번호", format ) );
		workbook.getSheet(0).addCell( new Label( 1, 0, "신청자", format ) );
		workbook.getSheet(0).addCell( new Label( 2, 0, "시설물명", format ) );
		workbook.getSheet(0).addCell( new Label( 3, 0, "전화번호", format ) );
		workbook.getSheet(0).addCell( new Label( 4, 0, "폰번호", format ) );
		workbook.getSheet(0).addCell( new Label( 5, 0, "신청이용일", format ) );
		workbook.getSheet(0).addCell( new Label( 6, 0, "신청이용시간", format ) );
		workbook.getSheet(0).addCell( new Label( 7, 0, "승인여부", format ) );
		
		int row = 1;
		for ( FacilityReq org : facilityReqList ) {
			
			String apply_state = "";
			if(org.getApply_state().equals("Y")) {
				apply_state = "승인";
			} else {
				apply_state = "미승인";
			}
			
			workbook.getSheet(0).addCell( new Label( 0, row, String.valueOf(row)));
			workbook.getSheet(0).addCell( new Label( 1, row, org.getReq_name(),format1 ) );
			workbook.getSheet(0).addCell( new Label( 2, row, org.getFacility_name(),format1 ) );
			workbook.getSheet(0).addCell( new Label( 3, row, org.getPhone(),format1 ) );
			workbook.getSheet(0).addCell( new Label( 4, row, org.getCell_phone(),format1 ) );
			workbook.getSheet(0).addCell( new Label( 5, row, org.getStart_date() + "~" + org.getEnd_date(), format1) );
			workbook.getSheet(0).addCell( new Label( 6, row, org.getStart_time() + "~" + org.getEnd_time(),format1 ) );
			workbook.getSheet(0).addCell( new Label( 7, row, apply_state,format1 ) );
			row++;
		}*/
	}

}
