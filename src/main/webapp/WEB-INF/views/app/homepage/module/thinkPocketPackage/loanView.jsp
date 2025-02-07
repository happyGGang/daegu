<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript">
  $(function () {
    $('#list-btn').on('click', function (e) {
      e.preventDefault();
      doGetLoad('loanList.do', $('#thinkPocketPackage').serialize());
    });
  });
</script>
<form:form modelAttribute="thinkPocketPackage" action="loanList.do" method="GET">
    <form:hidden path="menu_idx"/>
    <form:hidden path="viewPage"/>
</form:form>
<div>
    <table class="type1">
        <colgroup>
            <col width="150"/>
            <col width="*"/>
        </colgroup>
        <tbody>
        <tr>
            <th>생각 주머니명</th>
            <td>${thinkPocketPackage.think_pocket_package_subject}</td>
        </tr>
        <tr>
            <th>대출기간</th>
            <td>${thinkPocketPackage.loan_start_date} ~ ${thinkPocketPackage.loan_end_date}</td>
        </tr>
        <tr>
            <th>신청자</th>
            <td>${thinkPocketPackage.request_name}</td>
        </tr>
        <tr>
            <th>휴대폰</th>
            <td>${thinkPocketPackage.phone}</td>
        </tr>
        <tr>
            <th>수령(대출) 및 수거(반납)장소</th>
            <td>${thinkPocketPackage.loan_place}</td>
        </tr>
        <tr>
            <th>신청사유</th>
            <td>${thinkPocketPackage.request_content}</td>
        </tr>
        <tr>
            <th>진행상태</th>
            <td>
                <c:choose>
                    <c:when test="${thinkPocketPackage.request_status eq '0'}">신청중</c:when>
                    <c:when test="${thinkPocketPackage.request_status eq '1'}">예약상담중</c:when>
                    <c:when test="${thinkPocketPackage.request_status eq '2'}">대출중</c:when>
                    <c:when test="${thinkPocketPackage.request_status eq '3'}">반납완료</c:when>
                    <c:when test="${thinkPocketPackage.request_status eq '4'}">관리자취소</c:when>
                    <c:when test="${thinkPocketPackage.request_status eq '5'}">반납요청완료</c:when>
                    <c:when test="${thinkPocketPackage.request_status eq '6'}">승인</c:when>
                </c:choose>
            </td>
        </tr>
        </tbody>
    </table>
</div>
<br>
<div>
    <a href="#" id="list-btn" class="btn btn3">목록으로</a>
</div>