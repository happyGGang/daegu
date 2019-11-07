package kr.co.whalesoft.app.cms.module.bookStore;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
@RequestMapping(value = {"/cms/module/bookStore"})
public class BookStoreController extends BaseController {

	private final String basePath = "/cms/module/bookStore/";

	@Autowired
	private BookStoreService service;

	@RequestMapping(value = { "/index.*" }, method = RequestMethod.GET)
	public String index(Model model, BookStore bookStore, HttpServletRequest request, HttpServletResponse response) throws Exception {

		if(!"h18".equals(getAsideHomepageId(request))) {
			service.alertMessage("접근 권한이 없습니다", request, response);
			return null;
		}

		int listCount = service.getBookStoreListCount(bookStore);

		service.setPaging(model, listCount, bookStore);
		model.addAttribute("bookStore", bookStore);
		model.addAttribute("bookStoreListCount", listCount);
		model.addAttribute("bookStoreList", service.getBookStoreList(bookStore));

		return basePath + "index";
	}

	@RequestMapping(value = { "/edit.*" }, method = RequestMethod.GET)
	public String edit(Model model, BookStore bookStore, HttpServletRequest request, HttpServletResponse response) throws Exception {

		if(bookStore.getEditMode().equals("MODIFY")) {
			bookStore = (BookStore) service.copyObjectPaging(bookStore, service.getBookStoreOne(bookStore));
		}

		model.addAttribute("bookStore", bookStore);
		return basePath + "edit_ajax";
	}

	@RequestMapping(value = {"/excelDownload.*"}, method = RequestMethod.POST)
	public BookStoreSearchView excel(Model model, BookStore bookStore, HttpServletRequest request, HttpServletResponse response) throws Exception{

		model.addAttribute("bookStore", bookStore);
		model.addAttribute("bookStoreResult", service.getBookStoreListAll(bookStore));
		return new BookStoreSearchView();
	}

	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(BookStore bookStore, BindingResult result, HttpServletRequest request) {

		JsonResponse res = new JsonResponse(request);

		if(!bookStore.getEditMode().equals("DELETE")) {
			ValidationUtils.rejectIfEmpty(result, "loan_seq", "대출번호를 입력해주세요.");
			ValidationUtils.rejectIfEmpty(result, "loan_name", "대출자명을 입력해주세요.");
			ValidationUtils.rejectIfEmpty(result, "title", "제목을 입력해주세요.");
			ValidationUtils.rejectIfEmpty(result, "regist_num", "등록번호를 입력해주세요.");
			ValidationUtils.rejectIfEmpty(result, "claim_sign", "청구기호를 입력해주세요.");

			bookStore.setLoan_seq(bookStore.getLoan_seq().replaceAll(" ", ""));
		}

		Member member = (Member) getSessionMemberInfo(request);
		bookStore.setAdd_id(member.getMember_id());

		if(!result.hasErrors()) {
			bookStore.setAdd_id(member.getMember_id());
			if(bookStore.getEditMode().equals("ADD")) {
				service.addBookStore(bookStore);
				res.setValid(true);
				res.setMessage("등록되었습니다.");

			} else if(bookStore.getEditMode().equals("MODIFY")) {
				service.modifyBookStore(bookStore);
				res.setValid(true);
				res.setMessage("수정되었습니다.");

			} else if(bookStore.getEditMode().equals("DELETE")) {
				service.deleteBookStore(bookStore);
				res.setValid(true);
				res.setMessage("삭제되었습니다.");
			}

		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

}
