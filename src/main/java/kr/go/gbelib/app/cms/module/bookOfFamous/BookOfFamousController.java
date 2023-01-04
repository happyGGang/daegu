package kr.go.gbelib.app.cms.module.bookOfFamous;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;

@Controller
@RequestMapping(value = {"/cms/module/bookOfFamous"})
public class BookOfFamousController extends BaseController {

	private final String basePath = "/cms/module/bookOfFamous/";

	@Autowired
	private BookOfFamousService service;

	@Autowired
	private HomepageService homepageService;

	@RequestMapping (value = {"/index{url}.*"}, method = RequestMethod.GET)
	public String index(Model model, BookOfFamous boy, HttpServletRequest request, @PathVariable ("url") String url) throws AuthException {
		checkAuth("R", model, request);
		boy.setHomepage_id(getAsideHomepageId(request));

		service.setPaging(model, service.getBookOfFamousCount(boy), boy);
		model.addAttribute("boy", boy);
		model.addAttribute("boyList", service.getBookOfFamousList(boy));

		return basePath + "index" + url;
	}

	@RequestMapping (value = {"/edit.*"}, method = RequestMethod.GET)
	public String edit(Model model, BookOfFamous boy, HttpServletRequest request) throws AuthException {
		Homepage homepage = homepageService.getHomepageOne(new Homepage(getAsideHomepageId(request)));
		model.addAttribute("homepage", homepage);

		if (boy.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			boy = (BookOfFamous)service.copyObjectPaging(boy, service.getBookOfFamousOne(boy));
		} else {
			checkAuth("C", model, request);
		}

		model.addAttribute("bookOfFamous", boy);

		return basePath + "edit_ajax";
	}

	@RequestMapping (value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(BookOfFamous boy, BindingResult result, HttpServletRequest request) {

		JsonResponse res = new JsonResponse(request);

		if (boy.getEditMode().equals("ADD")) {
			ValidationUtils.rejectIfEmpty(result, "famous_name", "추천명사를 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "book_name", "도서명을 입력하세요.");
			if(!StringUtils.isEmpty(boy.getSelection_year())) {
				ValidationUtils.rejectExceptNumber(result, "selection_year", "선정년도는 숫자만 입력이 가능합니다.");
			}
			if(!StringUtils.isEmpty(boy.getBook_year())) {
				ValidationUtils.rejectExceptNumber(result, "book_year", "출판년도는 숫자만 입력이 가능합니다.");
			}
		}

		if (!result.hasErrors()) {

			boy.setAdd_id(getSessionMemberId(request));
			boy.setModify_id(getSessionMemberId(request));

			res.setValid(true);
			res.setUrl("index.do");
			if (boy.getEditMode().equals("ADD")) {
				service.addBookOfFamous(boy);
				res.setMessage("등록되었습니다.");
			} else if (boy.getEditMode().equals("MODIFY")) {
				service.modifyBookOfFamous(boy);
				res.setMessage("수정되었습니다.");
			} else if (boy.getEditMode().equals("DELETE")) {
				service.deleteBookOfFamous(boy);
				res.setMessage("삭제되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
}
