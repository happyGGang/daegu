package kr.go.gbelib.app.cms.module.authenticationLog;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
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

  @RequestMapping(value = {"/index.*"}, method = RequestMethod.GET)
  public String index(Model model, AuthenticationLog authenticationLog, HttpServletRequest request, HttpServletResponse response) {
    setDefaultSetting(authenticationLog, request);

    //테이블 데이터
    service.setPaging(model, service.getAuthenticationLogCount(authenticationLog), authenticationLog);
    List<AuthenticationLog> authenticationLogList = service.getAuthenticationLogList(authenticationLog);
    model.addAttribute("authenticationLogList", authenticationLogList);

    //차트 데이터
    List<AuthenticationLog> chartData = service.getAuthenticationLogChartData(authenticationLog);
    model.addAttribute("chartData", chartData);
    model.addAttribute("authenticationLog", authenticationLog);

    return basePath + "index";
  }

  private void setDefaultSetting(AuthenticationLog authenticationLog, HttpServletRequest request) {

    authenticationLog.setStartDate(getOrDefaultDate(authenticationLog.getStartDate()));
    authenticationLog.setEndDate(getOrDefaultDate(authenticationLog.getEndDate()));
  }

  private String getOrDefaultDate(String date) {
    if (date == null || date.isEmpty()) {
      return LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
    }
    return date;
  }
}
