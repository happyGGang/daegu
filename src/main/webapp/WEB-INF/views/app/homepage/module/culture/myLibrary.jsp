<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="boardTag" uri="/WEB-INF/config/tld/boardTag.tld"%>


<link rel="stylesheet" type="text/css" href="/resources/homepage/libculture/css/sub_libculture.css"/>
<link rel="stylesheet" type="text/css" href="/resources/homepage/libculture/css/sub-form-reset.css"/>


<script type="text/javascript">
  $(function() {
    $('a#save-btn').on('click', function(e) {
      if(doAjaxPost($('#myLibrary'))) {
        location.reload();
      }
      e.preventDefault();
    });
  });
</script>

<style>
  .myDashboardTop li{width:100%;margin-bottom:20px;}
</style>

<div class="myDashboardTop">
  <ul>
    <li class="mylibselect">
      <div class="">
        <span class="top"><b>${sessionScope.member.member_name}</b>님의 지정도서관입니다.</span>
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

<form:form modelAttribute="myLibrary" action="myLibrarySave.do" method="post" onsubmit="return false;">
  <div class="wrapper-bbs">
    <div class="mylibrary-table-wrap">
      <div>
        <div class="area-box">
          <h3>동구</h3>
          <ul>
              <%--h1 // AA--%>
            <li>
              <form:checkbox path="manage_codes" cssClass="chkbox" value="AA" label="2.28기념학생도서관" checked="${fn:contains(myLibraryOne.manage_codes, 'AA') ? 'checked' : ''}"></form:checkbox>
            </li>
              <%--h5 // AH--%>
            <li>
              <form:checkbox path="manage_codes" cssClass="chkbox" value="AH" label="동부도서관" checked="${fn:contains(myLibraryOne.manage_codes, 'AH') ? 'checked' : ''}"></form:checkbox>
            </li>
              <%--h59 // CB--%>
            <li>
              <form:checkbox path="manage_codes" cssClass="chkbox" value="CB" label="신천도서관" checked="${fn:contains(myLibraryOne.manage_codes, 'CB') ? 'checked' : ''}"></form:checkbox>
            </li>
              <%--h73 // CA--%>
            <li>
              <form:checkbox path="manage_codes" cssClass="chkbox" value="CA" label="안심도서관" checked="${fn:contains(myLibraryOne.manage_codes, 'CA') ? 'checked' : ''}"></form:checkbox>
            </li>
          </ul>
        </div>

        <div class="area-box fl-right">
          <h3>서구</h3>
          <ul>
              <%--h8 // BM--%>
            <li>
              <form:checkbox path="manage_codes" cssClass="chkbox" value="AF" label="서부도서관" checked="${fn:contains(myLibraryOne.manage_codes, 'AF') ? 'checked' : ''}"></form:checkbox>
            </li>
              <%--h64 // BM--%>
            <li>
              <form:checkbox path="manage_codes" cssClass="chkbox" value="BN" label="원고개도서관" checked="${fn:contains(myLibraryOne.manage_codes, 'BN') ? 'checked' : ''}"></form:checkbox>
            </li>
              <%--h77 // BM--%>
            <li>
              <form:checkbox path="manage_codes" cssClass="chkbox" value="BL" label="서구어린이도서관" checked="${fn:contains(myLibraryOne.manage_codes, 'BL') ? 'checked' : ''}"></form:checkbox>
            </li>
              <%--h61 // BM--%>
            <li>
              <form:checkbox path="manage_codes" cssClass="chkbox" value="BQ" label="비산도서관" checked="${fn:contains(myLibraryOne.manage_codes, 'BQ') ? 'checked' : ''}"></form:checkbox>
            </li>
              <%--h62 // BM--%>
            <li>
              <form:checkbox path="manage_codes" cssClass="chkbox" value="BP" label="서구영어도서관" checked="${fn:contains(myLibraryOne.manage_codes, 'BP') ? 'checked' : ''}"></form:checkbox>
            </li>
              <%--h63 // BM--%>
            <li>
              <form:checkbox path="manage_codes" cssClass="chkbox" value="BM" label="비원도서관" checked="${fn:contains(myLibraryOne.manage_codes, 'BM') ? 'checked' : ''}"></form:checkbox>
            </li>
          </ul>
        </div>

        <div class="area-box">
          <h3>남구</h3>
          <ul>
              <%--h3 // AG--%>
            <li>
              <form:checkbox path="manage_codes" cssClass="chkbox" value="AG" label="남부도서관" checked="${fn:contains(myLibraryOne.manage_codes, 'AG') ? 'checked' : ''}"></form:checkbox>
            </li>
              <%--h36 // BT--%>
            <li>
              <form:checkbox path="manage_codes" cssClass="chkbox" value="BT" label="이천어울림도서관" checked="${fn:contains(myLibraryOne.manage_codes, 'BT') ? 'checked' : ''}"></form:checkbox>
            </li>
              <%--h35 // BS--%>
            <li>
              <form:checkbox path="manage_codes" cssClass="chkbox" value="BS" label="대명어울림도서관" checked="${fn:contains(myLibraryOne.manage_codes, 'BS') ? 'checked' : ''}"></form:checkbox>
            </li>
          </ul>
        </div>

        <div class="area-box fl-right">
          <h3>북구</h3>
          <ul>
              <%--h7 // AC--%>
            <li>
              <form:checkbox path="manage_codes" cssClass="chkbox" value="AC" label="북부도서관" checked="${fn:contains(myLibraryOne.manage_codes, 'AC') ? 'checked' : ''}"></form:checkbox>
            </li>
              <%--h46 // BA--%>
            <li>
              <form:checkbox path="manage_codes" cssClass="chkbox" value="BA" label="북구구수산도서관" checked="${fn:contains(myLibraryOne.manage_codes, 'BA') ? 'checked' : ''}"></form:checkbox>
            </li>
              <%--h47 // BB--%>
            <li>
              <form:checkbox path="manage_codes" cssClass="chkbox" value="BB" label="북구대현도서관" checked="${fn:contains(myLibraryOne.manage_codes, 'BB') ? 'checked' : ''}"></form:checkbox>
            </li>
              <%--h48 // BC--%>
            <li>
              <form:checkbox path="manage_codes" cssClass="chkbox" value="BC" label="북구태전도서관" checked="${fn:contains(myLibraryOne.manage_codes, 'BC') ? 'checked' : ''}"></form:checkbox>
            </li>
          </ul>
        </div>

        <div class="area-box">
          <h3>수성구</h3>
          <ul>
              <%--h9 // AE--%>
            <li>
              <form:checkbox path="manage_codes" cssClass="chkbox" value="AE" label="수성도서관" checked="${fn:contains(myLibraryOne.manage_codes, 'AE') ? 'checked' : ''}"></form:checkbox>
            </li>
              <%--h50,수성구범어도서관,BD--%>
            <li>
              <form:checkbox path="manage_codes" cssClass="chkbox" value="BD" label="수성구범어도서관" checked="${fn:contains(myLibraryOne.manage_codes, 'BD') ? 'checked' : ''}"></form:checkbox>
            </li>
              <%--h51,수성구용학도서관,BE--%>
            <li>
              <form:checkbox path="manage_codes" cssClass="chkbox" value="BE" label="수성구용학도서관" checked="${fn:contains(myLibraryOne.manage_codes, 'BE') ? 'checked' : ''}"></form:checkbox>
            </li>
              <%--h52,수성구고산도서관,BF--%>
            <li>
              <form:checkbox path="manage_codes" cssClass="chkbox" value="BF" label="수성구고산도서관" checked="${fn:contains(myLibraryOne.manage_codes, 'BF') ? 'checked' : ''}"></form:checkbox>
            </li>
              <%--h54,수성구립 책숲길도서관,BJ--%>
            <li>
              <form:checkbox path="manage_codes" cssClass="chkbox" value="BJ" label="책숲길도서관" checked="${fn:contains(myLibraryOne.manage_codes, 'BJ') ? 'checked' : ''}"></form:checkbox>
            </li>
              <%--h55,수성구립 물망이도서관,BK--%>
            <li>
              <form:checkbox path="manage_codes" cssClass="chkbox" value="BK" label="물망이도서관" checked="${fn:contains(myLibraryOne.manage_codes, 'BK') ? 'checked' : ''}"></form:checkbox>
            </li>
              <%--h56,수성구립 파동도서관,BG--%>
            <li>
              <form:checkbox path="manage_codes" cssClass="chkbox" value="BG" label="파동도서관" checked="${fn:contains(myLibraryOne.manage_codes, 'BG') ? 'checked' : ''}"></form:checkbox>
            </li>
              <%--h57,수성구립 무학숲도서관,BH--%>
            <li>
              <form:checkbox path="manage_codes" cssClass="chkbox" value="BH" label="무학숲도서관" checked="${fn:contains(myLibraryOne.manage_codes, 'BH') ? 'checked' : ''}"></form:checkbox>
            </li>
          </ul>
        </div>

        <div class="area-box fl-right">
          <h3>중구</h3>
          <ul>
              <%--h10,대구광역시립 중앙도서관,AD--%>
            <li>
              <form:checkbox path="manage_codes" cssClass="chkbox" value="AD" label="중앙도서관" checked="${fn:contains(myLibraryOne.manage_codes, 'AD') ? 'checked' : ''}"></form:checkbox>
            </li>
              <%--h2,대구2ㆍ28민주운동기념회관,AL--%>
            <li>
              <form:checkbox path="manage_codes" cssClass="chkbox" value="AL" label="2ㆍ28도서관" checked="${fn:contains(myLibraryOne.manage_codes, 'AL') ? 'checked' : ''}"></form:checkbox>
            </li>
              <%--h74,중구영어도서관,FS--%>
            <li>
              <form:checkbox path="manage_codes" cssClass="chkbox" value="FS" label="중구영어" checked="${fn:contains(myLibraryOne.manage_codes, 'FS') ? 'checked' : ''}"></form:checkbox>
            </li>
              <%--h75,동인느티나무도서관,FQ--%>
            <li>
              <form:checkbox path="manage_codes" cssClass="chkbox" value="FQ" label="동인느티나무" checked="${fn:contains(myLibraryOne.manage_codes, 'FQ') ? 'checked' : ''}"></form:checkbox>
            </li>
              <%--h76,삼덕마루,HA--%>
            <li>
              <form:checkbox path="manage_codes" cssClass="chkbox" value="HA" label="삼덕마루" checked="${fn:contains(myLibraryOne.manage_codes, 'HA') ? 'checked' : ''}"></form:checkbox>
            </li>
              <%--h34,대구시청작은도서관,FV--%>
            <li>
              <form:checkbox path="manage_codes" cssClass="chkbox" value="FV" label="시청작은도서관" checked="${fn:contains(myLibraryOne.manage_codes, 'FV') ? 'checked' : ''}"></form:checkbox>
            </li>
          </ul>
        </div>

        <div class="area-box">
          <h3>달서구</h3>
          <ul>
              <%--h6,대구광역시립 두류도서관,AB--%>
            <li>
              <form:checkbox path="manage_codes" cssClass="chkbox" value="AB" label="두류도서관" checked="${fn:contains(myLibraryOne.manage_codes, 'AB') ? 'checked' : ''}"></form:checkbox>
            </li>
              <%--h72,달서구립 도원도서관,AB--%>
            <li>
              <form:checkbox path="manage_codes" cssClass="chkbox" value="AB" label="도원도서관" checked="${fn:contains(myLibraryOne.manage_codes, 'AB') ? 'checked' : ''}"></form:checkbox>
            </li>
              <%--h67,달서구립 성서도서관,AB--%>
            <li>
              <form:checkbox path="manage_codes" cssClass="chkbox" value="BU" label="성서도서관" checked="${fn:contains(myLibraryOne.manage_codes, 'BU') ? 'checked' : ''}"></form:checkbox>
            </li>
              <%--h68,달서구립 본리도서관,AB--%>
            <li>
              <form:checkbox path="manage_codes" cssClass="chkbox" value="BX" label="본리도서관" checked="${fn:contains(myLibraryOne.manage_codes, 'BX') ? 'checked' : ''}"></form:checkbox>
            </li>
              <%--h69,달서구립 달서가족문화도서관,AB--%>
            <li>
              <form:checkbox path="manage_codes" cssClass="chkbox" value="BY" label="달서가족문화도서관" checked="${fn:contains(myLibraryOne.manage_codes, 'BY') ? 'checked' : ''}"></form:checkbox>
            </li>
              <%--h66,달서구립 달서어린이,AB--%>
            <li>
              <form:checkbox path="manage_codes" cssClass="chkbox" value="BV" label="달서어린이도서관" checked="${fn:contains(myLibraryOne.manage_codes, 'BV') ? 'checked' : ''}"></form:checkbox>
            </li>
              <%--h70,달서구립 달서영어도서관,AB--%>
            <li>
              <form:checkbox path="manage_codes" cssClass="chkbox" value="BZ" label="달서영어도서관" checked="${fn:contains(myLibraryOne.manage_codes, 'BZ') ? 'checked' : ''}"></form:checkbox>
            </li>
          </ul>
        </div>

        <div class="area-box fl-right last-box">
          <h3>달성군</h3>
          <ul>
              <%--h4,대구광역시립 달성도서관,AJ--%>
            <li>
              <form:checkbox path="manage_codes" cssClass="chkbox" value="AJ" label="달성도서관" checked="${fn:contains(myLibraryOne.manage_codes, 'AJ') ? 'checked' : ''}"></form:checkbox>
            </li>
              <%--h44,달성군립도서관,BR--%>
            <li>
              <form:checkbox path="manage_codes" cssClass="chkbox" value="BR" label="달성군립도서관" checked="${fn:contains(myLibraryOne.manage_codes, 'BR') ? 'checked' : ''}"></form:checkbox>
            </li>
          </ul>
        </div>

      </div>
    </div>
    <div class="end"></div>
    <div class="mylibrary-btn-wrap">
      <a href="javascript:void(0)" id="save-btn" class="btn btn1" title="나만의 도서관 설정 저장">나만의 도서관 지정하기</a>
    </div>
  </div>
</form:form>