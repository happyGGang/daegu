package kr.go.gbelib.app.cms.module.facilityBook;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.view.document.AbstractJExcelView;

import jxl.format.Alignment;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.format.Colour;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableWorkbook;
import kr.co.whalesoft.framework.utils.AttachmentUtils;
import kr.go.gbelib.app.cms.module.bookPackage.BookPackage;

public class FacilityBookView extends AbstractJExcelView {
	
	@Override
	protected void buildExcelDocument(Map<String, Object> model, WritableWorkbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception {
		@SuppressWarnings ("unchecked")
		List<FacilityBook> facilityBookList = (List<FacilityBook>) model.get("facilityBookList");
		FacilityBook facilityBook = (FacilityBook)model.get("facilityBook");
		
		String name = "책 꾸러미 대출신청";
		
		response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(name + ".xls", request.getHeader("user-agent")));
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Pragma", "no-cache");
		response.setContentType("Application/Msexcel");
		
		workbook.createSheet(name, 0);	//시트설정

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
		workbook.getSheet(0).setColumnView(0,  15);
		workbook.getSheet(0).setColumnView(1,  20);
		workbook.getSheet(0).setColumnView(2,  20);
		workbook.getSheet(0).setColumnView(3,  20);
		workbook.getSheet(0).setColumnView(4,  30);
		workbook.getSheet(0).setColumnView(5,  20);
		workbook.getSheet(0).setColumnView(6,  20);
		workbook.getSheet(0).setColumnView(7,  10);
		
		// 헤더 컬럼 지정
		workbook.getSheet(0).addCell(new Label(0, 0, "신청인", format));
		workbook.getSheet(0).addCell(new Label(1, 0, "신청인 연락처", format));
		workbook.getSheet(0).addCell(new Label(2, 0, "참여인원 연락처", format));
		workbook.getSheet(0).addCell(new Label(3, 0, "사용시설", format));
		workbook.getSheet(0).addCell(new Label(4, 0, "이용시간", format));
		workbook.getSheet(0).addCell(new Label(5, 0, "모임명", format));
		workbook.getSheet(0).addCell(new Label(6, 0, "참여인원", format));
		workbook.getSheet(0).addCell(new Label(7, 0, "신청상태", format));
			
			
		int row = 1;
		for(FacilityBook one : facilityBookList) {
			
			workbook.getSheet(0).addCell(new Label(0, row, one.getApply_name()));
			workbook.getSheet(0).addCell(new Label(1, row, one.getPhone()));
			workbook.getSheet(0).addCell(new Label(2, row, one.getSub_phone()));
			
			String facility_name = "";
			if(one.getFacility_book_name().equals("1")) {
				facility_name = "4층 토론실(16석)";
			}
			workbook.getSheet(0).addCell(new Label(3, row, facility_name));
			
			String apply_date = one.getApply_date();
			if(one.getApply_time_code().equals("0")) {
				apply_date += " 09:30~13:30";
			} else if(one.getApply_time_code().equals("1")) {
				apply_date += " 13:30~17:30";
			}
			workbook.getSheet(0).addCell(new Label(4, row, apply_date));
			workbook.getSheet(0).addCell(new Label(5, row, one.getCurcles_name()));
			
			int man_count = one.getMan_count();
			int woman_count = one.getWoman_count();
			workbook.getSheet(0).addCell(new Label(6, row, "남 :"+man_count + " / 여:"+woman_count));
			
			String apply_status = "";
			if(one.getApply_status().equals("0")) {
				apply_status = "대기";
			} else if(one.getApply_status().equals("1")) {
				apply_status = "승인";
			}
			workbook.getSheet(0).addCell(new Label(7, row, apply_status));
			
			row++;
		}
	}
}
