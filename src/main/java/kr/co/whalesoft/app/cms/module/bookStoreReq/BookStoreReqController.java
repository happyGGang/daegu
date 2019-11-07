package kr.co.whalesoft.app.cms.module.bookStoreReq;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.utils.JsonResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping(value = {"/cms/module/bookStoreReq"})
public class BookStoreReqController extends BaseController {

	private final String basePath = "/cms/module/bookStoreReq/";

	@Autowired
	private BookStoreReqService service;

	@RequestMapping(value = { "/index.*" }, method = RequestMethod.GET)
	public String index(Model model, BookStoreReq bookStoreReq, HttpServletRequest request, HttpServletResponse response) throws Exception {

		if(!"h18".equals(getAsideHomepageId(request))) {
			service.alertMessage("접근 권한이 없습니다", request, response);
			return null;
		}

		int listCount = service.getBookStoreReqListCount(bookStoreReq);

		service.setPaging(model, listCount, bookStoreReq);
		model.addAttribute("bookStoreReq", bookStoreReq);
		model.addAttribute("bookStoreReqListCount", listCount);
		model.addAttribute("bookStoreReqList", service.getBookStoreReqList(bookStoreReq));

		return basePath + "index";
	}

	@RequestMapping(value = { "/edit.*" }, method = RequestMethod.GET)
	public String edit(Model model, BookStoreReq bookStoreReq, HttpServletRequest request, HttpServletResponse response) throws Exception {

		if(bookStoreReq.getEditMode().equals("MODIFY")) {
			bookStoreReq = (BookStoreReq) service.copyObjectPaging(bookStoreReq, service.getBookStoreReqOne(bookStoreReq));
		}

		model.addAttribute("bookStoreReq", bookStoreReq);
		return basePath + "edit_ajax";
	}

	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(BookStoreReq bookStoreReq, BindingResult result, HttpServletRequest request) {

		JsonResponse res = new JsonResponse(request);

		Member member = (Member) getSessionMemberInfo(request);
		bookStoreReq.setAdd_id(member.getMember_id());

		if(!result.hasErrors()) {
			bookStoreReq.setAdd_id(member.getMember_id());
			if(bookStoreReq.getEditMode().equals("ADD")) {
				service.addBookStoreReq(bookStoreReq);
				res.setValid(true);
				res.setMessage("등록되었습니다.");

			} else if(bookStoreReq.getEditMode().equals("MODIFY")) {
				service.modifyBookStoreReq(bookStoreReq);
				res.setValid(true);
				res.setMessage("수정되었습니다.");

			} else if(bookStoreReq.getEditMode().equals("DELETE")) {
				service.deleteBookStoreReq(bookStoreReq);
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
