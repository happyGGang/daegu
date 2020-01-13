package kr.go.gbelib.app.cms.module.teach;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.app.cms.code.CodeService;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.app.cms.module.survey.SurveyService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.AttachmentUtils;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.cms.module.category.Category;
import kr.go.gbelib.app.cms.module.category.CategoryService;
import kr.go.gbelib.app.cms.module.category.group.CategoryGroup;
import kr.go.gbelib.app.cms.module.category.group.CategoryGroupService;
import kr.go.gbelib.app.cms.module.teach.student.Student;
import kr.go.gbelib.app.cms.module.teach.student.StudentService;
import kr.go.gbelib.app.cms.module.teach.teachCode.TeachCode;
import kr.go.gbelib.app.cms.module.teach.teachCode.TeachCodeService;
import kr.go.gbelib.app.cms.module.teach.teachCode2.TeachCode2;
import kr.go.gbelib.app.cms.module.teach.teachCode2.TeachCode2Service;
import kr.go.gbelib.app.cms.module.teachSetting.TeachSetting;
import kr.go.gbelib.app.cms.module.teachSetting.TeachSettingService;

@Controller
@RequestMapping(value = { "/cms/module/teach" })
public class TeachController extends BaseController {

	private final String basePath = "/cms/module/teach/";

	@Autowired
	private TeachService teachService;

	@Autowired
	private TeachSettingService teachSettingService;

	@Autowired
	private CategoryGroupService categoryGroupService;

	@Autowired
	private CategoryService categoryService;

	@Autowired
	private StudentService studentService;

	@Autowired
	private HomepageService homepageService;

	@Autowired
	private CodeService codeService;

	@Autowired
	private SurveyService surveyService;

	@Autowired
	private TeachCodeService teachCodeService;

	@Autowired
	private TeachCode2Service teachCode2Service;

	@RequestMapping(value = {"/getTeachList.*"})
	public @ResponseBody Map<String, Object> getTeachList(Model model, Teach teach, HttpServletRequest request) {

		Map<String, Object> result = new HashMap<String, Object>();
		result.put("teachList", teachService.getTeachListAll(teach));
		return result;
	}

	@RequestMapping(value = { "/index.*" })
	public String index(Model model, Teach teach, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
//		if ( !getSessionIsAdmin(request) ) {
			teach.setHomepage_id(getAsideHomepageId(request));
//		}

		int count = teachService.getTeachListCount(teach);
		teachService.setPaging(model, count, teach);
		teach.setTotalDataCount(count);
		model.addAttribute("teach", teach);
		model.addAttribute("teachListCount", count);
		model.addAttribute("teachList", teachService.getTeachList(teach));
		model.addAttribute("categoryGroupList", categoryGroupService.getCategoryGroupListAll(new CategoryGroup(teach.getHomepage_id(), teach.getLarge_category_idx())));
		model.addAttribute("categoryList", categoryService.getCategoryListAll(new Category(teach.getHomepage_id(), teach.getGroup_idx(), teach.getLarge_category_idx())));


		//프로그램 대분류
		model.addAttribute("teachLargeCodeList", teachCodeService.getLargeCodeList());
		//프로그램 중분류
		TeachCode teachCode = new TeachCode();
		teachCode.setLarge_code("A");
		teachCode.setMid_code("01");
		teachCode.setMid_code("01");
		model.addAttribute("teachMidCodeList", teachCodeService.getMidCodeList(teachCode));
		//프로그램 소분류
		model.addAttribute("teachSmallCodeList", teachCodeService.getSmallCodeList(teachCode));

		//프로그램 주제구분
		TeachCode2 teachCode2 = new TeachCode2(1);
		model.addAttribute("teachSubjectCodeList", teachCode2Service.getSubcategories(teachCode2));

		//프로그램 연령구분
		teachCode2.setTeach_code(8);
		model.addAttribute("teachAgeDivCodeList", teachCode2Service.getSubcategories(teachCode2));

		//강좌대분류
		teachCode2.setTeach_code(15);
		model.addAttribute("teachLargeCategoryList", teachCode2Service.getSubcategories(teachCode2));


		return basePath + "index";
	}

	@RequestMapping(value = { "/edit.*" })
	public String edit(Model model, Teach teach, HttpServletRequest request) throws AuthException {

		List<CategoryGroup> categoryGroupListAll = categoryGroupService.getCategoryGroupListAll(new CategoryGroup(teach.getHomepage_id()));

		model.addAttribute("categoryGroupList", categoryGroupListAll);
//		model.addAttribute("categoryList", categoryService.getCategoryListAll(new Category(teach.getHomepage_id())));
		if (categoryGroupListAll != null && categoryGroupListAll.size() > 0) {
			model.addAttribute("categoryList", categoryService.getCategoryList(new Category(teach.getHomepage_id(), categoryGroupListAll.get(0).getGroup_idx())));
		}
		model.addAttribute("cellPhoneCode", codeService.getCode(teach.getHomepage_id(), "C0002"));
		model.addAttribute("phoneCode", codeService.getCode(teach.getHomepage_id(), "C0003"));
		model.addAttribute("surveyList", surveyService.getSurveyAll(teach.getHomepage_id()));

		Teach teachOne = null;
		if (teach.getEditMode().equals("MODIFY") || teach.getEditMode().equals("VIEW")) {
			teachOne = new Teach();
			teachOne = (Teach) teachService.copyObjectPaging(teach,teachService.getTeachOne(teach));
			model.addAttribute("teach", teachOne);
		} else {
			teach.setPrint_seq(teachService.getPrintMaxValue(teach));
			model.addAttribute("teach", teach);
		}


		//프로그램 대분류
		model.addAttribute("teachLargeCodeList", teachCodeService.getLargeCodeList());
		//프로그램 중분류
		TeachCode teachCode = new TeachCode();
		if (teachOne != null && StringUtils.isNotEmpty(teachOne.getProgram_classification1())) {
			teachCode.setLarge_code(teachOne.getProgram_classification1());
			teachCode.setMid_code(teachOne.getProgram_classification2());
		} else {
			teachCode.setLarge_code("A");
			teachCode.setMid_code("01");
		}
		model.addAttribute("teachMidCodeList", teachCodeService.getMidCodeList(teachCode));
		//프로그램 소분류
		model.addAttribute("teachSmallCodeList", teachCodeService.getSmallCodeList(teachCode));

		//프로그램 주제구분
		TeachCode2 teachCode2 = new TeachCode2(1);
		model.addAttribute("teachSubjectCodeList", teachCode2Service.getSubcategories(teachCode2));

		//프로그램 연령구분
		teachCode2.setTeach_code(8);
		model.addAttribute("teachAgeDivCodeList", teachCode2Service.getSubcategories(teachCode2));

		//강좌대분류
		teachCode2.setTeach_code(15);
		model.addAttribute("teachLargeCategoryList", teachCode2Service.getSubcategories(teachCode2));


		if ( teach.getEditMode().equals("MODIFY") ) {
			checkAuth("U", model, request);
			return basePath + "edit_ajax";
		} else if (teach.getEditMode().equals("VIEW")) {
			checkAuth("R", model, request);
			return "/cms/module/calendarManage/teachEdit_ajax";
		} else {
			checkAuth("C", model, request);
			return basePath + "edit_ajax";
		}
	}

	@RequestMapping(value = { "/setting.*" })
	public String setting(Model model, TeachSetting teachSetting, HttpServletRequest request) {
		TeachSetting oneTeachSetting = teachSettingService.getTeachSettingOne(teachSetting);
		if ( oneTeachSetting != null ) {
			teachSetting = oneTeachSetting;
		}
		model.addAttribute("teachSetting", teachSetting);
		return basePath + "setting_ajax";
	}

	@RequestMapping(value = {"/getSameTeachList.*"})
	public @ResponseBody Map<String, Object> getCategoryList(Model model, Teach teach, HttpServletRequest request) {
		Map<String, Object> result = new HashMap<String, Object>();
		teach.setTeach_name(teach.getTeach_name().trim());
		result.put("sameTeachList", teachService.getSameTeachByName(teach));
		return result;
	}


	@RequestMapping(value = { "/save.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Model model, Teach teach, BindingResult result, HttpServletRequest request) throws ParseException {
		JsonResponse res = new JsonResponse(request);
		String editMode = teach.getEditMode();
		if ( !teach.getEditMode().equals("DELETE") ) {
			ValidationUtils.rejectIfEmpty(result, "teach_name", "강의명을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "teach_stage", "강의장소를 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "use_yn", "사용여부를 선택하세요.");
			ValidationUtils.rejectIfEmpty(result, "certificate_yn","수료증 발급 여부를 선택하세요.");

			ValidationUtils.rejectIfStringLength(result, "teach_name", 100, "강의명");
			ValidationUtils.rejectIfStringLength(result, "teach_desc", 2000, "강의설명");
			ValidationUtils.rejectIfStringLength(result, "teach_etc", 100, "준비물 및 재료비");
			ValidationUtils.rejectIfStringLength(result, "teach_stage", 50, "강의장소");
			ValidationUtils.rejectIfStringLength(result, "teach_target", 200, "강의대상");

			if ( editMode.equals("ADD") || editMode.equals("MODIFY") ) {
				ValidationUtils.rejectIfEmpty(result, "program_age_div_arr","연령구분을 선택해주세요");
				ValidationUtils.rejectIfZero(result, "group_idx", "중분류를 선택해 주세요.");
				ValidationUtils.rejectExceptNumber(result, "teach_limit_count","모집인원은 숫자만 입력 가능 합니다.");
				ValidationUtils.rejectExceptNumber(result, "teach_backup_count","모집후보인원은 숫자만 입력 가능 합니다.");
				ValidationUtils.rejectExceptNumber(result, "teach_offline_count","모집오프라인인원은 숫자만 입력 가능 합니다.");
				ValidationUtils.rejectIfEmpty(result, "start_join_date","강의모집 시작 기간을 선택하세요.");
				ValidationUtils.rejectIfEmpty(result, "end_join_date","강의모집 종료 기간을 선택하세요.");
				ValidationUtils.rejectIfEmpty(result, "start_join_time","강의모집 시작 시간을 입력하세요.");
				ValidationUtils.rejectIfEmpty(result, "end_join_time","강의모집 종료 시간을 입력하세요.");
				ValidationUtils.rejectIfEmpty(result, "start_date","강의시작 기간을 선택하세요.");
				ValidationUtils.rejectIfEmpty(result, "start_time","강의시작 시간을 입력하세요.");
				ValidationUtils.rejectIfEmpty(result, "end_date", "강의종료 기간을 선택하세요.");
				ValidationUtils.rejectIfEmpty(result, "end_time", "강의종료 시간을 입력하세요.");
				ValidationUtils.rejectIfEmpty(result, "teach_day","강의요일을 선택해 주세요.");

				if ( !result.hasErrors() ) {

					if ( teach.getTeach_join_limit_unit().indexOf("SEX") != -1 || teach.getTeach_join_limit_unit().indexOf("OLD") != -1) {
						if ( teach.getTeach_join_limit_value() == null ) {
							result.reject("접수 제한 값을 설정해주세요.");
						}

						if ( StringUtils.isNotEmpty(teach.getTeach_join_limit_unit()) && StringUtils.isNotEmpty(teach.getTeach_join_limit_value())  ) {
							String[] limitUnit 	= teach.getTeach_join_limit_unit().split(",");
							String[] limitValue = teach.getTeach_join_limit_value().split(",");
							for ( int i = 0; i < limitUnit.length; i ++ ) {
								if ( limitUnit[i].equals("SEX") ) {
									if ( limitValue.length <= i ) {
										result.reject("제한 할 성별을 선택해주세요.");
									}
								}

								if ( limitUnit[i].equals("OLD") ) {
									try {
										int startOld 	= Integer.parseInt(limitValue[i]);
										int endOld		= Integer.parseInt(limitValue[i + 1]);
										if ( startOld > endOld ) {
											result.reject("나이 제한 설정이 올바르지 않습니다.");
										}
									}
									catch (NumberFormatException e1) {
										result.reject("나이 제한 설정 값은 숫자만 입력 가능합니다.");
									}
									catch (IndexOutOfBoundsException e2) {
										result.reject("나이 제한 설정 값을 모두 입력 해주세요.");
									}
								}
							}
						}
					}
				}
			}

			if ( !result.hasErrors() ) {
				SimpleDateFormat sfDate = new SimpleDateFormat("yyyy-MM-dd");

				// 접수일보다 강의 시작일이 빠를수 없다.
				Date start_join_date 	= sfDate.parse(teach.getStart_join_date());
				Date end_join_date 		= sfDate.parse(teach.getEnd_join_date());
				Date start_date 		= sfDate.parse(teach.getStart_date());
				Date end_date 			= sfDate.parse(teach.getEnd_date());
				Date start_cancle_date 	= StringUtils.isNotEmpty(teach.getStart_cancle_date()) ? sfDate.parse(teach.getStart_cancle_date()) : null;

				if ( start_join_date.after(start_date) ) {
					result.reject("접수 시작일은 강좌 시작일보다 빨라야 합니다.");
				}

				if ( end_date.before(end_join_date) ) {
					result.reject("접수 종료일은 강좌 종료일보다 빨라야 합니다.");
				}

				if ( start_cancle_date != null && start_cancle_date.after(start_date) ) {
					result.reject("접수취소 시작일은 강좌 시작일보다 빨라야 합니다.");
				}

				SimpleDateFormat sfTime = new SimpleDateFormat("HH:mm");
				sfTime.setLenient(false);
				try {
					sfTime.parse(teach.getStart_join_time());
					sfTime.parse(teach.getEnd_join_time());
					sfTime.parse(teach.getStart_time());
					sfTime.parse(teach.getEnd_time());
					if(StringUtils.isNotEmpty(teach.getStart_cancle_time()) && StringUtils.isNotEmpty(teach.getEnd_cancle_time())) {
						sfTime.parse(teach.getStart_cancle_time());
						sfTime.parse(teach.getEnd_cancle_time());
					}
				} catch (Exception e) {
					result.reject("시간입력은 00:00 ~ 23:59 범위 입니다.");
				}
			}

			if ( !result.hasErrors() ) {
				if(StringUtils.isNotEmpty(teach.getCancle_guid())) {
					int valueLength = 0;
					try {
						valueLength = teach.getCancle_guid().getBytes("EUC-KR").length;
					} catch ( UnsupportedEncodingException e ) {
						e.printStackTrace();
					}

					if(valueLength > 80) {
						result.reject(String.format("취소 안내 내용에 입력하신 길이가 큽니다. 현재 : %s byte, 제한 : %s byte", valueLength, 80));
					}

				}
			}
		}
		else {
			Teach targetTeach = teachService.getTeachOne(teach);
			// 강좌 삭제시 참여인원, 대기인원, 오프참여 인원이 1명이라도 있으면 삭제 불가.
			if ( targetTeach.getTeach_join_count() > 0 || targetTeach.getTeach_backup_join_count() > 0 || targetTeach.getTeach_off_join_count() > 0 ) {
				result.reject("해당 강좌는 참여/대기/오프 인원이 접수되어있으므로 삭제 불가능 합니다.");
			}
		}

		if ( !result.hasErrors() ) {
			if ( editMode.equals("ADD") ) {
				if ( StringUtils.isNotEmpty(teach.getTeach_name()) ) {
					teach.setTeach_name(teach.getTeach_name().trim());
				}

				teach.setAdd_id(getSessionMemberId(request));
				teachService.addTeach(teach);
				res.setValid(true);
				res.setMessage("등록 되었습니다.");
			} else if ( editMode.equals("MODIFY") ) {
				teach.setModify_id(getSessionMemberId(request));
				teachService.modifyTeach(teach);
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			} else if ( editMode.equals("DELETE") ) {
				teachService.deleteTeach(teach);
				res.setValid(true);
				res.setMessage("삭제 되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	@RequestMapping(value = { "/saveSetting.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse saveSetting(Model model, TeachSetting teachSetting, BindingResult result, HttpServletRequest request) throws ParseException {
		JsonResponse res = new JsonResponse(request);

		ValidationUtils.rejectExceptNumber(result, "term_count", "제한횟수는 숫자만 가능합니다.");

		if ( !result.hasErrors() ) {
			if (StringUtils.equals(teachSetting.getUse_yn(), "Y")) {
				if (teachSetting.getTerm_count() < 2) {
					res.setValid(false);
					res.setMessage("제한횟수는 1보다 큰 수만 가능 합니다.");
					return res;
				}
			}
			teachSettingService.mergeTeachSetting(teachSetting);
			res.setMessage("저장 되었습니다.");
			res.setValid(true);
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	@RequestMapping(value = { "/excelDownload.*" }, method = RequestMethod.POST)
	public TeachSearchView excel(Model model, Teach teach, HttpServletRequest request, HttpServletResponse response) throws Exception {
		model.addAttribute("homepage", homepageService.getHomepageOne(new Homepage(teach.getHomepage_id())));
		model.addAttribute("teach", teach);
		model.addAttribute("teachResult", teachService.getTeachListAll(teach));
		return new TeachSearchView();
	}

	@RequestMapping(value = {"/csvDownload.*"}, method = RequestMethod.POST)
	public void csv(Model model, Teach teach, HttpServletRequest request, HttpServletResponse response) {
		List<Teach> teachList = teachService.getTeachListAll(teach);
		Homepage homepage = homepageService.getHomepageOne(new Homepage(teach.getHomepage_id()));

		model.addAttribute("teach", teach);
		model.addAttribute("teachResult", teachService.getTeachListAll(teach));

		new TeachXlsToCsv(teachList, "Teach.csv", homepage, request, response);
	}

	@RequestMapping(value = "/download/{homepage_id}/{group_idx}/{category_idx}/{teach_idx}.*", method = RequestMethod.GET)
	@ResponseBody
    public byte[] getFile(@PathVariable("homepage_id") String homepage_id, @PathVariable("group_idx") int group_idx, @PathVariable("category_idx") int category_idx, @PathVariable("teach_idx") int teach_idx, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Teach teach = teachService.getTeachOne(new Teach(homepage_id, group_idx, category_idx, teach_idx));
		String filePath = teachService.getRootPath()+ "/" + homepage_id + "/" + teach.getServer_file_name();
		File file = new File(filePath);

		byte[] bytes = null;

		if(file.length() > 0) {
			bytes = FileCopyUtils.copyToByteArray(file);
		} else {
			response.setHeader("Content-type", "text/html");
			teachService.alertMessage("파일이 존재하지 않습니다.", request, response);
			return null;
		}

//		String fileName = "";
		String fileName = String.format("%s.%s", teach.getOrg_file_name(),teach.getFile_extension() );

		response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(fileName, request.getHeader("user-agent")));
		response.setHeader("Content-Length", Long.toString(file.length()));
	    response.setHeader("Content-Transfer-Encoding", "binary");
	    response.setHeader("Content-Type", "application/octet-stream");

	    return bytes;
    }

	@RequestMapping(value = {"/getTeachCertificateList.*"})
	public String getTeachCertificateList(Model model, Teach teach, HttpServletRequest request) {

		model.addAttribute("teachCertificateList", studentService.getTeachCertificateList(new Student(teach.getHomepage_id(), teach.getGroup_idx(), teach.getCategory_idx(), teach.getTeach_idx())));

		return basePath + "teachCertificateList_ajax";
	}

	@RequestMapping(value = {"/getTeachCertificateListByDate.*"})
	public String getTeachCertificateListByDate(Model model, Student student, HttpServletRequest request) {

		model.addAttribute("student", student);
		if ( !student.getEditMode().equals("FIRST") ) {
			model.addAttribute("certStudentList", studentService.getCertificateListByDate(student));
		}

		return basePath + "certStudentList_ajax";
	}

	@RequestMapping(value = { "/deleteFile.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse deleteFile(Model model, Teach teach, BindingResult result, HttpServletRequest request) throws ParseException {
		JsonResponse res = new JsonResponse(request);

		teachService.deleteFile(teach);
		res.setValid(true);
		res.setMessage("파일을 삭제 했습니다.");

		return res;
	}

	@RequestMapping(value = { "/deleteImage.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse deleteImage(Model model, Teach teach, BindingResult result, HttpServletRequest request) throws ParseException {
		JsonResponse res = new JsonResponse(request);

		teachService.deleteImage(teach);
		res.setValid(true);
		res.setMessage("이미지를 삭제 했습니다.");

		return res;
	}

	@RequestMapping (value = { "/getMidCodeList.*" }, method = RequestMethod.GET)
	public @ResponseBody List<TeachCode> getMidCodeList(TeachCode teachCode, HttpServletRequest request) {
		return teachCodeService.getMidCodeList(teachCode);
	}

	@RequestMapping (value = { "/getSmallCodeList.*" }, method = RequestMethod.GET)
	public @ResponseBody List<TeachCode> getSmallCodeList(TeachCode teachCode, HttpServletRequest request) {
		return teachCodeService.getSmallCodeList(teachCode);
	}
}