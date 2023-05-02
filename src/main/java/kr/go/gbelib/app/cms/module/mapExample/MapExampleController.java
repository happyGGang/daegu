/**
 *
 */
package kr.go.gbelib.app.cms.module.mapExample;

import javax.servlet.http.HttpServletRequest;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.base.CommonBean;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtilsFromMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @author whaleesoft YONGJU 2020. 2. 12.
 */
@Controller
@RequestMapping(value = {"/cms/module/mapExample"})
public class MapExampleController extends BaseController {

    private final String basePath = "/cms/module/mapExample/";

    @Autowired
    private MapExampleService service;

    @Autowired
    private HomepageService homepageService;

    @RequestMapping(value = {"/index{url}.*"}, method = RequestMethod.GET)
    public String index(Model model, CommonBean bean, HttpServletRequest request, @PathVariable("url") String url) throws AuthException {
        checkAuth("R", model, request);
        bean.put("homepage_id", getAsideHomepageId(request));
        service.setPaging(model, service.getBookOfYearCount(bean.getMap()), bean);

        model.addAttribute("mapOne", bean.getMap());
        model.addAttribute("mapList", service.getBookOfYearList(bean.getMap()));

        return basePath + "index" + url;
    }

    @RequestMapping(value = {"/edit.*"}, method = RequestMethod.GET)
    public String edit(Model model, CommonBean bean, HttpServletRequest request) throws AuthException {
        Homepage homepage = homepageService.getHomepageOne(new Homepage(getAsideHomepageId(request)));

        model.addAttribute("homepage", homepage);

        if (bean.get("editMode").equals("MODIFY")) {
            checkAuth("U", model, request);
            bean.putAll(service.getBookOfYearOne(bean.getMap()));
        } else {
            checkAuth("C", model, request);
        }

        model.addAttribute("mapOne", bean.getMap());

        return basePath + "edit_ajax";
    }

    @RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
    public @ResponseBody JsonResponse save(CommonBean bean, HttpServletRequest request) {
        JsonResponse res = new JsonResponse(request);

        if (bean.getEditMode().equals("ADD")) {
            ValidationUtilsFromMap.rejectIfEmpty(res, bean, "book_name", "도서명을 입력하세요.");
            ValidationUtilsFromMap.rejectIfEmpty(res, bean, "book_author", "저자명을 입력하세요.");
        }

        if (!res.hasErrors()) {

            bean.put("add_id", getSessionMemberId(request));
            bean.put("modify_id", getSessionMemberId(request));

            res.setValid(true);
            res.setUrl("index.do");
            if (bean.get("editMode").equals("ADD")) {
                if (service.getBookOfYearOne(bean.getMap()) != null) {
                    res.setMessage("해당년도에 선정된 도서가 존재합니다.");
                    res.setValid(false);
                    res.setUrl("");
                } else {
                    service.addBookOfYear(bean.getMap());
                    res.setMessage("등록되었습니다.");
                }
            } else if (bean.get("editMode").equals("MODIFY")) {
                service.modifyBookOfYear(bean.getMap());
                res.setMessage("수정되었습니다.");
            } else if (bean.get("editMode").equals("DELETE")) {
                service.deleteBookOfYear(bean.getMap());
                res.setMessage("삭제되었습니다.");
            }
        } else {
            res.setValid(false);
        }
        return res;
    }
}
