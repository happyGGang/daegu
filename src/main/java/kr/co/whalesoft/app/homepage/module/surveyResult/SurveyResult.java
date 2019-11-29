package kr.co.whalesoft.app.homepage.module.surveyResult;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.framework.base.BaseController;

@Controller
@RequestMapping(value = {"/{homepagePath}/module/surveyResult"})
public class SurveyResult extends BaseController{
    private String basePath = null;
    private Homepage homepage = null;

    private void attributeInit(HttpServletRequest request, Model model) {
          homepage = (Homepage)request.getAttribute("homepage");

          String homepageFolder = "";

          if(homepage != null) {
                homepageFolder = "/homepage/" + homepage.getFolder();
          }

          basePath = homepageFolder + "/module/surveyResult/";
    }

    @RequestMapping(value = { "/index.*" })
    public String index(Model model, HttpServletRequest request) {
          attributeInit(request, model);

          return basePath + "index_ajax";
    }

}
