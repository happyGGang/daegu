package kr.go.gbelib.app.module.teach;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.app.cms.menu.menuHtml.MenuHtml;
import kr.co.whalesoft.app.cms.menu.menuHtml.MenuHtmlService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.app.cms.code.CodeService;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.menu.Menu;
import kr.co.whalesoft.app.cms.menu.MenuService;
import kr.co.whalesoft.app.cms.recommendSite.RecommendSite;
import kr.co.whalesoft.app.cms.recommendSite.RecommendSiteService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.utils.AttachmentUtils;
import kr.co.whalesoft.framework.utils.CalculateHashUtils;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.go.gbelib.app.cms.module.category.Category;
import kr.go.gbelib.app.cms.module.category.CategoryService;
import kr.go.gbelib.app.cms.module.category.group.CategoryGroup;
import kr.go.gbelib.app.cms.module.category.group.CategoryGroupService;
import kr.go.gbelib.app.cms.module.portalMember.PortalMember;
import kr.go.gbelib.app.cms.module.teach.Teach;
import kr.go.gbelib.app.cms.module.teach.TeachService;
import kr.go.gbelib.app.cms.module.teach.student.StudentService;
import kr.go.gbelib.app.cms.module.teach.teachCode2.TeachCode2;
import kr.go.gbelib.app.cms.module.teach.teachCode2.TeachCode2Service;

@Controller(value="userTeach")
@RequestMapping(value = {"/{homepagePath}/module/teach"})
public class TeachController extends BaseController{

	private String basePath = "/homepage/%s/module/teach/";

	@Autowired
	private TeachService teachService;

	@Autowired
	private CategoryService categoryService;

	@Autowired
	private CategoryGroupService categoryGroupService;

	@Autowired
	private StudentService studentService;

	@Autowired
	private MenuService menuService;

	@Autowired
	private CodeService codeService;

	@Autowired
	private TeachCode2Service teachCode2Service;

	@Autowired
	private RecommendSiteService recommendSiteService;

	@Autowired
	private HomepageService homepageService;

	@Autowired
	private MenuHtmlService menuHtmlService;

	@ModelAttribute("recommendSiteList")
	public List<RecommendSite> getAreaCdList(HttpServletRequest request) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		return recommendSiteService.getRecommendSiteListAll(new RecommendSite(homepage.getHomepage_id()));
	}

	@RequestMapping(value = {"/index.*"})
	public String index(Model model, Teach teach, HttpServletRequest request, HttpServletResponse response) throws Exception {
		checkAuth("R", model, request);

		Homepage homepage = (Homepage)request.getAttribute("homepage");
		if ( isLogin(request) && getSessionMemberLoginType(request).equals("HOMEPAGE") ) {
			teach.setMember_key(getSessionMemberId(request));
		}

		Menu menuOne = (Menu) request.getAttribute("menuOne");
		if ( menuOne != null ) {
			model.addAttribute("html", menuHtmlService.getLastMenuHtmlOne(new MenuHtml(homepage.getHomepage_id(), menuOne.getMenu_idx())));
		}

		if ( homepage.getHomepage_id().equals("h32") && teach.getEditMode().equals("ALL")) {
			if (StringUtils.isEmpty(teach.getHomepage_id())) {
				teach.setHomepage_id(homepage.getHomepage_id());
			}
			if (teach.getProgram_age_div_arr() != null && teach.getProgram_age_div_arr().size() > 0) {
				teach.setProgram_age_div(StringUtils.join(teach.getProgram_age_div_arr(), "|"));
			}
			teachService.setPaging(model, teachService.getTeachListForAllHomepageCount(teach), teach);
			model.addAttribute("teachList", teachService.getTeachListForAllHomepage(teach));
			model.addAttribute("teach", teach);
			model.addAttribute("myTeachListMenuIdx", menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 93)));//수강신청내역 menu_idx
			if (!teach.getHomepage_id().equals("h32")) {
				model.addAttribute("groupList", categoryGroupService.getCategoryGroupListAll(new CategoryGroup(teach.getHomepage_id())));
				model.addAttribute("categoryList", categoryService.getCategoryListAll(new Category(teach.getHomepage_id(), teach.getGroup_idx())));
			}

			//프로그램 주제구분
			TeachCode2 teachCode2 = new TeachCode2(1);
			teachCode2.setHomepage_id(teach.getHomepage_id());
			model.addAttribute("teachSubjectCodeList", teachCode2Service.getSubcategories(teachCode2));

			//프로그램 연령구분
			teachCode2.setTeach_code(8);
			model.addAttribute("teachAgeDivCodeList", teachCode2Service.getSubcategories(teachCode2));

			//강좌대분류
			teachCode2.setTeach_code(15);
			model.addAttribute("teachLargeCategoryList", teachCode2Service.getSubcategories(teachCode2));
			return String.format(basePath, homepage.getFolder()) + "index_all";
		} else if ( homepage.getHomepage_id().equals("h32") && teach.getEditMode().equals("GUGUN")) {
			if (StringUtils.isEmpty(teach.getHomepage_id())) {
				teach.setHomepage_id(homepage.getHomepage_id());
			}
			if (teach.getProgram_age_div_arr() != null && teach.getProgram_age_div_arr().size() > 0) {
				teach.setProgram_age_div(StringUtils.join(teach.getProgram_age_div_arr(), "|"));
			}
			List<String> homepage_ids = new ArrayList<String>();
			homepage_ids.add("h34");
			homepage_ids.add("h35");
			homepage_ids.add("h36");
			homepage_ids.add("h37");
			homepage_ids.add("h38");
			homepage_ids.add("h39");
			homepage_ids.add("h40");
			homepage_ids.add("h41");
			homepage_ids.add("h42");
			homepage_ids.add("h43");
			homepage_ids.add("h44");
			homepage_ids.add("h45");
			homepage_ids.add("h46");
			homepage_ids.add("h47");
			homepage_ids.add("h48");
			homepage_ids.add("h49");
			homepage_ids.add("h50");
			homepage_ids.add("h51");
			homepage_ids.add("h52");
			homepage_ids.add("h53");
			homepage_ids.add("h54");
			homepage_ids.add("h55");
			homepage_ids.add("h56");
			homepage_ids.add("h57");
			homepage_ids.add("h58");
			homepage_ids.add("h59");
			homepage_ids.add("h60");
			homepage_ids.add("h61");
			homepage_ids.add("h62");
			homepage_ids.add("h63");
			homepage_ids.add("h64");
			homepage_ids.add("h65");
			homepage_ids.add("h66");
			homepage_ids.add("h67");
			homepage_ids.add("h68");
			homepage_ids.add("h69");
			homepage_ids.add("h70");
			homepage_ids.add("h71");
			homepage_ids.add("h72");
			homepage_ids.add("h73");
			homepage_ids.add("h74");
			homepage_ids.add("h75");
			homepage_ids.add("h76");
			homepage_ids.add("h77");
			homepage_ids.add("h78");
			teach.setHomepage_ids(homepage_ids);
			teach.setLarge_category_idx(16);
			teachService.setPaging(model, teachService.getTeachListForAllHomepageGugunCount(teach), teach);
			model.addAttribute("teachList", teachService.getTeachListForAllHomepageGugun(teach));
			model.addAttribute("teach", teach);
			model.addAttribute("myTeachListMenuIdx", menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 93)));//수강신청내역 menu_idx
			if (!teach.getHomepage_id().equals("h32")) {
				model.addAttribute("groupList", categoryGroupService.getCategoryGroupListAll(new CategoryGroup(teach.getHomepage_id())));
				model.addAttribute("categoryList", categoryService.getCategoryListAll(new Category(teach.getHomepage_id(), teach.getGroup_idx())));
			}

			//프로그램 주제구분
			TeachCode2 teachCode2 = new TeachCode2(1);
			teachCode2.setHomepage_id(teach.getHomepage_id());
			model.addAttribute("teachSubjectCodeList", teachCode2Service.getSubcategories(teachCode2));

			//프로그램 연령구분
			teachCode2.setTeach_code(8);
			model.addAttribute("teachAgeDivCodeList", teachCode2Service.getSubcategories(teachCode2));

			//강좌대분류
			teachCode2.setTeach_code(15);
			model.addAttribute("teachLargeCategoryList", teachCode2Service.getSubcategories(teachCode2));
			return String.format(basePath, homepage.getFolder()) + "index_all";
		}
		else {
//			teach.setHomepage_id(homepage.getHomepage_id());
			if ((homepage.getHomepage_id().equals("h37") || homepage.getHomepage_id().equals("h49") || homepage.getHomepage_id().equals("h45") || homepage.getHomepage_id().equals("h53"))) {
				Homepage h = new Homepage();
				h.setHomepage_id(homepage.getHomepage_id());
				h.setHomepage_group(homepage.getHomepage_id());
				h.setTemp_use_yn("Y");
				List<Homepage> subHomepageList = homepageService.getSubHomepageList(h);
				if (StringUtils.isEmpty(teach.getHomepage_id())) {
					if (subHomepageList != null && subHomepageList.size() > 0) {
						teach.setHomepage_id(subHomepageList.get(0).getHomepage_id());
					}
				}
				model.addAttribute("subHomepageList", subHomepageList);
			} else {
				teach.setHomepage_id(homepage.getHomepage_id());
			}
			model.addAttribute("teach", teach);
			model.addAttribute("teachList", teachService.getTeachListForUser(teach));
			model.addAttribute("myTeachListMenuIdx", menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 93)));//수강신청내역 menu_idx
			
			// 분류별 검색
			if(StringUtils.isNotEmpty(teach.getSearchCate1())) teach.setLarge_category_idx(Integer.parseInt(teach.getSearchCate1()));
			model.addAttribute("categoryGroupList", categoryGroupService.getCategoryGroupListAll(new CategoryGroup(teach.getHomepage_id(), teach.getLarge_category_idx())));
			model.addAttribute("categoryList", categoryService.getCategoryListAll(new Category(teach.getHomepage_id(), teach.getGroup_idx(), teach.getLarge_category_idx())));

			//프로그램 주제구분
			TeachCode2 teachCode2 = new TeachCode2(1);
			teachCode2.setHomepage_id(teach.getHomepage_id());
			model.addAttribute("teachSubjectCodeList", teachCode2Service.getSubcategories(teachCode2));

			//프로그램 연령구분
			teachCode2.setTeach_code(8);
			model.addAttribute("teachAgeDivCodeList", teachCode2Service.getSubcategories(teachCode2));

			//강좌대분류
			teachCode2.setTeach_code(15);
			model.addAttribute("teachLargeCategoryList", teachCode2Service.getSubcategories(teachCode2));

			return String.format(basePath, homepage.getFolder()) + "index";
		}
	}

	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, Teach teach, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage)request.getAttribute("homepage");

		String calendarPath = "/homepage/" + homepage.getFolder() + "/module/calendarManage/";

		// 대표도서관 사서 인증
		PortalMember loginPortal = sessionLoginPortal(request);
		String portal_auth = loginPortal == null ? "0" : loginPortal.getAuth_group();
		int portal_menu_idx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 97));
		if ( homepage.getHomepage_id().equals("h32") && teach.getMenu_idx() == portal_menu_idx && !portal_auth.equals("4") ) {
			teach.setBefore_url(String.format("/%s/module/teach/index.do?menu_idx=%s", homepage.getContext_path(), teach.getMenu_idx()));
			teachService.alertMessageAndUrl("학교도서관 사서 회원 인증 후 이용가능합니다.", String.format("/%s/module/portalMember/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), teach.getMenu_idx(), teach.getBefore_url()), request, response);
			return null;
		}

		teach.setHomepage_id(homepage.getHomepage_id());
		if ( teach.getEditMode().equals("MODIFY") ) {
			checkAuth("U", model, request, "소속도서관에서 신청하시기 바랍니다.");
			int menu_idx = teach.getMenu_idx();
			teach = teachService.getTeachOne(teach);
			teach.setMenu_idx(menu_idx);
			model.addAttribute("teach", teach);
		} else {
			checkAuth("C", model, request, "소속도서관에서 신청하시기 바랍니다.");
			model.addAttribute("teach", teach);
		}

		return calendarPath + "teachEdit";
	}

	@RequestMapping(value = {"/detail.*"})
	public String detail(Model model, Teach teach, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage)request.getAttribute("homepage");

		if (StringUtils.isEmpty(teach.getHomepage_id())) {
			teach.setHomepage_id(homepage.getHomepage_id());
		}

		int menu_idx = teach.getMenu_idx();
		String searchCate1 = teach.getSearchCate1();
		String homepage_id = teach.getHomepage_id();

		teach = teachService.getTeachDetailForUser(teach);
		if ( teach == null ) {
			teachService.alertMessage("해당 강좌 정보가 없습니다.", request, response);
			return null;
		}
		teach.setMenu_idx(menu_idx);
		teach.setSearchCate1(searchCate1);
		teach.setHomepage_id(homepage_id);

		model.addAttribute("teach", teach);

		return String.format(basePath, homepage.getFolder()) + "detail";
	}

	@RequestMapping(value = {"/applyList.*"})
	public String applyList(Model model, Teach teach, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage)request.getAttribute("homepage");

		if ( !isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			teach.setBefore_url(String.format("/%s/module/teach/applyList.do?menu_idx=%s", homepage.getContext_path(), teach.getMenu_idx()));
			teachService.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), teach.getMenu_idx(), teach.getBefore_url()), request, response);
			return null;
		}

		String homepageId = homepage.getHomepage_id();

		if ((homepageId.equals("h37") || homepageId.equals("h49") || homepageId.equals("h45") || homepageId.equals("h53"))) {
			Homepage h = new Homepage();
			h.setHomepage_id(homepageId);
			h.setHomepage_group(homepageId);
			h.setTemp_use_yn("Y");
			List<Homepage> subHomepageList = homepageService.getSubHomepageList(h);
			if (StringUtils.isEmpty(teach.getHomepage_id())) {
				teach.setHomepage_id(subHomepageList.get(0).getHomepage_id());
			}
			model.addAttribute("subHomepageList", subHomepageList);
		} else {
			teach.setHomepage_id(homepage.getHomepage_id());
		}

//		teach.setHomepage_id(homepage.getHomepage_id());
		if (isLogin(request)) {
			teach.setMember_key(getSessionMemberId(request));
		}
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		if (StringUtils.isEmpty(teach.getSearchDateFrom())) {
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.MONTH, -1);
			teach.setSearchDateFrom(sdf.format(cal.getTime()));
		}
		if (StringUtils.isEmpty(teach.getSearchDateTo())) {
			teach.setSearchDateTo(sdf.format(new Date()));
		}

		model.addAttribute("statusCode", codeService.getCode("CMS", "C0005"));

		if (teach.getSearchStatus().equals("Y")) {
			model.addAttribute("teachList", teachService.getApplyList(teach));
		} else {
			model.addAttribute("teachList", studentService.getCertificateListByDate(teach));
		}

		return String.format(basePath, homepage.getFolder()) + "applyList";
	}

	@RequestMapping(value = {"/anonyApplyCheck.*"})
	public String anonyApplyCheck(Model model, Teach teach, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage)request.getAttribute("homepage");

		return String.format(basePath, homepage.getFolder()) + "anonyApplyCheck";
	}

	@RequestMapping(value = {"/anonyApplyList.*"})
	public String anonyApplyList(Model model, Teach teach, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage)request.getAttribute("homepage");

		HttpSession session = request.getSession();

		if (StringUtils.isNotEmpty(teach.getApply_name()) && StringUtils.isNotEmpty(teach.getApply_password())) {
    		teach.setApply_password(CalculateHashUtils.calculateHash(teach.getApply_password()));
			session.setAttribute("studentAnonyCert", teach);
    	} else {
    		if (session.getAttribute("studentAnonyCert") == null) {
    			return String.format(basePath, homepage.getFolder()) + "anonyApplyCheck";
    		}
    	}

		Teach tmp = (Teach) session.getAttribute("studentAnonyCert");
		teach.setApply_name(tmp.getApply_name());
		teach.setApply_password(tmp.getApply_password());

//		teach.setHomepage_id(homepage.getHomepage_id());

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		if (StringUtils.isEmpty(teach.getSearchDateFrom())) {
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.MONTH, -1);
			teach.setSearchDateFrom(sdf.format(cal.getTime()));
		}
		if (StringUtils.isEmpty(teach.getSearchDateTo())) {
			teach.setSearchDateTo(sdf.format(new Date()));
		}

		model.addAttribute("statusCode", codeService.getCode("CMS", "C0005"));

		if (teach.getSearchStatus().equals("Y")) {
			model.addAttribute("teachList", teachService.getApplyList(teach));
		} else {
			model.addAttribute("teachList", studentService.getCertificateListByDate(teach));
		}

		return String.format(basePath, homepage.getFolder()) + "anonyApplyList";
	}

	@RequestMapping(value = "/download/{homepage_id}/{group_idx}/{category_idx}/{teach_idx}.*", method = RequestMethod.GET)
	@ResponseBody
	public ResponseEntity<byte[]> getFile(@PathVariable("homepage_id") String homepage_id, @PathVariable("group_idx") int group_idx, @PathVariable("category_idx") int category_idx,
			@PathVariable("teach_idx") int teach_idx, @RequestParam(required=false, value="file_type") String file_type, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Teach teach = teachService.getTeachOne(new Teach(homepage_id, group_idx, category_idx, teach_idx));
		HttpHeaders responseHeaders = new HttpHeaders();
		byte[] bytes = null;

		if(teach == null) {
			responseHeaders.setContentType(MediaType.valueOf("text/html"));
			teachService.alertMessage("파일이 존재하지 않습니다.", request, response);
			return null;
		}
		
		String serverName = "";
		String orgName = "";
		String extension = "";
		if(file_type != null && file_type.equals("attach")) {
			serverName = teach.getAttach_server_file_name();
			orgName = teach.getAttach_org_file_name();
			extension = teach.getAttach_file_extension();
		} else {
			serverName = teach.getServer_file_name();
			orgName = teach.getOrg_file_name();
			extension = teach.getFile_extension();
		}

		String filePath = teachService.getRootPath()+ "/" + homepage_id + "/" + serverName;
//		String filePath = teachService.getRootPath()+ "/" + homepage_id + "/" + teach.getServer_file_name();
		File file = new File(filePath);

//		if(file.length() > 0) {
//			bytes = FileCopyUtils.copyToByteArray(file);
//		} else {
//			responseHeaders.setHeader("Content-type", "text/html");
//			teachService.alertMessage("파일이 존재하지 않습니다.", request, responseHeaders);
//			return null;
//		}

		if(file.length() > 0) {
			bytes = FileCopyUtils.copyToByteArray(file);
		} else {
			responseHeaders.setContentType(MediaType.valueOf("text/html"));
			teachService.alertMessage("파일이 존재하지 않습니다.", request, response);
			return null;
		}

//		String fileName = "";
//		String fileName = String.format("%s.%s", teach.getOrg_file_name(),teach.getFile_extension() );
//		String fileName = boardFile.getFile_name().substring(0,boardFile.getFile_name().lastIndexOf("."));
		String fileName = String.format("%s.%s", orgName, extension);
//		String fileType = teach.getFile_extension().toUpperCase();
//		String fullFilename = fileName+"."+fileType;

//		response.setHeader("Content-Length", Long.toString(file.length()));
//	    response.setHeader("Content-Transfer-Encoding", "binary");
//	    response.setHeader("Content-Type", "application/octet-stream");
//	    response.setHeader("Content-Disposition", "attachment;fileName=\"" + fileName + "\";");

		responseHeaders.set("Content-Disposition", AttachmentUtils.getContentDisposition(fileName, request.getHeader("user-agent")));
		responseHeaders.setPragma("no-cache;");
		responseHeaders.setExpires(-1);
//		responseHeaders.setContentLength(file.length());
		responseHeaders.setContentType(MediaType.valueOf(AttachmentUtils.getContentType(extension.toUpperCase())));
		responseHeaders.setContentLength(bytes.length);

	    return new ResponseEntity<byte[]>(bytes, responseHeaders, HttpStatus.OK);
    }

	@RequestMapping(value = {"/excelDownload.*"})
	public TeachApplySearchView excelDownload(Model model, Teach teach, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage)request.getAttribute("homepage");

		if ( !isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			teach.setBefore_url(String.format("/%s/module/teach/applyList.do?menu_idx=%s", homepage.getContext_path(), teach.getMenu_idx()));
			teachService.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), teach.getMenu_idx(), teach.getBefore_url()), request, response);
			return null;
		}

		teach.setHomepage_id(homepage.getHomepage_id());
		teach.setMember_key(getSessionMemberId(request));

		model.addAttribute("teachList", teachService.getApplyList(teach));

		return new TeachApplySearchView();
	}

	@RequestMapping(value = {"/anonyExcelDownload.*"})
	public TeachApplySearchView anonyExcelDownload(Model model, Teach teach, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage)request.getAttribute("homepage");

		try {
			Teach tmp = (Teach) request.getSession().getAttribute("studentAnonyCert");
			teach.setApply_name(tmp.getApply_name());
			teach.setApply_password(tmp.getApply_password());

			teach.setHomepage_id(homepage.getHomepage_id());

			model.addAttribute("teachList", teachService.getApplyList(teach));
		} catch (Exception e) {
			teachService.alertMessageAndUrl("잘못된 접근입니다 (세션 만료)", String.format("anonyApplyCheck.do?menu_idx=%d", teach.getMenu_idx()),request, response);
			return null;
		}


		return new TeachApplySearchView();
	}

	@RequestMapping (value = { "/getGroupList.*" })
	public @ResponseBody JsonResponse getGroupList(Teach teach, BindingResult result, HttpServletRequest request) {

		JsonResponse res = new JsonResponse(request);

		if ( !result.hasErrors() ) {
			res.setData(categoryGroupService.getCategoryGroupListAll(new CategoryGroup(teach.getHomepage_id())));
		}
		else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	@RequestMapping (value = { "/getCategoryList.*" })
	public @ResponseBody JsonResponse getCategoryList(Teach teach, BindingResult result, HttpServletRequest request) {

		JsonResponse res = new JsonResponse(request);

		if ( !result.hasErrors() ) {
			res.setData(categoryService.getCategoryListAll(new Category(teach.getHomepage_id(), teach.getGroup_idx())));
		}
		else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

}
