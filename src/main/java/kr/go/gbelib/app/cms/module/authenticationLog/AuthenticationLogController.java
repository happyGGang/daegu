package kr.go.gbelib.app.cms.module.authenticationLog;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.List;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import kr.co.whalesoft.framework.base.BaseController;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
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

  @RequestMapping(value = "/downloadExcel", method = RequestMethod.GET)
  public void downloadExcel(HttpServletResponse response, AuthenticationLog authenticationLog) throws IOException {
    // 엑셀 파일 생성
    XSSFWorkbook workbook = new XSSFWorkbook();
    XSSFSheet sheet = workbook.createSheet("Authentication Logs");

    // 헤더 생성
    Row headerRow = sheet.createRow(0);
    String[] headers = {
        "홈페이지 이름", "사용자 이름", "생년월일", "전화번호", "IP 주소",
        "홈페이지 타입", "브라우저 타입", "인증일시"
    };

    for (int i = 0; i < headers.length; i++) {
      Cell cell = headerRow.createCell(i);
      cell.setCellValue(headers[i]);
    }

    // 데이터 가져오기
    List<AuthenticationLog> authenticationLogList = service.getAuthenticationLogList(authenticationLog);

    // 데이터 추가
    int rowNum = 1;
    for (AuthenticationLog log : authenticationLogList) {
      Row row = sheet.createRow(rowNum++);
      row.createCell(0).setCellValue(log.getHomepage_name());       // 홈페이지 이름
      row.createCell(1).setCellValue(log.getUser_name());           // 사용자 이름
      row.createCell(2).setCellValue(log.getUser_birth());          // 생년월일
      row.createCell(3).setCellValue(log.getUser_phone());          // 전화번호
      row.createCell(4).setCellValue(log.getUser_ip());             // IP 주소
      row.createCell(5).setCellValue(log.getHomepage_type_name());   // 홈페이지 타입
      row.createCell(6).setCellValue(log.getBrowser_type());        // 브라우저 타입

      // 날짜 포맷 적용
      Cell dateCell = row.createCell(7);
      if (log.getAdd_date() != null) {
        dateCell.setCellValue(log.getAdd_date().toInstant().atZone(ZoneId.systemDefault()).toLocalDate().format(DateTimeFormatter.ofPattern("yyyy.MM.dd")));
      } else {
        dateCell.setCellValue("");  // 날짜 값이 없을 경우 빈 값
      }
    }

    // 응답 설정
    response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
    response.setHeader("Content-Disposition", "attachment; filename=authentication_logs.xlsx");

    // 엑셀 파일을 응답으로 전송
    ServletOutputStream outputStream = response.getOutputStream();
    workbook.write(outputStream);
    outputStream.flush();
    outputStream.close();
  }

  @RequestMapping(value = "/downloadCSV", method = RequestMethod.GET)
  public void downloadCSV(HttpServletResponse response, AuthenticationLog authenticationLog) throws IOException {
    response.setContentType("text/csv");
    response.setHeader("Content-Disposition", "attachment; filename=authentication_logs.csv");

    PrintWriter writer = response.getWriter();
    writer.println("홈페이지 이름, 사용자 이름, 생년월일, 전화번호,IP 주소, 홈페이지 타입, 브라우저 타입, 인증일시");

    List<AuthenticationLog> authenticationLogList = service.getAuthenticationLogList(authenticationLog);
    for (AuthenticationLog log : authenticationLogList) {
      writer.println(
          log.getHomepage_name() + "," +
              log.getUser_name() + "," +
              log.getUser_birth() + "," +
              log.getUser_phone() + "," +
              log.getUser_ip() + "," +
              log.getHomepage_type_name() + "," +
              log.getBrowser_type() + "," +
              (log.getAdd_date() != null ? log.getAdd_date().toInstant().atZone(ZoneId.systemDefault()).toLocalDate().format(DateTimeFormatter.ofPattern("yyyy.MM.dd")) : "")
      );
    }

    writer.flush();
    writer.close();
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
