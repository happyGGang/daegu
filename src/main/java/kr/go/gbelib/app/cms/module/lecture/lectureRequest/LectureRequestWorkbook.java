package kr.go.gbelib.app.cms.module.lecture.lectureRequest;

import jxl.format.Alignment;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.format.Colour;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableWorkbook;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.framework.utils.AttachmentUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

public class LectureRequestWorkbook {
	
	protected WritableWorkbook workbookForm(WritableWorkbook workbook, List<LectureRequest> lectureRequestList, Homepage homepage, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String sheetName = "강의 리스트";	//시트이름
		workbook.createSheet(sheetName, 0);	//시트설정
		
		String fileName = "LectureRequest.xls";
		
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
		workbook.getSheet(0).setColumnView( 0,  30 );	// 강좌 고유번호
		workbook.getSheet(0).setColumnView( 1,  30 );	// 신청 고유번호
		workbook.getSheet(0).setColumnView( 2,  50 );	// 강좌 제목
		workbook.getSheet(0).setColumnView( 3,  10);	// 신청자명
		workbook.getSheet(0).setColumnView( 4,  10 );	// 생년월일
		workbook.getSheet(0).setColumnView( 5,  10 );	// 성별
		workbook.getSheet(0).setColumnView( 6,  20 );	// 휴대전화
		workbook.getSheet(0).setColumnView( 7,  20 );	// 이메일
		workbook.getSheet(0).setColumnView( 8,  10 );	// 우편번호
		workbook.getSheet(0).setColumnView( 9,  30 );	// 주소
		workbook.getSheet(0).setColumnView( 10, 20 );	// 상세주소
		workbook.getSheet(0).setColumnView( 11, 10 );	// 예약상태
		workbook.getSheet(0).setColumnView( 12, 10 );	// 접수방법
		workbook.getSheet(0).setColumnView( 13, 30 );	// 등록일
		workbook.getSheet(0).setColumnView( 14, 10 );	// 등록 아이디
		workbook.getSheet(0).setColumnView( 15, 20 );	// 등록 아이피
		workbook.getSheet(0).setColumnView( 16, 10 );	// 취소여부
		workbook.getSheet(0).setColumnView( 17, 30 );	// 취소일
		workbook.getSheet(0).setColumnView( 18, 10 );	// 취소아이디
		workbook.getSheet(0).setColumnView( 19, 20 );	// 취소아이피
		
		// 헤더 컬럼 지정
		workbook.getSheet(0).addCell( new Label( 0, 0, "강좌고유번호", format ) );
		workbook.getSheet(0).addCell( new Label( 1, 0, "신청고유번호", format ) );
		workbook.getSheet(0).addCell( new Label( 2, 0, "강좌제목", format ) );
		workbook.getSheet(0).addCell( new Label( 3, 0, "신청자명", format ) );
		workbook.getSheet(0).addCell( new Label( 4, 0, "생년월일", format ) );
		workbook.getSheet(0).addCell( new Label( 5, 0, "성별", format ) );
		workbook.getSheet(0).addCell( new Label( 6, 0, "휴대전화", format ) );
		workbook.getSheet(0).addCell( new Label( 7, 0, "이메일", format ) );
		workbook.getSheet(0).addCell( new Label( 8, 0, "우편번호", format ) );
		workbook.getSheet(0).addCell( new Label( 9,  0, "주소", format ) );
		workbook.getSheet(0).addCell( new Label( 10, 0, "상세주소", format ) );
		workbook.getSheet(0).addCell( new Label( 11, 0, "예약상태", format ) );
		workbook.getSheet(0).addCell( new Label( 12, 0, "접수방법", format ) );
		workbook.getSheet(0).addCell( new Label( 13, 0, "등록일", format ) );
		workbook.getSheet(0).addCell( new Label( 14, 0, "등록ID", format ) );
		workbook.getSheet(0).addCell( new Label( 15, 0, "등록IP", format ) );
		workbook.getSheet(0).addCell( new Label( 16, 0, "취소여부", format ) );
		workbook.getSheet(0).addCell( new Label( 17, 0, "취소일", format ) );
		workbook.getSheet(0).addCell( new Label( 18, 0, "취소ID", format ) );
		workbook.getSheet(0).addCell( new Label( 19, 0, "취소IP", format ) );

		
		int row = 1;
		for ( LectureRequest one : lectureRequestList ) {
			workbook.getSheet(0).addCell( new Label( 0,  row, one.getLecture_id(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 1,  row, one.getRequest_id(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 2,  row, one.getLecture_title(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 3,  row, one.getRequest_name(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 4,  row, one.getBirthday(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 5,  row, one.getGender() == '0' ? "남자" : "여자", format1 ) );
			workbook.getSheet(0).addCell( new Label( 6,  row, one.getPhone_number(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 7,  row, one.getEmail() == null ? "" : one.getEmail(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 8,  row, one.getZip_code() == null ? "" : one.getZip_code(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 9,  row, one.getAddress1() == null ? "" : one.getAddress1(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 10, row, one.getAddress2() == null ? "" : one.getAddress2(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 11, row, one.getRequest_status(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 12, row, one.getRequest_type(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 13, row, one.getAdd_date().toString(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 14, row, one.getAdd_id() == null ? "" : one.getAdd_id(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 15, row, one.getAdd_ip(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 16, row, one.getCancel_yn(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 17, row, one.getCancel_date() == null ? "" : one.getCancel_date().toString(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 18, row, one.getCancel_id() == null ? "" : one.getCancel_id(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 19, row, one.getCancel_ip() == null ? "" : one.getCancel_ip(), format1 ) );

			row++;
		}
		
		return workbook;
	}
}
