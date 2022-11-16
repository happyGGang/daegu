package kr.go.gbelib.app.cms.module.teach.hashtag;

import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.http.HttpServletRequest;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.cms.module.teach.Teach;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping(value = { "/cms/module/teach/hashtag" })
public class HashtagController extends BaseController {
    private final String basePath = "/cms/module/teach/hashtag/";

    @Autowired
    private HashtagService service;

    @RequestMapping(value = { "/index.*" }, method = RequestMethod.GET)
    public String index(Model model, Hashtag hashtag, HttpServletRequest request) throws AuthException {
        checkAuth("R", model, request);

        model.addAttribute("hashtag", "hashtag");
        model.addAttribute("hashtagList", service.getHashtagList(hashtag));
        return basePath + "index";
    }

    @RequestMapping(value = { "/edit.*" }, method = RequestMethod.GET)
    public String edit(Model model, Hashtag hashtag, HttpServletRequest request) throws AuthException {
        if (hashtag.getEditMode().equals("MODIFY")) {
            checkAuth("U", model, request);
            model.addAttribute("hashtag", service.copyObjectPaging(hashtag, service.getHashtagOne(hashtag)));
        } else {
            checkAuth("C", model, request);
            model.addAttribute("hashtag", hashtag);
        }
        return basePath + "edit_ajax";
    }

    @RequestMapping(value = { "/save.*" }, method = RequestMethod.POST)
    public @ResponseBody
    JsonResponse save(Model model, Hashtag hashtag, BindingResult result, HttpServletRequest request) throws ParseException {
        JsonResponse res = new JsonResponse(request);
        String editMode = hashtag.getEditMode();
        Homepage homepage = getSessionHomepageInfo(request);
        hashtag.setHomepage_id(homepage.getHomepage_id());
        Member member = getSessionMemberInfo(request);

        if ("ADD".equals(hashtag.getEditMode())) {
            ValidationUtils.rejectIfEmpty(result, "hashtag_code", "해시태그코드를 입력해주세요.");
            if (!"Y".equals(hashtag.getDouble_check_yn())) {
                result.rejectValue("hashtag_code", "해시태그 중복확인 후 등록해주세요.");
            }

            String check = service.checkHashtag(hashtag);

            if ("Y".equals(check)) {
                result.rejectValue("hashtag_code", "이미 등록된 해시태그코드 입니다. 확인 후 다시 확인해주세요.");
            }
        }
        ValidationUtils.rejectIfEmpty(result, "hashtag_name", "해시태그명을 입력해주세요.");
        ValidationUtils.rejectIfEmpty(result, "use_yn", "사용유무를 선택해주세요.");




        if ( !result.hasErrors() ) {
            if ( editMode.equals("ADD") ) {
                service.insertHashtag(Hashtag.ofcreate(hashtag,member,request.getRemoteAddr()));
                res.setValid(true);
                res.setMessage("등록 되었습니다.");
            } else if ( editMode.equals("MODIFY") ) {
                service.updateHashtag(Hashtag.ofupdate(hashtag,member,request.getRemoteAddr()));
                res.setValid(true);
                res.setMessage("수정 되었습니다.");
            } else if ( editMode.equals("DELETE") ) {
                res.setValid(true);
                res.setMessage("삭제 되었습니다.");
            }
        } else {
            res.setValid(false);
            res.setResult(result.getAllErrors());
        }

        return res;
    }

    @RequestMapping(value = { "/check.*" }, method = RequestMethod.POST)
    public @ResponseBody
    JsonResponse check(Model model, Hashtag hashtag, BindingResult result, HttpServletRequest request) throws ParseException {
        JsonResponse res = new JsonResponse(request);

        if ( !result.hasErrors() ) {
            String check = service.checkHashtag(hashtag);
            if ("Y".equals(check)) {
                res.setMessage("이미 등록된 해시태그코드 입니다. 확인 후 다시 확인해주세요.");
            } else {
                res.setMessage("사용 가능한 해시태그코드 입니다.");
            }
            res.setValid(true);
        } else {
            res.setValid(false);
            res.setResult(result.getAllErrors());
        }

        return res;
    }
}
