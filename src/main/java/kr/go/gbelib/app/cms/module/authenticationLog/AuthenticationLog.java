package kr.go.gbelib.app.cms.module.authenticationLog;

import java.util.Date;
import kr.co.whalesoft.framework.utils.PagingUtils;

public class AuthenticationLog extends PagingUtils {

  private int authentication_log_idx; // 인증로그 인덱스
  private String csrfToken; // CSRF 토큰
  private String user_name; // 사용자명
  private String user_birth; // 사용자 생년월일
  private String user_ip; // 사용자 아이피
  private String user_phone; // 사용자 전화번호 (중간 4자리 마스킹)
  private int homepage_type; // 홈페이지 타입 (1: 홈페이지 , 2: 검색대)
  private String success_type; // 성공여부
  private String result_message; // 결과메시지
  private String cert_type; // 인증타입
  private String user_agent; // 사용자 에이전트
  private String browser_type; // 브라우저 타입
  private Date add_date; // 인증시간
  private String homepage_name; // 홈페이지명
  private String homepage_type_name; // 홈페이지 타입명

  //검색관련
  private String dateType; // 날짜타입
  private String startMonthYear; // 시작년월
  private String startYear; // 시작년도
  private String endYear; // 종료년도
  private String startDate; // 시작일
  private String endDate; // 종료일

  //차트 관련
  private String chart_label; // 라벨
  private int homepage_chart_count; // 홈페이지값
  private int search_chart_count; // 검색대 값

  public int getAuthentication_log_idx() {
    return authentication_log_idx;
  }

  public void setAuthentication_log_idx(int authentication_log_idx) {
    this.authentication_log_idx = authentication_log_idx;
  }

  public String getUser_name() {
    return user_name;
  }

  public void setUser_name(String user_name) {
    this.user_name = user_name;
  }

  public String getUser_birth() {
    return user_birth;
  }

  public void setUser_birth(String user_birth) {
    this.user_birth = user_birth;
  }

  public String getUser_ip() {
    return user_ip;
  }

  public void setUser_ip(String user_ip) {
    this.user_ip = user_ip;
  }

  public String getUser_phone() {
    return user_phone;
  }

  public void setUser_phone(String user_phone) {
    this.user_phone = user_phone;
  }

  public int getHomepage_type() {
    return homepage_type;
  }

  public void setHomepage_type(int homepage_type) {
    this.homepage_type = homepage_type;
  }

  public String getSuccess_type() {
    return success_type;
  }

  public void setSuccess_type(String success_type) {
    this.success_type = success_type;
  }

  public String getResult_message() {
    return result_message;
  }

  public void setResult_message(String result_message) {
    this.result_message = result_message;
  }

  public String getCert_type() {
    return cert_type;
  }

  public void setCert_type(String cert_type) {
    this.cert_type = cert_type;
  }

  public String getUser_agent() {
    return user_agent;
  }

  public void setUser_agent(String user_agent) {
    this.user_agent = user_agent;
  }

  public String getBrowser_type() {
    return browser_type;
  }

  public void setBrowser_type(String browser_type) {
    this.browser_type = browser_type;
  }

  public Date getAdd_date() {
    return add_date;
  }

  public void setAdd_date(Date add_date) {
    this.add_date = add_date;
  }

  public String getCsrfToken() {
    return csrfToken;
  }

  public void setCsrfToken(String csrfToken) {
    this.csrfToken = csrfToken;
  }

  public String getHomepage_name() {
    return homepage_name;
  }

  public void setHomepage_name(String homepage_name) {
    this.homepage_name = homepage_name;
  }

  public String getHomepage_type_name() {
    return homepage_type_name;
  }

  public void setHomepage_type_name(String homepage_type_name) {
    this.homepage_type_name = homepage_type_name;
  }

  public String getDateType() {
    return dateType;
  }

  public void setDateType(String dateType) {
    this.dateType = dateType;
  }

  public String getStartMonthYear() {
    return startMonthYear;
  }

  public void setStartMonthYear(String startMonthYear) {
    this.startMonthYear = startMonthYear;
  }

  public String getStartYear() {
    return startYear;
  }

  public void setStartYear(String startYear) {
    this.startYear = startYear;
  }

  public String getEndYear() {
    return endYear;
  }

  public void setEndYear(String endYear) {
    this.endYear = endYear;
  }

  public String getStartDate() {
    return startDate;
  }

  public void setStartDate(String startDate) {
    this.startDate = startDate;
  }

  public String getEndDate() {
    return endDate;
  }

  public void setEndDate(String endDate) {
    this.endDate = endDate;
  }

  public String getChart_label() {
    return chart_label;
  }

  public void setChart_label(String chart_label) {
    this.chart_label = chart_label;
  }

  public int getHomepage_chart_count() {
    return homepage_chart_count;
  }

  public void setHomepage_chart_count(int homepage_chart_count) {
    this.homepage_chart_count = homepage_chart_count;
  }

  public int getSearch_chart_count() {
    return search_chart_count;
  }

  public void setSearch_chart_count(int search_chart_count) {
    this.search_chart_count = search_chart_count;
  }
}
