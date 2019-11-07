package kr.co.whalesoft.app.cms.boardRegexFilter;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.app.cms.boardRegexFilter.BoardRegexFilter;
import kr.co.whalesoft.app.cms.boardRegexFilter.BoardRegexFilterService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;

@Controller
@RequestMapping(value = {"/cms/boardRegexFilter"})
public class BoardRegexFilterController extends BaseController {

	private final String basePath = "/cms/boardRegexFilter/";

	@Autowired
	private BoardRegexFilterService service;
	
	@RequestMapping(value = {"/index.*"})
	public String index(Model model, BoardRegexFilter boardRegexFilter, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		model.addAttribute("boardRegexFilterList", service.getBoardRegexFilter());
		model.addAttribute("boardRegexFilter", boardRegexFilter);
		return basePath + "index";
	}
	
	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, BoardRegexFilter boardRegexFilter, HttpServletRequest request) throws AuthException {
		if(boardRegexFilter.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			model.addAttribute("boardRegexFilter", service.copyObjectPaging(boardRegexFilter, service.getBoardRegexFilterOne(boardRegexFilter)));
		} else {
			checkAuth("C", model, request);
			model.addAttribute("boardRegexFilter", boardRegexFilter);
		}
		
		return basePath + "edit_ajax";
	}
	
	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Model model, BoardRegexFilter boardRegexFilter, BindingResult result, HttpServletRequest request) {
		
		JsonResponse res = new JsonResponse(request);
		
		boardRegexFilter.setAdd_id(getSessionMemberId(request));
		
		if(!result.hasErrors()) {
			if(boardRegexFilter.getEditMode().equals("ADD")) {
				service.addBoardRegexFilter(boardRegexFilter);
				res.setValid(true);
				res.setMessage("등록 되었습니다.");
			} else if(boardRegexFilter.getEditMode().equals("MODIFY")) {
				service.modifyBoardRegexFilter(boardRegexFilter);
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			} else if(boardRegexFilter.getEditMode().equals("DELETE")) {
				service.deleteBoardRegexFilter(boardRegexFilter);
				res.setValid(true);
				res.setMessage("삭제 되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}
	
}