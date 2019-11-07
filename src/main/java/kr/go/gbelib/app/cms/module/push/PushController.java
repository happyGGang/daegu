package kr.go.gbelib.app.cms.module.push;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.RequestUtils;
import kr.co.whalesoft.framework.utils.ValidationUtils;

@Controller
@RequestMapping(value = {"/cms/module/push"})
public class PushController extends BaseController{

	private final String basePath = "/cms/module/push/";

	@Autowired
	private PushService service;
	
	@RequestMapping(value = { "/index.*" })
	public String index(Model model, Push push, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		if ( push.getLib_code() == null ) {
			if ( getSessionIsAdmin(request) ) {
				push.setLib_code("admin");
			} else {
				push.setLib_code(getHomepageOne(getAsideHomepageId(request)).getHomepage_code());
			}	
		}
		
		int count = service.getPushListCount(push);
		push.setTotalDataCount(count);
		service.setPaging(model, count, push);
		
		model.addAttribute("push", push);
		model.addAttribute("pushListCount", count);
		model.addAttribute("pushList", service.getPushList(push));
		
		return basePath + "index";
	}
	
	@RequestMapping(value = { "/edit.*" }, method = RequestMethod.GET)
	public String edit(Model model, Push push, HttpServletRequest request) throws AuthException {
		
		if ( push.getEditMode().equals("ADD") ) {
			checkAuth("R", model, request);
			if ( getSessionIsAdmin(request) ) {
				push.setLib_code("admin");
			} else {
				push.setLib_code(getHomepageOne(getAsideHomepageId(request)).getHomepage_code());
			}	
			model.addAttribute("push", push);
		} else if ( push.getEditMode().equals("MODIFY") ) {
			checkAuth("R", model, request);
			model.addAttribute("push", service.copyObjectPaging(push, service.getPushOne(push)));
		}
						
		return basePath + "edit_ajax";
	}
	
	
	@RequestMapping(value = { "/save.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Push push, BindingResult result, HttpServletRequest request) {
		
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		
		if ( push.getEditMode().equals("ADD") ||  push.getEditMode().equals("MODIFY") ) {
			ValidationUtils.rejectIfEmpty(result, "lib_code", "도서관을 선택해주세요.");
			ValidationUtils.rejectIfEmpty(result, "push_msg", "푸시메시지를 입력해주세요.");
			ValidationUtils.rejectIfEmpty(result, "push_date", "발송일자를 지정해주세요.");
			
			if ( "일반텍스트".equals(push.getPush_type()) ) {
				push.setPush_url("http://www.gbelib.kr");
				if ( push.getPush_msg().length() > 20 ) {
					res.setValid(false);
					res.setMessage("일반텍스트 일 경우 메시지 길이는 20자 제한입니다.");
					return res;
				}
			}
			else if ( "긴텍스트".equals(push.getPush_type()) ) {
				push.setPush_url("http://www.gbelib.kr");
				if ( push.getPush_msg().length() > 150 ) {
					res.setValid(false);
					res.setMessage("긴텍스트 일 경우 메시지 길이는 150자 제한입니다.");
					return res;
				}
			}	
		}
		
		if (!result.hasErrors()) {
			Member member = getSessionMemberInfo(request);
			
			if (push.getEditMode().equals("ADD")) {
				push.setPush_reg_id(member.getMember_id());
				push.setPush_reg_nm(member.getMember_name());
				push.setPush_reg_ip(RequestUtils.getClientIpAddr(request));
				service.addPush(push);
				res.setValid(true);
				res.setMessage("등록 되었습니다.");
			} 
			else if (push.getEditMode().equals("MODIFY")) {
				push.setPush_mod_id(member.getMember_id());
				push.setPush_mod_nm(member.getMember_name());
				push.setPush_mod_ip(RequestUtils.getClientIpAddr(request));
				service.modifyPush(push);
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			}
			else if ( push.getEditMode().equals("FILEDELETE") ) {
				service.deletePushFile(push);
				res.setValid(true);
				res.setMessage("파일 정상 삭제 되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
	
}
