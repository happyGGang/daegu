package kr.go.gbelib.app.cms.module.teach.teachCode2;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import kr.co.whalesoft.app.cms.code.Code;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;

@Controller
@RequestMapping(value = {"/cms/module/teach/teachCode2"})
public class TeachCode2Controller extends BaseController {

	private final String basePath = "/cms/module/teach/teachCode2/";

	@Autowired
	private TeachCode2Service service;
	
	@RequestMapping(value = {"/index.*"})
	public String index(Model model, TeachCode2 category, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		category.setHomepage_id(getAsideHomepageId(request));	
		
		int count = service.getCategoryListCnt(category);
		model.addAttribute("category", category);
		model.addAttribute("categoryListCount", count);
		model.addAttribute("categoryList", service.getCategoryList(category));
		
		return basePath + "index";
	}
	
	@RequestMapping(value = {"/getSubcategories.*"}, method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> getSubcategories(Model model, TeachCode2 category, BindingResult result, HttpServletRequest request) {
		List<TeachCode2> subcategories = service.getSubcategories(category);
		
		return makeMap(subcategories);
	}
	
	private Map<String, Object> makeMap(Object object) {
		Map<String, Object> data = new HashMap<String, Object>();
		
		if(object == null) {
			data.put("data", new ArrayList<Code>());
		} else {
			data.put("data", object);
		}
		
		return data;
	}
	
	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Model model, TeachCode2 category, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		String editMode = category.getEditMode();
		if(!editMode.equals("DELETE")) {
			ValidationUtils.rejectIfEmpty(result, "code_name", "분류명을 입력하세요.");
		}
		if(!result.hasErrors()) {
//			if ( Integer.parseInt(getSessionMemberInfo(request).getAuth_id()) <= 200 ) {
				if(editMode.equals("ADD")) {
					category.setAdd_id(getSessionMemberId(request));
					if(service.nameDupCheck(category) > 0) {
						res.setValid(false);
						res.setMessage("분류명이 중복됩니다.");
					} else {
						service.addCategory(category);
						res.setValid(true);
						res.setMessage("등록되었습니다.");
						res.setData(category);
					}
				} else if(editMode.equals("MODIFY")) {
					category.setMod_id(getSessionMemberId(request));
					if(service.nameDupCheck(category) > 0) {
						res.setValid(false);
						res.setMessage("분류명이 중복됩니다.");
					} else {
						service.modifyCategory(category);
						res.setValid(true);
						res.setMessage("수정되었습니다.");
						res.setData(category);
					}
				} else if(editMode.equals("DELETE")) {
					if(service.subCategoryCheck(category) > 0) {
						res.setValid(false);
						res.setMessage("하위 분류가 존재하므로 삭제할 수 없습니다.");
					} else {
						service.deleteCategory(category);
						res.setValid(true);
						res.setMessage("삭제되었습니다.");
						res.setData(category);
					}
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
	
	@RequestMapping(value = {"/saveList.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse saveList(Model model, @RequestBody TeachCode2[] cateList, HttpServletRequest request) {
		
		JsonResponse res = new JsonResponse(request);
		
//		if ( Integer.parseInt(getSessionMemberInfo(request).getAuth_id()) <= 200 ) {
			if(cateList == null || cateList.length == 0) {
				res.setValid(false);
				res.setMessage("저장할 분류가 없습니다.");
			} else {
				for(TeachCode2 cate: cateList) {
					cate.setMod_id(getSessionMemberId(request));
				}
				service.saveCategoryList(cateList);
				res.setValid(true);
				res.setMessage("저장되었습니다.");
			}
//		} else {
//			res.setValid(false);
//			res.setMessage("권한이 없습니다.");
//		}
		
		return res;
	}
}