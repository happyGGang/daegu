package kr.go.gbelib.app.cms.module.lecture.lectureInfo;

import jxl.format.Alignment;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.format.Colour;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableWorkbook;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.framework.utils.AttachmentUtils;
import org.apache.commons.lang.StringUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

public class LectureInfoWorkbook {
	
	protected WritableWorkbook workbookForm(WritableWorkbook workbook, List<LectureInfo> lectureInfoList, Homepage homepage, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String sheetName = "강의 리스트";	//시트이름
		workbook.createSheet(sheetName, 0);	//시트설정
		
		String fileName = "LectureInfo.xls";
		
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
		workbook.getSheet(0).setColumnView( 0,  30 );	// 과정고유번호
		workbook.getSheet(0).setColumnView( 1,  30 );	// 강좌고유번호
		workbook.getSheet(0).setColumnView( 2,  50 );	// 강좌명
		workbook.getSheet(0).setColumnView( 3,  10);	// 접수시작일
		workbook.getSheet(0).setColumnView( 4,  10);	// 접수종료일
		workbook.getSheet(0).setColumnView( 5,  10 );	// 교육시작일
		workbook.getSheet(0).setColumnView( 6,  10 );	// 교육종료일
		workbook.getSheet(0).setColumnView( 7,  20 );	// 교육요일
		workbook.getSheet(0).setColumnView( 8,  20 );	// 교육시작시간
		workbook.getSheet(0).setColumnView( 9,  20 );	// 교육종료시간
		workbook.getSheet(0).setColumnView( 10,  20 );	// 온라인 모집인원 현원
		workbook.getSheet(0).setColumnView( 11,  20 );	// 온라인 모집인원 정원
		workbook.getSheet(0).setColumnView( 12,  20 );	// 대기 모집인원 현원
		workbook.getSheet(0).setColumnView( 13,  20 );	// 대기 모집인원 정원
		workbook.getSheet(0).setColumnView( 14,  20 );	// 오프라인 모집인원 현원
		workbook.getSheet(0).setColumnView( 15,  20 );	// 오프라인 모집인원 정원
		workbook.getSheet(0).setColumnView( 16, 10 );	// 접수방법
		workbook.getSheet(0).setColumnView( 17, 10 );	// 담당자명
		workbook.getSheet(0).setColumnView( 18, 20 );	// 담당자 연락처
		workbook.getSheet(0).setColumnView( 19, 10 );	// 강사명
		workbook.getSheet(0).setColumnView( 20, 20 );	// 강사 연락처
		workbook.getSheet(0).setColumnView( 21, 20 );	// 교육장
		workbook.getSheet(0).setColumnView( 22, 30 );	// 교육장 주소
		workbook.getSheet(0).setColumnView( 23, 20 );	// 교육장 상세주소
		workbook.getSheet(0).setColumnView( 24, 30 );	// 교육장 지도링크
		workbook.getSheet(0).setColumnView( 25, 20 );	// 교육소개
		workbook.getSheet(0).setColumnView( 26, 30 );	// 등록일
		workbook.getSheet(0).setColumnView( 27, 20 );	// 등록ID
		workbook.getSheet(0).setColumnView( 28, 20 );	// 등록IP
		workbook.getSheet(0).setColumnView( 29, 20 );	// 강사ID
		workbook.getSheet(0).setColumnView( 30, 20 );	// 교육장 부속

		// 헤더 컬럼 지정
		workbook.getSheet(0).addCell( new Label( 0, 0, "과정고유번호", format ) );
		workbook.getSheet(0).addCell( new Label( 1, 0, "강좌고유번호", format ) );
		workbook.getSheet(0).addCell( new Label( 2, 0, "강좌명", format ) );
		workbook.getSheet(0).addCell( new Label( 3, 0, "접수시작일", format ) );
		workbook.getSheet(0).addCell( new Label( 4, 0, "접수종료일", format ) );
		workbook.getSheet(0).addCell( new Label( 5, 0, "교육시작일", format ) );
		workbook.getSheet(0).addCell( new Label( 6, 0, "교육종료일", format ) );
		workbook.getSheet(0).addCell( new Label( 7, 0, "교육요일", format ) );
		workbook.getSheet(0).addCell( new Label( 8, 0, "교육시작시간", format ) );
		workbook.getSheet(0).addCell( new Label( 9, 0, "교육종료시간", format ) );
		workbook.getSheet(0).addCell( new Label( 10, 0, "온라인모집인원(현원)", format ) );
		workbook.getSheet(0).addCell( new Label( 11, 0, "온라인모집인원(정원)", format ) );
		workbook.getSheet(0).addCell( new Label( 12, 0, "대기모집인원(현원)", format ) );
		workbook.getSheet(0).addCell( new Label( 13, 0, "대기모집인원(정원)", format ) );
		workbook.getSheet(0).addCell( new Label( 14,  0, "오프라인모집인원(현원)", format ) );
		workbook.getSheet(0).addCell( new Label( 15,  0, "오프라인모집인원(정원)", format ) );
		workbook.getSheet(0).addCell( new Label( 16, 0, "접수방법", format ) );
		workbook.getSheet(0).addCell( new Label( 17, 0, "담당자명", format ) );
		workbook.getSheet(0).addCell( new Label( 18, 0, "담당자 연락처", format ) );
		workbook.getSheet(0).addCell( new Label( 19, 0, "강사명", format ) );
		workbook.getSheet(0).addCell( new Label( 20, 0, "강사 연락처", format ) );
		workbook.getSheet(0).addCell( new Label( 21, 0, "교육장", format ) );
		workbook.getSheet(0).addCell( new Label( 22, 0, "교육장 주소", format ) );
		workbook.getSheet(0).addCell( new Label( 23, 0, "교육장 상세주소", format ) );
		workbook.getSheet(0).addCell( new Label( 24, 0, "교육장 지도링크", format ) );
		workbook.getSheet(0).addCell( new Label( 25, 0, "교육소개", format ) );
		workbook.getSheet(0).addCell( new Label( 26, 0, "등록일", format ) );
		workbook.getSheet(0).addCell( new Label( 27, 0, "등록ID", format ) );
		workbook.getSheet(0).addCell( new Label( 28, 0, "등록IP", format ) );
		workbook.getSheet(0).addCell( new Label( 29, 0, "강사ID", format ) );
		workbook.getSheet(0).addCell( new Label( 30, 0, "교육장 부속", format ) );

		
		int row = 1;
		for ( LectureInfo one : lectureInfoList ) {
			workbook.getSheet(0).addCell( new Label( 0,  row, one.getCourse_id(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 1,  row, one.getLecture_id(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 2,  row, one.getLecture_title(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 3,  row, one.getRequest_start_date(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 4,  row, one.getRequest_end_date(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 5,  row, one.getEdu_start_date(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 6,  row, one.getEdu_end_date(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 7,  row, getDayToString(one.getDay_week()), format1 ) );
			workbook.getSheet(0).addCell( new Label( 8,  row, one.getEdu_start_time(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 9,  row, one.getEdu_end_time(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 10, row, Integer.toString(one.getOnline_request_count()), format1 ) );
			workbook.getSheet(0).addCell( new Label( 11, row, Integer.toString(one.getOnline_person_count()), format1 ) );
			workbook.getSheet(0).addCell( new Label( 12, row, Integer.toString(one.getWait_request_count()), format1 ) );
			workbook.getSheet(0).addCell( new Label( 13, row, Integer.toString(one.getWait_person_count()), format1 ) );
			workbook.getSheet(0).addCell( new Label( 14, row, Integer.toString(one.getOffline_request_count()), format1 ) );
			workbook.getSheet(0).addCell( new Label( 15, row, Integer.toString(one.getOffline_person_count()), format1 ) );
			workbook.getSheet(0).addCell( new Label( 16, row, one.getRequest_type(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 17, row, one.getSupporter_name(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 18, row, one.getSupporter_tel(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 19, row, one.getTeacher_name(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 20, row, one.getTeacher_tel(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 21, row, one.getEdu_school(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 22, row, one.getEdu_address_1(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 23, row, one.getEdu_address_2(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 24, row, one.getEdu_school_map(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 25, row, one.getLecture_content(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 26, row, one.getAdd_date().toString(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 27, row, one.getAdd_id(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 28, row, one.getAdd_ip(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 29, row, one.getTeacher_id() == null ? "" : one.getTeacher_id(), format1 ) );
			workbook.getSheet(0).addCell( new Label( 30, row, one.getEdu_second_school() == null ? "" : one.getEdu_second_school(), format1 ) );

			row++;
		}

		return workbook;
	}

	private String getDayToString(String days) {
		List<String> result	= new ArrayList<String>();
		String[] arr = days.split(",");

		for ( String one : arr ) {
			if ( "1".equals(one) ) {
				result.add("월");
			}
			else if ( "2".equals(one) ) {
				result.add("화");
			}
			else if ( "3".equals(one) ) {
				result.add("수");
			}
			else if ( "4".equals(one) ) {
				result.add("목");
			}
			else if ( "5".equals(one) ) {
				result.add("금");
			}
			else if ( "6".equals(one) ) {
				result.add("토");
			}
			else if ( "7".equals(one) ) {
				result.add("일");
			}
		}

		return StringUtils.join(result, ",");
	}
}
