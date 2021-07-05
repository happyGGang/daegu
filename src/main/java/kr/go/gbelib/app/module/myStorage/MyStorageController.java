package kr.go.gbelib.app.module.myStorage;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.app.cms.recommendSite.RecommendSite;
import kr.co.whalesoft.app.cms.recommendSite.RecommendSiteService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.module.myItem.MyItem;
import kr.go.gbelib.app.module.myItem.MyItemService;

@Controller
@RequestMapping(value = {"/{homepagePath}/module/myStorage"})
public class MyStorageController extends BaseController {

	private String basePath = "/homepage/%s/module/myStorage/";

	@Autowired
	private MyStorageService service;

	@Autowired
	private MyItemService myItemService;

	@Autowired
	private HomepageService homepageService;


	@Autowired
	private RecommendSiteService recommendSiteService;

	@ModelAttribute("recommendSiteList")
	public List<RecommendSite> getAreaCdList(HttpServletRequest request) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		return recommendSiteService.getRecommendSiteListAll(new RecommendSite(homepage.getHomepage_id()));
	}

	@RequestMapping(value = {"/index.*"})
	public String index(Model model, MyStorage myStorage, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		if ( !isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			myStorage.setBefore_url(String.format("/%s/module/myStorage/index.do?menu_idx=%s", homepage.getContext_path(), myStorage.getMenu_idx()));
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), myStorage.getMenu_idx(), myStorage.getBefore_url()), request, response);
			return null;
		}

		myStorage.setHomepage_id(homepage.getHomepage_id());
		model.addAttribute("member", getSessionMemberInfo(request));
		model.addAttribute("myStorage", myStorage);
		return String.format(basePath, homepage.getFolder()) + "index";
	}

	@RequestMapping(value="/getMyStorageTreeList.*", method=RequestMethod.GET)
	public @ResponseBody List<MyStorage> getMyStorageTreeList(MyStorage myStorage, HttpServletRequest request) {
		myStorage.setMember_key(getSessionMemberId(request));
		return service.getMyStorageTreeList(myStorage);
	}

	@RequestMapping(value="/getMyStorageOne.*", method=RequestMethod.GET)
	public @ResponseBody MyStorage getMyStorageOne(Model model, MyStorage myStorage, HttpServletRequest request) {
		myStorage.setMember_key(getSessionMemberId(request));
		return service.getMyStorageOne(myStorage);
	}

	/*@RequestMapping(value="/editMemberOrga.*", method=RequestMethod.GET)
	public String editMemberOrga(Model model, MemberOrganization memberOrga) {
		model.addAttribute("memberOrga", memberOrga);
		model.addAttribute("memberList", memberOrgaService.getMemberNotInOrganization(memberOrga));
		return basePath + "editMemberOrga_ajax";
	}

	*/

	@RequestMapping(value="/getItemList.*", method=RequestMethod.GET)
	public String getItemList(Model model, MyItem myItem, HttpServletRequest request) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		myItem.setMember_key(getSessionMemberId(request));
		myItem.setHomepage_id(homepage.getHomepage_id());
		model.addAttribute("myItemList", myItemService.getMyItemList(myItem));
		return basePath + "myItem_ajax";
	}

	@RequestMapping(value = {"/viewStorage.*"})
	public String viewStorage(Model model, MyItem myItem, HttpServletRequest request, HttpServletResponse response) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		// img_url 변조 확인
		if(!request.getParameterMap().containsKey("ctrl_no")) {
		String[] allow_urls = {"localhost/%s/board/view.do", "library.daegu.go.kr/%s/board/view.do"};
		boolean param_err_flg = false;
			String redirectURL = request.isSecure() ? "https://" : "http://";
			for (String url_tmp : allow_urls) {
				url_tmp = redirectURL + String.format(url_tmp, homepage.getContext_path());
				int paramIdx = myItem.getImg_url().indexOf('?');
				if(paramIdx > -1 && StringUtils.equals(url_tmp, myItem.getImg_url().substring(0, paramIdx))) {
					param_err_flg = true;
					break;
				}
			}
			
			if(!param_err_flg) {
				try {
					service.alertMessage("보관함에 담을 수 없습니다.", request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
				return null;
			}
		}
		// img_url 변조 확인 END
		
		myItem.setHomepage_id(homepage.getHomepage_id());
		model.addAttribute("member", getSessionMemberInfo(request));
		model.addAttribute("myItem", myItem);
		return String.format(basePath, homepage.getFolder()) + "viewStorage_ajax";
	}

	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Model model, MyStorage myStorage, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		if ( !myStorage.getEditMode().equals("DELETE") && !myStorage.getEditMode().equals("PARENTMOVE") ) {
			ValidationUtils.rejectIfEmpty(result, "storage_name", "보관함명을 입력하세요.");
		}
		myStorage.setHomepage_id(homepage.getHomepage_id());
		myStorage.setMember_key(getSessionMemberId(request));

		if ( !result.hasErrors() ) {
			if ( myStorage.getEditMode().equals("ADD") ) {
				service.addMyStorage(myStorage);
				res.setValid(true);
				res.setMessage("등록 되었습니다.");
			}
			else if ( myStorage.getEditMode().equals("MODIFY") ) {
				service.modifyMyStorage(myStorage);
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			}
			else if ( myStorage.getEditMode().equals("DELETE") ) {
				if ( service.getChildCount(myStorage) > 0 ) {
					res.setValid(false);
					res.setMessage("하위 보관함이 존재하여 삭제할 수 없습니다.");
				}
				else {
					service.deleteMyStorage(myStorage);
					res.setValid(true);
					res.setMessage("삭제 되었습니다.");
				}
			}
			else if ( myStorage.getEditMode().equals("PARENTMOVE") ) {
				service.moveMyStorage(myStorage);
				res.setValid(true);
				res.setMessage("이동 되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	@RequestMapping(value = {"/saveItem.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse saveItem(Model model, MyItem myItem, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		myItem.setHomepage_id(homepage.getHomepage_id());
		myItem.setMember_key(getSessionMemberId(request));

		if ( !result.hasErrors() ) {
			if ( myItem.getEditMode().equals("ADD") ) {
				if (myItem.getStrList() == null || myItem.getStrList().size() < 1) {
					myItemService.addMyItem(myItem);
					res.setValid(true);
					res.setMessage("보관함에 정상 등록 되었습니다.");
				} else {
					for (String str : myItem.getStrList()) {

						String[] lib_rec_tid = str.split("\\^\\^\\^");

						MyItem item = new MyItem(myItem.getHomepage_id(), myItem.getMember_key());
						item.setStorage_idx(myItem.getStorage_idx());

						item.setItem_name(String.valueOf(lib_rec_tid[0]).replaceAll(";;;", ","));
						item.setPubler(String.valueOf(lib_rec_tid[1]));
						item.setLoca(String.valueOf(lib_rec_tid[2]));
						item.setCtrl_no(lib_rec_tid[3]);
						item.setCall_no(lib_rec_tid[4]);
						item.setImg_url(lib_rec_tid[5]);
						myItemService.addMyItem(item);
					}
					res.setValid(true);
					res.setMessage("보관함에 정상 등록 되었습니다.");
				}
			}
			else if ( myItem.getEditMode().equals("DELETE") ) {
				myItemService.deleteMyItem(myItem);
				res.setValid(true);
				res.setMessage("삭제 되었습니다.");
			}
			/*else if ( storage.getEditMode().equals("PARENTMOVE") ) {
				service.moveMyStorage(storage);
				res.setValid(true);
				res.setMessage("이동 되었습니다.");
			}*/
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}


	/*@RequestMapping(value = {"/saveMemberOrga.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse saveMemberOrga(Model model, MemberOrganization memberOrga, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);

		if ( memberOrga.getEditMode().equals("ADD") ) {
			if ( memberOrga.getMember_id_list() == null || memberOrga.getMember_id_list().size() == 0 ) {
				result.reject("사용자를 선택해주세요.");
			}
		}

		if(!result.hasErrors()) {
			if(memberOrga.getEditMode().equals("ADD")) {
				memberOrgaService.addMemberOrganization(memberOrga);
				res.setValid(true);
				res.setMessage("등록 되었습니다.");
			} else if(memberOrga.getEditMode().equals("DELETE")) {
				memberOrgaService.deleteMemberOrganization(memberOrga);
				res.setValid(true);
				res.setMessage("삭제 되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}*/

	/**
	 * 내 보관함 메뉴로 REDIRECT
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value = { "/goMyStorage.*" }, method = RequestMethod.GET)
	public String index(Model model, HttpServletRequest request) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		int menuIdx = homepageService.getMenuIdxByProgramIdx(homepage.getHomepage_id(), 94);
		return String.format("redirect:/%s/module/myStorage/index.do?menu_idx=%s", homepage.getContext_path(), menuIdx);
	}
}