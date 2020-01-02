package kr.co.whalesoft.app.cms.boardManage.fieldManage;

import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.app.cms.code.Code;
import kr.co.whalesoft.app.cms.code.CodeService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.utils.JsonResponse;

@Controller
@RequestMapping(value = {"/cms/boardManage/fieldManage"})
public class FieldManageController extends BaseController {

	private final String basePath = "/cms/boardManage/fieldManage/";

	@Autowired
	private FieldManageService service;

	@Autowired
	private CodeService codeService;

	@RequestMapping(value = {"/index.*"})
	public String index(Model model, FieldManage fieldManage) {
		model.addAttribute("fieldManageList", service.getBoardFieldManage(fieldManage));
		model.addAttribute("fieldManage", fieldManage);
		return basePath + "index_ajax";
	}

	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, FieldManage fieldManage, HttpServletRequest request) {
		if(fieldManage.getEditMode().equals("ADD")) {
			fieldManage.setList_seq(service.getNextListSeq(fieldManage));
			fieldManage.setWrite_seq(service.getNextWriteSeq(fieldManage));
			model.addAttribute("fieldManage", fieldManage);
		} else if(fieldManage.getEditMode().equals("MODIFY")) {
			model.addAttribute("fieldManage", service.copyObjectPaging(fieldManage, service.getBoardFieldManageOne(fieldManage)));
		}
		model.addAttribute("boardColumnInfoList", service.getBoardColumnInfo());
		model.addAttribute("columnTypeList", codeService.getCode("CMS", "C0001"));
		model.addAttribute("codeGroupList", codeService.getCodeGroup(getAsideHomepageId(request)));

		return basePath + "edit_ajax";
	}


	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(FieldManage fieldManage, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);

		if(!result.hasErrors()) {
			if(fieldManage.getEditMode().equals("ADD")) {
				fieldManage.setAdd_id(getSessionMemberId(request));
				service.addBoardFieldManage(fieldManage);
				res.setValid(true);
				res.setMessage("등록 되었습니다.");
			} else if(fieldManage.getEditMode().equals("MODIFY")) {
				fieldManage.setModify_id(getSessionMemberId(request));
				service.modifyBoardFieldManage(fieldManage);
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			} else if(fieldManage.getEditMode().equals("DELETE")) {
				service.deleteBoardFieldManage(fieldManage);
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
