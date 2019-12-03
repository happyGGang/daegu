package kr.go.gbelib.app.cms.module.elib.category;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
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
@RequestMapping(value = {"/cms/module/elib/category/{type}"})
public class ElibCategoryController extends BaseController {

	private final String basePath = "/cms/module/elib/category/";

	@Autowired
	private ElibCategoryService service;
	
	@RequestMapping(value = {"/index.*"})
	public String index(Model model, @PathVariable String type, ElibCategory category, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
//		if ( !getSessionIsAdmin(request) ) {
			category.setHomepage_id(getAsideHomepageId(request));	
//		}
		
		category.setType(type);
		
		int count = service.getCategoryListCnt(category);
		model.addAttribute("category", category);
		model.addAttribute("categoryListCount", count);
		model.addAttribute("categoryList", service.getCategoryList(category));
		
		return basePath + "index";
	}
	
	@RequestMapping(value = {"/getCategories.*"}, method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> getCategories(Model model, ElibCategory category, BindingResult result, HttpServletRequest request) {
		List<ElibCategory> categories = service.getCategoryList(category);
		
		return makeMap(categories);
	}
	
	@RequestMapping(value = {"/getSubcategories.*"}, method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> getSubcategories(Model model, ElibCategory category, BindingResult result, HttpServletRequest request) {
		List<ElibCategory> subcategories = service.getSubcategories(category);
		
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
	public @ResponseBody JsonResponse save(Model model, ElibCategory category, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		String editMode = category.getEditMode();
		if(!editMode.equals("DELETE")) {
			ValidationUtils.rejectIfEmpty(result, "cate_name", "카테고리명을 입력하세요.");
		}
		if(!result.hasErrors()) {
//			if ( Integer.parseInt(getSessionMemberInfo(request).getAuth_id()) <= 200 ) {
				if(editMode.equals("ADD")) {
					category.setAdd_id(getSessionMemberId(request));
					if(service.nameDupCheck(category) > 0) {
						res.setValid(false);
						res.setMessage("카테고리명이 중복됩니다.");
					} else {
						service.addCategory(category);
						res.setValid(true);
						res.setMessage("등록되었습니다.");
						res.setData(category);
					}
				} else if(editMode.equals("MODIFY")) {
					category.setModify_id(getSessionMemberId(request));
					if(service.nameDupCheck(category) > 0) {
						res.setValid(false);
						res.setMessage("카테고리명이 중복됩니다.");
					} else {
						service.modifyCategory(category);
						res.setValid(true);
						res.setMessage("수정되었습니다.");
						res.setData(category);
					}
				} else if(editMode.equals("DELETE")) {
					if(service.subCategoryCheck(category) > 0) {
						res.setValid(false);
						res.setMessage("하위 카테고리가 존재하므로 삭제할 수 없습니다.");
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
	public @ResponseBody JsonResponse saveList(Model model, @RequestBody ElibCategory[] cateList, HttpServletRequest request) {
		
		JsonResponse res = new JsonResponse(request);
		
//		if ( Integer.parseInt(getSessionMemberInfo(request).getAuth_id()) <= 200 ) {
			if(cateList == null || cateList.length == 0) {
				res.setValid(false);
				res.setMessage("저장할 카테고리가 없습니다.");
			} else {
				for(ElibCategory cate: cateList) {
					cate.setModify_id(getSessionMemberId(request));
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