package kr.go.gbelib.app.module.facilityBook;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.app.cms.menu.Menu;
import kr.co.whalesoft.app.cms.terms.Terms;
import kr.co.whalesoft.app.cms.terms.TermsService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.cms.module.facilityBook.FacilityBook;
import kr.go.gbelib.app.cms.module.facilityBook.FacilityBookService;

@Controller(value="userFacilityBook")
@RequestMapping(value = {"/{homepagePath}/module/facilityBook"})
public class FacilityBookController extends BaseController {
	
	private String basePath = "/homepage/%s/module/facilityBook/";

	@Autowired
	private FacilityBookService service;
	
	@Autowired
	private HomepageService homepageService;
	
	@Autowired
	private TermsService termsService;
	
	@RequestMapping(value = {"/index.*"})
	public String index(Model model, FacilityBook facilityBook, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		facilityBook.setHomepage_id(homepage.getHomepage_id());

		if ( StringUtils.isEmpty(facilityBook.getPlan_date()) ) {
			facilityBook.setPlan_date(new SimpleDateFormat("yyyy-MM").format(new Date()));
		}

		model.addAttribute("facilityBook", facilityBook);
		model.addAttribute("calendarList", service.getCalendar(facilityBook));
		model.addAttribute("applyList", service.convertToRepo(service.getApplyList(facilityBook)));
		model.addAttribute("closeList", service.getFacilityBookClose(facilityBook));

		return String.format(basePath, homepage.getFolder()) + "index";
	}
	
	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, FacilityBook facilityBook, HttpServletRequest request) throws Exception {
//		checkAuth("C", model, request);
		
		Homepage homepage = homepageService.getHomepageOne(new Homepage(facilityBook.getHomepage_id()));
		
		facilityBook.setApply_date(facilityBook.getPlan_date());
		facilityBook.setFacility_book_name("1");
		facilityBook.setAdd_date(new Date());
		
		//약관 연동부
		Menu menuOne = (Menu)request.getAttribute("menuOne");
		model.addAttribute("termsList", termsService.getTermsListInModule(new Terms(homepage.getHomepage_id(), menuOne.getManage_idx(), "module")));

		return String.format(basePath, homepage.getFolder()) + "edit";
	}
	
	@RequestMapping (value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(FacilityBook facilityBook, BindingResult result, HttpServletRequest request) {
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		ValidationUtils.rejectIfEmpty(result, "apply_name", "신청인을 입력하세요.");
		ValidationUtils.rejectIfEmpty(result, "phone1", "신청자 연락처를 입력하세요.");
		ValidationUtils.rejectIfEmpty(result, "phone2", "신청자 연락처를 입력하세요.");
		ValidationUtils.rejectIfEmpty(result, "phone3", "신청자 연락처를 입력하세요.");
		ValidationUtils.rejectIfEmpty(result, "sub_phone1", "참여인원 연락처를 입력하세요.");
		ValidationUtils.rejectIfEmpty(result, "sub_phone2", "참여인원 연락처를 입력하세요.");
		ValidationUtils.rejectIfEmpty(result, "sub_phone3", "참여인원 연락처를 입력하세요.");
		ValidationUtils.rejectIfEmpty(result, "apply_date", "이용시간을 입력하세요.");
		ValidationUtils.rejectIfEmpty(result, "curcles_name", "모임명을 입력하세요.");
		
		if(facilityBook.getMan_count() == 0 && facilityBook.getWoman_count() == 0) {
			result.rejectValue("man_count", "참여인원을 입력하세요.");
		}
		ValidationUtils.rejectIfEmpty(result, "attend_list", "참가자 명단을 입력하세요.");
		ValidationUtils.rejectIfEmpty(result, "add_id", "신청인을 입력하세요.");
		
		int duplChk = service.getFacilityBookDuplCheck(facilityBook);
		if(duplChk > 0) {
			result.reject("해당 시설은 이미 신청자가 있습니다.");
		}
		
		int closeDuplChk = service.getCloseDuplCheck(facilityBook);
		if(closeDuplChk > 0) {
			result.reject("해당 시설은 휴관입니다.");
		}
		/* <<<<< 유효성 검증 */

		if (!result.hasErrors()) {
			if (facilityBook.getEditMode().equals("ADD")) {
				res.setValid(true);
				service.addFacilityBook(facilityBook);
				res.setUrl("index.do?menu_idx="+facilityBook.getMenu_idx());
				res.setMessage("신청되었습니다.");
			} else if (facilityBook.getEditMode().equals("MODIFY")) {
				res.setValid(true);
				res.setUrl("index.do?menu_idx="+facilityBook.getMenu_idx());
				res.setMessage("수정되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
	
	@RequestMapping (value = {"/apply.*"}, method = RequestMethod.GET)
	public String apply(Model model, FacilityBook facilityBook, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		facilityBook.setHomepage_id(homepage.getHomepage_id());
		
		service.setPaging(model, service.getFacilityBookCount(facilityBook), facilityBook);
		model.addAttribute("applyList", service.getFacilityBookAll(facilityBook));

		return String.format(basePath, homepage.getFolder()) + "apply";
	}

}
