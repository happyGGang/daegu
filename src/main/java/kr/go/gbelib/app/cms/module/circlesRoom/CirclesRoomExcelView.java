package kr.go.gbelib.app.cms.module.circlesRoom;

import jxl.format.Alignment;
import jxl.format.Colour;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import kr.co.whalesoft.app.cms.code.Code;
import org.apache.commons.lang.StringUtils;
import org.apache.http.client.utils.DateUtils;
import org.springframework.web.servlet.view.document.AbstractJExcelView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

public class CirclesRoomExcelView extends AbstractJExcelView {
	
	@Override
	@SuppressWarnings("unchecked")
	protected void buildExcelDocument(Map<String, Object> model, WritableWorkbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception {
		CirclesRoom circlesRoom = (CirclesRoom) model.get("circlesRoom");
		List<CirclesRoom> circlesRoomList = (List<CirclesRoom>) model.get("circlesRoomList");
		List<Code> reqTimeCode = (List<Code>) model.get("reqTimeCode");
		List<Code> circlesDivCode = (List<Code>) model.get("circlesDivCode");
		
		String orderText = "";
		if("visit_date".equals(circlesRoom.getOrderText())) {
			orderText = "사용희망일";
		} else if("add_date".equals(circlesRoom.getOrderText())) {
			orderText = "신청일자";
		}
		
		workbook.createSheet("동아리방신청관리", 0);	//시트설정
		
		String fileName = "동아리방신청관리" + "_" + new SimpleDateFormat("yyyyMMdd").format(new Date()) + ".xls";
		
		String header = request.getHeader("user-agent");
		fileName = java.net.URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "%20");
		if (header.contains("MSIE") || header.contains("Trident")) {
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
		format1.setWrap(true);

		WritableSheet sheet = workbook.getSheet(0);
		
		sheet.addCell(new Label( 0, 0,
				String.format("동아리방신청관리 [ 정렬: %s, 조회기간: %s ~ %s ]", orderText, StringUtils.defaultString(circlesRoom.getSearch_sdt()), StringUtils.defaultString(circlesRoom.getSearch_edt()))));
		sheet.mergeCells(0, 0, 4, 0);
		
		// 컬럼 폭 지정
		int i=0;
		sheet.setColumnView( i++, 10 );
		sheet.setColumnView( i++, 20 );
		sheet.setColumnView( i++, 15 );
		sheet.setColumnView( i++, 15 );
		sheet.setColumnView( i++, 20 );
		sheet.setColumnView( i++, 15 );
		sheet.setColumnView( i++, 10 );
		sheet.setColumnView( i++, 25 );
		sheet.setColumnView( i++, 50 );
		sheet.setColumnView( i++, 20 );
		sheet.setColumnView( i++, 10 );
		
		// 헤더 컬럼 지정
		i=0;
		sheet.addCell( new Label( i++, 1, "번호", format ) );
		sheet.addCell( new Label( i++, 1, "제목", format ) );
		sheet.addCell( new Label( i++, 1, "동아리방", format ) );
		sheet.addCell( new Label( i++, 1, "이름", format ) );
		sheet.addCell( new Label( i++, 1, "휴대폰", format ) );
		sheet.addCell( new Label( i++, 1, "사용희망일", format ) );
		sheet.addCell( new Label( i++, 1, "방문인원", format ) );
		sheet.addCell( new Label( i++, 1, "신청일자", format ) );
		sheet.addCell( new Label( i++, 1, "사용목적", format ) );
		sheet.addCell( new Label( i++, 1, "사용시간", format ) );
		sheet.addCell( new Label( i++, 1, "상태", format ) );
		
		int row = 2;
		for(CirclesRoom org : circlesRoomList) {
			String status = "";
			if(org.getStatus() == 0) {
				status = "신청";
			} else if(org.getStatus() == 1) {
				status = "승인";
			} else if(org.getStatus() == 2) {
				status = "미승인";
			}
			
			String[] visit_time = StringUtils.defaultString(org.getVisit_time()).split(",");
			StringBuilder sb = new StringBuilder();
			int size = visit_time.length;
			for(int j=0; j < size; j++) {
				String time = visit_time[j];
				for(Code code: reqTimeCode) {
					if(code.getCode_id().equals(time)) {
						sb.append(code.getCode_name());
						if(j < size - 1) {
							sb.append("\n");
						}
					}
				}
			}
			
			i=0;
			sheet.addCell( new Label( i++, row, String.valueOf(circlesRoom.getTotalDataCount() - row + 2), format1 ) );
			sheet.addCell( new Label( i++, row, org.getCircles_title(), format1) );
			for (Code code_div : circlesDivCode) {
				if (org.getCircles_div().equals(code_div.getCode_id())) {
					sheet.addCell( new Label( i++, row, code_div.getCode_name(), format1 ) );
				}
			}
			sheet.addCell( new Label( i++, row, org.getUser_name(), format1 ) );
			sheet.addCell( new Label( i++, row, org.getUser_phone(), format1 ) );
			sheet.addCell( new Label( i++, row, org.getVisit_date(), format1) );
			sheet.addCell( new Label( i++, row, org.getVisit_num(), format1) );
			sheet.addCell( new Label( i++, row, DateUtils.formatDate(org.getAdd_date(), "yyyy-MM-dd HH:mm:ss"), format1) );
			sheet.addCell( new Label( i++, row, org.getEtc(), format1) );
			sheet.addCell( new Label( i++, row, sb.toString(), format1) );
			sheet.addCell( new Label( i++, row, status, format1) );
			
			row++;
		}
	}

}
