package kr.go.gbelib.app.cms.module.readingNotes;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.app.cms.menu.Menu;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;

@Controller
@RequestMapping(value = {"/cms/module/readingNotes"})
public class ReadingNotesController extends BaseController {

	private final String basePath = "/cms/module/readingNotes/";
	
	@Autowired
	private ReadingNotesService service;
	
	@RequestMapping (value = {"index.*"})
	public String index (Model model, ReadingNotes readingNotes, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		
		readingNotes.setHomepage_id(getAsideHomepageId(request));
		readingNotes.setApprove_status("");
		
		service.setPaging(model, service.getReadingNotesCount(readingNotes), readingNotes);
		model.addAttribute("readingNotesList", service.getReadingNotesList(readingNotes));
		model.addAttribute("readingNotes", readingNotes);

		return basePath + "index";
	}
	
	@RequestMapping (value = {"edit.*"})
	public String edit (Model model, ReadingNotes readingNotes, HttpServletRequest request) throws AuthException {
		if (readingNotes.getEditMode().equals("ADD")) {
			checkAuth("C", model, request);
		} else if (readingNotes.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
		}
		return null;
	}
	
	@RequestMapping (value = {"save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(ReadingNotes readingNotes, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		/************** 유효성 검증 **************/
		if (readingNotes.getEditMode().equals("MODIFYSTATUSONE")) {
			ValidationUtils.rejectIfEmpty(result, "member_id", "아이디를 선택해 주세요.");
			ValidationUtils.rejectIfEmpty(result, "approve_status_replace", "승인상태를 선택해 주세요.");
			if(readingNotes.getApprove_status_replace().equals("N")) {
				ValidationUtils.rejectIfEmpty(result, "cancel_reason_replace", "반려 사유를 입력해 주세요.");
			}
		} else if (readingNotes.getEditMode().equals("MODIFYSTATUS")) {
			if (readingNotes.getReading_notes_idx_arr().length == 0) {
				result.reject("일지를 선택해 주세요.");
			}
			
			if (readingNotes.getMember_id_arr().length == 0) {
				result.reject("일지를 선택해 주세요.");
			}
			
			if (readingNotes.getApprove_status_arr().length == 0) {
				result.reject("일지를 선택해 주세요.");
			} else {
				for (int i = 0; i < readingNotes.getApprove_status_arr().length; i++) {
					if (readingNotes.getApprove_status_modify().equals("N")) {
						if (readingNotes.getCancel_reason_arr().length == 0) {
							result.reject("선택한 " + (i + 1) + "번째 일지의 반려 사유를 입력해 주세요.");
						} else {
							if (readingNotes.getCancel_reason_arr()[i].equals("")) {
								result.reject("선택한 " + (i + 1) + "번째 일지의 반려 사유를 입력해 주세요.");
							}
						}
					}
				}
			}
			
		}
		/************************************/
		
		if (!result.hasErrors()) {
			if (readingNotes.getEditMode().equals("MODIFYSTATUSONE")) {
				service.modifyReadingNotesStatusOne(readingNotes);
				res.setValid(true);
				res.setMessage("수정되었습니다.");
			} else if (readingNotes.getEditMode().equals("MODIFYSTATUS")) {
				service.modifyReadingNotesStatus(readingNotes);
				res.setValid(true);
				res.setMessage("수정되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
	
	@RequestMapping(value = {"/viewReadingNotesExcelDown.*"}) //나의 일지노트 엑셀 다운
	public String viewApplicantExcelDown(Model model, ReadingNotes readingNotes, HttpServletRequest request) {
		
		List<ReadingNotes> readingNotesList = service.getReadingNotesExcelList(readingNotes);
		
		model.addAttribute("readingNotesList", readingNotesList);
		request.setAttribute("readingNotes", readingNotes);
		return basePath + "viewReadingNotesExcelDown_ajax";
	}
}
