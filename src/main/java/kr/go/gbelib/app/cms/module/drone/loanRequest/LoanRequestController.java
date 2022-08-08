package kr.go.gbelib.app.cms.module.drone.loanRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import kr.co.whalesoft.app.cms.code.Code;
import kr.co.whalesoft.app.cms.code.CodeService;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.StaticVariables;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping(value = {"/cms/module/drone/loanRequest/"})
public class LoanRequestController extends BaseController {
    private final String basePath = "/cms/module/drone/loanRequest/";

    @Autowired
    private LoanRequestService service;

    @Autowired
    private CodeService codeService;

    @Autowired
    private HomepageService homepageService;

    @RequestMapping(value = {"/index.*"})
    public String index(Model model, LoanRequest loanRequest, HttpServletRequest request) throws AuthException {
        checkAuth("R", model, request);
        Homepage homepage = homepageService.getHomepageOne(new Homepage(getAsideHomepageId(request)));
        if (homepage != null) {
            loanRequest.setManage_code(homepage.getManage_code());
        }

        service.setPaging(model, service.getLoanRequestCount(loanRequest), loanRequest);
        model.addAttribute("loanRequest", loanRequest);
        model.addAttribute("loanRequestList", service.getLoanRequestList(loanRequest));

        Code code = new Code();
        code.setHomepage_id("CMS");
        code.setGroup_id("DR000");
        model.addAttribute("status", codeService.getCodeList(code));
        return basePath + "index";
    }

    @RequestMapping(value = { "/statusHistory.*" })
    public String statusHistory(Model model, LoanRequest loanRequest, HttpServletRequest request) throws AuthException {
        model.addAttribute("history", service.getLoanRequestLogList(loanRequest));
        return basePath + "statusHistory_ajax";
    }

    @RequestMapping (value = {"/save.*"}, method = RequestMethod.POST)
    public @ResponseBody
    JsonResponse save(LoanRequest loanRequest, BindingResult result, HttpServletRequest request) {
        /* 유효성 검증 >>>>> */
        JsonResponse res = new JsonResponse(request);

        if (!result.hasErrors()) {
            HttpSession session = request.getSession();
            Member member = (Member)session.getAttribute(StaticVariables.MEMBER);

            if ("MODIFY_STATUS".equals(loanRequest.getEditMode())) {
                String message = service.updateStatus(LoanRequest.ofUpdateStatus(loanRequest.getRequest_idx(), loanRequest.getManage_code(),loanRequest.getUser_key(), member.getMember_id(), request.getRemoteAddr(), loanRequest.getRequest_status()));
                res.setValid(true);
                if ("success".equals(message)) {
                    res.setMessage("대출상태가 변경되었습니다.");
                } else {
                    res.setMessage("대출상태가 변경에 실패 하였습니다. 관리자에게문의 해주세요. \nAPI 오류 : "+message);
                }

            }
        } else {
            res.setValid(false);
            res.setResult(result.getAllErrors());
        }

        return res;
    }
}
