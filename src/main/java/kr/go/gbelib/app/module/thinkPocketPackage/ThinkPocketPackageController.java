package kr.go.gbelib.app.module.thinkPocketPackage;

import java.io.File;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Optional;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.AttachmentUtils;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.cms.module.thinkPocketPackage.ThinkPocketPackage;
import kr.go.gbelib.app.cms.module.thinkPocketPackage.ThinkPocketPackageService;
import kr.go.gbelib.app.cms.module.thinkPocketPackage.ThinkPocketPackageView;
import kr.go.gbelib.app.common.api.LibSearchAPI;
import kr.go.gbelib.app.intro.search.LibrarySearch;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller(value = "userThinkPocketPackage")
@RequestMapping(value = {"/{homepagePath}/module/thinkPocketPackage"})
public class ThinkPocketPackageController extends BaseController {

  private static final Logger logger = LoggerFactory.getLogger(ThinkPocketPackageController.class);
  private String basePath = "/homepage/%s/module/thinkPocketPackage/";

  private static final Pattern PHONE_PATTERN = Pattern.compile("^01[0|1|6|7|8|9]-?[\\d]{3,4}-?[\\d]{4}$");

  @Autowired
  private ThinkPocketPackageService service;

  @RequestMapping(value = {"/index.*"}, method = RequestMethod.GET)
  public String index(Model model, ThinkPocketPackage thinkPocketPackage, HttpServletRequest request) throws AuthException {
    checkAuth("R", model, request);
    Homepage homepage = getHomepage(thinkPocketPackage, request);

    service.setPaging(model, service.getThinkPocketPackageCount(thinkPocketPackage), thinkPocketPackage);

    model.addAttribute("thinkPocketPackage", thinkPocketPackage);
    model.addAttribute("thinkPocketPackageList", service.getThinkPocketPackageList(thinkPocketPackage));

    return String.format(basePath, homepage.getFolder()) + "index";
  }

  @RequestMapping(value = {"/edit.*"})
  public String edit(Model model, ThinkPocketPackage thinkPocketPackage, HttpServletRequest request) throws AuthException {

    Homepage homepage = getHomepage(thinkPocketPackage, request);

    if (thinkPocketPackage.getEditMode().equals("MODIFY")) {
      checkAuth("U", model, request);
      int menu_idx = thinkPocketPackage.getMenu_idx();
      thinkPocketPackage = (ThinkPocketPackage) service.copyObjectPaging(thinkPocketPackage, service.getThinkPocketPackageOne(thinkPocketPackage));
      thinkPocketPackage.setMenu_idx(menu_idx);
    }
    model.addAttribute("thinkPocketPackage", thinkPocketPackage);

    return String.format(basePath, homepage.getFolder()) + "edit";
  }

  @RequestMapping(value = {"/search.*"}, method = RequestMethod.GET)
  public String search(Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Exception {

    if (StringUtils.isNotEmpty(librarySearch.getSearch_text())) {

      Map<String, Object> resultMap = LibSearchAPI.getNaverList(librarySearch);
      int totalCount = (Integer) resultMap.get("totalCount");
      @SuppressWarnings("unchecked")
      List<Map<String, Object>> itemList = (List<Map<String, Object>>) resultMap.get("list");

      if (itemList != null && !itemList.isEmpty()) {
        LibSearchAPI.getSameIsbnCheck(itemList);
      }

      service.setPaging(model, totalCount, librarySearch);
      model.addAttribute("naverResult", resultMap);
      model.addAttribute("totalCount", totalCount);
    }
    model.addAttribute("librarySearch", librarySearch);

    return basePath + "search_ajax";
  }

  @RequestMapping(value = {"/view.*"}, method = RequestMethod.GET)
  public String view(Model model, ThinkPocketPackage thinkPocketPackage, HttpServletRequest request) throws AuthException {

    Homepage homepage = getHomepage(thinkPocketPackage, request);

    int menu_idx = thinkPocketPackage.getMenu_idx();

    thinkPocketPackage = (ThinkPocketPackage) service.copyObjectPaging(thinkPocketPackage, service.getThinkPocketPackageOne(thinkPocketPackage));
    thinkPocketPackage.setMenu_idx(menu_idx);

    model.addAttribute("thinkPocketPackage", thinkPocketPackage);

    return String.format(basePath, homepage.getFolder()) + "view";
  }

  private Homepage getHomepage(ThinkPocketPackage thinkPocketPackage, HttpServletRequest request) {
    Homepage homepage = (Homepage) request.getAttribute("homepage");
    thinkPocketPackage.setHomepage_id(homepage.getHomepage_id());
    thinkPocketPackage.setHomepage_name(homepage.getHomepage_name());
    return homepage;
  }

  @RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
  public @ResponseBody JsonResponse save(ThinkPocketPackage thinkPocketPackage, BindingResult result, HttpServletRequest request) {
    getHomepage(thinkPocketPackage, request);
    /* 유효성 검증 >>>>> */
    JsonResponse res = new JsonResponse(request);
    if (thinkPocketPackage.getEditMode().equals("ADD") || thinkPocketPackage.getEditMode().equals("MODIFY")) {
      ValidationUtils.rejectIfEmpty(result, "think_pocket_package_name", "이름을 입력하세요.");
      ValidationUtils.rejectIfEmpty(result, "think_pocket_package_subject", "생각 주머니명을 입력하세요.");
    }
    /* <<<<< 유효성 검증 */

    if (!result.hasErrors()) {
      if (thinkPocketPackage.getEditMode().equals("ADD")) {
        thinkPocketPackage.setAdd_id(sessionLoginSupport(request).getMember_id());
        service.addThinkPocketPackage(thinkPocketPackage);
        res.setValid(true);
        res.setUrl("index.do");
        res.setData("menu_idx=" + thinkPocketPackage.getMenu_idx());
        res.setMessage("저장되었습니다.");
      } else if (thinkPocketPackage.getEditMode().equals("MODIFY")) {
        thinkPocketPackage.setModify_id(sessionLoginSupport(request).getMember_id());
        service.modifyThinkPocketPackage(thinkPocketPackage);
        res.setValid(true);
        res.setUrl("index.do");
        res.setData("menu_idx=" + thinkPocketPackage.getMenu_idx() + "&viewPage=" + thinkPocketPackage.getViewPage());
        res.setMessage("수정되었습니다.");
      } else if (thinkPocketPackage.getEditMode().equals("DELETE")) {
        service.deleteThinkPocketPackage(thinkPocketPackage);
        res.setValid(true);
        res.setUrl("index.do");
        res.setData("menu_idx=" + thinkPocketPackage.getMenu_idx() + "&viewPage=" + thinkPocketPackage.getViewPage());
        res.setMessage("삭제되었습니다.");
      } else if (thinkPocketPackage.getEditMode().equals("DELETE_CHECK")) {
        service.deleteCheckThinkPocketPackage(thinkPocketPackage);
        res.setValid(true);
        res.setMessage("선택 삭제 되었습니다.");
      }
    } else {
      res.setValid(false);
      res.setResult(result.getAllErrors());
    }

    return res;
  }

  @RequestMapping(value = {"/loanList.*"}, method = RequestMethod.GET)
  public String thinkPocketPackageLoanList(Model model, ThinkPocketPackage thinkPocketPackage, HttpServletRequest request, HttpServletResponse response) throws Exception {
    checkAuth("R", model, request);
    Homepage homepage = getHomepage(thinkPocketPackage, request);

    if (!isLogin(request) && !getSessionIsAdmin(request)) {
      thinkPocketPackage.setBefore_url(String.format("/%s/module/thinkPocketPackage/loanList.do?menu_idx=%s", homepage.getContext_path(), thinkPocketPackage.getMenu_idx()));
      service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), thinkPocketPackage.getMenu_idx(), thinkPocketPackage.getBefore_url()), request, response);
      return null;
    }

    if (!getSessionIsAdmin(request)) {
      thinkPocketPackage.setAdd_id(getSessionMemberId(request));
    }
    service.setPaging(model, service.getThinkPocketPackageLoanCount(thinkPocketPackage), thinkPocketPackage);

    model.addAttribute("thinkPocketPackage", thinkPocketPackage);
    model.addAttribute("loanList", service.getThinkPocketPackageLoanList(thinkPocketPackage));

    return String.format(basePath, homepage.getFolder()) + "loanList";
  }

  @RequestMapping(value = {"/loanView.*"}, method = RequestMethod.GET)
  public String loanView(Model model, ThinkPocketPackage thinkPocketPackage, HttpServletRequest request) throws AuthException {
    checkAuth("R", model, request);
    Homepage homepage = getHomepage(thinkPocketPackage, request);

    thinkPocketPackage = (ThinkPocketPackage) service.copyObjectPaging(thinkPocketPackage, service.getThinkPocketPackageLoanOne(thinkPocketPackage));
    model.addAttribute("thinkPocketPackage", thinkPocketPackage);

    return String.format(basePath, homepage.getFolder()) + "loanView";
  }

  @RequestMapping(value = {"/loanEdit.*"})
  public String thinkPocketPackageReq(Model model, ThinkPocketPackage thinkPocketPackage, HttpServletRequest request, HttpServletResponse response, @PathVariable String homepagePath) throws Exception {

    checkAuth("C", model, request);
    Homepage homepage = getHomepage(thinkPocketPackage, request);

    if (!isLogin(request) && !getSessionIsAdmin(request)) {
      thinkPocketPackage.setBefore_url(String.format("/%s/module/thinkPocketPackage/index.do?menu_idx=%s", homepage.getContext_path(), thinkPocketPackage.getMenu_idx()));
      service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), thinkPocketPackage.getMenu_idx(), thinkPocketPackage.getBefore_url()), request, response);
      return null;
    }

    Member member = getSessionMemberInfo(request);

    if (!StringUtils.equals(member.getMember_class(), "0")) {// 정회원만 가능
      service.alertMessage("정회원만 이용 가능 합니다.", request, response);
      return null;
    }

    thinkPocketPackage.setAdd_id(member.getMember_id());
    int getDuplicateLoanCount = service.getDuplicateLoanCount(thinkPocketPackage);

    if (getDuplicateLoanCount > 0) {
      service.alertMessage("이미 대출신청 또는 예약신청 하셨습니다. 계정당 1건만 신청 가능합니다.", request, response);
      return null;
    }

    int menu_idx = thinkPocketPackage.getMenu_idx();

    if (thinkPocketPackage.getEditMode().equals("MODIFY")) {
      checkAuth("U", model, request);

      thinkPocketPackage = (ThinkPocketPackage) service.copyObjectPaging(thinkPocketPackage, service.getThinkPocketPackageLoanOne(thinkPocketPackage));
      ThinkPocketPackage finalThinkPocketPackage = thinkPocketPackage;
      Optional.ofNullable(thinkPocketPackage.getPhone())
          .ifPresent(phone -> {
            splitPhoneNumbers(finalThinkPocketPackage);
          });
    } else {
      thinkPocketPackage = (ThinkPocketPackage) service.copyObjectPaging(thinkPocketPackage, service.getThinkPocketPackageOne(thinkPocketPackage));

      DateTimeFormatter displayFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
      DateTimeFormatter searchFormatter = DateTimeFormatter.ofPattern("yyyyMMdd");

      LocalDate today = computeHolidayAdjustedDate(LocalDate.now(), 0, homepage.getManage_code(), searchFormatter);
      thinkPocketPackage.setLoan_start_date(today.format(displayFormatter));

      LocalDate loanEndDate = computeHolidayAdjustedDate(today, 30, homepage.getManage_code(), searchFormatter);
      thinkPocketPackage.setLoan_end_date(loanEndDate.format(displayFormatter));

      //대출 날짜 리스트 가져오기
      ThinkPocketPackage thinkPocketData = new ThinkPocketPackage();
      thinkPocketData.setHomepage_id(homepage.getHomepage_id());
      thinkPocketData.setThink_pocket_package_idx(thinkPocketPackage.getThink_pocket_package_idx());
      List<ThinkPocketPackage> loanList = service.getThinkPocketPackageLoanDate(thinkPocketData);

      List<String> loanDateList = loanList.stream()
          .map(requestData -> {
            Map<String, String> loanRequestData = new HashMap<>();
            loanRequestData.put("start_date", requestData.getLoan_start_date());
            loanRequestData.put("end_date", requestData.getLoan_end_date());
            return service.getThinkPocketPackageLoanDateList(loanRequestData);
          })
          .filter(Objects::nonNull)
          .flatMap(List::stream)
          .collect(Collectors.toList());

      if (!loanDateList.isEmpty()) {
        LocalDate lastLoanDate = LocalDate.parse(loanDateList.get(loanDateList.size() - 1), displayFormatter);
        LocalDate newLoanStartDate = computeHolidayAdjustedDate(lastLoanDate,1, homepage.getManage_code(),searchFormatter);
        thinkPocketPackage.setLoan_start_date(newLoanStartDate.format(displayFormatter));

        LocalDate newLoanEndDate = computeHolidayAdjustedDate(newLoanStartDate, 30, homepage.getManage_code(), searchFormatter);
        thinkPocketPackage.setLoan_end_date(newLoanEndDate.format(displayFormatter));
      }

      model.addAttribute("loanDateList", StringUtils.join(loanDateList, ","));
    }

    thinkPocketPackage.setMenu_idx(menu_idx);
    model.addAttribute("thinkPocketPackage", thinkPocketPackage);

    return String.format(basePath, homepage.getFolder()) + "loanEdit";
  }

  @RequestMapping(value = {"/loanSave.*"}, method = RequestMethod.POST)
  public @ResponseBody JsonResponse thinkPocketPackageReqSave(ThinkPocketPackage thinkPocketPackage, BindingResult result, HttpServletRequest request) {
    Homepage homepage = getHomepage(thinkPocketPackage, request);
    /* 유효성 검증 >>>>> */
    JsonResponse res = new JsonResponse(request);
    if (thinkPocketPackage.getEditMode().equals("ADD") || thinkPocketPackage.getEditMode().equals("MODIFY")) {
      ValidationUtils.rejectIfEmpty(result, "loan_start_date", "대출시작기간을 입력하세요.");
      ValidationUtils.rejectIfEmpty(result, "loan_end_date", "대출시작기간을 입력하세요.");
      ValidationUtils.rejectIfEmpty(result, "request_name", "이름을 입력하세요.");
      ValidationUtils.rejectIfEmpty(result, "phone_2", "휴대폰을 입력하세요.");
      ValidationUtils.rejectIfEmpty(result, "phone_3", "휴대폰을 입력하세요.");

      String phone = thinkPocketPackage.getPhone_1() + "-" + thinkPocketPackage.getPhone_2() + "-" + thinkPocketPackage.getPhone_3();
      thinkPocketPackage.setPhone(phone);

      Matcher matcher1 = PHONE_PATTERN.matcher(phone);
      if (!matcher1.matches()) {
        result.rejectValue("phone_2", "휴대폰 형식이 올바르지 않습니다.");
      }
    }
    /* <<<<< 유효성 검증 */
    Member member = getSessionMemberInfo(request);
    if (!StringUtils.equals(member.getMember_class(), "0")) {// 정회원만 가능
      res.setMessage("정회원만 이용 가능 합니다.");
      return res;
    }

    if (!result.hasErrors()) {

      String session_id = getSessionMemberId(request);
      String user_key = member.getRec_key();
      thinkPocketPackage.setUser_key(String.valueOf(user_key));
      thinkPocketPackage.setAdd_ip(request.getRemoteAddr());

      switch (thinkPocketPackage.getEditMode()) {
        case "ADD":
          thinkPocketPackage.setAdd_id(session_id);
          service.addThinkPocketPackageLoan(thinkPocketPackage);
          res.setValid(true);
          res.setUrl("index.do");
          res.setMessage("등록되었습니다.");
          res.setData("menu_idx=" + thinkPocketPackage.getMenu_idx());
          break;
        case "MODIFY":
          thinkPocketPackage.setModify_id(session_id);
          service.modifyThinkPocketPackageLoan(thinkPocketPackage);
          res.setValid(true);
          res.setUrl("loanList.do");
          res.setData("menu_idx=" + thinkPocketPackage.getMenu_idx() + "&viewPage=" + thinkPocketPackage.getViewPage() + "&rowCount=" + thinkPocketPackage.getRowCount());
          res.setMessage("수정되었습니다.");
          break;
        case "DELETE":
          service.deleteThinkPocketPackageLoan(thinkPocketPackage);
          res.setValid(true);
          res.setUrl("loanList.do");
          res.setData("menu_idx=" + thinkPocketPackage.getMenu_idx() + "&viewPage=" + thinkPocketPackage.getViewPage() + "&rowCount=" + thinkPocketPackage.getRowCount());
          res.setMessage("취소되었습니다.");
          break;
        case "returnReq":
          service.modifyReturnReq(thinkPocketPackage);
          res.setValid(true);
          break;
        case "returnReqCancel":
          service.modifyReturnReq(thinkPocketPackage);
          res.setValid(true);
          res.setMessage("반납요청이 취소 되었습니다.");
          break;
        case "STATUS":
          service.statusChangeAll(thinkPocketPackage);
          res.setValid(true);
          res.setMessage("상태가 모두 변경되었습니다.");
          break;
      }
    } else {
      res.setValid(false);
      res.setResult(result.getAllErrors());
    }

    return res;
  }

  @RequestMapping(value = {"/excelDownload.*"}, method = RequestMethod.POST)
  public ThinkPocketPackageView excel(Model model, ThinkPocketPackage thinkPocketPackage, HttpServletRequest request, HttpServletResponse response) throws Exception {

    Homepage homepage = getHomepage(thinkPocketPackage, request);
    thinkPocketPackage.setAdd_id(getSessionMemberId(request));
    List<ThinkPocketPackage> thinkPocketPackageList = null;
    if (thinkPocketPackage.getEditMode().equals("thinkPocketPackage")) {
      thinkPocketPackageList = service.getThinkPocketPackageExcelList(thinkPocketPackage);
    } else {
      thinkPocketPackageList = service.getThinkPocketPackageLoanExcelList(thinkPocketPackage);
    }

    model.addAttribute("thinkPocketPackage", thinkPocketPackage);
    model.addAttribute("thinkPocketPackageList", thinkPocketPackageList);

    return new ThinkPocketPackageView();
  }

  @RequestMapping(value = "/download/{think_pocket_package_idx}.*", method = RequestMethod.GET)
  @ResponseBody
  public ResponseEntity<byte[]> getFile(@PathVariable("think_pocket_package_idx") int think_pocket_package_idx, HttpServletRequest request, HttpServletResponse response) throws Exception {

    if (!isLogin(request) && !getSessionIsAdmin(request)) {
      service.alertMessage("로그인 후 사용 가능 합니다.", request, response);
      return null;
    }

    ThinkPocketPackage thinkPocketPackage = new ThinkPocketPackage();
    thinkPocketPackage.setThink_pocket_package_idx(think_pocket_package_idx);
    thinkPocketPackage = service.getThinkPocketPackageOne(thinkPocketPackage);

    HttpHeaders responseHeaders = new HttpHeaders();
    byte[] bytes = null;

    if (thinkPocketPackage == null) {
      responseHeaders.setContentType(MediaType.valueOf("text/html"));
      service.alertMessage("파일이 존재하지 않습니다.", request, response);
      return null;
    }

    String filePath = service.getRootPath() + "/" + thinkPocketPackage.getDoc_server_file_name();
    File file = new File(filePath);

    if (file.length() > 0) {
      bytes = FileCopyUtils.copyToByteArray(file);
    } else {
      responseHeaders.setContentType(MediaType.valueOf("text/html"));
      service.alertMessage("파일이 존재하지 않습니다.", request, response);
      return null;
    }

    String fileName = String.format("%s.%s", thinkPocketPackage.getDoc_org_file_name(), thinkPocketPackage.getDoc_file_extension());
    String fileType = thinkPocketPackage.getDoc_file_extension().toUpperCase();

    responseHeaders.set("Content-Disposition", AttachmentUtils.getContentDisposition(fileName, request.getHeader("user-agent")));
    responseHeaders.setPragma("no-cache;");
    responseHeaders.setExpires(-1);
    responseHeaders.setContentType(MediaType.valueOf(AttachmentUtils.getContentType(fileType)));
    responseHeaders.setContentLength(bytes.length);

    return new ResponseEntity<byte[]>(bytes, responseHeaders, HttpStatus.OK);
  }

  private void splitPhoneNumbers(ThinkPocketPackage thinkPocketPackage) {
    if (thinkPocketPackage.getPhone() != null) {
      String[] phoneParts = thinkPocketPackage.getPhone().split("-");
      if (phoneParts.length >= 3) {
        thinkPocketPackage.setPhone_1(phoneParts[0]);
        thinkPocketPackage.setPhone_2(phoneParts[1]);
        thinkPocketPackage.setPhone_3(phoneParts[2]);
      } else {
        logger.warn("전화번호 형식이 올바르지 않습니다: {}", thinkPocketPackage.getPhone());
      }
    }
  }

  private LocalDate computeHolidayAdjustedDate(LocalDate baseDate, int offsetDays, String manageCode, DateTimeFormatter searchFormatter) {
    LocalDate candidate = baseDate.plusDays(offsetDays);
    return adjustForHoliday(candidate, manageCode, searchFormatter);
  }


  private LocalDate adjustForHoliday(LocalDate date, String manageCode, DateTimeFormatter searchFormatter) {
    LibrarySearch librarySearch = new LibrarySearch();
    librarySearch.setSearch_start_date(date.format(searchFormatter));
    librarySearch.setManageCode(manageCode);
    Map<String, Object> holidays = LibSearchAPI.getCheckHoliday(librarySearch);
    if ("1".equals(holidays.get("RESULT_CODE"))) {
      return date.plusDays(1);
    }
    return date;
  }

}
