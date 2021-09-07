package kr.go.gbelib.app.cms.module.lecture.lectureInfo;

import kr.co.whalesoft.framework.base.BaseController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping(value = {"/cms/module/lecture/lectureInfo"})
public class LectureInfoController extends BaseController {

    private final String basePath = "/cms/module/lecture/lectureInfo/";

    @Autowired
    private LectureInfoService service;

    @RequestMapping(value = {"/index.*"}, method = RequestMethod.GET)
    public String index(Model model, LectureInfo lectureInfo, HttpServletRequest request) {
        service.setPaging(model, service.getLectureInfoCount(lectureInfo), lectureInfo);

        model.addAttribute("lectureInfo", lectureInfo);
        model.addAttribute("lectureInfoList", service.getLectureInfoList(lectureInfo));

        return basePath + "index";
    }

}
