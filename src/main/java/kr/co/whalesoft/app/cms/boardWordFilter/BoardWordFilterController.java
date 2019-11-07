package kr.co.whalesoft.app.cms.boardWordFilter;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;

@Controller
@RequestMapping(value = {"/cms/boardWordFilter"})
public class BoardWordFilterController extends BaseController {

	private final String basePath = "/cms/boardWordFilter/";
	
	@Autowired
	private BoardWordFilterService service;
	
	@RequestMapping(value = {"/index.*"})
	public String index(Model model, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		BoardWordFilter boardWordFilter = service.getBoardWordFilterOne();
		if(boardWordFilter == null) {
			boardWordFilter = new BoardWordFilter();
		}
		
		model.addAttribute("boardWordFilter", boardWordFilter);
		return basePath + "index";
	}
	
	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Model model, BoardWordFilter boardWordFilter, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		
		boardWordFilter.setModify_id(getSessionMemberId(request));
		
		if(!result.hasErrors()) {
			service.addBoardWordFilter(boardWordFilter);
			res.setValid(true);
			res.setMessage("저장 되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}
}