package kr.go.gbelib.app.cms.module.blackList;

import java.util.*;
import java.util.stream.Collectors;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.whalesoft.framework.utils.PagingUtils;
import kr.go.gbelib.app.cms.module.blackListDetail.BlackListDetail;
import kr.go.gbelib.app.cms.module.blackListDetail.BlackListDetailDao;
import kr.go.gbelib.app.cms.module.blackListDetail.BlackListDetailService;
import kr.go.gbelib.app.cms.module.category.Category;
import kr.go.gbelib.app.cms.module.category.CategoryService;
import kr.go.gbelib.app.cms.module.category.group.CategoryGroup;
import kr.go.gbelib.app.cms.module.category.group.CategoryGroupDao;
import kr.go.gbelib.app.cms.module.category.group.CategoryGroupService;
import kr.go.gbelib.app.cms.module.teach.teachCategoryCode.TeachCategoryCode;
import kr.go.gbelib.app.cms.module.teach.teachCode2.TeachCode2;
import kr.go.gbelib.app.cms.module.teach.teachCode2.TeachCode2Service;
import org.apache.commons.lang.StringUtils;
import org.apache.logging.log4j.core.pattern.AbstractStyleNameConverter.Black;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ValidationUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import kr.co.whalesoft.app.cms.code.Code;
import kr.co.whalesoft.app.cms.code.CodeService;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.go.gbelib.app.common.api.MemberAPI;

@Controller
@RequestMapping(value = {"/cms/module/blackList"})
public class BlackListController extends BaseController{

	private final String basePath = "/cms/module/blackList/";

	@Autowired
	private BlackListService service;
	
	@Autowired
	private HomepageService homepageService;

	@Autowired
	private CodeService codeService;

	@Autowired
	private TeachCode2Service teachCode2Service;

	@Autowired
	private CategoryGroupService categoryGroupService;

	@Autowired
	private CategoryService categoryService;

	@Autowired
	private BlackListDetailService blackListDetailService;

	@RequestMapping(value = { "/index.*" })
	public String index(Model model, BlackList blackList, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		Map<String, String> codeMap = new HashMap<String, String>();
		for ( Code one : codeService.getCode("CMS", "C0017") ) {
			codeMap.put(one.getCode_id(), one.getCode_name());
		}
		Homepage sessionHomepageInfo = getSessionHomepageInfo(request);
		if ((getAsideHomepageId(request).equals("h37") || getAsideHomepageId(request).equals("h49") || getAsideHomepageId(request).equals("h45") || getAsideHomepageId(request).equals("h53"))) {
			sessionHomepageInfo.setHomepage_group(getAsideHomepageId(request));
			sessionHomepageInfo.setTemp_use_yn("Y");
			List<Homepage> subHomepageList = homepageService.getSubHomepageList(sessionHomepageInfo);
			if (StringUtils.isEmpty(blackList.getHomepage_id())) {
				blackList.setHomepage_id(subHomepageList.get(0).getHomepage_id());
			}
			model.addAttribute("subHomepageList", subHomepageList);
		} else {
			if (StringUtils.isEmpty(blackList.getHomepage_id())) {
				blackList.setHomepage_id(getAsideHomepageId(request));
				blackList.setHomepage_name(sessionHomepageInfo.getHomepage_name());
			}

		}

		service.setPaging(model, service.getBlackListCount(blackList), blackList);
		model.addAttribute("blackTypeList", codeMap);
		model.addAttribute("blackList", blackList);
		model.addAttribute("list", service.getBlackListList(blackList));

		return basePath + "index";
	}

	@RequestMapping(value = { "/edit.*" }, method = RequestMethod.GET)
	public String edit(Model model, BlackList blackList, HttpServletRequest request) throws AuthException {
		// 대분류 카테고리 추가
		TeachCode2 teachCode2 = new TeachCode2();
		teachCode2.setTeach_code(15);
		teachCode2.setHomepage_id(blackList.getHomepage_id());
		// 대분류
		List<TeachCode2> teachCodeList = teachCode2Service.getSubcategories(teachCode2);

		CategoryGroup categoryGroup = new CategoryGroup();
		categoryGroup.setHomepage_id(blackList.getHomepage_id());

		// 중분류
		List<CategoryGroup> middleCategory = categoryGroupService.getMiddleTeachCategoryGroupByLargeIdx(categoryGroup);

		Category category = new Category();
		category.setHomepage_id(blackList.getHomepage_id());
		// 소분류
		List<Category> smallCategoryList = categoryService.getSmallCategoryListInLargeCode(category);

		// 계층분리
		for (TeachCode2 tc : teachCodeList) {
			int teachCode = tc.getTeach_code(); // or getTeachCode()
			// 해당 teachCode에 속한 그룹 필터링
			List<CategoryGroup> groups = middleCategory.stream()
					.filter(g -> teachCode == g.getLarge_category_idx())
					.collect(Collectors.toList());
			// 기존 TeachCode2 객체에 주입
			tc.setGroupList(groups);
		}
		for (CategoryGroup tg : middleCategory) {
			int groupIdx = tg.getGroup_idx(); // or getTeachCode()
			// 해당 groupIdx 에 속한 그룹 필터링
			List<Category> groups = smallCategoryList.stream()
					.filter(g -> groupIdx == g.getGroup_idx())
					.collect(Collectors.toList());
			// 기존 CategoryGroup 객체에 주입
			tg.setCategoryList(groups);
		}

		model.addAttribute("teachCodeList",teachCodeList);

		// 대분류 차단 전체 체크 값
		boolean teachAllChecked = false;

		if (blackList.getEditMode().equals("ADD")) {
			checkAuth("C", model, request);
			model.addAttribute("blackListOne", blackList);
		} else if (blackList.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			BlackList result = service.getBlackListOne(blackList);

			BlackListDetail blackListDetail = new BlackListDetail();

			blackListDetail.setHomepage_id(blackList.getHomepage_id());
			blackListDetail.setBlack_idx(result.getBlack_idx());
			BlackListDetail detail = blackListDetailService.getTeachCodeLists(blackListDetail);

			if (detail != null) {
				result.setTeach_code(detail.getTeach_codes());
				result.setGroup_idx(detail.getGroup_ids());
				result.setCategory_idx(detail.getCategory_ids());
			}

			// 전부 체크되어 있는지 확인
			if (result.getTeach_code() != null) {
				teachAllChecked = teachCodeList.stream().allMatch(i -> result.getTeach_code().contains(String.valueOf(i.getTeach_code())));
			}

			// 기존에 존재하던 블랙리스트의 teach_code는 null 값으로 존재하기 때문에 teachAllChecked를 true,teach_code 전부 넣어서
			// 전체 차단으로 판단 (기존의 블랙리스트 기능이 전체차단이였기 때문에 계속 유지)
			if (result.getTeach_code() == null && result.getGroup_idx() == null && result.getCategory_idx() == null) {
				StringBuilder teachAllStr = new StringBuilder();
				for (TeachCode2 t : teachCodeList) {
					teachAllStr.append(t.getTeach_code()).append(",");
				}
				if (teachAllStr.length() > 0) {
					teachAllStr.deleteCharAt(teachAllStr.length() - 1);
				};
				result.setTeach_code(teachAllStr.toString());
				teachAllChecked = true;
			}
			PagingUtils pagingUtils = service.copyObjectPaging(blackList, result);
			model.addAttribute("blackListOne", pagingUtils);
		}

		model.addAttribute("teachAllChecked", teachAllChecked);
		model.addAttribute("blackTypeList", codeService.getCode("CMS", "C0017"));

		return basePath + "edit_ajax";
	}

	@RequestMapping(value = {"/excelDownload.*"}, method = RequestMethod.POST)
	public BlackListSearchView excel(Model model, BlackList blackList, HttpServletRequest request, HttpServletResponse response) throws Exception{
		model.addAttribute("blackList", blackList);
		model.addAttribute("blackListResult", service.getBlackListList(blackList));
		return new BlackListSearchView();
	}

	@RequestMapping(value = {"/csvDownload.*"}, method = RequestMethod.POST)
	public void csv(Model model, BlackList blackList, HttpServletRequest request, HttpServletResponse response) throws Exception{
		List<BlackList> blackListResult = service.getBlackListList(blackList);

		String fileName = blackListResult.get(0).getHomepage_name() + "블랙리스트 내역.csv";
		new BlackListXlsToCsv(blackList, blackListResult, fileName, request, response);
	}

	@RequestMapping(value = {"/checkId.*"}, method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> checkId(Model model, BlackList blackList, HttpServletRequest request) {
		Map<String, Object> result = new HashMap<String, Object>();

		Member blackListMember = new Member();
		blackListMember.setUser_id(blackList.getMember_id());

		if ( blackList.getSearch_api_type().equals("WEBID") ) {
		}
		else {
			List<Map<String, Object>> listMap = MemberAPI.checkDupUser("0", blackListMember);
			if(listMap == null) {
				result.put("resultMsg", "해당 ID는 유효한 회원이 아닙니다.");
			} else {
				result.put("memberInfo", listMap.get(0));
			}
		}
		return result;
	}
	
	@RequestMapping(value = { "/save.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(BlackList blackList, BindingResult result, HttpServletRequest request) {

		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		if (!blackList.getEditMode().equals("DELETE")) {
			ValidationUtils.rejectIfEmpty(result, "homepage_id", "홈페이지를 설정해 주세요.");
			if(blackList.getEditMode().equals("ADD")) {
				ValidationUtils.rejectIfEmpty(result, "member_id", "블랙리스트 아이디를 입력해 주세요.");
				if (service.checkSaveBlackList(blackList) > 0) {
					result.reject("이미 등록된 아이디 입니다.");
				}
			}
		}

		if (!result.hasErrors()) {
			blackList.setAdd_id(getSessionMemberId(request));
			blackList.setModify_id(getSessionMemberId(request));

			BlackListDetail blackListDetail = new BlackListDetail();
			blackListDetail.setHomepage_id(blackList.getHomepage_id());
			blackListDetail.setBlack_idx(blackList.getBlack_idx());
			blackListDetail.setMember_id(blackList.getMember_id());

			if (blackList.getEditMode().equals("ADD")) {
				List<BlackListDetail> details = new ArrayList<>();
				service.addBlackList(blackList);

				// details 리스트 값 추가
				populateBlackListDetails(blackList, details);
				for (BlackListDetail detail : details) {
					// detail 추가
					blackListDetailService.addBlackListDetail(detail);
				}
				res.setValid(true);
				res.setMessage("등록 되었습니다.");
			} else if (blackList.getEditMode().equals("MODIFY")) {
				List<BlackListDetail> details = new ArrayList<>();
				// 기존에 있던거 전부 다 삭제
				blackListDetailService.deleteBlackListDetails(blackListDetail);

				service.modifyBlackList(blackList);
				// details 리스트 값 추가
				populateBlackListDetails(blackList,details);

				for (BlackListDetail detail : details) {
					// detail 추가
					blackListDetailService.addBlackListDetail(detail);
				}
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			} else if (blackList.getEditMode().equals("DELETE")) {
				service.deleteBlackList(blackList);
				blackListDetailService.deleteBlackListDetails(blackListDetail);
				res.setValid(true);
				res.setMessage("삭제 되었습니다.");
			} else if ( blackList.getEditMode().equals("BLACKTYPEDELETE") ) {
				service.blackTypeDelete(blackList);
				blackListDetailService.deleteBlackListDetails(blackListDetail);
				res.setValid(true);
				res.setMessage("삭제 되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	private void populateBlackListDetails(BlackList blackList, List<BlackListDetail> details) {
		String[] blackTypes = blackList.getBlack_type().split(",");
		for (String blackType : blackTypes) {
			// 대분류값 분류
			Map<String, String> teachCodeMap = null;
			Map<String, String> groupCodeMap = new HashMap<>();

			// 대분류 차단 추가
			if (blackList.getTeach_code() != null) {
				String[] teachCodes = blackList.getTeach_code().split(",");
				teachCodeMap = Arrays.stream(teachCodes).collect(Collectors.toMap(k -> k, v -> v));
				for (String teachCode : teachCodeMap.values()) {
					createBlackListDetail(blackList,blackType, Integer.parseInt(teachCode), blackList.getBlack_idx(), details,0, 0);
				}
			}

			// 중분류 차단 추가
			if (blackList.getGroup_idx() != null) {
				String[] groupIds = blackList.getGroup_idx().split(",");
				for (String groupId : groupIds) {
					// 대분류_중분류
					String[] groups = groupId.split("_");
					groupCodeMap.put(groups[1], groups[1]);

					// 대분류가 체크 되었는지 확인후 체크 되어 있다면 detail x
					if (teachCodeMap != null && teachCodeMap.containsKey(groups[0])) {
						continue;
					}
					int teachIdx = Integer.parseInt(groups[0]);
					int groupIdx = Integer.parseInt(groups[1]);
					createBlackListDetail(blackList,blackType, teachIdx, blackList.getBlack_idx(), details,groupIdx,0);
				}
			}

			// 소분류 차단 추가
			if (blackList.getCategory_idx() != null) {
				String[] categoryIds = blackList.getCategory_idx().split(",");
				for (String categoryId : categoryIds) {

					// 대분류_중분류_소분류
					String[] category = categoryId.split("_");

					// 대분류가 체크 되었는지 확인후 체크 되어 있다면 detail  x
					if (teachCodeMap != null && teachCodeMap.containsKey(category[0])) {
						continue;
					}
					// 중분류가 체크 되었는지 확인후 체크 되어 있다면 detail x
					if (groupCodeMap.containsKey(category[1])) {
						continue;
					}
					int teachIdx = Integer.parseInt(category[0]);
					int groupIdx = Integer.parseInt(category[1]);
					int categoryIdx = Integer.parseInt(category[2]);
					createBlackListDetail(blackList,blackType, teachIdx, blackList.getBlack_idx(), details, groupIdx,categoryIdx);
				}
			}
		}
	}

	private static void createBlackListDetail(BlackList blackList, String blackType,int teachIdx, int blackIdx, List<BlackListDetail> details,int groupIdx,int categoryIdx) {
		BlackListDetail detail = new BlackListDetail();
		detail.setBlack_idx(blackIdx);
		detail.setTeach_code(teachIdx);

		if (groupIdx != 0) {
			detail.setGroup_idx(groupIdx);
		}
		if (categoryIdx != 0) {
			detail.setCategory_idx(categoryIdx);
		}
		detail.setHomepage_id(blackList.getHomepage_id());
		detail.setMember_id(blackList.getMember_id());
		detail.setMember_name(blackList.getMember_name());
		detail.setBlack_type(blackType);
		detail.setAdd_id(blackList.getAdd_id());
		detail.setModify_id(blackList.getModify_id());
		details.add(detail);
	}
}
