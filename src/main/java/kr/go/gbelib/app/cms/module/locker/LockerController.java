package kr.go.gbelib.app.cms.module.locker;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
import kr.go.gbelib.app.cms.module.lockerPre.LockerPre;
import kr.go.gbelib.app.cms.module.lockerPre.LockerPreService;

@Controller
@RequestMapping(value = { "/cms/module/locker" })
public class LockerController extends BaseController {

	private final String basePath = "/cms/module/locker/";

	@Autowired
	private LockerService service;

	@Autowired
	private LockerPreService lockerPreService;

	@RequestMapping(value = { "/index.*" })
	public String index(Model model, Locker locker, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
//		if ( !getSessionIsAdmin(request) ) { 
			locker.setHomepage_id(getAsideHomepageId(request));
//		}

		LockerPre lockerPre = new LockerPre();
		lockerPre.setHomepage_id(locker.getHomepage_id());
		lockerPre.setLocker_pre_idx(locker.getLocker_pre_idx());

		int count = service.getLockerCount(locker);
		
		List<LockerPre> lockerPreList = lockerPreService.getLockerPreAll(lockerPre);
		
		service.setPaging(model, count, locker);
		locker.setTotalDataCount(count);
		model.addAttribute("locker", locker);
		model.addAttribute("lockerCount", count);
		model.addAttribute("lockerList", service.getLockerAll(locker));
		model.addAttribute("lockerPreList",lockerPreList);
		model.addAttribute("lockerPreCount",lockerPreList.size());

		return basePath + "index";
	}
	
	@RequestMapping(value = {"/excelDownload.*"}, method = RequestMethod.POST)
	public LockerSearchView excel(Model model, Locker locker, HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		model.addAttribute("locker", locker); 		
		model.addAttribute("lockerResult", service.getLockerAllByExcel(locker));
		return new LockerSearchView();
	}
	
	@RequestMapping(value = {"/csvDownload.*"}, method = RequestMethod.POST)
	public void csv(Model model, Locker locker, HttpServletRequest request, HttpServletResponse response) throws Exception{
		List<Locker> lockerList = service.getLockerAllByExcel(locker);
		
		new LockerXlsToCsv(lockerList, "사물함현황 리스트.csv", request, response);
	}

	@RequestMapping(value = { "/edit.*" })
	public String edit(Model model, Locker locker, HttpServletRequest request) throws AuthException {
		if (locker.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			model.addAttribute("locker",service.copyObjectPaging(locker,service.getLockerOne(locker)));
		} else {
			checkAuth("C", model, request);
			model.addAttribute("locker", locker);
		}

		return basePath + "edit_ajax";
	}

	@RequestMapping(value = { "/save.*" }, method = RequestMethod.POST)
	public @ResponseBody
	JsonResponse save(Model model, Locker locker, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		String editMode = locker.getEditMode();
		
		if(!locker.getEditMode().equals("DELETE")) {
			ValidationUtils.rejectIfEmpty(result, "locker_name", "사물함명을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "locker_desc", "설명을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "status", "상태값을 선택해주세요.");						
		}
		
		if (!result.hasErrors()) {
			// locker.setHomepage_id(getSessionHomepageId(request));
			if (editMode.equals("ADD")) {
				locker.setAdd_id(getSessionMemberId(request));
				service.addLocker(locker);
				res.setValid(true);
				res.setMessage("등록 되었습니다.");
			} else if (editMode.equals("MODIFY")) {
				locker.setMod_id(getSessionMemberId(request));
				service.modifyLocekr(locker);
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			} else if (editMode.equals("DELETE")) {
				service.deleteLocker(locker);
				res.setValid(true);
				res.setMessage("삭제 되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
}
