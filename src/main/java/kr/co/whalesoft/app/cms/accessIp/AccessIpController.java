package kr.co.whalesoft.app.cms.accessIp;

import java.util.List;

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
@RequestMapping (value = {"/wbuilder/accessIp"})
public class AccessIpController extends BaseController {

	private final String basePath = "/wbuilder/accessIp/";

	@Autowired
	private AccessIpService service;

	@RequestMapping (value = {"/index.*"})
	public String index(Model model, AccessIp accessIp, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		model.addAttribute("accessIpList", service.getAccessIp());
		model.addAttribute("accessIp", accessIp);
		return basePath + "index";
	}

	@RequestMapping (value = {"/edit.*"})
	public String edit(Model model, AccessIp accessIp, HttpServletRequest request) throws AuthException {
		if (accessIp.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			model.addAttribute("accessIp", service.copyObjectPaging(accessIp, service.getAccessIpOne(accessIp)));
		} else {
			checkAuth("C", model, request);
			model.addAttribute("accessIp", accessIp);
		}

		return basePath + "edit_ajax";
	}

	@RequestMapping (value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Model model, AccessIp accessIp, BindingResult result, HttpServletRequest request) {

		JsonResponse res = new JsonResponse(request);

		if (!accessIp.getEditMode().equals("DELETE")) {
			ValidationUtils.rejectIfEmpty(result, "access_ip", "접근가능IP를 입력하세요.");
		}

		if (!result.hasErrors()) {
			if (accessIp.getEditMode().equals("ADD")) {
				accessIp.setAdd_id(getSessionMemberId(request));
				service.addAccessIp(accessIp);
				res.setValid(true);
				res.setMessage("등록 되었습니다.");
			} else if (accessIp.getEditMode().equals("MODIFY")) {
				accessIp.setMod_id(getSessionMemberId(request));
				service.modifyAccessIp(accessIp);
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			} else if (accessIp.getEditMode().equals("DELETE")) {
				service.deleteAccessIp(accessIp);
				res.setValid(true);
				res.setMessage("삭제 되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	/**
	 * 접속자 IP가 관리자 접속 IP인지 확인 함수
	 *
	 * @param request
	 * @return
	 */
	public boolean isUserCMSAccessIp(HttpServletRequest request) {
		String userIp = request.getRemoteAddr();

//		if (userIp.equals("127.0.0.1")) {
//			return true;
//		} else if (userIp.equals("0:0:0:0:0:0:0:1")) {
//			return true;
//		} else if (userIp.equals("121.182.43.205")) {
//			return true;
//		}

		List<AccessIp> accessIpList = service.getAllowIpList();

		for (AccessIp allowed_ip : accessIpList) {

			String allowedIp = allowed_ip.getAccess_ip();

			/*
			 * 허용 IP에 '*'이 있으면 허용IP, 접속IP 각각 split(".");
			 */
			if (allowed_ip.getAccess_ip().contains("*")) {

				// 허용 IP
				String[] allowed_ip_temp = allowed_ip.getAccess_ip().split("\\.");

				// 접속 IP
				String[] ip_temp = userIp.split("\\.");

				for (int i = 0; i < allowed_ip_temp.length; i++) {
					// 허용 IP에 '*'이 있으면 해당 위치에 접속IP 값을 삽입.
					if (allowed_ip_temp[i].equals("*")) {
						allowed_ip_temp[i] = ip_temp[i];
					}
				}

				allowedIp = allowed_ip_temp[0] + "." + allowed_ip_temp[1] + "." + allowed_ip_temp[2] + "." + allowed_ip_temp[3];
			}

			if (allowedIp.equals(userIp)) {
				return true;
			}

		}

		log.debug("@@@@@@@@@@@@@@@@ access ip : " + userIp);
		return false;
	}

}
