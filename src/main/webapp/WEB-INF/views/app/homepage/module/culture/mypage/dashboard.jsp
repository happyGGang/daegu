<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<link rel="stylesheet" type="text/css" href="/resources/homepage/libculture/css/sub_libculture.css"/>
<link rel="stylesheet" type="text/css" href="/resources/homepage/libculture/css/sub-form-reset.css"/>

<script type="text/javascript">
  $(function() {
    $('input#start_date').datepicker({
      maxDate: $('input#end_date').val(),
      onClose: function (selectedDate) {
        $('input#end_date').datepicker('option', 'minDate', selectedDate);
      }
    });
    $('input#end_date').datepicker({
      minDate: $('input#start_date').val(),
      onClose: function (selectedDate) {
        $('input#start_date').datepicker('option', 'maxDate', selectedDate);
      }
    });

    $('#onemonth').on('click', function(){
      var toDay = new Date();

      $('#end_date').val($.datepicker.formatDate('yy-mm-dd', toDay));
      // 1달전
      toDay.setMonth(toDay.getMonth() - 1);
      $('#start_date').val($.datepicker.formatDate('yy-mm-dd', toDay));

      var param = serializeCustom($('form#pointReqeust'));
      doGetLoad('dashboard.do', param);
    });

    $('#threemonth').on('click', function(){
      var toDay = new Date();

      $('#end_date').val($.datepicker.formatDate('yy-mm-dd', toDay));
      // 3달전
      toDay.setMonth(toDay.getMonth() - 3);
      $('#start_date').val($.datepicker.formatDate('yy-mm-dd', toDay));

      var param = serializeCustom($('form#pointReqeust'));
      doGetLoad('dashboard.do', param);
    });

    $('#sixmonth').on('click', function(){
      var toDay = new Date();

      $('#end_date').val($.datepicker.formatDate('yy-mm-dd', toDay));
      // 6달전
      toDay.setMonth(toDay.getMonth() - 6);
      $('#start_date').val($.datepicker.formatDate('yy-mm-dd', toDay));

      var param = serializeCustom($('form#pointReqeust'));
      doGetLoad('dashboard.do', param);
    });

    $('#twelvemonth').on('click', function(){
      var toDay = new Date();

      $('#end_date').val($.datepicker.formatDate('yy-mm-dd', toDay));
      // 12달전
      toDay.setMonth(toDay.getMonth() - 12);
      $('#start_date').val($.datepicker.formatDate('yy-mm-dd', toDay));

      var param = serializeCustom($('form#pointReqeust'));
      doGetLoad('dashboard.do', param);
    });

    $('#point_search').on('click', function(){
      var param = serializeCustom($('form#pointReqeust'));
      doGetLoad('dashboard.do', param);
    });
  });
</script>

<div class="myDashboardTop">
  <ul>
    <li class="point">
      <div class="">
        <span class="top">${sessionScope.member.member_name}님의 사용가능 포인트입니다.</span>
        <span class="middle">${total_point} P</span>
        <%--<span class="bottom"><img src="libculture/img/point-icon.png" alt="" style='vertical-align:middle;'> 당월 소멸 예정 - <b>9</b></span>--%>
      </div>
    </li>
    <li class="mylibselect">
      <div class="">
        <span class="top">${sessionScope.member.member_name}님의 지정도서관입니다.</span>
        <span class="middle">
          <c:set var="name" value="${fn:split(homepage_name,',')}" />
          <select>
            <c:choose>
              <c:when test="${empty homepage_name or homepage_name == ''}">
                <option value="">등록된 나만의 도서관이 없습니다.</option>
              </c:when>
              <c:otherwise>
                <c:forEach var="i" items="${name}" varStatus="g">
                  <option value="${i}">${i}</option>
                </c:forEach>
              </c:otherwise>
            </c:choose>
          </select>
        </span>
        <span class="bottom">지정도서관을 설정하시면 해당 도서관의 문화정보를 한눈에 보실 수 있습니다. </span>
      </div>
    </li>
  </ul>
</div>

<form:form modelAttribute="pointReqeust" >
<form:hidden path="menu_idx"></form:hidden>
<div class="myDashboard-pointbox">
  <div class="myDashboard-pointbox-title">
    <h5>포인트</h5>
    <%--<a href="" class="more-btn">더보기 +</a>--%>
  </div>
  <div class="myDashboard-pointbox-searchbox">
    <div class="myDashboard-pointbox-searchbox-innerbox">
<%--      <span class=""><input type="radio" name=""> 전체 <input type="radio" name=""> 적립 <input type="radio" name=""> 사용 </span>--%>
      <span class="">
        <a href="javascript:void(0)" id="onemonth" class="btn bttn">1개월</a>
        <a href="javascript:void(0)" id="threemonth" class="btn bttn">3개월</a>
        <a href="javascript:void(0)" id="sixmonth" class="btn bttn">6개월</a>
        <a href="javascript:void(0)" id="twelvemonth" class="btn bttn">1년</a>
      </span>
      <span class="">
        <form:input path="start_date" cssClass="ui-calendar ui-calendar-input"></form:input> ~
        <form:input path="end_date" cssClass="ui-calendar  ui-calendar-input"></form:input>
      </span>
      <span class="search-submit-btn" id="point_search"><a href="javascript:void(0)">조회</a></span>
    </div>
  </div>

  <div class="myDashboard-pointbox-listbox">

    <div class="">
      <span>
        조회기간 내
        <em>
          총 적립 포인트
          <b>
            <c:set var="point" value="0"></c:set>
            <c:forEach var="i" items="${pointList}" varStatus="status">
              <c:set var="point" value="${point + i.point_amount}"></c:set>
            </c:forEach>
            ${point}P
          </b>
        </em>
      </span>
     <%-- <span class="sortbox">
          <select name="">
              <option>구분</option>
          </select>

          <select name="">
              <option>적용위치</option>
          </select>
      </span>--%>
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
      <c:if test="${fn:length(pointList) < 1}">
        <tr>
          <td colspan="6">적립된 포인트가 없습니다.</td>
        </tr>
      </c:if>
      <c:forEach var="i" items="${pointList}" varStatus="status">
        <tr>
          <td>${status.count}</td>
          <td>${i.reg_date}</td>
          <td>${i.biz_name}</td>
          <td>${i.rule_type_code}</td>
          <td><b class="get">${i.point_amount} P</b></td>
          <td>${i.point_memo}</td>
        </tr>
      </c:forEach>
      </tbody>
    </table>
  </div>
</div>
</form:form>

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

