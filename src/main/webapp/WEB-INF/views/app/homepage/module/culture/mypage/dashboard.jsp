<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<link rel="stylesheet" type="text/css" href="/resources/homepage/libculture/css/sub_libculture.css"/>
<link rel="stylesheet" type="text/css" href="/resources/homepage/libculture/css/sub-form-reset.css"/>
<div class="myDashboardTop">
  <ul>
    <li class="point">
      <div class="">
        <span class="top">${sessionScope.member.member_name}님의 사용가능 포인트입니다.</span>
        <span class="middle">0 P</span>
        <span class="bottom"><img src="libculture/img/point-icon.png" alt="" style='vertical-align:middle;'> 당월 소멸 예정 - <b>9</b></span>
      </div>
    </li>
    <li class="mylibselect">
      <div class="">
        <span class="top">${sessionScope.member.member_name}님의 지정도서관입니다.</span>
        <span class="middle">${homepage_name}</span>
        <span class="bottom">지정도서관을 설정하시면 해당 도서관의 문화정보를 한눈에 보실 수 있습니다. </span>
      </div>
    </li>
  </ul>
</div>

<div class="myDashboard-pointbox">
  <div class="myDashboard-pointbox-title">
    <h5>포인트</h5>
    <a href="" class="more-btn">더보기 +</a>
  </div>
  <div class="myDashboard-pointbox-searchbox">
    <div class="myDashboard-pointbox-searchbox-innerbox">
      <span class=""><input type="radio" name=""> 전체 <input type="radio" name=""> 적립 <input type="radio" name=""> 사용 </span>
      <span class=""><a href="#" id="onemonth" class="btn bttn">1개월</a> <a href="#" id="threemonth" class="btn bttn">3개월</a> <a href="#" id="sixmonth" class="btn bttn">6개월</a> <a href="#" id="twelvemonth" class="btn bttn">1년</a></span>
      <span class=""><input type="text" name="" id="searchDateFrom" class="ui-calendar ui-calendar-input"> ~  <input type="text" name="" id="searchDateTo" class="ui-calendar  ui-calendar-input"></span>
      <span class="search-submit-btn"><a href="">조회</a></span>
    </div>
  </div>

  <div class="myDashboard-pointbox-listbox">
    <div class="">
      <span>조회기간 내 <em>총 적립 포인트 <b>50 P</b></em></span>
      <span class="sortbox">
											<select name="">
												<option>구분</option>
											</select>

											<select name="">
												<option>적용위치</option>
											</select>
										</span>
    </div>
    <table>
      <thead>
      <tr>
        <th style="width:15%;">번호</th>
        <th style="width:20%;">적용일시</th>
        <th style="width:15%;">적용위치</th>
        <th style="width:15%;">구분</th>
        <th style="width:15%;">포인트</th>
        <th style="width:20%;">내역</th>
      </tr>
      </thead>
      <tbody>
      <tr>
        <td>1</td>
        <td>2022-05-11 15:30:20</td>
        <td>범어도서관</td>
        <td>적립</td>
        <td><b class="get">50 P</b></td>
        <td>문화강좌수료</td>
      </tr>
      <tr>
        <td>2</td>
        <td>2022-05-11 15:30:20</td>
        <td>용학도서관</td>
        <td>사용</td>
        <td><b class="use">30 P</b></td>
        <td>문화강좌수료</td>
      </tr>
      <tr>
        <td>3</td>
        <td>2022-05-11 15:30:20</td>
        <td>고산도서관</td>
        <td>사용</td>
        <td><b class="use">30 P</b></td>
        <td>문화강좌참여</td>
      </tr>
      <tr>
        <td>4</td>
        <td>2022-05-11 15:30:20</td>
        <td>구수산도서관</td>
        <td>적립</td>
        <td><b class="get">50 P</b></td>
        <td>문화강좌수료</td>
      </tr>
      <tr>
        <td>5</td>
        <td>2022-05-11 15:30:20</td>
        <td>태전도서관</td>
        <td>적립</td>
        <td><b class="get">50 P</b></td>
        <td>문화강좌수료</td>
      </tr>
      </tbody>
    </table>
  </div>
</div>

<div class="myDashboard-culturebox">
  <div class="myDashboard-culturebox-title">
    <h5>나의 문화 활동</h5>
    <a href="/libculture/module/culture/mypage/applyHistory.do?menu_idx=11" class="more-btn">더보기 +</a>
  </div>
  <!--
  <div class="myDashboard-culturebox-sortbox">
      <span class="">
          <select name="">
              <option>상태</option>
          </select>

          <select name="">
              <option>신청도서관</option>
          </select>
      </span>
  </div>
  -->
  <div class="">
    <table>
      <thead>
      <tr>
        <th style="width:12%">번호</th>
        <th style="width:15%">도서관</th>
        <th style="width:20%">행사명</th>
        <th style="width:20%">신청일시</th>
        <th style="width:20%">취소일시</th>
        <th style="width:13%">상태</th>
      </tr>
      </thead>
      <tbody>
      <c:if test="${fn:length(applyList) < 1}">
        <tr>
          <td colspan="6">등록된 신청이 없습니다.</td>
        </tr>
      </c:if>
      <c:forEach var="i" items="${applyList}" varStatus="status">
        <tr>
          <td>${status.count}</td>
          <td>${i.homepage_name}</td>
          <td>${i.teach_name}</td>
          <td>${i.add_date}</td>
          <td>${i.cancel_date}</td>
          <td>
              ${i.student_status_name}
          </td>
        </tr>
      </c:forEach>
      </tbody>
    </table>
  </div>
</div>

