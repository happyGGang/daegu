package kr.go.gbelib.app.cms.module.teach.student;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.web.servlet.view.document.AbstractJExcelView;

import jxl.format.Alignment;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.format.Colour;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableWorkbook;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.framework.utils.AttachmentUtils;
import kr.go.gbelib.app.cms.module.teach.Teach;
import kr.go.gbelib.app.cms.module.teacher.Teacher;

public class StudentWorkbook {
	
	protected WritableWorkbook workbookForm(WritableWorkbook workbook, List<Student> studentList, Teach teach, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		workbook.createSheet(teach.getTeach_name(), 0); // 시트설정

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
		workbook.getSheet(0).setColumnView(0,  20);
		workbook.getSheet(0).setColumnView(1,  20);
		workbook.getSheet(0).setColumnView(2,  20);
		/*workbook.getSheet(0).setColumnView(3,  20);
		workbook.getSheet(0).setColumnView(4,  20);
		workbook.getSheet(0).setColumnView(5,  20);
		workbook.getSheet(0).setColumnView(6,  20);*/
		workbook.getSheet(0).setColumnView(3,  20);
		workbook.getSheet(0).setColumnView(4,  20);
		workbook.getSheet(0).setColumnView(5,  20);
		workbook.getSheet(0).setColumnView(6, 20);
		workbook.getSheet(0).setColumnView(7, 20);
		workbook.getSheet(0).setColumnView(8, 20);
		workbook.getSheet(0).setColumnView(9, 20);
		workbook.getSheet(0).setColumnView(10, 20);
		workbook.getSheet(0).setColumnView(11, 20);
		/*workbook.getSheet(0).setColumnView(16, 20);*/
		workbook.getSheet(0).setColumnView(12, 20);
		workbook.getSheet(0).setColumnView(13, 20);
		workbook.getSheet(0).setColumnView(14, 20);
		workbook.getSheet(0).setColumnView(15, 20);

		workbook.getSheet(0).addCell(new Label(0, 0, String.format("강좌명 : %s", teach.getTeach_name()), format1));
		workbook.getSheet(0).mergeCells(0, 0, 5, 0);
		
		int column = 0;
		
		// 헤더 컬럼 지정
		workbook.getSheet(0).addCell(new Label(column++, 1, "번호", format));
		workbook.getSheet(0).addCell(new Label(column++, 1, "신청자-ID", format));
		workbook.getSheet(0).addCell(new Label(column++, 1, "신청자-명", format));
		/*workbook.getSheet(0).addCell(new Label(3, 0, "신청자-생년월일", format));
		workbook.getSheet(0).addCell(new Label(4, 0, "신청자-성별", format));
		workbook.getSheet(0).addCell(new Label(5, 0, "신청자-우편번호", format));
		workbook.getSheet(0).addCell(new Label(6, 0, "신청자-주소", format));*/
		workbook.getSheet(0).addCell(new Label(column++, 1, "신청자-휴대전화번호", format));
		workbook.getSheet(0).addCell(new Label(column++, 1, "수강생-동일여부", format));
		workbook.getSheet(0).addCell(new Label(column++, 1, "수강생-명", format));
		workbook.getSheet(0).addCell(new Label(column++, 1, "수강생-생년월일", format));
		workbook.getSheet(0).addCell(new Label(column++, 1, "수강생-성별", format));
		workbook.getSheet(0).addCell(new Label(column++, 1, "수강생-우편번호", format));
		workbook.getSheet(0).addCell(new Label(column++, 1, "수강생-주소", format));
		workbook.getSheet(0).addCell(new Label(column++, 1, "수강생-학교", format));
//		workbook.getSheet(0).addCell(new Label(column++, 1, "수강생-학년", format));
		/*workbook.getSheet(0).addCell(new Label(16, 0, "개인정보동의여부", format));*/
		workbook.getSheet(0).addCell(new Label(column++, 1, "상태", format));
		
		if ( "Y".equals(teach.getFamily_yn()) ) {
			workbook.getSheet(0).setColumnView(column, 20);
			workbook.getSheet(0).addCell(new Label(column++, 1, "보호자 관계", format));

			workbook.getSheet(0).setColumnView(column, 20);
			workbook.getSheet(0).addCell(new Label(column++, 1, "보호자 이름", format));

			workbook.getSheet(0).setColumnView(column, 20);
			workbook.getSheet(0).addCell(new Label(column++, 1, "보호자 연락처", format));
			
			workbook.getSheet(0).setColumnView(column, 20);
			workbook.getSheet(0).addCell(new Label(column++, 1, "보호자 승인 여부", format));

			workbook.getSheet(0).setColumnView(column, 20);
			workbook.getSheet(0).addCell(new Label(column++, 1, "보호자 비고사항", format));
		}
		if ( StringUtils.equals(teach.getFamily_count_yn(), "Y")) {
			workbook.getSheet(0).setColumnView(column, 20);
			workbook.getSheet(0).addCell(new Label(column++, 1, "가족인원수", format));
		}
		if ( StringUtils.equals(teach.getSchool_info_yn(), "Y")) {
			workbook.getSheet(0).setColumnView(column, 20);
			workbook.getSheet(0).addCell(new Label(column++, 1, "학년", format));
		}
		workbook.getSheet(0).setColumnView(column, 20);
		workbook.getSheet(0).addCell(new Label(column++, 1, "취소자ID", format));
		if ( StringUtils.equals(teach.getRemark_yn(), "Y")) {
			workbook.getSheet(0).setColumnView(column, 20);
			workbook.getSheet(0).addCell(new Label(column++, 1, "비고", format));
		}
		if ( StringUtils.equals(teach.getNeis_location_yn(), "Y")) {
			workbook.getSheet(0).setColumnView(column, 20);
			workbook.getSheet(0).addCell(new Label(column++, 1, "지역(나이스)", format));
		}
		if ( StringUtils.equals(teach.getNeis_cd_yn(), "Y")) {
			workbook.getSheet(0).setColumnView(column, 20);
			workbook.getSheet(0).addCell(new Label(column++, 1, "개인번호(나이스)", format));
		}
		if ( StringUtils.equals(teach.getNeis_training_num_yn(), "Y")) {
			workbook.getSheet(0).setColumnView(column, 20);
			workbook.getSheet(0).addCell(new Label(column++, 1, "연수지명번호(나이스)", format));
		}
		if ( StringUtils.equals(teach.getOrganization_yn(), "Y")) {
			workbook.getSheet(0).setColumnView(column, 20);
			workbook.getSheet(0).addCell(new Label(column++, 1, "기관", format));
		}
		if ( StringUtils.equals(teach.getRank_yn(), "Y")) {
			workbook.getSheet(0).setColumnView(column, 20);
			workbook.getSheet(0).addCell(new Label(column++, 1, "직급", format));
		}
		if ( StringUtils.equals(teach.getCourse_taken_yn(), "Y")) {
			workbook.getSheet(0).setColumnView(column, 20);
			workbook.getSheet(0).addCell(new Label(column++, 1, "연수수강여부(Y,N)", format));
		}
		

		int row = 2;

		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		
		for (Student org : studentList) {

			String applicant_sex = "";
			if (org.getApplicant_sex().equals("M")) {
				applicant_sex = "남자";
			} else {
				applicant_sex = "여자";
			}
			
			String student_sex = "";
			if (org.getStudent_sex().equals("M")) {
				student_sex = "남자";
			} else {
				student_sex = "여자";
			}
				
			String student_status = "";
			if (org.getApply_status().equals("1") && org.getApply_type().equals("CMS")) {
				student_status = "오프참여";
			} else if (org.getApply_status().equals("1") && !org.getApply_type().equals("CMS")) {
				student_status = "참여";
			} else if ( org.getApply_status().equals("2") ){
				student_status = "후보";
			} else if ( org.getApply_status().equals("3") ){
				student_status = "대기";
			} else if ( org.getApply_status().equals("99") ){
				student_status = "취소";
			}
			
			String hack = "";
			if ( org.getStudent_hack() > 0 ) {
				hack = String.valueOf(org.getStudent_hack());
			}
			column = 0;
			workbook.getSheet(0).addCell(new Label(column++, row, String.valueOf((row-1))));
			workbook.getSheet(0).addCell(new Label(column++, row, org.getWeb_id(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, org.getApplicant_name(), format1));
			/*workbook.getSheet(0).addCell(new Label(3, row, org.getApplicant_birth(), format1));
			workbook.getSheet(0).addCell(new Label(4, row, applicant_sex, format1));
			workbook.getSheet(0).addCell(new Label(5, row, org.getApplicant_zipcode(), format1));
			workbook.getSheet(0).addCell(new Label(6, row, org.getApplicant_address(), format1));*/
			workbook.getSheet(0).addCell(new Label(column++, row, org.getApplicant_cell_phone(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, org.getSelf_yn(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, org.getStudent_name(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, org.getStudent_birth(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, student_sex, format1));
			workbook.getSheet(0).addCell(new Label(column++, row, org.getStudent_zipcode(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, org.getStudent_address(), format1));
			workbook.getSheet(0).addCell(new Label(column++, row, org.getStudent_school(), format1));
//			workbook.getSheet(0).addCell(new Label(column++, row, String.valueOf(hack), format1));
			/*workbook.getSheet(0).addCell(new Label(16, row, org.getSelf_info_yn(), format1));*/
			workbook.getSheet(0).addCell(new Label(column++, row, student_status, format1));
			if ( "Y".equals(teach.getFamily_yn()) ) {
				workbook.getSheet(0).addCell(new Label(column++, row, org.getFamily_relation(), format1));
				workbook.getSheet(0).addCell(new Label(column++, row, org.getFamily_name(), format1));
				workbook.getSheet(0).addCell(new Label(column++, row, org.getFamily_cell_phone(), format1));
				workbook.getSheet(0).addCell(new Label(column++, row, org.getFamily_confirm_yn(), format1));
				workbook.getSheet(0).addCell(new Label(column++, row, org.getFamily_desc(), format1));
			}
			if ( StringUtils.equals(teach.getFamily_count_yn(), "Y")) {
				workbook.getSheet(0).addCell(new Label(column++, row, org.getStudent_family_count(), format1));
			}
			if ( StringUtils.equals(teach.getSchool_info_yn(), "Y")) {
				workbook.getSheet(0).addCell(new Label(column++, row, org.getStudent_hack_str(), format1));
			}
			workbook.getSheet(0).addCell(new Label(column++, row, org.getCancel_id(), format1));
			if ( StringUtils.equals(teach.getRemark_yn(), "Y")) {
				workbook.getSheet(0).addCell(new Label(column++, row, org.getStudent_remark(), format1));
			}
			if ( StringUtils.equals(teach.getNeis_location_yn(), "Y")) {
				workbook.getSheet(0).addCell(new Label(column++, row, org.getStudent_location_code_str(), format1));
			}
			if ( StringUtils.equals(teach.getNeis_cd_yn(), "Y")) {
				workbook.getSheet(0).addCell(new Label(column++, row, org.getStudent_neis_cd(), format1));
			}
			if ( StringUtils.equals(teach.getNeis_training_num_yn(), "Y")) {
				workbook.getSheet(0).addCell(new Label(column++, row, org.getStudent_training_num(), format1));
			}
			if ( StringUtils.equals(teach.getOrganization_yn(), "Y")) {
				workbook.getSheet(0).addCell(new Label(column++, row, org.getStudent_organization(), format1));
			}
			if ( StringUtils.equals(teach.getRank_yn(), "Y")) {
				workbook.getSheet(0).addCell(new Label(column++, row, org.getStudent_rank(), format1));
			}
			if ( StringUtils.equals(teach.getCourse_taken_yn(), "Y")) {
				workbook.getSheet(0).addCell(new Label(column++, row, org.getStudent_course_taken_yn(), format1));
			}
			
			row++;
		}
		
		return workbook;
	}
}
