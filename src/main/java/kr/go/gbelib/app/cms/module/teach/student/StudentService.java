package kr.go.gbelib.app.cms.module.teach.student;

import java.io.IOException;
import java.io.OutputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;
import jxl.format.Alignment;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.format.Colour;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import jxl.write.WriteException;
import jxl.write.biff.RowsExceededException;
import kr.co.whalesoft.app.cms.code.Code;
import kr.co.whalesoft.app.cms.code.CodeService;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.framework.base.BaseService;
import kr.go.gbelib.app.cms.module.teach.Teach;
import kr.go.gbelib.app.cms.module.teach.TeachDao;
import kr.go.gbelib.app.cms.module.teachSetting.TeachSetting;
import kr.go.gbelib.app.cms.module.teachSetting.TeachSettingService;
import kr.go.gbelib.app.common.api.PushAPI;

@Service
public class StudentService extends BaseService {

	@Autowired
	private TeachDao teachDao;

	@Autowired
	private StudentDao dao;

	@Autowired
	private HomepageService homepageService;

	@Autowired
	private TeachSettingService teachSettingService;

	@Autowired
	private CodeService codeService;

	public List<Student> getStudentListAll(Student student) {
		return dao.getStudentListAll(student);
	}

	public List<Student> getStudentList(Student student) {
		return dao.getStudentList(student);
	}

	public int getStudentListCount(Student student) {
		return dao.getStudentListCount(student);
	}

	public Student getStudentOne(Student student) {
		return dao.getStudentOne(student);
	}

	@Transactional
	public Object[] addStudent(Student student, String addType) {
		Object[] addResult = new Object[3];
		student.setApply_type(addType);
		Teach teach = null;
		teach = teachDao.getTeachOne(new Teach(student.getHomepage_id(), student.getGroup_idx(), student.getCategory_idx(), student.getTeach_idx()));

//		TeachSetting ts = new TeachSetting(student.getHomepage_id(), student.getMember_key());
//		String reject = teachSettingService.checkTeachSetting(ts);
		student.setUserNo(student.getMember_key());
		String reject = teachSettingService.checkTeachSettingCategoryGroup(student);
		if (StringUtils.isNotEmpty(reject)) {

			addResult[0] = false;
			addResult[0] = false;
			addResult[1] = reject;
			return addResult;
		}
		reject = teachSettingService.checkTeachSettingCategory(student);
		if (StringUtils.isNotEmpty(reject)) {
			addResult[0] = false;
			addResult[1] = reject;
			return addResult;
		}

		if (StringUtils.equals(teach.getAgent_yn(), "N")) {
			student.setStudent_name(student.getApplicant_name());
			student.setStudent_birth(student.getApplicant_birth());
			student.setStudent_sex(student.getApplicant_sex());
			student.setStudent_zipcode(student.getApplicant_zipcode());
			student.setStudent_address(student.getApplicant_address());
			student.setSelf_info_yn("Y");
		}

		if ( "Y".equals(teach.getFamily_yn()) ) {
			if ( StringUtils.isEmpty(student.getFamily_relation()) ){
				addResult[0] = false;
				addResult[1] = "보호자 정보를 입력해주세요.";
				return addResult;
			}

			if ( StringUtils.isEmpty(student.getFamily_name()) ){
				addResult[0] = false;
				addResult[1] = "보호자 정보를 입력해주세요.";
				return addResult;
			}

			if ( !"Y".equals(student.getFamily_confirm_yn()) ){
				addResult[0] = false;
				addResult[1] = "해당 강좌는 보호자 승인을 받아야합니다.";
				return addResult;
			}
		}

		if ( dao.checkStudent(student) > 0 ) {
			addResult[0] = false;
			addResult[1] = "이미 신청하신 강좌입니다.";
			return addResult;
		}

		if ( teach != null ) {
			if ( "Y".equals(teach.getMember_yn()) ) {
				if ( student.getApi_user_id().startsWith("*") ) {
					addResult[0] = false;
					addResult[1] = String.format("해당 강좌는 정회원(대출회원) 제한이 있습니다.");
					return addResult;
				}
			}

			if ( teach.getTeach_join_limit_value() != null && teach.getTeach_join_limit_value() != null ) {
				String[] limitUnit = teach.getTeach_join_limit_unit().split(",");
				String[] limitValue = teach.getTeach_join_limit_value().split(",");
				for ( int i = 0; i < limitUnit.length; i ++ ) {
					String oneLimitUnit = limitUnit[i];
					//강의 성별 제한이 있으면 체크.
					if ( "SEX".equals(oneLimitUnit) ) {
						if ( !student.getApplicant_sex().equals(limitValue[i]) ) {
							addResult[0] = false;
							addResult[1] = String.format("해당 강좌는 성별 제한이 있습니다.");
							return addResult;
						}
					}
					// 강의 나이 제한이 있으면 체크.
					if ( "OLD".equals(oneLimitUnit) ) {
						if ( Integer.parseInt(limitValue[i]) <= student.getStudent_old() && Integer.parseInt(limitValue[i+1]) >= student.getStudent_old()) { }
						else {
							addResult[0] = false;
							addResult[1] = String.format("해당강좌는 나이 %s 세 이상 %s 세 이하 만 신청 가능합니다.", limitValue[i], limitValue[i+1]);
							return addResult;
						}
					}
				}
			}

			if (StringUtils.equals(teach.getLimit_hak_yn(), "Y")) {
				int fromHak = Integer.parseInt(teach.getLimit_hak());
				int toHak = Integer.parseInt(teach.getLimit_hak2());

				if (fromHak > student.getStudent_hack() || toHak < student.getStudent_hack()) {
					String formHakStr = codeService.getCodeOne("CMS", "C0020", teach.getLimit_hak()).getCode_name();
					String toHakStr = codeService.getCodeOne("CMS", "C0020", teach.getLimit_hak2()).getCode_name();
					addResult[0] = false;
					addResult[1] = String.format("해당강좌는 %s 이상 %s 이하 만 신청 가능합니다.", formHakStr, toHakStr);
					return addResult;
				}
			}


			int limitCount 			= teach.getTeach_limit_count(); // 제한인원
			int curJoinCount 		= teach.getTeach_join_count(); // 현재 참여인원
			int backupCount 		= teach.getTeach_backup_count(); // 후보인원
			int curBackupJoinCount 	= teach.getTeach_backup_join_count(); //현재 후보인원
			int offlineCount 		= teach.getTeach_offline_count(); // 오프라인 인원
			int curOfflineJoinCount = teach.getTeach_off_join_count(); // 현재 오프라인 인원

			if ( addType.equals("CMS") ) {
				if ( offlineCount == 0 ) {
					addResult[0] = false;
					addResult[1] = "해당 강좌는 오프라인 모집이 없습니다.";
					return addResult;
				}

				if ( offlineCount > curOfflineJoinCount ) {
					student.setApply_status("1"); // 참여 상태
					int result = dao.addStudent(student);

					if ( result > 0 ) {
						addResult[0] = true;
						addResult[1] = String.format("%s번째 오프라인 참여자로 신청 되었습니다.", curOfflineJoinCount + 1);
						return addResult;
					}
					else {
						addResult[0] = false;
						addResult[1] = "신청 실패 하였습니다.";
						return addResult;
					}
				}
				else {
					addResult[0] = false;
					addResult[1] = String.format("신청 실패 했습니다.\n오프라인 모집 인원 : %s, 오프라인 참여 인원 : %s입니다.", offlineCount, curOfflineJoinCount);
					return addResult;
				}
			}
			else {
				// 강의 제한 인원 보다 참여인원이 작거나 같을때 수강생 등록한다.
				if ( limitCount > curJoinCount ) {
					student.setApply_status("1");
					int result = dao.addStudent(student);
					if ( result > 0 ) {
						String message = String.format("[%s] 해당 강좌 신청이 완료 되었습니다.", teach.getTeach_name());
//						Homepage homepage = homepageService.getHomepageOne(new Homepage(student.getHomepage_id()));
//						if (isSmsReceive(student.getSearch_api_type(), student.getMember_id())) {
//							PushAPI.sendMessage(homepage, PushAPI.SMS_TYPE_SMS, student.getApplicant_cell_phone(), message, homepage.getHomepage_send_tell(), true);
//						}
						addResult[0] = true;
						addResult[1] = String.format("%s번째 참여자로 신청 되었습니다.", curJoinCount + 1);
						addResult[2] = true;
						return addResult;
					}
					else {
						addResult[0] = false;
						addResult[1] = "신청 실패 하였습니다.";
						return addResult;
					}
				}
				else { // 강의 모집 인원이 다 차서 후보 인원으로 등록 할것인이 판단한다.
					if ( backupCount > curBackupJoinCount ) {
						student.setApply_status("2"); // 후보로 세팅
						int result = dao.addStudent(student);
						if ( result > 0 ) {
							// 참여인원이 제한인원과 같으면 강의 상태를 접수 마감으로 변경 시킨다.
							if ( backupCount == (curBackupJoinCount + 1) ) {
								teach.setTeach_status("2");
								teachDao.changeTeachStatus(teach);
							}
							addResult[0] = true;
							addResult[1] = String.format("%s번째 대기자로 신청 되었습니다.", curBackupJoinCount + 1);
							String message = String.format("[%s] 해당 강좌에 대기자로 신청이 완료되었습니다.", teach.getTeach_name());
//							Homepage homepage = homepageService.getHomepageOne(new Homepage(student.getHomepage_id()));
//							if (isSmsReceive(student.getSearch_api_type(), student.getMember_id())) {
//								PushAPI.sendMessage(homepage, PushAPI.SMS_TYPE_SMS, student.getApplicant_cell_phone(), message, homepage.getHomepage_send_tell(), true);
//							}
							return addResult;
						}
						else {
							addResult[0] = false;
							addResult[1] = "대기 신청 실패 하였습니다.";
							return addResult;
						}
					}
					else {
						addResult[0] = false;
						addResult[1] = String.format("모집 인원 : %s, 참여 인원 : %s, 후보 인원: %s, 후보참여 인원 : %s입니다.", limitCount, curJoinCount, backupCount, curBackupJoinCount);
						return addResult;
					}
				}
			}
		} else {
			addResult[0] = false;
			addResult[1] = "해당 강의 정보가 없습니다.";
			return addResult;
		}
	}

	@Transactional
	public int modifyStudent(Student student) {
		int result = 0;
		String applyStatus = student.getApply_status();
		result = dao.modifyStudent(student);

		if ( result > 0 ) {
			if ( applyStatus.equals("99") ) { // 신청 상태 : 취소
				student.setCancel_id(student.getModify_id());
				cancelStudent(student);
			}
			else  if ( student.getApply_status().equals("1") ) {
/*				Teach teach = teachDao.getTeachOne(new Teach(student.getHomepage_id(), student.getGroup_idx(), student.getCategory_idx(), student.getTeach_idx()));
				String message = String.format("[%s] 해당 강좌 정상 참여 되었습니다.", teach.getTeach_name());
				PushAPI.sendMessage(student.getHomepage_id(), PushAPI.SMS_TYPE_SMS, student.getApplicant_cell_phone(), message);*/
			}
		}

		return result;
	}

	@Transactional
	public int cancelStudent(Student student) {
		if (student.getStudent_idx() < 1) {
			Student st = dao.getStudentOne(student);
			student.setStudent_idx(st.getStudent_idx());
//			student.setCancel_id(st.getWeb_id());
			Teach teach = new Teach(student.getHomepage_id(), student.getGroup_idx(), student.getCategory_idx(), student.getTeach_idx());
			teach = teachDao.getTeachOne(teach);
			//TODO 휴대문자 동의 여부 확인 후 전송
//			Homepage homepage = homepageService.getHomepageOne(new Homepage(student.getHomepage_id()));
//			if (isSmsReceive("USERID", st.getMember_id())) {
//				PushAPI.sendMessage(homepage, PushAPI.SMS_TYPE_SMS, st.getApplicant_cell_phone(), String.format("[%s] 해당 강좌 신청이 취소 되었습니다.", teach.getTeach_name()), homepage.getHomepage_send_tell(), true);
//			}
		}
		int result = dao.cancelStudent(student);
		if ( result > 0 ) {
			Teach teach = new Teach(student.getHomepage_id(), student.getGroup_idx(), student.getCategory_idx(), student.getTeach_idx());
			teach = teachDao.getTeachOne(teach);
			if ( teach != null ) {
				int limitCount 		= teach.getTeach_limit_count(); // 제한인원
				int curJoinCount 	= teach.getTeach_join_count(); // 현재 참여인원
				int backupJoinCount = teach.getTeach_backup_join_count();

				if ( limitCount > curJoinCount ) {
					if ( backupJoinCount > 0 ) {
						Student firstBackupStudent = dao.getFirstBackupMember(teach);
						if ( firstBackupStudent != null ) {
							if ( dao.updateJoinToBackupMember(firstBackupStudent) > 0 ) {
								//대기자에서 정상참여로 변경될 경우
//								Homepage homepage = homepageService.getHomepageOne(new Homepage(firstBackupStudent.getHomepage_id()));
//								PushAPI.sendMessage(homepage, PushAPI.SMS_TYPE_SMS, firstBackupStudent.getApplicant_cell_phone(), String.format("[%s] 해당 강좌 신청이 완료 되었습니다.", teach.getTeach_name()), homepage.getHomepage_send_tell(), true);
							}
						}
					}
				}
			}
		}
		return result;
	}

	@Transactional
	public int deleteStudent(Student student) {
		if (student.getStudent_idx() < 1) {
			Student st = dao.getStudentOne(student);
			student.setStudent_idx(st.getStudent_idx());
		}
		int result = dao.deleteStudent(student);

		if ( result > 0 ) {
			Teach teach = new Teach(student.getHomepage_id(), student.getGroup_idx(), student.getCategory_idx(), student.getTeach_idx());
			teach = teachDao.getTeachOne(teach);
			if ( teach != null ) {
				int limitCount 		= teach.getTeach_limit_count(); // 제한인원
				int curJoinCount 	= teach.getTeach_join_count(); // 현재 참여인원
				int backupCount 	= teach.getTeach_backup_join_count();
				if ( limitCount > curJoinCount ) {
					if ( backupCount > 0 ) {
						Student firstBackupStudent = dao.getFirstBackupMember(teach);
						if ( firstBackupStudent != null ) {
							if ( dao.updateJoinToBackupMember(firstBackupStudent) > 0 ) {
//								Homepage homepage = homepageService.getHomepageOne(new Homepage(firstBackupStudent.getHomepage_id()));
//								PushAPI.sendMessage(homepage, PushAPI.SMS_TYPE_SMS, homepage.getHomepage_send_tell(), String.format("[%s] 정상 참여 되었습니다.", teach.getTeach_name()), firstBackupStudent.getApplicant_cell_phone(), true);
							}
						}
					}
				}
			}
		}
		return result;
	}

	public int batchCancelStudent(Student student) {
		int result = 0;

		if(student.getStudent_idx_arr() != null) {
			for(Integer student_idx: student.getStudent_idx_arr()) {
				Student one = new Student();
				one.setHomepage_id(student.getHomepage_id());
				one.setGroup_idx(student.getGroup_idx());
				one.setCategory_idx(student.getCategory_idx());
				one.setTeach_idx(student.getTeach_idx());
				one.setStudent_idx(student_idx);
				one.setCancel_id(one.getCancel_id());

				result += cancelStudent(one);
			}
		}

		return result;
	}

	public int batchDeleteStudent(Student student) {
		int result = 0;

		if(student.getStudent_idx_arr() != null) {
			for(Integer student_idx: student.getStudent_idx_arr()) {
				Student one = new Student();
				one.setHomepage_id(student.getHomepage_id());
				one.setGroup_idx(student.getGroup_idx());
				one.setCategory_idx(student.getCategory_idx());
				one.setTeach_idx(student.getTeach_idx());
				one.setStudent_idx(student_idx);

				result += deleteStudent(one);
			}
		}

		return result;
	}

	public Student getCertificateInfo(Student student) {
		return dao.getCertificateInfo(student);
	}

	public List<Student> getTeachCertificateList(Student student) {
		return dao.getTeachCertificateList(student);
	}

	public String checkStudent(Student student) {
		Teach targetTeach = teachDao.getTeachOne(new Teach(student.getHomepage_id(), student.getGroup_idx(), student.getCategory_idx(), student.getTeach_idx()));

		//해당강좌 중복 체크
		if ( dao.checkStudent(student) > 0 ) {
			return "이미 신청하신 강좌입니다.";
		}
		//동일강좌(1차, 2차) 수강 제한 : 강좌 명 + 강사 이름 으로 체크
		if ( targetTeach.getTeach_same_limit_count() != 0 ) {
			if ( dao.checkStudentSameTeach(student) >= targetTeach.getTeach_same_limit_count() ) {
				return "동일 강좌 수강내역이 있습니다.";
			}
		}

		//동시간 수강 제한 : 신정한 사람의 강의 내역 중 같은 요일, 같은 시간 겹치는지 체크.
		/*String[] parsePattern = {"yyyy-MM-dd"};
		Calendar cal = Calendar.getInstance() ;
		List<Teach> teachList = teachDao.getTeachListOfStudent(student);
		for ( Teach one : teachList ) {
			String[] teachDay = one.getTeach_day().split(","); // 1 = 일 , 2 = 월 ~
			Map<Integer, Object> teachDayRepo = new HashMap<Integer, Object>(); // 강의 요일을 담아둔다
			for ( String oneDay : teachDay ) {
				teachDayRepo.put(Integer.parseInt(oneDay), "");
			}


			Date StartDate = DateUtils.parseDate(one.getStart_date(), parsePattern);
			cal.setTime(StartDate);
			int dayNum = cal.get(Calendar.DAY_OF_WEEK) ;

		}*/


		return null;
	}

	public void writeExcelDataSample(OutputStream out ) throws RowsExceededException, WriteException, IOException {

		WritableWorkbook workbook = Workbook.createWorkbook( out );
		WritableSheet sheet = workbook.createSheet( "수강생등록", 0 );

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
		sheet.setColumnView( 0,  20 );
		sheet.setColumnView( 1,  20 );
		sheet.setColumnView( 2,  20 );
		sheet.setColumnView( 3,  20 );
		sheet.setColumnView( 4,  20 );
		sheet.setColumnView( 5,  20 );
		sheet.setColumnView( 6,  30 );
		sheet.setColumnView( 7,  20 );
		sheet.setColumnView( 8,  20 );
		sheet.setColumnView( 9,  20 );
		sheet.setColumnView( 10, 20 );
		sheet.setColumnView( 11, 20 );
		sheet.setColumnView( 12, 20 );
		sheet.setColumnView( 13, 20 );
		sheet.setColumnView( 14, 20 );
		sheet.setColumnView( 15, 20 );
		sheet.setColumnView( 16, 30 );
		sheet.setColumnView( 17, 20 );
		sheet.setColumnView( 18, 20 );
		sheet.setColumnView( 19, 20 );
		sheet.setColumnView( 20, 20 );
		sheet.setColumnView( 21, 20 );
		sheet.setColumnView( 22, 20 );
		sheet.setColumnView( 23, 20 );
		sheet.setColumnView( 24, 20 );
		sheet.setColumnView( 25, 20 );
		sheet.setColumnView( 26, 20 );
		sheet.setColumnView( 27, 20 );
		sheet.setColumnView( 28, 20 );

		// 헤더 컬럼 지정
		sheet.addCell( new Label( 0,  0, "신청자 ID", format ) );
		sheet.addCell( new Label( 1,  0, "신청자 명", format ) );
		sheet.addCell( new Label( 2,  0, "신청자 생년월일", format ) );
		sheet.addCell( new Label( 3,  0, "신청자 성별", format ) );
		sheet.addCell( new Label( 4,  0, "신청자 우편번호", format ) );
		sheet.addCell( new Label( 5,  0, "신청자 주소", format ) );
		sheet.addCell( new Label( 6,  0, "신청자 휴대전화번호", format ) );
		sheet.addCell( new Label( 7,  0, "신청자 수강생 동일여부 (Y,N)", format ) );
		sheet.addCell( new Label( 8,  0, "수강생 명", format ) );
		sheet.addCell( new Label( 9,  0, "수강생 생년월일", format ) );
		sheet.addCell( new Label( 10, 0, "수강생 나이", format ) );
		sheet.addCell( new Label( 11, 0, "수강생 성별", format ) );
		sheet.addCell( new Label( 12, 0, "수강생 우편번호", format ) );
		sheet.addCell( new Label( 13, 0, "수강생 주소", format ) );
		sheet.addCell( new Label( 14, 0, "수강생 학교", format ) );
		sheet.addCell( new Label( 15, 0, "수강생 학년", format ) );
		sheet.addCell( new Label( 16, 0, "개인정보 동의 여부 (Y,N)", format ) );
		sheet.addCell( new Label( 17, 0, "보호자 관계", format ) );
		sheet.addCell( new Label( 18, 0, "보호자 이름", format ) );
		sheet.addCell( new Label( 19, 0, "보호자 연락처", format ) );
		sheet.addCell( new Label( 20, 0, "보호자 동의 여부", format ) );
		sheet.addCell( new Label( 21, 0, "보호자 비고", format ) );
		sheet.addCell( new Label( 22, 0, "일반 비고", format ) );
		sheet.addCell( new Label( 23, 0, "나이스 지역", format ) );
		sheet.addCell( new Label( 24, 0, "나이스 개인번호", format ) );
		sheet.addCell( new Label( 25, 0, "나이스 연수지명번호", format ) );
		sheet.addCell( new Label( 26, 0, "기관", format ) );
		sheet.addCell( new Label( 27, 0, "직급", format ) );
		sheet.addCell( new Label( 28, 0, "연수수강여부 (Y,N)", format ) );

		sheet.addCell( new Label( 0,  1, "ID") );
		sheet.addCell( new Label( 1,  1, "홍길동") );
		sheet.addCell( new Label( 2,  1, "19990101") );
		sheet.addCell( new Label( 3,  1, "남") );
		sheet.addCell( new Label( 4,  1, "12345") );
		sheet.addCell( new Label( 5,  1, "대구광역시") );
		sheet.addCell( new Label( 6,  1, "010-1234-5678") );
		sheet.addCell( new Label( 7,  1, "Y") );
		sheet.addCell( new Label( 8,  1, "") );
		sheet.addCell( new Label( 9,  1, "") );
		sheet.addCell( new Label( 10, 1, "18") );
		sheet.addCell( new Label( 11, 1, "") );
		sheet.addCell( new Label( 12, 1, "") );
		sheet.addCell( new Label( 13, 1, "") );
		sheet.addCell( new Label( 14, 1, "대구고등학교") );
		sheet.addCell( new Label( 15, 1, "2") );
		sheet.addCell( new Label( 15, 2, "학년은 반드시 코드로 입력하여야합니다. 아래 내용을 참조하여 입력하세요") );
		sheet.addCell( new Label( 16, 1, "Y") );
		sheet.addCell( new Label( 17, 1, "부 또는 모") );
		sheet.addCell( new Label( 18, 1, "성함") );
		sheet.addCell( new Label( 19, 1, "010-1234-5678") );
		sheet.addCell( new Label( 20, 1, "Y") );
		sheet.addCell( new Label( 21, 1, "가족프로그램의 경우 비고를 입력하세요") );
		sheet.addCell( new Label( 22, 1, "일반 비고 사용시 입력하세요") );
		sheet.addCell( new Label( 23, 1, "나이스 지역입력 시 입력하세요") );
		sheet.addCell( new Label( 23, 2, "지역은 반드시 코드로 입력하여야합니다. 아래 내용을 참조하여 입력하세요") );
		sheet.addCell( new Label( 24, 1, "R1234") );
		sheet.addCell( new Label( 24, 2, "나이스 개인번호 입력시 입력하세요") );
		sheet.addCell( new Label( 25, 1, "R1234") );
		sheet.addCell( new Label( 25, 1, "나이스 연수지명번호 입력시 입력하세요") );
		sheet.addCell( new Label( 26, 1, "") );
		sheet.addCell( new Label( 27, 1, "") );
		sheet.addCell( new Label( 28, 1, "Y 또는 N") );


		List<Code> locationCode = codeService.getCode("CMS", "C0022");
		sheet.addCell( new Label( 23, 3, "코드 - 코드명") );
		for ( int i = 0; i < locationCode.size(); i++ ) {
			sheet.addCell( new Label( 22, i+4, locationCode.get(i).getCode_id() + " - " + locationCode.get(i).getCode_name()) );
		}

		List<Code> hakCode = codeService.getCode("CMS", "C0020");
		sheet.addCell( new Label( 15, 3, "코드-코드명") );
		for ( int i = 0; i < hakCode.size(); i++ ) {
			sheet.addCell( new Label( 15, i+4, hakCode.get(i).getCode_id() + " - " + hakCode.get(i).getCode_name()) );
		}


		workbook.write();
		workbook.close();
	}

	public List<Student> excelUpload(Student teachStaff, XlsUpload excel) throws Exception {
		Workbook workbook = Workbook.getWorkbook( excel.getFile().getInputStream() );
		Sheet sheet = workbook.getSheet( 0 );

		int rowCount = sheet.getRows();
		List<Student> students = new ArrayList<Student>();

		for ( int i = excel.getStartRow(); i < rowCount; i++ ) {
			Student auth = getAuthenticationFromExcel( sheet, excel, i ,teachStaff);
			if(auth == null) return null;
			students.add( auth );
		}

		workbook.close();

		return students;
	}

	private Student getAuthenticationFromExcel( Sheet sheet, XlsUpload excel, int row ,Student student) {

		Student oneStudent = new Student();

		Cell member_id				= sheet.getCell( excel.getMember_id(), row );
		Cell applicant_name			= sheet.getCell( excel.getApplicant_name(), row );
		Cell applicant_birth		= sheet.getCell( excel.getApplicant_birth(), row );
		Cell applicant_sex			= sheet.getCell( excel.getApplicant_sex(), row );
		Cell applicant_zipcode		= sheet.getCell( excel.getApplicant_zipcode(), row );
		Cell applicant_address		= sheet.getCell( excel.getApplicant_address(), row );
		Cell applicant_cell_phone	= sheet.getCell( excel.getApplicant_cell_phone(), row );
		Cell self_yn				= sheet.getCell( excel.getSelf_yn(), row );
		Cell student_name			= sheet.getCell( excel.getStudent_name(), row );
		Cell student_birth			= sheet.getCell( excel.getStudent_birth(), row );
		Cell student_old			= sheet.getCell( excel.getStudent_old(), row );
		Cell student_sex			= sheet.getCell( excel.getStudent_sex(), row );
		Cell student_zipcode		= sheet.getCell( excel.getStudent_zipcode(), row );
		Cell student_address		= sheet.getCell( excel.getStudent_address(), row );
		Cell student_school			= sheet.getCell( excel.getStudent_school(), row );
		Cell student_hack			= sheet.getCell( excel.getStudent_hack(), row );
		Cell self_info_yn			= sheet.getCell( excel.getSelf_info_yn(), row );
		Cell family_relation		= sheet.getCell( excel.getFamily_relation(), row );
		Cell family_name			= sheet.getCell( excel.getFamily_name(), row );
		Cell family_cell_phone		= sheet.getCell( excel.getFamily_cell_phone(), row );
		Cell family_confirm_yn		= sheet.getCell( excel.getFamily_confirm_yn(), row );
		Cell family_desc		= sheet.getCell( excel.getFamily_desc(), row );
		Cell student_remark		= sheet.getCell( excel.getStudent_remark(), row );
		Cell student_location_code		= sheet.getCell( excel.getStudent_location_code(), row );
		Cell student_neis_cd		= sheet.getCell( excel.getStudent_neis_cd(), row );
		Cell student_training_num		= sheet.getCell( excel.getStudent_training_num(), row );
		Cell student_organization		= sheet.getCell( excel.getStudent_organization(), row );
		Cell student_rank				= sheet.getCell( excel.getStudent_rank(), row );
		Cell student_course_taken_yn	= sheet.getCell( excel.getStudent_course_taken_yn(), row );

		try {
			if(member_id != null) oneStudent.setMember_id(member_id.getContents().trim());
			if(applicant_name != null) oneStudent.setApplicant_name(applicant_name.getContents().trim());
			if(applicant_birth != null) {
				String a = applicant_birth.getContents().trim();
				a = a.substring(0, 4) + "-" + a.substring(4, 6) + "-" + a.substring(6);
				oneStudent.setApplicant_birth(a);
			}
			if(applicant_sex != null) {
				String sex = applicant_sex.getContents().trim();
				if ( sex.equals("남자") || sex.equals("남") || sex.equals("M") || sex.equals("m")) {
					oneStudent.setApplicant_sex("M");
				}
				else {
					oneStudent.setApplicant_sex("F");
				}
			}
			if(applicant_zipcode != null) oneStudent.setApplicant_zipcode(applicant_zipcode.getContents().trim());
			if(applicant_address != null) oneStudent.setApplicant_address(applicant_address.getContents().trim());
			if(applicant_cell_phone != null) oneStudent.setApplicant_cell_phone(applicant_cell_phone.getContents().trim());
			if(self_yn != null) {
				oneStudent.setSelf_yn(self_yn.getContents().trim());
				if ( self_yn.getContents().trim().equals("Y") ) {
					if(student_name != null) oneStudent.setStudent_name(oneStudent.getApplicant_name());
					if(student_birth != null) oneStudent.setStudent_birth(oneStudent.getApplicant_birth());
					if(student_sex != null) oneStudent.setStudent_sex(oneStudent.getApplicant_sex());
					if(student_zipcode != null) oneStudent.setStudent_zipcode(oneStudent.getApplicant_zipcode());
					if(student_address != null) oneStudent.setStudent_address(oneStudent.getApplicant_address());
				}
				else {
					if(student_name != null) oneStudent.setStudent_name(student_name.getContents().trim());
					if(student_birth != null) {
						String a = applicant_birth.getContents().trim();
						a = a.substring(0, 4) + "-" + a.substring(4, 6) + "-" + a.substring(6);
						oneStudent.setStudent_birth(a);
					}
					if(student_sex != null) {
						if(applicant_sex != null) {
							String sex = student_sex.getContents().trim();
							if ( sex.equals("남자") || sex.equals("남") || sex.equals("M") || sex.equals("m")) {
								oneStudent.setStudent_sex("M");
							}
							else {
								oneStudent.setStudent_sex("F");
							}
						}
					}
					if(student_zipcode != null) oneStudent.setStudent_zipcode(student_zipcode.getContents().trim());
					if(student_address != null) oneStudent.setStudent_address(student_address.getContents().trim());
				}
			}

			if(student_old != null) oneStudent.setStudent_old(Integer.parseInt(student_old.getContents()));
			if(student_school != null) oneStudent.setStudent_school(student_school.getContents());
			if(student_hack != null) oneStudent.setStudent_hack(Integer.parseInt(student_hack.getContents()));
			if(self_info_yn != null) oneStudent.setSelf_info_yn(self_info_yn.getContents());
			if(family_relation != null) oneStudent.setFamily_relation(family_relation.getContents());
			if(family_name != null) oneStudent.setFamily_name(family_name.getContents());
			if(family_cell_phone != null) oneStudent.setFamily_cell_phone(family_cell_phone.getContents().trim());
			if(family_confirm_yn != null) {
				String yn = family_confirm_yn.getContents();
				if ( "동의".equals(yn) || "승인".equals(yn) || "Y".equals(yn) || "y".equals(yn) ) {
					yn = "Y";
				}
				else {
					yn = "N";
				}

				oneStudent.setFamily_confirm_yn(yn);
			}
			if(family_desc != null) oneStudent.setFamily_desc(family_desc.getContents());
			if(student_remark != null) oneStudent.setStudent_remark(student_remark.getContents());
			if(student_location_code != null) oneStudent.setStudent_location_code(student_location_code.getContents());
			if(student_neis_cd != null) oneStudent.setStudent_neis_cd(student_neis_cd.getContents());
			if(student_training_num != null) oneStudent.setStudent_training_num(student_training_num.getContents());
			if(student_organization != null) oneStudent.setStudent_organization(student_organization.getContents());
			if(student_rank != null) oneStudent.setStudent_rank(student_rank.getContents());
			if(student_course_taken_yn != null) oneStudent.setStudent_course_taken_yn(student_course_taken_yn.getContents());

		}
		catch ( Exception e ) {
			e.printStackTrace();
		}

		oneStudent.setAdd_id(student.getAdd_id());

		return oneStudent;
	}

	public String checkValidation(Student student) {
		SimpleDateFormat sfDate = new SimpleDateFormat("yyyy-MM-dd");
		sfDate.setLenient(false);
		try {
			sfDate.parse(student.getApplicant_birth());
			sfDate.parse(student.getStudent_birth());
		} catch (ParseException e) {
			return "생년월일 형식이 맞지 않습니다. YYYYMMDD 형식으로 입력해주세요.";
		}

		if ( student.getStudent_old() == 0 ) {
			return "나이는 0일수 없습니다.";
		}

		String checkResult = checkStudent(student);

		if ( checkResult != null ) {
			return checkResult;
		}

		return null;
	}

	public List<Student> getCertificateListByDate(Student student) {
		return dao.getCertificateListByDate(student);
	}

	public List<Student> getCertificateListByDate(Teach teach) {
		return dao.getCertificateListByDate2(teach);
	}

	/**
	 * 기간내 신청(취소제외) 횟수
	 * @param ts
	 * @return 기간내 신청(취소제외) 횟수
	 */
	public int checkStudentSetting(TeachSetting ts) {
		return dao.checkStudentSetting(ts);
	}

	/**
	 * 기간내 신청(취소제외) 횟수 - 소분류
	 * @param student
	 * @return 기간내 신청(취소제외) 횟수
	 */
	public int checkStudentSetting2(Student student) {
		return dao.checkStudentSetting2(student);
	}

	/**
	 * 기간내 신청(취소제외) 횟수 - 중분류
	 * @param student
	 * @return 기간내 신청(취소제외) 횟수
	 */
	public int checkStudentSetting3(Student student) {
		return dao.checkStudentSetting3(student);
	}

}