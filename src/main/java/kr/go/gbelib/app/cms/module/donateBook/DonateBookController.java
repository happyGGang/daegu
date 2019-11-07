package kr.go.gbelib.app.cms.module.donateBook;

import java.util.List;

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
import kr.co.whalesoft.app.cms.code.CodeService;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.common.api.PushAPI;

@Controller
@RequestMapping(value = {"/cms/module/donateBook"})
public class DonateBookController extends BaseController {

	private final String basePath = "/cms/module/donateBook/";

	@Autowired
	private DonateBookService donateBookService;
	
	@Autowired
	private CodeService codeService;
	
	@RequestMapping(value = {"/index.*"})
	public String index(Model model, DonateBook donateBook, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
//		if ( !getSessionIsAdmin(request) ) {
			donateBook.setHomepage_id(getAsideHomepageId(request));	
//		}
		int count = donateBookService.getDonateBookListCount(donateBook);
		donateBookService.setPaging(model, count, donateBook);
		model.addAttribute("donateBook", donateBook);
		model.addAttribute("donateBookListCount", count);
		model.addAttribute("donateBookList", donateBookService.getDonateBookList(donateBook));
		return basePath + "index";
	}
	
	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, DonateBook donateBook, HttpServletRequest request) throws AuthException {
		
		if(donateBook.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			donateBook = (DonateBook) donateBookService.copyObjectPaging(donateBook, donateBookService.getDonateBookOne(donateBook));
		} else {
			checkAuth("C", model, request);
		}
		
		model.addAttribute("donateBook", donateBook);
		model.addAttribute("cellPhoneCode", codeService.getCode(donateBook.getHomepage_id(), "C0002"));
		model.addAttribute("phoneCode", codeService.getCode(donateBook.getHomepage_id(), "C0003"));
		return basePath + "edit_ajax";
	}
	
	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Model model, DonateBook donateBook, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		String editMode = donateBook.getEditMode();
		if(!donateBook.getEditMode().equals("DELETE")) {
			ValidationUtils.rejectIfEmpty(result, "name", "기증자명을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "donate_book", "기증도서정보를 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "donate_count", "기증권수를 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "donate_method", "기증방법을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "donate_year", "기증년을 선택해주세요.");
			ValidationUtils.rejectIfEmpty(result, "donate_month", "기증월을 선택해주세요.");
		}
		if(!result.hasErrors()) {
			if(editMode.equals("ADD")) {
				donateBookService.addDonateBook(donateBook);
				res.setValid(true);
				res.setMessage("등록 되었습니다.");
				if (StringUtils.equals(donateBook.getDonate_yn(), "Y")) {
					Homepage homepage = getHomepageOne(donateBook.getHomepage_id());
					PushAPI.sendMessage(homepage, PushAPI.SMS_TYPE_SMS, donateBook.getCell_phone(), "기증도서 신청이 정상 접수 되었습니다.", homepage.getHomepage_send_tell(), true);
				}
			} else if(editMode.equals("MODIFY")) {
				donateBookService.modifyDonateBook(donateBook);
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			} else if(editMode.equals("DELETE")) {
				donateBookService.deleteDonateBook(donateBook);
				res.setValid(true);
				res.setMessage("삭제 되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}
	
	@RequestMapping(value = {"/excelDownload.*"}, method = RequestMethod.POST)
	public DonateBookSearchView excel(Model model, DonateBook donateBook, HttpServletRequest request, HttpServletResponse response) throws Exception{
		model.addAttribute("donateBook", donateBook); 
		model.addAttribute("donateBookResult", donateBookService.getDonateBookListAll(donateBook));
		return new DonateBookSearchView();
	}
	
	@RequestMapping(value = {"/csvDownload.*"}, method = RequestMethod.POST)
	public void csv(DonateBook donateBook, HttpServletRequest request, HttpServletResponse response) throws Exception{
		List<DonateBook> donateBookResult = donateBookService.getDonateBookListAll(donateBook);
		
		new DonateBookXlsToCsv(donateBook, donateBookResult, request, response);
	}
}