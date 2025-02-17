package kr.go.gbelib.app.cms.module.authenticationLog;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import kr.co.whalesoft.framework.base.BaseController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping(value = {"/cms/module/authenticationLog"})
public class AuthenticationLogController extends BaseController {

  private final String basePath = "/cms/module/authenticationLog/";

  @Autowired
  private AuthenticationLogService service;

  @RequestMapping(value = {"/index.*"})
  public String index(Model model, AuthenticationLog authenticationLog, HttpServletRequest request, HttpServletResponse response) {
    authenticationLog.setHomepage_id(getAsideHomepageId(request));
    return basePath + "index";
  }

/*  @RequestMapping(value = {"/excelDownload.*"}, method = RequestMethod.POST)
  public AuthenticationLogSearchView excel(Model model, AuthenticationLog authenticationLog, HttpServletRequest request, HttpServletResponse response) throws Exception {
    model.addAttribute("authenticationLog", authenticationLog);
    model.addAttribute("authenticationLogResult", service.getExcelList(authenticationLog));

    return new AuthenticationLogSearchView();
  }

  @RequestMapping(value = {"/csvDownload.*"}, method = RequestMethod.POST)
  public void csv(Model model, AuthenticationLog authenticationLog, HttpServletRequest request, HttpServletResponse response) {
    List<AuthenticationLog> authenticationLogList = service.getExcelList(authenticationLog);

    new AuthenticationLogXlsToCsv(authenticationLogList, "독서릴레이 우수 사례 공모 리스트.csv", request, response);
  }*/

}
