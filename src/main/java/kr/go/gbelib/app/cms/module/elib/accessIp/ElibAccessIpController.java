package kr.go.gbelib.app.cms.module.elib.accessIp;

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
@RequestMapping(value = {"/cms/module/elib/accessIp"})
public class ElibAccessIpController extends BaseController {
	
	private final String basePath = "/cms/module/elib/accessIp/"; 

	@Autowired
	private ElibAccessIpService service;
	
	@RequestMapping(value = {"/index.*"})
	public String index(Model model, ElibAccessIp accessIp, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		int count = service.getAccessIpCnt();
		service.setPaging(model, count, accessIp);
		model.addAttribute("accessIp", accessIp);
		model.addAttribute("accessIpCnt", count);
		model.addAttribute("accessIpList", service.getAccessIp(accessIp));
		return basePath + "index";
	}
	
	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, ElibAccessIp accessIp, HttpServletRequest request) throws AuthException {
		if(accessIp.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			model.addAttribute("accessIp", service.copyObjectPaging(accessIp, service.getAccessIpOne(accessIp)));
		} else {
			checkAuth("C", model, request);
			model.addAttribute("accessIp", accessIp);
		}
		
		return basePath + "edit_ajax";
	}
	
	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Model model, ElibAccessIp accessIp, BindingResult result, HttpServletRequest request) {
		
		JsonResponse res = new JsonResponse(request);
		
		if(!accessIp.getEditMode().equals("DELETE")) {
			ValidationUtils.rejectIfEmpty(result, "access_ip", "제한할 IP를 입력하세요.");
		}
		
		if(!result.hasErrors()) {
//			if ( getSessionIsAdmin(request) ) {
				if(accessIp.getEditMode().equals("ADD")) {
					accessIp.setAdd_id(getSessionMemberId(request));
					service.addAccessIp(accessIp);
					res.setValid(true);
					res.setMessage("등록 되었습니다.");
				} else if(accessIp.getEditMode().equals("MODIFY")) {
					accessIp.setMod_id(getSessionMemberId(request));
					service.modifyAccessIp(accessIp);
					res.setValid(true);
					res.setMessage("수정 되었습니다.");
				} else if(accessIp.getEditMode().equals("DELETE")) {
					service.deleteAccessIp(accessIp);
					res.setValid(true);
					res.setMessage("삭제 되었습니다.");
				}	
//			}
//			else {
//				res.setValid(false);
//				res.setMessage("권한이 없습니다.");
//			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}
	
}