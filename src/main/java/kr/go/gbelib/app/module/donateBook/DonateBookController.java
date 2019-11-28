package kr.go.gbelib.app.module.donateBook;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.app.cms.menu.Menu;
import kr.co.whalesoft.app.cms.recommendSite.RecommendSite;
import kr.co.whalesoft.app.cms.recommendSite.RecommendSiteService;
import kr.co.whalesoft.app.cms.terms.Terms;
import kr.co.whalesoft.app.cms.terms.TermsService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.cms.module.donateBook.DonateBook;
import kr.go.gbelib.app.cms.module.donateBook.DonateBookService;
import kr.go.gbelib.app.common.api.PushAPI;

@Controller(value="userDonateBook")
@RequestMapping(value = {"/{homepagePath}/module/donateBook"})
public class DonateBookController extends BaseController{

	private String basePath = "/homepage/%s/module/donateBook/";

	@Autowired
	private DonateBookService service;

	@Autowired
	private TermsService termsService;

	@Autowired
	private RecommendSiteService recommendSiteService;

	@ModelAttribute("siteList")
	public List<RecommendSite> getAreaCdList(HttpServletRequest request) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		return recommendSiteService.getRecommendSiteListAll(new RecommendSite(homepage.getHomepage_id()));
	}

	@RequestMapping(value = {"/index.*"})
	public String index(Model model, DonateBook donateBook, HttpServletRequest request) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		donateBook.setHomepage_id(homepage.getHomepage_id());

		model.addAttribute("donateBook", donateBook);
		model.addAttribute("donateBookList", service.getDonateBookList(donateBook));
		model.addAttribute("donateBookListCount", service.getDonateBookList(donateBook).size());
		return String.format(basePath, homepage.getFolder()) + "index_ajax";
	}

	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, DonateBook donateBook, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		if ( !isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			donateBook.setBefore_url(String.format("http://www.gbelib.kr/%s/html.do?menu_idx=%s", homepage.getContext_path(), donateBook.getMenu_idx()));
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("http://www.gbelib.kr/%s/intro/login/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), donateBook.getMenu_idx(), donateBook.getBefore_url()), request, response);
			return null;
	    }

		//약관 연동부
		Menu menuOne = (Menu) request.getAttribute("menuOne");
		model.addAttribute("termsList", termsService.getTermsListInModule(new Terms(menuOne.getManage_idx())));

		donateBook.setHomepage_id(homepage.getHomepage_id());
		if(donateBook.getEditMode().equals("MODIFY")) {
			model.addAttribute("donateBook", service.copyObjectPaging(donateBook, service.getDonateBookOne(donateBook)));
		} else {
			model.addAttribute("donateBook", donateBook);
		}

		model.addAttribute("member", getSessionMemberInfo(request));

		return String.format(basePath, homepage.getFolder()) + "edit";
	}

	@Transactional
	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Model model, DonateBook donateBook, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		String editMode = donateBook.getEditMode();
		Homepage homepage = (Homepage)request.getAttribute("homepage");
		if(!donateBook.getEditMode().equals("DELETE")) {
			ValidationUtils.rejectIfEmpty(result, "name", "기증자명을 입력하세요.");
//			ValidationUtils.rejectIfEmpty(result, "phone1", "전화번호를 입력해주세요.");
//			ValidationUtils.rejectIfEmpty(result, "phone2", "전화번호를 입력해주세요.");
//			ValidationUtils.rejectIfEmpty(result, "phone3", "전화번호를 입력해주세요.");
			ValidationUtils.rejectIfEmpty(result, "cell_phone1", "휴대번호를 입력해주세요.");
			ValidationUtils.rejectIfEmpty(result, "cell_phone2", "휴대번호를 입력해주세요.");
			ValidationUtils.rejectIfEmpty(result, "cell_phone3", "휴대번호를 입력해주세요.");
			ValidationUtils.rejectIfEmpty(result, "donate_book", "기증도서정보를 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "donate_count", "기증권수를 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "donate_method", "기증방법을 입력하세요.");
//			ValidationUtils.rejectIfEmpty(result, "donate_year", "기증년을 선택해주세요.");
//			ValidationUtils.rejectIfEmpty(result, "donate_month", "기증월을 선택해주세요.");

			if ( !"Y".equals(donateBook.getSelf_info_yn()) ) {
				res.setValid(false);
				res.setMessage("개인정보 동의 후 신청이 가능합니다.");
				return res;
			}
		}

		if(!result.hasErrors()) {
			if(editMode.equals("ADD")) {
				service.addDonateBook(donateBook);
				res.setValid(true);
				res.setMessage("등록 되었습니다.");
				res.setUrl("index.do?menu_idx=" + donateBook.getMenu_idx());
				Member member = getSessionMemberInfo(request);
				if (StringUtils.equals(member.getSms_service_yn(), "Y")) {
					PushAPI.sendMessage(homepage, PushAPI.SMS_TYPE_SMS, donateBook.getCell_phone(), "기증도서 신청이 완료되었습니다.", homepage.getHomepage_send_tell(), true);
				}
			} else if(editMode.equals("MODIFY")) {
				service.modifyDonateBook(donateBook);
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
				res.setUrl("index.do?menu_idx=" + donateBook.getMenu_idx());
			} else if(editMode.equals("DELETE")) {
				service.deleteDonateBook(donateBook);
				res.setValid(true);
				res.setMessage("삭제 되었습니다.");
			} else {
				res.setValid(false);
				res.setMessage("권한이 없습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		return res;
	}

}
