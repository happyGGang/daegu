package kr.go.gbelib.app.cms.module.cultureTeach.hashtag;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.go.gbelib.app.cms.module.category.group.CategoryGroup;
import kr.go.gbelib.app.cms.module.teach.statistics.TeachStatistics;
import kr.go.gbelib.app.cms.module.teach.teachCode2.TeachCode2;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping(value = { "/cms/module/cultureTeach/hashtag" })
public class HashtagController extends BaseController {
    private final String basePath = "/cms/module/cultureTeach/hashtag/";

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
}
