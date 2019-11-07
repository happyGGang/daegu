package kr.go.gbelib.app.cms.module.elib.code;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;

@Controller
@RequestMapping(value = {"/cms/module/elib/code"})
public class ElibCodeController extends BaseController {
	
	private final String basePath = "/cms/module/elib/code/";
	
	@Autowired
	private ElibCodeService service;
	
	@RequestMapping(value = {"/index.*"}, method = RequestMethod.GET)
	public String index(Model model, ElibCode code, HttpServletRequest request) {
		code.setHomepage_id(getAsideHomepageId(request));
		
		model.addAttribute("code", code);
		model.addAttribute("compList", service.getCompListCms(code));
		
		return basePath + "index";
	}
	
	@RequestMapping(value = {"/edit.*"})
	public String book_edit(Model model, ElibCode code, HttpServletRequest request) {
		code.setHomepage_id(getAsideHomepageId(request));	
		
		if(code.getEditMode().equals("MODIFY")) {
			code =  service.getComp(code);
		}
		
		model.addAttribute("code", code);
		
		return basePath + "edit_ajax";
	}

	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Model model, ElibCode code, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		String editMode = code.getEditMode();
		if(!editMode.equals("DELETE")) {
			ValidationUtils.rejectIfEmpty(result, "com_code", "코드를 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "comp_name", "공급사명을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "type", "콘텐츠 타입을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "user_cnt", "유저수를 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "license_sdate", "사용기간 시작일을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "license_edate", "사용기간 종료일을 입력하세요.");
		}
		if(!result.hasErrors()) {
//			if ( Integer.parseInt(getSessionMemberInfo(request).getAuth_id()) <= 200 ) {
				if(editMode.equals("ADD")) {
					code.setAdd_id(getSessionMemberId(request));
					service.addComp(code);
					res.setValid(true);
					res.setMessage("등록되었습니다.");
				} else if(editMode.equals("MODIFY")) {
					code.setMod_id(getSessionMemberId(request));
					service.modifyComp(code);
					res.setValid(true);
					res.setMessage("수정되었습니다.");
				} else if(editMode.equals("DELETE")) {
					service.deleteComp(code);
					res.setValid(true);
					res.setMessage("삭제되었습니다.");
				}
//			}
//			else {
//				res.setValid(false);
//				res.setMessage("권한이 없습니다.");
//			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}

	@RequestMapping(value = {"/get_providers.*"}, method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> getProviders() {
		List<ElibCode> providers = service.getProviders();
		
		return makeMap(providers);
	}
	
	private Map<String, Object> makeMap(Object object) {
		Map<String, Object> data = new HashMap<String, Object>();
		
		if(object == null) {
			data.put("data", new ArrayList<ElibCode>());
		} else {
			data.put("data", object);
		}
		
		return data;
	}
	
}
