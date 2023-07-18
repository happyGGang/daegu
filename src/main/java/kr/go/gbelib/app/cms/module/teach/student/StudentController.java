package kr.go.gbelib.app.cms.module.teach.student;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import java.util.Optional;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.app.cms.code.Code;
import kr.co.whalesoft.app.cms.code.CodeService;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.app.cms.terms.Terms;
import kr.co.whalesoft.app.cms.terms.TermsService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.file.Download;
import kr.co.whalesoft.framework.utils.AttachmentUtils;
import kr.co.whalesoft.framework.utils.CalculateHashUtils;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.cms.module.category.Category;
import kr.go.gbelib.app.cms.module.category.CategoryService;
import kr.go.gbelib.app.cms.module.category.group.CategoryGroup;
import kr.go.gbelib.app.cms.module.category.group.CategoryGroupService;
import kr.go.gbelib.app.cms.module.teach.Teach;
import kr.go.gbelib.app.cms.module.teach.TeachService;
import kr.go.gbelib.app.cms.module.teach.teachCode2.TeachCode2;
import kr.go.gbelib.app.cms.module.teach.teachCode2.TeachCode2Service;
import kr.go.gbelib.app.common.api.MemberAPI;

@Controller
@RequestMapping(value = {"/cms/module/teach/student"})
public class StudentController extends BaseController {

	private final String basePath = "/cms/module/teach/student/";

	private final int cert_percent = 70;	// 수료 기준 출석률

	@Autowired
	private StudentService studentService;

	@Autowired
	private TeachService teachService;

	@Autowired
	private CodeService codeService;

	@Autowired
	private CategoryGroupService categoryGroupService;

	@Autowired
	private CategoryService categoryService;

	@Autowired
	private TeachCode2Service teachCode2Service;

	@Autowired
	private TermsService termsService;

	@Autowired
	private HomepageService homepageService;

	@RequestMapping(value = {"/index.*"})
	public String index(Model model, Student student, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
//		if ( !getSessionIsAdmin(request) ) {
//			student.setHomepage_id(getAsideHomepageId(request));
//		}
		if ((getAsideHomepageId(request).equals("h37") || getAsideHomepageId(request).equals("h49") || getAsideHomepageId(request).equals("h45") || getAsideHomepageId(request).equals("h53"))) {
			Homepage sessionHomepageInfo = getSessionHomepageInfo(request);
			sessionHomepageInfo.setHomepage_group(getAsideHomepageId(request));
			sessionHomepageInfo.setTemp_use_yn("Y");
			List<Homepage> subHomepageList = homepageService.getSubHomepageList(sessionHomepageInfo);
			if (StringUtils.isEmpty(student.getHomepage_id())) {
				student.setHomepage_id(subHomepageList.get(0).getHomepage_id());
			}
			model.addAttribute("subHomepageList", subHomepageList);
		} else {
			if (StringUtils.isEmpty(student.getHomepage_id())) {
				student.setHomepage_id(getAsideHomepageId(request));
			}
		}
		model.addAttribute("categoryGroupList", categoryGroupService.getCategoryGroupListAll(new CategoryGroup(student.getHomepage_id(), student.getLarge_category_idx())));
		model.addAttribute("categoryList", categoryService.getCategoryListAll(new Category(student.getHomepage_id(), student.getGroup_idx(), student.getLarge_category_idx())));
		Teach teach = new Teach(student.getHomepage_id(), student.getGroup_idx(),student.getCategory_idx());
		teach.setLarge_category_idx(student.getLarge_category_idx());
		model.addAttribute("teachList", teachService.getTeachListAll(teach));
		model.addAttribute("student", student);

		TeachCode2 teachCode2 = new TeachCode2(1);
		teachCode2.setTeach_code(15);
		teachCode2.setHomepage_id(student.getHomepage_id());
		model.addAttribute("teachLargeCategoryList", teachCode2Service.getSubcategories(teachCode2));

		return basePath + "index";
	}

	@RequestMapping(value = {"/student.*"})
	public String student(Model model, Student student, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		student.setCert_percent(cert_percent);
		int count = studentService.getStudentListCount(student);
		studentService.setPaging(model, count, student);

		model.addAttribute("student", student);
		Teach teach = new Teach(student.getHomepage_id(), student.getGroup_idx(), student.getCategory_idx(), student.getTeach_idx());
		teach.setLarge_category_idx(student.getLarge_category_idx());
		List<Student> studentList = getStudents(student);

		model.addAttribute("teachInfo", teachService.getTeachOne(teach));
		model.addAttribute("studentListCount", count);
		model.addAttribute("studentList", studentList);
		Map<String, Code> codeRepo = new HashMap<String, Code>();
		for ( Code one : codeService.getCode("CMS", "C0005") ) {
			codeRepo.put(one.getCode_id(), one);
		}
		model.addAttribute("statusCode", codeRepo);
		return basePath + "student_ajax";
	}

	private List<Student> getStudents(Student student) {
		List<Student> studentList = studentService.getStudentList(student);
		studentList.forEach(oneStudent -> {
			int studentHack = Optional.ofNullable(oneStudent.getStudent_hack()).orElse(0);
			String grade = StudentHack.getDescriptionByValue(studentHack);
			oneStudent.setStudent_hack_str(grade);
		});
		return studentList;
	}

	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, Student student, HttpServletRequest request) throws AuthException {
		if(student.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			model.addAttribute("student", studentService.copyObjectPaging(student, studentService.getStudentOne(student)));
		} else {
			checkAuth("C", model, request);
			model.addAttribute("student", student);
		}
		model.addAttribute("teach", teachService.getTeachOne(new Teach(student.getHomepage_id(), student.getGroup_idx(), student.getCategory_idx(), student.getTeach_idx())));
		model.addAttribute("statusCode", codeService.getCode("CMS", "C0005"));
		model.addAttribute("hakList", codeService.getCode("CMS", "C0020"));
		model.addAttribute("traingLocationList", codeService.getCode("CMS", "C0022"));

		//약관선택
		model.addAttribute("termsList", termsService.getTermsListByTeach(new Teach(student.getHomepage_id(), student.getGroup_idx(), student.getCategory_idx(), student.getTeach_idx())));

		return basePath + "edit_ajax";
	}

	@RequestMapping(value = {"/checkId.*"}, method = RequestMethod.GET)
	public @ResponseBody JsonResponse checkId(Model model, Student student, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);

		Member member = new Member();
		member.setMember_id(student.getMember_id());

		res.setData(MemberAPI.checkDupUser("0", member));

		return res;
	}

	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Model model, Student student, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		Teach teachOne = teachService.getTeachOne(new Teach(student.getHomepage_id(), student.getGroup_idx(), student.getCategory_idx(), student.getTeach_idx()));

		if ( !student.getEditMode().equals("DELETE") && !student.getEditMode().equals("CANCEL") && !student.getEditMode().equals("SAVELIST")
				&& !student.getEditMode().equals("BATCH_DELETE") && !student.getEditMode().equals("BATCH_CANCEL") ) {
			if ( student.getEditMode().equals("ADD") ) {
//				ValidationUtils.rejectIfEmpty(result, "member_id", "신청자ID를 입력하세요.");
//				ValidationUtils.rejectIfEmpty(result, "member_key", "ID 확인을 해주세요.");
			}

			ValidationUtils.rejectIfEmpty(result, "applicant_name", "신청자명을 입력하세요.");
			ValidationUtils.rejectNumbers(result, "applicant_name", "신청자명에는 숫자를 입력할 수 없습니다.");
			
			if (StringUtils.equals(teachOne.getBirth_yn(), "Y")) {
				ValidationUtils.rejectIfEmpty(result, "applicant_birth", "신청자 생년월일을 입력하세요.");
			}
//			ValidationUtils.rejectIfEmpty(result, "applicant_birth", "신청자 생년월일을 입력하세요.");
//			ValidationUtils.rejectIfEmpty(result, "applicant_sex", "신청자 성별을 선택하세요.");
//			ValidationUtils.rejectIfEmpty(result, "applicant_zipcode", "신청자 우편번호를 입력하세요.");
//			ValidationUtils.rejectIfEmpty(result, "applicant_address", "신청자 주소를 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "applicant_cell_phone", "신청자 휴대전화번호를 입력하세요.");
			ValidationUtils.rejectPhone(result, "applicant_cell_phone", "폰번호 형식이 잘못되었습니다.");

			ValidationUtils.rejectIfEmpty(result, "student_name", "수강생명을 입력하세요.");
			ValidationUtils.rejectNumbers(result, "student_name", "수강생명에는 숫자를 입력할 수 없습니다.");
//			ValidationUtils.rejectIfEmpty(result, "student_birth", "수강생 생년월일을 입력하세요.");
//			ValidationUtils.rejectIfEmpty(result, "student_sex", "수강생 성별을 선택하세요.");
//			ValidationUtils.rejectIfEmpty(result, "student_zipcode", "수강생 우편번호를 입력하세요.");
//			ValidationUtils.rejectIfEmpty(result, "student_address", "수강생 주소를 입력하세요.");

			ValidationUtils.rejectIfStringLength(result, "student_name", 50, "수강생명");
//			ValidationUtils.rejectIfStringLength(result, "student_address", 200, "수강생 주소");
			ValidationUtils.rejectIfStringLength(result, "student_name", 50, "수강생명");

			ValidationUtils.rejectIfStringLength(result, "applicant_name", 50, "신청자명");

//			ValidationUtils.rejectIfStringLength(result, "applicant_address", 200, "신청자 주소");

			ValidationUtils.rejectIfStringLength(result, "applicant_cell_phone", 13, "신청자 휴대전화번호");


			if ( student.getEditMode().equals("ADD") && student.getSelf_info_yn().equals("N") ) {
				res.setValid(false);
				res.setMessage("개인정보 미동의 시 참여 하실수 없습니다.");
				return res;
			}

			if ( student.getEditMode().equals("ADD") ) {
				String resultMsg = studentService.checkStudent(student);
				if ( resultMsg != null ) {
					res.setValid(false);
					res.setMessage(resultMsg);
					return res;
				}
			}
		}

		if(!result.hasErrors()) {
			if(student.getEditMode().equals("ADD")) {
				student.setAdd_id(getSessionMemberId(request));
				if (StringUtils.isNotEmpty(student.getStudent_password())) {
					student.setStudent_password(CalculateHashUtils.calculateHash(student.getStudent_password()));
				}
				Object[] addResult = studentService.addStudent(student, "CMS");
				res.setValid((Boolean) addResult[0]);
				res.setMessage((String) addResult[1]);
			}else if(student.getEditMode().equals("MODIFY")) {
				student.setModify_id(getSessionMemberId(request));
				if (StringUtils.isNotEmpty(student.getStudent_password())) {
					student.setStudent_password(CalculateHashUtils.calculateHash(student.getStudent_password()));
				}
				studentService.modifyStudent(student);
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			} else if(student.getEditMode().equals("DELETE")) {
				studentService.deleteStudent(student);
				//teachBookService.deleteTeachBookByStudent(student);
				res.setValid(true);
				res.setMessage("삭제 되었습니다.");
			} else if (student.getEditMode().equals("CANCEL")) {
				student.setCancel_id(getSessionMemberId(request));
				studentService.cancelStudent(student);
				res.setValid(true);
				res.setMessage("취소되었습니다.");
			} else if (student.getEditMode().equals("SAVELIST")) {
				List<Student> studentList = student.getStudentList();
				for ( int i = 0; i < studentList.size(); i ++ ) {
					Student one = studentList.get(i);
					one.setHomepage_id(student.getHomepage_id());
					one.setGroup_idx(student.getGroup_idx());
					one.setCategory_idx(student.getCategory_idx());
					one.setTeach_idx(student.getTeach_idx());
					one.setAdd_id(getSessionMemberId(request));
					if (StringUtils.isEmpty(one.getMember_id())) {
						one.setMember_id("ANONYMOUS");
					}
					studentList.set(i, one);

					Member studentMember = new Member();
					studentMember.setUser_id(one.getMember_id());
//					studentMember.setCheck_certify_type("WEBID");
//					studentMember.setCheck_certify_data(one.getMember_id());
//					Map<String, String> memberInfo = MemberAPI.getMemberCertify("WEB", studentMember);

//					if ( memberInfo != null ) {
//						String web_id 	= memberInfo.get("WEB_ID");
//						String seq_no 	= memberInfo.get("SEQ_NO");
//
////						one.setMember_id(web_id);
//						one.setMember_key(seq_no);
//						one.setWeb_id(web_id);
//						one.setMember_id(memberInfo.get("USER_ID"));
//					}
//					else {

//						memberInfo = MemberAPI.getDupUser("WEB", studentMember, "0002", one.getMember_id());
//						if ( memberInfo != null && !memberInfo.isEmpty()) {
//							String web_id 	= memberInfo.get("WEB_ID");
//							String seq_no 	= memberInfo.get("SEQ_NO");
//
////							one.setMember_id(web_id);
//							one.setMember_key(seq_no);
//							one.setWeb_id(web_id);
//							one.setMember_id(memberInfo.get("USER_ID"));
//						}
//						else {
//							res.setMessage(String.format("(ERROR) %s번째 신청자 : 해당 ID는 유효한 회원이 아닙니다.", i+1));
//							res.setValid(false);
//							return res;
//						}
//						res.setMessage(String.format("(ERROR) %s번째 신청자 : 해당 ID는 유효한 회원이 아닙니다.", i+1));
//						res.setValid(false);
//						return res;
//					}

					String resultMsg = studentService.checkValidation(one) ;
					if ( resultMsg != null ) {
						res.setValid(false);
						res.setMessage(String.format("(ERROR) %s번째 신청자 : %s", i+1, resultMsg));
						return res;
					}
				}

				List<String> resultMsg = new ArrayList<String>();
				for ( int j = 0; j < studentList.size(); j ++ ) {
					Student one = studentList.get(j);

					Object[] addResult = studentService.addStudent(one, "CMS");
					resultMsg.add(String.format("%s번째 : %s", j+1, addResult[1]));
				}
				res.setValid(false);
				res.setMessage(StringUtils.join(resultMsg, "\n"));
			} else if (student.getEditMode().equals("BATCH_DELETE")) {
				studentService.batchDeleteStudent(student);
				//teachBookService.deleteTeachBookByStudent(student);
				res.setValid(true);
				res.setMessage("삭제 되었습니다.");
			} else if (student.getEditMode().equals("BATCH_CANCEL")) {
				student.setCancel_id(getSessionMemberId(request));
				studentService.batchCancelStudent(student);
				res.setValid(true);
				res.setMessage("취소되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	@RequestMapping(value = {"/certificate.*"})
	public String certificate(Model model, Student student, HttpServletRequest request) {

		model.addAttribute("certificateInfo", studentService.getCertificateInfo(student));

		return basePath + "certificate_ajax";
	}

	@RequestMapping(value = { "/excelDownload.*" }, method = RequestMethod.POST)
	public StudentSearchView excel(Model model, Student student, HttpServletRequest request, HttpServletResponse response) throws Exception {
		model.addAttribute("teach", teachService.getTeachOne(new Teach(student.getHomepage_id(), student.getGroup_idx(), student.getCategory_idx(), student.getTeach_idx())));
		model.addAttribute("student", student);
		model.addAttribute("studentResult", studentService.getStudentListAll(student));

		// 약관 연동
		Terms t = new Terms(97);
		t.setHomepage_id(student.getHomepage_id());
		model.addAttribute("termsList", termsService.getTermsListInModule(t));

		return new StudentSearchView();
	}

	@RequestMapping(value = {"/csvDownload.*"}, method = RequestMethod.POST)
	public void csv(Model model, Student student, HttpServletRequest request, HttpServletResponse response) {
		List<Student> teachList = studentService.getStudentListAll(student);
		Teach teach = teachService.getTeachOne(new Teach(student.getHomepage_id(), student.getGroup_idx(), student.getCategory_idx(), student.getTeach_idx()));

//		model.addAttribute("student", student);
//		model.addAttribute("studentResult", studentService.getStudentListAll(student));

		// 약관 연동
		Terms t = new Terms(97);
		t.setHomepage_id(student.getHomepage_id());
		List<Terms> termsList = termsService.getTermsListInModule(t);

		new StudentXlsToCsv(teachList, "Student.csv", teach, termsList, request, response);
	}

	@RequestMapping(value = {"/excelUpload.*"}, method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> excelUpload(Model model, Student student, HttpServletRequest request, XlsUpload excel) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		Teach teachOne = teachService.getTeachOne(new Teach(student.getHomepage_id(), student.getGroup_idx(), student.getCategory_idx(), student.getTeach_idx()));
		
		//약관선택
		List<Terms> termsList = termsService.getTermsListByTeach(new Teach(student.getHomepage_id(), student.getGroup_idx(), student.getCategory_idx(), student.getTeach_idx()));
		List<Student> list = studentService.excelUpload(student, termsList, excel, teachOne );

		result.put("studentList", list);
//			List<String> resultMsg = new ArrayList<String>();

//			int count = 1;

			/*for ( Student one : list ) {
				one.setHomepage_id(student.getHomepage_id());
				one.setGroup_idx(student.getGroup_idx());
				one.setCategory_idx(student.getCategory_idx());
				one.setTeach_idx(student.getTeach_idx());

				resultMsg.add(String.format("%s번째 : %s", count, studentService.addStudent(one, "CMS")));
				count += 1;
			}*/

		return result;
	}

	@RequestMapping(value = {"/excelDownloadSample.*"}, method = RequestMethod.GET)
	public void excelDownloadSample(Model model, Student student, HttpServletRequest request, HttpServletResponse response) throws Exception{
		//약관선택
		List<Terms> termsList = termsService.getTermsListByTeach(new Teach(student.getHomepage_id(), student.getGroup_idx(), student.getCategory_idx(), student.getTeach_idx()));

		Teach teachOne = teachService.getTeachOne(new Teach(student.getHomepage_id(), student.getGroup_idx(), student.getCategory_idx(), student.getTeach_idx()));
		Download down = new Download( request, response, "수강생등록Sample.xls" );
		studentService.writeExcelDataSample( down.getOutputStream(), termsList, teachOne );
		down.close();
	}

	@RequestMapping(value = "/download/{homepage_id}/{group_idx}/{category_idx}/{teach_idx}/{student_idx}.*", method = RequestMethod.GET)
	@ResponseBody
    public ResponseEntity<byte[]> getFile(@PathVariable("homepage_id") String homepage_id, @PathVariable("group_idx") int group_idx, @PathVariable("category_idx") int category_idx, @PathVariable("teach_idx") int teach_idx, @PathVariable("student_idx") int student_idx, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	Student student = new Student(homepage_id, group_idx, category_idx, teach_idx);
    	student.setStudent_idx(student_idx);
    	student = studentService.getStudentFileOne(student);

		HttpHeaders responseHeaders = new HttpHeaders();
		byte[] bytes = null;

		if(student == null) {
			responseHeaders.setContentType(MediaType.valueOf("text/html"));
			studentService.alertMessage("파일이 존재하지 않습니다.", request, response);
			return null;
		}

		String filePath = studentService.getRootPath()+ "/" + homepage_id + "/" + student.getServer_file_name();
		File file = new File(filePath);

		if(file.length() > 0) {
			bytes = FileCopyUtils.copyToByteArray(file);
		} else {
			responseHeaders.setContentType(MediaType.valueOf("text/html"));
			teachService.alertMessage("파일이 존재하지 않습니다.", request, response);
			return null;
		}

		String fileName = String.format("%s.%s", student.getOrg_file_name(),student.getFile_extension() );
		String fileType = student.getFile_extension().toUpperCase();

		responseHeaders.set("Content-Disposition", AttachmentUtils.getContentDisposition(fileName, request.getHeader("user-agent")));
		responseHeaders.setPragma("no-cache;");
		responseHeaders.setExpires(-1);
		responseHeaders.setContentType(MediaType.valueOf(AttachmentUtils.getContentType(fileType)));
		responseHeaders.setContentLength(bytes.length);

	    return new ResponseEntity<byte[]>(bytes, responseHeaders, HttpStatus.OK);
    }

}