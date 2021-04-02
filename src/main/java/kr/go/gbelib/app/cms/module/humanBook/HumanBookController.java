package kr.go.gbelib.app.cms.module.humanBook;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.app.cms.code.CodeService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;

@Controller
@RequestMapping(value = {"/cms/module/humanBook"})
public class HumanBookController extends BaseController {

	private final String basePath = "/cms/module/humanBook/";

	@Autowired
	private HumanBookService service;

	@Autowired
	private CodeService codeService;

	@RequestMapping (value = {"/index.*"}, method = RequestMethod.GET)
	public String index(Model model, HumanBook humanBook, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		humanBook.setHomepage_id(getAsideHomepageId(request));

		service.setPaging(model, service.getHumanBookCount(humanBook), humanBook);

		model.addAttribute("humanBook", humanBook);
		model.addAttribute("humanBookAll", service.getHumanBookAll(humanBook));
		model.addAttribute("activityCateList", codeService.getCode(humanBook.getHomepage_id(), "H0005"));

		return basePath + "index";
	}

	@RequestMapping (value = {"/edit.*"}, method = RequestMethod.GET)
	public String edit(Model model, HumanBook humanBook, HttpServletRequest request) throws AuthException {
//		Homepage homepage = getHomepageOne(humanBook.getHomepage_id());

		if(humanBook.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			model.addAttribute("humanBook", service.copyObjectPaging(humanBook, service.getHumanBookOne(humanBook)));
		} else {
			checkAuth("C", model, request);
			model.addAttribute("humanBook", humanBook);
		}

		model.addAttribute("activityCateList", codeService.getCode(humanBook.getHomepage_id(), "H0005"));

		return basePath + "edit_ajax";
	}

	@RequestMapping (value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(HumanBook humanBook, BindingResult result, HttpServletRequest request) {
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		String editMode = humanBook.getEditMode();
		if (editMode.equals("ADD") || editMode.equals("MODIFY")) {
			ValidationUtils.rejectIfEmpty(result, "teacher_name", "성명은 필수 입력입니다.");
			ValidationUtils.rejectIfEmpty(result, "teacher_birth", "생년월일은 필수 입력입니다.");
			ValidationUtils.rejectIfEmpty(result, "teacher_phone", "휴대폰번호는 필수 입력입니다.");
			ValidationUtils.rejectIfEmpty(result, "teacher_agency", "소속은 필수 입력입니다.");
			ValidationUtils.rejectIfEmpty(result, "teacher_zipcode", "우편번호는 필수 입력입니다.");
			ValidationUtils.rejectIfEmpty(result, "teacher_address", "주소는 필수 입력입니다.");
			ValidationUtils.rejectIfEmpty(result, "activity_day", "활동가능요일을 선택해주세요.");
			ValidationUtils.rejectIfEmpty(result, "activity_time", "활동가능시간을 선택해주세요.");
//			if(humanBook.getActivity_time().equals("3")) {
//				ValidationUtils.rejectIfEmpty(result, "activity_time_txt", "활동가능시간 상시 내용을 입력하세요.");
//			}
//			ValidationUtils.rejectIfEmpty(result, "human_book_title", "휴먼북 제목은 필수 입력입니다.");
			ValidationUtils.rejectIfEmpty(result, "teacher_content", "본인소개는 필수 입력입니다.");

			if(StringUtils.isNotEmpty(humanBook.getTeacher_email())) {
				ValidationUtils.rejectNotFullEmailType(result, "teacher_email", "이메일 형식이 아닙니다.");
			}
			ValidationUtils.rejectPhone(result, "teacher_phone", "휴대폰번호 형식 (01x-xxxx-xxxx) or (01x-xxx-xxxx) 입니다.");
		}
		/* <<<<< 유효성 검증 */

		if (!result.hasErrors()) {
			if (editMode.equals("ADD")) {
				humanBook.setAdd_id(getSessionMemberId(request));
				if(service.addHumanBook(humanBook) > 0) {
					res.setValid(true);
					res.setMessage("등록되었습니다.");
				} else {
					res.setValid(false);
					res.setMessage("도서관에 문의하세요.");
				}
			} else if (editMode.equals("MODIFY")) {
				humanBook.setModify_id(getSessionMemberId(request));
				if(service.modifyHumanBook(humanBook) > 0) {
					res.setValid(true);
					res.setMessage("수정되었습니다.");
				} else {
					res.setValid(false);
					res.setMessage("도서관에 문의하세요.");
				}
			} else if(editMode.equals("STATUS")) {
				service.applyStatus(humanBook);
				String message = "";
				if (humanBook.getApply_status().equals("1")) {
					message = "미승인 되었습니다.";
				} else if(humanBook.getApply_status().equals("2")) {
					message = "승인 되었습니다.";
				} else {
					message = "신청 되었습니다.";
				}
				res.setValid(true);
				res.setMessage(message);
			} else if (humanBook.getEditMode().equals("DELETE")) {
				if(service.deleteHumanBook(humanBook) > 0) {
					res.setValid(true);
					res.setMessage("삭제되었습니다.");
					res.setReload(true);
				} else {
					res.setValid(false);
					res.setMessage("도서관에 문의하세요.");
				}
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

}
