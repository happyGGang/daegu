package kr.co.whalesoft.app.cms.boardBlockIp;

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
import kr.co.whalesoft.framework.utils.ValidationUtils;

@Controller
@RequestMapping(value = {"/cms/boardBlockIp"})
public class BoardBlockIpController extends BaseController {
	
	private final String basePath = "/cms/boardBlockIp/";

	@Autowired
	private BoardBlockIpService service;
	
	@RequestMapping(value = {"/index.*"})
	public String index(Model model, BoardBlockIp boardBlockIp, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		model.addAttribute("boardBlockIpList", service.getBoardBlockIp());
		model.addAttribute("boardBlockIp", boardBlockIp);
		return basePath + "index";
	}
	
	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, BoardBlockIp boardBlockIp, HttpServletRequest request) throws AuthException {
		if(boardBlockIp.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			model.addAttribute("boardBlockIp", service.copyObjectPaging(boardBlockIp, service.getBoardBlockIpOne(boardBlockIp)));
		} else {
			checkAuth("C", model, request);
			model.addAttribute("boardBlockIp", boardBlockIp);
		}
		
		return basePath + "edit_ajax";
	}
	
	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Model model, BoardBlockIp boardBlockIp, BindingResult result, HttpServletRequest request) {
		
		JsonResponse res = new JsonResponse(request);
		
		ValidationUtils.rejectIfEmpty(result, "block_ip", "차단할 IP를 입력하세요.");
		
		boardBlockIp.setAdd_id(getSessionMemberId(request));
		
		if(!result.hasErrors()) {
			if(boardBlockIp.getEditMode().equals("ADD")) {
				service.addBoardBlockIp(boardBlockIp);
				res.setValid(true);
				res.setMessage("등록 되었습니다.");
			} else if(boardBlockIp.getEditMode().equals("MODIFY")) {
				service.modifyBoardBlockIp(boardBlockIp);
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			} else if(boardBlockIp.getEditMode().equals("DELETE")) {
				service.deleteBoardBlockIp(boardBlockIp);
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
