package kr.go.gbelib.app.cms.module.category;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
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
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.cms.module.category.group.CategoryGroup;
import kr.go.gbelib.app.cms.module.category.group.CategoryGroupService;
import kr.go.gbelib.app.cms.module.teach.teachCode2.TeachCode2;
import kr.go.gbelib.app.cms.module.teach.teachCode2.TeachCode2Service;
import kr.go.gbelib.app.cms.module.teachSetting.TeachSettingService;

@Controller
@RequestMapping(value = {"/cms/module/category"})
public class CategoryController extends BaseController {

	private final String basePath = "/cms/module/category/";

	@Autowired
	private CategoryService categoryService;

	@Autowired
	private CategoryGroupService categoryGroupService;

	@Autowired
	private HomepageService homepageService;

	@Autowired
	private TeachCode2Service teachCode2Service;

	@RequestMapping(value = {"/getCategoryList.*"})
	public @ResponseBody Map<String, Object> getCategoryList(Model model, Category category, HttpServletRequest request) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("categoryList", categoryService.getCategoryListAll(category));
		return result;
	}

	@RequestMapping(value = {"/getCategoryGroupList.*"})
	public @ResponseBody List<CategoryGroup> getCategoryGroupList(Model model, CategoryGroup categoryGroup, HttpServletRequest request) {
		return categoryGroupService.getCategoryGroupListAll(categoryGroup);
	}

	@RequestMapping(value = {"/index.*"})
	public String index(Model model, CategoryGroup categoryGroup, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
//		if ( !getSessionIsAdmin(request) ) {
//			categoryGroup.setHomepage_id(getAsideHomepageId(request));
//		}

		if ((getAsideHomepageId(request).equals("h37") || getAsideHomepageId(request).equals("h49") || getAsideHomepageId(request).equals("h45") || getAsideHomepageId(request).equals("h53"))) {
			Homepage sessionHomepageInfo = getSessionHomepageInfo(request);
			sessionHomepageInfo.setHomepage_group(getAsideHomepageId(request));
			sessionHomepageInfo.setTemp_use_yn("Y");
			List<Homepage> subHomepageList = homepageService.getSubHomepageList(sessionHomepageInfo);
			if (StringUtils.isEmpty(categoryGroup.getHomepage_id())) {
				categoryGroup.setHomepage_id(subHomepageList.get(0).getHomepage_id());
			}
			model.addAttribute("subHomepageList", subHomepageList);
		} else {
			categoryGroup.setHomepage_id(getAsideHomepageId(request));
		}

		int count = categoryGroupService.getCategoryGroupListCount(categoryGroup);
		categoryGroup.setTotalDataCount(count);
		model.addAttribute("categoryGroup", categoryGroup);
		model.addAttribute("categoryGroupListCount", count);
		model.addAttribute("categoryGroupList", categoryGroupService.getCategoryGroupList(categoryGroup));

		TeachCode2 teachCode2 = new TeachCode2();
		teachCode2.setTeach_code(15);
		teachCode2.setHomepage_id(categoryGroup.getHomepage_id());
		model.addAttribute("teachLargeCategoryList", teachCode2Service.getSubcategories(teachCode2));

		return basePath + "index";
	}

	@RequestMapping(value = {"/category.*"})
	public String category(Model model, Category category, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		int count = categoryService.getCategoryListCount(category);
		categoryService.setPaging(model, count, category);
		category.setTotalDataCount(count);
		model.addAttribute("category", category);
		model.addAttribute("categoryListCount", count);
		model.addAttribute("categoryList", categoryService.getCategoryList(category));

		CategoryGroup cg = new CategoryGroup();
		cg.setHomepage_id(category.getHomepage_id());
		cg.setLarge_category_idx(category.getLarge_category_idx());
		cg.setGroup_idx(category.getGroup_idx());
		model.addAttribute("categoryGroupOne", categoryGroupService.getCategoryGroupOne(cg));

		return basePath + "category_ajax";
	}

	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, Category category) {
		if(category.getEditMode().equals("MODIFY")) {
			model.addAttribute("category", categoryService.copyObjectPaging(category, categoryService.getCategoryOne(category)));

//			CategoryGroup categoryGroup = new CategoryGroup(category.getHomepage_id());
//			categoryGroup.setGroup_idx(category.getGroup_idx());
//			categoryGroup = categoryGroupService.getCategoryGroupOne(categoryGroup);
//			Category categoryLimitTotal = categoryService.getReqLimitTotal(category);
//			if (StringUtils.equals(categoryGroup.getReq_limit_yn(), "Y")) {
//				if (categoryLimitTotal.getCnt() > 0) {
//					model.addAttribute("possibleCount", categoryGroup.getReq_limit_count() - categoryLimitTotal.getReq_limit_count());
//				} else {
//					model.addAttribute("possibleCount", categoryGroup.getReq_limit_count());
//				}
//			} else {
//				TeachSetting teachSetting = new TeachSetting();
//				teachSetting.setHomepage_id(categoryGroup.getHomepage_id());
//				teachSetting = teachSettingService.getTeachSettingOne(teachSetting);
//
//				if (StringUtils.equals(teachSetting.getUse_yn(), "Y")) {
//					if (categoryLimitTotal.getCnt() > 0) {
//						model.addAttribute("possibleCount", teachSetting.getTerm_count() - categoryLimitTotal.getReq_limit_count());
//					} else {
//						model.addAttribute("possibleCount", teachSetting.getTerm_count());
//					}
//				}
//			}
		} else {
			category.setPrint_seq(categoryService.getPrintMaxValue(category));
			model.addAttribute("category", category);
		}
		return basePath + "edit_ajax";
	}

	@RequestMapping(value = {"/editGroup.*"})
	public String editGroup(Model model, CategoryGroup categoryGroup) {

		if(categoryGroup.getEditMode().equals("MODIFY")) {
			model.addAttribute("categoryGroup", categoryGroupService.copyObjectPaging(categoryGroup, categoryGroupService.getCategoryGroupOne(categoryGroup)));
//			TeachSetting ts = new TeachSetting();
//			ts.setHomepage_id(categoryGroup.getHomepage_id());
//			ts = teachSettingService.getTeachSettingOne(ts);
//			if (StringUtils.equals(ts.getUse_yn(), "Y")) {
//				CategoryGroup categoryGroupLimitTotal = categoryGroupService.getReqLimitTotal(categoryGroup);
//				if (categoryGroupLimitTotal.getCnt() > 0) {
//					model.addAttribute("possibleCount", ts.getTerm_count() - categoryGroupLimitTotal.getReq_limit_count());
//				} else {
//					model.addAttribute("possibleCount", ts.getTerm_count());
//				}
//			}
		} else {
			model.addAttribute("categoryGroup", categoryGroup);
		}

		return basePath + "editGroup_ajax";
	}

	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Category category, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		String editMode = category.getEditMode();
		if(!category.getEditMode().equals("DELETE")) {
			ValidationUtils.rejectIfEmpty(result, "category_name", "카테고리명을 입력하세요.");
			ValidationUtils.rejectIfStringLength(result, "category_name", 50, "카테고리명");

//			if (StringUtils.equals(category.getReq_limit_yn(), "Y")) {
//				CategoryGroup categoryGroup = new CategoryGroup(category.getHomepage_id());
//				categoryGroup.setGroup_idx(category.getGroup_idx());
//				categoryGroup = categoryGroupService.getCategoryGroupOne(categoryGroup);
//				Category categoryLimitTotal = categoryService.getReqLimitTotal(category);
//				if (StringUtils.equals(categoryGroup.getReq_limit_yn(), "Y")) {
//					if (categoryLimitTotal.getCnt() > 0) {
//						int diff = categoryGroup.getReq_limit_count() - (categoryLimitTotal.getReq_limit_count() + category.getReq_limit_count());
//						if (diff < 0) {
//							result.reject("제한횟수는 "+(categoryGroup.getReq_limit_count()-categoryLimitTotal.getReq_limit_count()+1)+"이상 입력할 수 없습니다.");
//						}
//					} else {
//						int diff = categoryGroup.getReq_limit_count() - category.getReq_limit_count();
//						if (diff < 0) {
//							result.reject("제한횟수는 "+(categoryGroup.getReq_limit_count()+1)+"이상 입력할 수 없습니다.");
//						}
//					}
//				} else {
//					TeachSetting teachSetting = new TeachSetting();
//					teachSetting.setHomepage_id(categoryGroup.getHomepage_id());
//					teachSetting = teachSettingService.getTeachSettingOne(teachSetting);
//
//					if (StringUtils.equals(teachSetting.getUse_yn(), "Y")) {
//						if (categoryLimitTotal.getCnt() > 0) {
//							int diff = teachSetting.getTerm_count() - (categoryLimitTotal.getReq_limit_count() + category.getReq_limit_count());
//							if (diff < 0) {
//								result.reject("제한횟수는 "+(teachSetting.getTerm_count()-categoryLimitTotal.getReq_limit_count()+1)+"이상 입력할 수 없습니다.");
//							}
//						} else {
//							int diff = teachSetting.getTerm_count() - (category.getReq_limit_count());
//							if (diff < 0) {
//								result.reject("제한횟수는 "+(teachSetting.getTerm_count()+1)+"이상 입력할 수 없습니다.");
//							}
//						}
//					}
//				}
//			}
		} else {
			if ( categoryService.checkTeachInCategory(category) > 0) {
				result.reject("해당 카테고리에 생성된 강좌가 있으므로 삭제가 불가능 합니다.");
			}
		}



		if(!result.hasErrors()) {
			if(editMode.equals("ADD")) {
				category.setAdd_id(getSessionMemberId(request));
				categoryService.addCategory(category);
				res.setValid(true);
				res.setMessage("등록 되었습니다.");
			} else if(editMode.equals("MODIFY")) {
				category.setModify_id(getSessionMemberId(request));
				categoryService.modifyCategory(category);
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			} else if(editMode.equals("DELETE")) {
				categoryService.deleteCategory(category);
				res.setValid(true);
				res.setMessage("삭제 되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	@RequestMapping(value = {"/saveGroup.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse saveGroup(CategoryGroup categoryGroup, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		String editMode = categoryGroup.getEditMode();
		if(!categoryGroup.getEditMode().equals("DELETE")) {
			ValidationUtils.rejectIfEmpty(result, "group_name", "그룹명을 입력하세요.");
			ValidationUtils.rejectIfStringLength(result, "group_name", 50, "그룹명");

//			if (StringUtils.equals(categoryGroup.getReq_limit_yn(), "Y")) {
//				TeachSetting teachSetting = new TeachSetting();
//				teachSetting.setHomepage_id(categoryGroup.getHomepage_id());
//				teachSetting = teachSettingService.getTeachSettingOne(teachSetting);
//				if (StringUtils.equals(teachSetting.getUse_yn(), "Y")) {
//					CategoryGroup categoryGroupLimitTotal = categoryGroupService.getReqLimitTotal(categoryGroup);
//					if (categoryGroupLimitTotal.getCnt() > 0) {
//						int diff = teachSetting.getTerm_count() - (categoryGroupLimitTotal.getReq_limit_count() + categoryGroup.getReq_limit_count());
//						if (diff < 0) {
//							result.reject("제한횟수는 "+(teachSetting.getTerm_count()-categoryGroupLimitTotal.getReq_limit_count()+1)+"이상 입력할 수 없습니다.");
//						}
//					} else {
//						int diff = teachSetting.getTerm_count() - (categoryGroup.getReq_limit_count());
//						if (diff < 0) {
//							result.reject("제한횟수는 "+(teachSetting.getTerm_count()+1)+"이상 입력할 수 없습니다.");
//						}
//					}
//				}
//			}
		} else {
			if ( categoryGroupService.checkCategoryInGroup(categoryGroup) > 0 ) {
				result.reject("해당 그룹에 생성된 카테고리가 있으므로 삭제가 불가능 합니다.");
			}
		}

		if(!result.hasErrors()) {
			if(editMode.equals("ADD")) {
				categoryGroup.setAdd_id(getSessionMemberId(request));
				categoryGroupService.addCategoryGroup(categoryGroup);
				res.setValid(true);
				res.setMessage("등록 되었습니다.");
			} else if(editMode.equals("MODIFY")) {
				categoryGroup.setMod_id(getSessionMemberId(request));
				categoryGroupService.modifyCategoryGroup(categoryGroup);
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			} else if(editMode.equals("DELETE")) {
				categoryGroupService.deleteCategoryGroup(categoryGroup);
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