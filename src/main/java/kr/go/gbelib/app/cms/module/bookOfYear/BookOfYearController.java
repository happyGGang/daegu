/**
 *
 */
package kr.go.gbelib.app.cms.module.bookOfYear;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;

/**
 * @author whaleesoft YONGJU 2020. 2. 12.
 *
 */
@Controller
@RequestMapping(value = {"/cms/module/bookOfYear"})
public class BookOfYearController extends BaseController {

	private final String basePath = "/cms/module/bookOfYear/";

	@Autowired
	private BookOfYearService service;

	@RequestMapping (value = {"/index{url}.*"}, method = RequestMethod.GET)
	public String index(Model model, BookOfYear boy, HttpServletRequest request, @PathVariable ("url") String url) throws AuthException {
		checkAuth("R", model, request);
		boy.setHomepage_id(getAsideHomepageId(request));
		service.setPaging(model, service.getBookOfYearCount(boy), boy);
		model.addAttribute("boy", boy);
		model.addAttribute("boyList", service.getBookOfYearList(boy));

		return basePath + "index" + url;
	}

	@RequestMapping (value = {"/edit.*"}, method = RequestMethod.GET)
	public String edit(Model model, BookOfYear boy, HttpServletRequest request) throws AuthException {

		if (boy.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			boy = (BookOfYear)service.copyObjectPaging(boy, service.getBookOfYearOne(boy));
		} else {
			checkAuth("C", model, request);
		}

		model.addAttribute("bookOfYear", boy);

		return basePath + "edit_ajax";
	}

	@RequestMapping (value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(BookOfYear boy, BindingResult result, HttpServletRequest request) {

		JsonResponse res = new JsonResponse(request);

		if (boy.getEditMode().equals("ADD")) {
			ValidationUtils.rejectIfEmpty(result, "book_name", "도서명을 입력하세요.");
		}

		if (!result.hasErrors()) {

			boy.setAdd_id(getSessionMemberId(request));
			boy.setModify_id(getSessionMemberId(request));

			res.setValid(true);
			res.setUrl("index.do");
			if (boy.getEditMode().equals("ADD")) {
				if (service.getBookOfYearOne(boy) != null) {
					res.setMessage("해당년도에 선정된 도서가 존재합니다.");
					res.setValid(false);
					res.setUrl("");
				} else {
					service.addBookOfYear(boy);
					res.setMessage("등록되었습니다.");
				}
			} else if (boy.getEditMode().equals("MODIFY")) {
				service.modifyBookOfYear(boy);
				res.setMessage("수정되었습니다.");
			} else if (boy.getEditMode().equals("DELETE")) {
				service.deleteBookOfYear(boy);
				res.setMessage("삭제되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
}
