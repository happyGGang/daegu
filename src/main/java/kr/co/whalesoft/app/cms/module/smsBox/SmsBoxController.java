package kr.co.whalesoft.app.cms.module.smsBox;

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
import kr.co.whalesoft.framework.utils.ValidationUtils;

@Controller
@RequestMapping(value = {"/cms/module/smsBox"})
public class SmsBoxController extends BaseController {
	
private final String basePath = "/cms/module/smsBox/";
	
	@Autowired
	private SmsBoxService service;
	
	@RequestMapping(value = { "/index.*" })
	public String index(Model model, SmsBox smsBox, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
//		if ( !getSessionIsAdmin(request) ) {
			smsBox.setHomepage_id(getAsideHomepageId(request));	
//		}
		
		int listCount = service.getSmsBoxCnt(smsBox);
		service.setPaging(model, listCount, smsBox);
		model.addAttribute("smsBoxCnt", listCount);
		model.addAttribute("smsBox", smsBox);
		model.addAttribute("smsBoxList", service.getSmsBoxList(smsBox));
		return basePath + "index";
	}
	
	@RequestMapping(value = { "/edit.*" }, method = RequestMethod.GET)
	public String edit(Model model, SmsBox smsBox, HttpServletRequest request) throws AuthException {

		if (smsBox.getEditMode().equals("ADD")) {
			checkAuth("C", model, request);
			model.addAttribute("smsBox", smsBox);
		} else if (smsBox.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			model.addAttribute("smsBox", service.copyObjectPaging(smsBox, service.getSmsBoxListOne(smsBox)));
		}
		
		return basePath + "edit_ajax";
	}
	
	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(SmsBox smsBox, BindingResult result, HttpServletRequest request) {
		
		JsonResponse res = new JsonResponse(request);
		
		if(!smsBox.getEditMode().equals("DELETE")) {
			ValidationUtils.rejectIfEmpty(result, "title", "제목을 입력해주세요.");
			ValidationUtils.rejectIfEmpty(result, "contents", "내용을 입력해주세요.");
			ValidationUtils.rejectIfEmpty(result, "use_yn", "사용유무를 선택해주세요.");
		}
		
		Member member = (Member) getSessionMemberInfo(request);		
		smsBox.setAdd_id(member.getMember_id());
		
		if(!result.hasErrors()) {
			smsBox.setAdd_id(member.getMember_id());
			
			if(smsBox.getEditMode().equals("ADD")) {
				service.addSmsBox(smsBox);
				res.setValid(true);
				res.setMessage("등록되었습니다.");
				
			} else if(smsBox.getEditMode().equals("MODIFY")) {
				service.modifySmsBox(smsBox);
				res.setValid(true);
				res.setMessage("수정되었습니다.");
			
			} else if(smsBox.getEditMode().equals("DELETE")) {
				service.deleteSmsBox(smsBox);
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
