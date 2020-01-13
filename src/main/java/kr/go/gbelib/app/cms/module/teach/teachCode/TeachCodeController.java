package kr.go.gbelib.app.cms.module.teach.teachCode;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.utils.JsonResponse;

@Controller
@RequestMapping(value = {"/cms/module/teach/teachCode"})
public class TeachCodeController extends BaseController {

	private final String basePath = "/cms/module/teach/teachCode/";

	@Autowired
	private TeachCodeService service;

	@RequestMapping (value = { "/index.*" }, method = RequestMethod.GET)
	public String index(Model model, TeachCode teachCode, HttpServletRequest request) {
		model.addAttribute("teachCode", teachCode);
		model.addAttribute("largeCodeList", service.getLargeCodeList());
		return basePath + "index";
	}

	@RequestMapping (value = { "/getMidCodeList.*" }, method = RequestMethod.GET)
	public @ResponseBody List<TeachCode> getMidCodeList(TeachCode teachCode, HttpServletRequest request) {
		return service.getMidCodeList(teachCode);
	}

	@RequestMapping (value = { "/getSmallCodeList.*" }, method = RequestMethod.GET)
	public @ResponseBody List<TeachCode> getSmallCodeList(TeachCode teachCode, HttpServletRequest request) {
		return service.getSmallCodeList(teachCode);
	}

	@RequestMapping (value = { "/save.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(TeachCode teachCode, BindingResult result, HttpServletRequest request) {

		JsonResponse res = new JsonResponse(request);

		if ( !result.hasErrors() ) {
			teachCode.setCud_id(getSessionMemberId(request));
			if (teachCode.getEditMode().equals("ADD")) {
				int dupCheck = service.addTeachCode(teachCode);
				if (dupCheck > 0) {
					res.setMessage("등록되었습니다.");
					res.setValid(true);
					res.setData(teachCode);
				} else {
					res.setMessage("이미 존재하는 분류코드입니다.");
					res.setValid(false);
				}
			} else if (teachCode.getEditMode().equals("MODIFY")) {
//				int dupCheck = service.addTeachCode(teachCode);
//				if (dupCheck > 0) {
//					res.setMessage("이미 존재하는 분류코드입니다.");
//					res.setValid(false);
//				} else {
					service.modifyTeachCode(teachCode);
					res.setMessage("수정되었습니다.");
					res.setValid(true);
					res.setData(teachCode);
//				}
			} else if (teachCode.getEditMode().equals("DELETE")) {
				service.deleteTeachCode(teachCode);
				res.setMessage("삭제되었습니다.");
				res.setValid(true);
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	@RequestMapping(value = {"/saveList.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse saveList(Model model, @RequestBody TeachCode[] codeList, HttpServletRequest request) {

		JsonResponse res = new JsonResponse(request);

		if(codeList == null || codeList.length == 0) {
			res.setValid(false);
			res.setMessage("저장할 분류가 없습니다.");
		} else {
			service.saveCodeList(codeList, getSessionMemberId(request));
			res.setValid(true);
			res.setMessage("저장되었습니다.");
		}

		return res;
	}
}
