package kr.co.whalesoft.app.cms.accountLock;

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
@RequestMapping(value = {"/cms/accountLock", "/wbuilder/accountLock"})
public class AccountLockController extends BaseController {
	
	private final String basePath = "/cms/accountLock/";
	private final String wbuilderPath = "/wbuilder/accountLock/";
	
	@Autowired
	private AccountLockService service;
	
	@RequestMapping(value = {"/index.*"})
	public String index(Model model, AccountLock accountLock, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		accountLock.setHomepage_id(getAsideHomepageId(request));
		accountLock.setAuth_id(getSessionMemberInfo(request).getAuth_id());
		
		int count = service.getAccountLockCount(accountLock); 
		service.setPaging(model, count, accountLock);
		model.addAttribute("accountLockList", service.getAccountLockList(accountLock));
		model.addAttribute("accountLockCount", count);
		return returnUrl("index", request);
	}
	
	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, AccountLock accountLock, HttpServletRequest request) throws AuthException {
		accountLock.setHomepage_id(getAsideHomepageId(request));
		accountLock.setAuth_id(getSessionMemberInfo(request).getAuth_id());
		
		if ( accountLock.getEditMode().equals("MODIFY") ) {
			checkAuth("U", model, request);
			model.addAttribute("accountLock", service.copyObjectPaging(accountLock, service.getAccountLock(accountLock)));
		} else {
			checkAuth("C", model, request);
			model.addAttribute("accountLock", accountLock);
		}
		
		return returnUrl("edit_ajax", request);
	}
	
	@RequestMapping(value = { "/save.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(AccountLock accountLock, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);

		if ( "ADD".equals(accountLock.getEditMode()) ) {
			ValidationUtils.rejectIfEmpty(result, "member_id", "사용자ID를 입력해주세요.");
			if ( service.checkMemberId(accountLock) > 0 ) {
				result.reject("중복된 ID가 있습니다.");
			}
		}
		
		if ( !result.hasErrors() ) {
//			if (Integer.parseInt(getSessionMemberInfo(request).getAuth_id()) <= 200) {
			res.setValid(true);
//			res.setData(accountLock.getPram("index"));
			res.setUrl("index.do");
//			if (accountLock.getEditMode().equals("MODIFY")) {
//				service.modifyAccountLock(accountLock);
//				res.setMessage("수정되었습니다.");
//			} else
			if (accountLock.getEditMode().equals("ADD")) {
				service.addAccountLock(accountLock);
				res.setMessage("등록되었습니다.");
			} else if (accountLock.getEditMode().equals("DELETE")) {
				service.deleteAccountLock(accountLock);
				res.setMessage("삭제되었습니다.");
			}	
//			}
//			else {
//				res.setValid(false);
//				res.setResult("권한이 없습니다.");
//			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
	
	private String returnUrl(String url, HttpServletRequest request) {
		if (request.getHeader("referer").toString().contains("wbuilder")) {
			return wbuilderPath + url;
		} else {
			return basePath + url;
		}
	}
}