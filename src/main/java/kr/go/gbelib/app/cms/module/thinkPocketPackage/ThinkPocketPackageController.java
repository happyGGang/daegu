package kr.go.gbelib.app.cms.module.thinkPocketPackage;

import java.io.File;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.AttachmentUtils;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
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

@Controller
@RequestMapping("/cms/module/thinkPocketPackage")
public class ThinkPocketPackageController extends BaseController {

  private static final Logger logger = LoggerFactory.getLogger(ThinkPocketPackageController.class);

  private final String basePath = "/cms/module/thinkPocketPackage/";

  private static final Pattern PHONE_PATTERN = Pattern.compile("^01[0|1|6|7|8|9]-?[\\d]{3,4}-?[\\d]{4}$");

  @Autowired
  private ThinkPocketPackageService service;

  @RequestMapping(value = {"/index.*"}, method = RequestMethod.GET)
  public String index(Model model, ThinkPocketPackage thinkPocketPackage, HttpServletRequest request) throws AuthException {
    checkAuth("R", model, request);
    thinkPocketPackage.setHomepage_id(getAsideHomepageId(request));
    service.setPaging(model, service.getThinkPocketPackageCount(thinkPocketPackage), thinkPocketPackage);
    model.addAttribute("thinkPocketPackage", thinkPocketPackage);
    model.addAttribute("thinkPocketPackageList", service.getThinkPocketPackageList(thinkPocketPackage));
    return basePath + "index";
  }

  @RequestMapping(value = {"/edit.*"})
  public String edit(Model model, ThinkPocketPackage thinkPocketPackage, HttpServletRequest request) throws AuthException {
    thinkPocketPackage.setHomepage_id(getAsideHomepageId(request));
    if ("MODIFY".equals(thinkPocketPackage.getEditMode())) {
      checkAuth("U", model, request);
      model.addAttribute("thinkPocketPackage", service.copyObjectPaging(thinkPocketPackage, service.getThinkPocketPackageOne(thinkPocketPackage)));
    } else {
      checkAuth("C", model, request);
      thinkPocketPackage.setOutput_order(service.setOutputOrder(thinkPocketPackage));
      model.addAttribute("thinkPocketPackage", thinkPocketPackage);
    }
    return basePath + "edit_ajax";
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

  @RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
  public @ResponseBody JsonResponse save(ThinkPocketPackage thinkPocketPackage, BindingResult result, HttpServletRequest request) {
    JsonResponse res = new JsonResponse(request);
    thinkPocketPackage.setHomepage_id(getAsideHomepageId(request));
    if ("ADD".equals(thinkPocketPackage.getEditMode()) || "MODIFY".equals(thinkPocketPackage.getEditMode())) {
      ValidationUtils.rejectIfEmpty(result, "think_pocket_package_name", "이름을 입력하세요.");
      ValidationUtils.rejectIfEmpty(result, "think_pocket_package_subject", "생각 꾸러미명을 입력하세요.");
    }
    if (!result.hasErrors()) {
      switch (thinkPocketPackage.getEditMode()) {
        case "ADD":
          thinkPocketPackage.setAdd_id(getSessionMemberId(request));
          service.addThinkPocketPackage(thinkPocketPackage);
          res.setValid(true);
          res.setMessage("등록되었습니다.");
          break;
        case "MODIFY":
          thinkPocketPackage.setModify_id(getSessionMemberId(request));
          service.modifyThinkPocketPackage(thinkPocketPackage);
          res.setValid(true);
          res.setMessage("수정되었습니다.");
          break;
        case "DELETE":
          service.deleteThinkPocketPackage(thinkPocketPackage);
          res.setValid(true);
          res.setMessage("삭제되었습니다.");
          break;
        case "DELETE_CHECK":
          service.deleteCheckThinkPocketPackage(thinkPocketPackage);
          res.setValid(true);
          res.setMessage("선택 삭제 되었습니다.");
          break;
      }
    } else {
      res.setValid(false);
      res.setResult(result.getAllErrors());
    }
    return res;
  }

  @RequestMapping(value = {"/loanList.*"}, method = RequestMethod.GET)
  public String thinkPocketPackageLoanList(Model model, ThinkPocketPackage thinkPocketPackage, HttpServletRequest request) throws AuthException {
    checkAuth("R", model, request);
    thinkPocketPackage.setHomepage_id(getAsideHomepageId(request));
    service.setPaging(model, service.getThinkPocketPackageLoanCount(thinkPocketPackage), thinkPocketPackage);
    model.addAttribute("thinkPocketPackage", thinkPocketPackage);
    model.addAttribute("loanList", service.getThinkPocketPackageLoanList(thinkPocketPackage));
    return basePath + "loanList";
  }

  @RequestMapping(value = {"/loanEdit.*"})
  public String thinkPocketPackageReq(Model model, ThinkPocketPackage thinkPocketPackage, HttpServletRequest request) throws AuthException {

    thinkPocketPackage.setHomepage_id(getAsideHomepageId(request));
    if ("MODIFY".equals(thinkPocketPackage.getEditMode())) {
      checkAuth("U", model, request);

      thinkPocketPackage = (ThinkPocketPackage) service.copyObjectPaging(thinkPocketPackage, service.getThinkPocketPackageLoanOne(thinkPocketPackage));
      splitPhoneNumbers(thinkPocketPackage);
      model.addAttribute("thinkPocketPackage", thinkPocketPackage);
    } else {
      checkAuth("C", model, request);

      SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
      Calendar cal = Calendar.getInstance();
      thinkPocketPackage = (ThinkPocketPackage) service.copyObjectPaging(thinkPocketPackage, service.getThinkPocketPackageOne(thinkPocketPackage));
      thinkPocketPackage.setLoan_start_date(sdf.format(cal.getTime()));
      if (thinkPocketPackage.getLender_count() > 0) {
        thinkPocketPackage.setRequest_status("1");
      }
      model.addAttribute("thinkPocketPackage", thinkPocketPackage);
    }
    return basePath + "loanEdit_ajax";
  }

  @RequestMapping(value = {"/loanSave.*"}, method = RequestMethod.POST)
  public @ResponseBody JsonResponse thinkPocketPackageReqSave(ThinkPocketPackage thinkPocketPackage, BindingResult result, HttpServletRequest request) {

    Homepage homepage = getSessionHomepageInfo(request);
    thinkPocketPackage.setHomepage_id(getAsideHomepageId(request));

    JsonResponse res = new JsonResponse(request);
    if ("ADD".equals(thinkPocketPackage.getEditMode()) || "MODIFY".equals(thinkPocketPackage.getEditMode())) {
      ValidationUtils.rejectIfEmpty(result, "loan_start_date", "대출시작기간을 입력하세요.");
      ValidationUtils.rejectIfEmpty(result, "loan_end_date", "대출종료기간을 입력하세요.");
      ValidationUtils.rejectIfEmpty(result, "request_name", "이름을 입력하세요.");
      ValidationUtils.rejectIfEmpty(result, "phone_2", "휴대폰을 입력하세요.");
      ValidationUtils.rejectIfEmpty(result, "phone_3", "휴대폰을 입력하세요.");

      String phone = concatenatePhone(thinkPocketPackage.getPhone_1(), thinkPocketPackage.getPhone_2(), thinkPocketPackage.getPhone_3());
      thinkPocketPackage.setPhone(phone);

      Matcher matcher1 = PHONE_PATTERN.matcher(phone);
      if (!matcher1.matches()) {
        result.rejectValue("phone_2", "휴대폰 형식이 올바르지 않습니다.");
      }
    }
    if (!result.hasErrors()) {
      switch (thinkPocketPackage.getEditMode()) {
        case "ADD":
          thinkPocketPackage.setAdd_id(getSessionMemberId(request));
          service.addThinkPocketPackageLoan(thinkPocketPackage);
          res.setValid(true);
          res.setMessage("등록되었습니다.");
          break;
        case "MODIFY":
          thinkPocketPackage.setModify_id(getSessionMemberId(request));
          service.modifyThinkPocketPackageLoan(thinkPocketPackage);
          if ("6".equals(thinkPocketPackage.getRequest_status())) {
            Map<String, Object> notificationParam = setNotificationParams(thinkPocketPackage, homepage);
            LibSearchAPI.sendNotificationThinkPocketToUser(thinkPocketPackage, notificationParam);
          }
          res.setValid(true);
          res.setMessage("수정되었습니다.");
          break;
        case "DELETE":
          service.deleteThinkPocketPackageLoan(thinkPocketPackage);
          res.setValid(true);
          res.setMessage("취소되었습니다.");
          break;
        case "returnReq":
          service.modifyReturnReq(thinkPocketPackage);
          res.setValid(true);
          res.setMessage("반납요청이 변경되었습니다.");
          break;
        case "returnReqCancel":
          service.modifyReturnReq(thinkPocketPackage);
          res.setValid(true);
          res.setMessage("반납요청이 취소되었습니다.");
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

  private Map<String, Object> setNotificationParams(ThinkPocketPackage thinkPocketPackage, Homepage homepage) {
    LocalDate today = LocalDate.now();
    LocalDate returnDate = today.plusDays(3);
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");

    LibrarySearch librarySearch = new LibrarySearch();
    librarySearch.setSearch_start_date(returnDate.format(formatter));
    librarySearch.setManageCode(homepage.getManage_code());

    Map<String, Object> holidays = LibSearchAPI.getCheckHoliday(librarySearch);
    if ("1".equals(holidays.get("RESULT_CODE"))) {
      returnDate = returnDate.plusDays(1);
    }

    Map<String , Object> notificationParam = new HashMap<>();
    notificationParam.put("talk_code", "A15");
    notificationParam.put("manage_code", homepage.getManage_code());
    notificationParam.put("template_code", "SJB_086173");

    notificationParam.put("data1", "신청하신 책꾸러미가 대출 승인되었으니 3층 유아자료실로 오셔서 대출해가시기 바랍니다.");
    notificationParam.put("data2", thinkPocketPackage.getHomepage_name());
    notificationParam.put("data3", returnDate.format(formatter));
    notificationParam.put("data4", thinkPocketPackage.getThink_pocket_package_subject());
    notificationParam.put("data5", "053-231-2059");

    return notificationParam;
  }

  @RequestMapping(value = {"/excelDownload.*"}, method = RequestMethod.POST)
  public ThinkPocketPackageView excel(Model model, ThinkPocketPackage thinkPocketPackage, HttpServletRequest request, HttpServletResponse response) throws Exception {
    thinkPocketPackage.setHomepage_id(getAsideHomepageId(request));
    List<ThinkPocketPackage> thinkPocketPackageList;
    if ("thinkPocketPackage".equals(thinkPocketPackage.getEditMode())) {
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
    ThinkPocketPackage thinkPocketPackage = new ThinkPocketPackage();
    thinkPocketPackage.setHomepage_id(getAsideHomepageId(request));
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

    return new ResponseEntity<>(bytes, responseHeaders, HttpStatus.OK);
  }

  private String concatenatePhone(String firstPart, String secondPart, String thirdPart) {
    return firstPart + "-" + secondPart + "-" + thirdPart;
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

}
