package kr.co.whalesoft.app.cms.limitedIp;

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
@RequestMapping (value = {"/wbuilder/limitedIp"})
public class LimitedIpController extends BaseController {

	private final String basePath = "/wbuilder/limitedIp/";

	@Autowired
	private LimitedIpService service;

	@RequestMapping (value = {"/index.*"})
	public String index(Model model, LimitedIp limitedIp, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		model.addAttribute("limitedIpList", service.getLimitedIp());
		model.addAttribute("limitedIp", limitedIp);
		return basePath + "index";
	}

	@RequestMapping (value = {"/edit.*"})
	public String edit(Model model, LimitedIp limitedIp, HttpServletRequest request) throws AuthException {
		if (limitedIp.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			model.addAttribute("limitedIp", service.copyObjectPaging(limitedIp, service.getLimitedIpOne(limitedIp)));
		} else {
			checkAuth("C", model, request);
			model.addAttribute("limitedIp", limitedIp);
		}

		return basePath + "edit_ajax";
	}

	@RequestMapping (value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Model model, LimitedIp limitedIp, BindingResult result, HttpServletRequest request) {

		JsonResponse res = new JsonResponse(request);

		if (!limitedIp.getEditMode().equals("DELETE")) {
			ValidationUtils.rejectIfEmpty(result, "limited_ip", "접근불가능IP를 입력하세요.");
		}

		if (!result.hasErrors()) {
			if (limitedIp.getEditMode().equals("ADD")) {
				limitedIp.setAdd_id(getSessionMemberId(request));
				service.addLimitedIp(limitedIp);
				res.setValid(true);
				res.setMessage("등록 되었습니다.");
			} else if (limitedIp.getEditMode().equals("MODIFY")) {
				limitedIp.setModify_id(getSessionMemberId(request));
				service.modifyLimitedIp(limitedIp);
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			} else if (limitedIp.getEditMode().equals("DELETE")) {
				service.deleteLimitedIp(limitedIp);
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
