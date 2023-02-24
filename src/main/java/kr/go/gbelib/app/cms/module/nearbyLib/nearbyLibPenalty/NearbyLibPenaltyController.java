package kr.go.gbelib.app.cms.module.nearbyLib.nearbyLibPenalty;

import java.text.ParseException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
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
import kr.go.gbelib.app.cms.module.nearbyLib.NearbyLib;
import kr.go.gbelib.app.cms.module.nearbyLib.NearbyLibService;

@Controller
@RequestMapping(value = {"/cms/module/nearbyLib/nearbyLibPenalty"})
public class NearbyLibPenaltyController extends BaseController {
	
	private final String basePath = "/cms/module/nearbyLib/nearbyLibPenalty/";
	
	@Autowired
	private NearbyLibPenaltyService service;
	
	@Autowired
	private NearbyLibService nearbyLibservice;
	
	@RequestMapping(value = { "/index.*" })
	public String index(Model model, NearbyLibPenalty nearbyLibPenalty, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		
		nearbyLibPenalty.setHomepage_id(getAsideHomepageId(request));
		
		int count = service.getNearbyLibPenaltyCount(nearbyLibPenalty);
		service.setPaging(model, count, nearbyLibPenalty);
		nearbyLibPenalty.setTotalDataCount(count);
		
		List<NearbyLibPenalty> nearbyLibPenaltyList = service.getNearbyLibPenaltyList(nearbyLibPenalty);
		
		model.addAttribute("nearbyLibPenalty", nearbyLibPenalty);
		model.addAttribute("nearbyLibPenaltyCount", count);
		model.addAttribute("nearbyLibPenaltyList", nearbyLibPenaltyList);
		
		return basePath + "index";
	}
	
	@RequestMapping(value = { "/settingEdit.*" })
	public String settingEdit(Model model, NearbyLibPenalty nearbyLibPenalty, HttpServletRequest request) throws AuthException {
		nearbyLibPenalty.setHomepage_id(getAsideHomepageId(request));
		
		nearbyLibPenalty = service.getNearbyLibPenaltySetting(nearbyLibPenalty);
		
		if(nearbyLibPenalty == null) {
			nearbyLibPenalty = new NearbyLibPenalty();
			nearbyLibPenalty.setHomepage_id(getAsideHomepageId(request));
		}
		
		model.addAttribute("nearbyLibPenalty", nearbyLibPenalty);

		return basePath + "settingEdit_ajax";
	}
	
	@RequestMapping (value = {"/saveSetting.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse saveSetting(NearbyLibPenalty nearbyLibPenalty, BindingResult result, HttpServletRequest request) {
		nearbyLibPenalty.setHomepage_id(getAsideHomepageId(request));

		JsonResponse res = new JsonResponse(request);
		
		if (!result.hasErrors()) {
			nearbyLibPenalty.setPenalty_add_id(getSessionMemberId(request));
			nearbyLibPenalty.setPenalty_add_ip(request.getRemoteAddr());
			
			service.addNearbyLibPenaltySetting(nearbyLibPenalty);
			res.setValid(true);
			res.setMessage("저장 되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}
	
	@RequestMapping (value = {"/modifySetting.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse modifySetting(NearbyLibPenalty nearbyLibPenalty, BindingResult result, HttpServletRequest request) {
		nearbyLibPenalty.setHomepage_id(getAsideHomepageId(request));
		
		JsonResponse res = new JsonResponse(request);
		
		if (!result.hasErrors()) {
			service.modifyNearbyLibPenaltySetting(nearbyLibPenalty);
			res.setValid(true);
			res.setMessage("수정 되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}
	
	@RequestMapping(value = { "/edit.*" })
	public String edit(Model model, NearbyLibPenalty nearbyLibPenalty, HttpServletRequest request) throws AuthException {
		nearbyLibPenalty.setHomepage_id(getAsideHomepageId(request));
		nearbyLibPenalty.setEditMode("MODIFY");
		nearbyLibPenalty = service.getNearbyLibPenaltyMember(nearbyLibPenalty);
		
		if(nearbyLibPenalty == null) {
			nearbyLibPenalty = new NearbyLibPenalty();
			nearbyLibPenalty.setEditMode("ADD");
			nearbyLibPenalty.setHomepage_id(getAsideHomepageId(request));
		}

		model.addAttribute("nearbyLibPenalty", nearbyLibPenalty);

		return basePath + "edit_ajax";
	}
	
	@RequestMapping (value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(NearbyLibPenalty nearbyLibPenalty, BindingResult result, HttpServletRequest request) throws ParseException {
		JsonResponse res = new JsonResponse(request);
		
		if (!result.hasErrors()) {
			nearbyLibPenalty.setPenalty_count(1);
			if(StringUtils.isEmpty(nearbyLibPenalty.getPenalty_reason())) {
				nearbyLibPenalty.setPenalty_reason("없음");
			}
			
			nearbyLibPenalty.setPenalty_add_id(getSessionMemberId(request));
			nearbyLibPenalty.setPenalty_add_ip(request.getRemoteAddr());
			
			service.addNearbyLibPenaltyMember(nearbyLibPenalty);
			res.setValid(true);
			res.setMessage("등록 되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}
	
	@RequestMapping (value = {"/modify.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse modify(NearbyLibPenalty nearbyLibPenalty, BindingResult result, HttpServletRequest request) {
		nearbyLibPenalty.setHomepage_id(getAsideHomepageId(request));
		
		JsonResponse res = new JsonResponse(request);
		
		if (!result.hasErrors()) {
			service.modifyNearbyLibPenaltyMember(nearbyLibPenalty);
			res.setValid(true);
			res.setMessage("수정 되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}
	
	@RequestMapping (value = {"/delete.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse delete(NearbyLibPenalty nearbyLibPenalty, BindingResult result, HttpServletRequest request) {
		nearbyLibPenalty.setHomepage_id(getAsideHomepageId(request));
		
		JsonResponse res = new JsonResponse(request);
		
		if (!result.hasErrors()) {
			nearbyLibPenalty.setPenalty_modify_id(getSessionMemberId(request));
			nearbyLibPenalty.setPenalty_modify_ip(request.getRemoteAddr());
			
			service.deleteNearbyLibPenaltyMember(nearbyLibPenalty);
			res.setValid(true);
			res.setMessage("삭제 되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}
	
	@RequestMapping(value = {"/searchMember.*"})
	public String searchMember(Model model, NearbyLib nearbyLib, NearbyLibPenalty nearbyLibPenalty, HttpServletRequest request) {
		String member_id = nearbyLibPenalty.getPenalty_member_id();
		
		if(StringUtils.isEmpty(nearbyLib.getSearch_type())) {
			nearbyLib.setSearch_type("member_id");
			nearbyLib.setSearch_text(member_id);
		}
		
		nearbyLibservice.setPaging(model, nearbyLibservice.getNeighborhoodLibraryCount(nearbyLib), nearbyLib);
		
		model.addAttribute("nearbyLib", nearbyLib);
		model.addAttribute("nearbyLibList", nearbyLibservice.getNeighborhoodLibraryListAll(nearbyLib));
		
		return basePath + "searchMember_ajax";
	}
}
