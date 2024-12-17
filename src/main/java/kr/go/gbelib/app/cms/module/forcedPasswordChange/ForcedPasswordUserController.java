package kr.go.gbelib.app.cms.module.forcedPasswordChange;

import javax.servlet.http.HttpServletRequest;
import kr.co.whalesoft.app.cms.code.CodeService;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ValidationUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping(value = {"/cms/module/forcedPasswordChange"})
public class ForcedPasswordUserController extends BaseController {

    private final String BASE_PATH = "/cms/module/forcedPasswordChange/";

    @Autowired
    private ForcedPasswordChangeService service;

    @RequestMapping(value = {"/index.*"})
    public String index(Model model, ForcedPasswordChange forcedPasswordChange, HttpServletRequest request) throws AuthException {

        checkAuth("R", model, request);
		
        service.setPaging(model, service.getForcedPasswordChangeListCount(forcedPasswordChange), forcedPasswordChange);
        model.addAttribute("forcedPasswordChangeList", service.getForcedPasswordChangeList(forcedPasswordChange));
        model.addAttribute("forcedPasswordChange", forcedPasswordChange);

        return BASE_PATH + "index";
    }

    @RequestMapping(value = {"/edit.*"}, method = RequestMethod.GET)
    public String edit(Model model, ForcedPasswordChange forcedPasswordChange, HttpServletRequest request) throws AuthException {

        if ("ADD".equals(forcedPasswordChange.getEditMode())) {
            checkAuth("C", model, request);
            model.addAttribute("forcedPasswordChangeOne", forcedPasswordChange);
        } else if ("MODIFY".equals(forcedPasswordChange.getEditMode())) {
            checkAuth("U", model, request);
			ForcedPasswordChange result = service.getForcedPasswordChangeOne(forcedPasswordChange);
            model.addAttribute("forcedPasswordChangeOne", service.copyObjectPaging(forcedPasswordChange, result));
        }

        return BASE_PATH + "edit_ajax";
    }

    @RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
    public @ResponseBody JsonResponse save(ForcedPasswordChange forcedPasswordChange, BindingResult result, HttpServletRequest request) {

        JsonResponse res = new JsonResponse(request);

		ValidationUtils.rejectIfEmpty(result, "member_id", "아이디를 입력해 주세요.");

        if (!result.hasErrors()) {
            forcedPasswordChange.setAdd_id(getSessionMemberId(request));
            forcedPasswordChange.setModify_id(getSessionMemberId(request));
            switch (forcedPasswordChange.getEditMode()) {
                case "ADD":
                    service.addForcedPasswordChangeUser(forcedPasswordChange);
                    res.setValid(true);
                    res.setMessage("등록 되었습니다.");
                    break;
                case "MODIFY":
                    service.modifyForcedPasswordChangeUser(forcedPasswordChange);
                    res.setValid(true);
                    res.setMessage("수정 되었습니다.");
                    break;
                case "DELETE":
                    service.deleteForcedPasswordChangeUser(forcedPasswordChange);
                    res.setValid(true);
                    res.setMessage("삭제 되었습니다.");
                    break;
            }
        } else {
            res.setValid(false);
            res.setResult(result.getAllErrors());
        }

        return res;
    }
}
