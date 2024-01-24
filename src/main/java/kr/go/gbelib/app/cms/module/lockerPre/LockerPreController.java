package kr.go.gbelib.app.cms.module.lockerPre;

import java.text.SimpleDateFormat;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.cms.module.locker.Locker;
import kr.go.gbelib.app.cms.module.locker.LockerService;

@Controller
@RequestMapping(value = { "/cms/module/locker/pre" })
public class LockerPreController extends BaseController {

	private final String basePath = "/cms/module/locker/pre/";

	@Autowired
	private LockerPreService service;

	@Autowired
	private LockerService lockerService;

	@RequestMapping(value = { "/index.*" })
	public String index(Model model, LockerPre LockerPre, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		LockerPre.setHomepage_id(getAsideHomepageId(request));

		int count = service.getLockerPreCount(LockerPre);
		service.setPaging(model, count, LockerPre);
		model.addAttribute("LockerPre", LockerPre);
		model.addAttribute("LockerPreCount", count);
		model.addAttribute("LockerPreList", service.getLockerPre(LockerPre));

		return basePath + "index_ajax";
	}

	@RequestMapping(value = { "/edit.*" })
	public String edit(Model model, LockerPre LockerPre, HttpServletRequest request) throws AuthException {
		if (LockerPre.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);	
			model.addAttribute("lockerPre", service.copyObjectPaging(LockerPre, service.getLockerPreOne(LockerPre)));
		} else {
			checkAuth("C", model, request);	
			model.addAttribute("lockerPre", LockerPre);
		}

		return basePath + "edit_ajax";
	}

	@RequestMapping(value = { "/save.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Model model, LockerPre lockerPre, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		String editMode = lockerPre.getEditMode();
		
		if(!lockerPre.getEditMode().equals("DELETE")) {
			ValidationUtils.rejectIfEmpty(result, "locker_pre_name", "구분명을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "locker_pre_type", "배정방법을 선택하세요.");
			ValidationUtils.rejectIfEmpty(result, "apply_start_date", "접수 시작일자를 선택하세요.");
			ValidationUtils.rejectIfEmpty(result, "apply_start_time", "접수 시작시간을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "apply_end_date", "접수 종료일자를 선택하세요.");	
			ValidationUtils.rejectIfEmpty(result, "apply_end_time", "접수 종료시간을 입력하세요.");	
			ValidationUtils.rejectIfEmpty(result, "start_date", "사용기간 시작일자를 선택하세요.");
			ValidationUtils.rejectIfEmpty(result, "end_date", "사용기간 종료일자를 선택하세요.");
			ValidationUtils.rejectIfEmpty(result, "locker_count", "사물함 개수를 입력하세요.");
			
			SimpleDateFormat sfTime = new SimpleDateFormat("HH:mm");
			sfTime.setLenient(false);
			try {
				sfTime.parse(lockerPre.getApply_start_time());
				sfTime.parse(lockerPre.getApply_end_time());
			} catch (Exception e) {
				result.reject("시간입력은 00:00 ~ 23:59 범위 입니다.");
			}
		}
		
		if (!result.hasErrors()) {
			lockerPre.setHomepage_id(getAsideHomepageId(request));
			if (editMode.equals("ADD")) {
				lockerPre.setAdd_id(getSessionMemberId(request));

				int locker_pre_idx = service.lockerPreIdx(lockerPre);
				lockerPre.setLocker_pre_idx(locker_pre_idx);

				service.addLockerPre(lockerPre);

				Locker locker = new Locker();
				locker.setHomepage_id(lockerPre.getHomepage_id());
				locker.setLocker_pre_idx(locker_pre_idx);
				locker.setAdd_id(getSessionMemberId(request));
				locker.setStatus("1");

				for (int i = 0; i < lockerPre.getLocker_count(); i++) {
					locker.setLocker_desc("사물함" + (i + 1));
					locker.setLocker_name("사물함" + (i + 1));

					lockerService.addLocker(locker);
				}

				res.setValid(true);
				res.setMessage("등록 되었습니다.");
			} else if (editMode.equals("MODIFY")) {
				lockerPre.setMod_id(getSessionMemberId(request));
				service.modifyLocekrPre(lockerPre);
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			} else if (editMode.equals("DELETE")) {
				service.deleteLockerPre(lockerPre);
				service.deleteAllLockerPre(lockerPre);
				service.deleteLockerReq(lockerPre);
				res.setValid(true);
				res.setMessage("삭제 되었습니다.");
			}
			else if ( editMode.equals("DELETE-FILE") ) {
				service.deleteFile(lockerPre);
				res.setValid(true);
				res.setMessage("해당 파일이 삭제 되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
}
