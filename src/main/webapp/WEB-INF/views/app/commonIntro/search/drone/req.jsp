<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" type="text/css" href="/resources/book/search/css/default.css"/>


<script type="text/javascript">
  $(function() {

    $('#save-btn').on('click', function(e) {
      e.preventDefault();
      if (!confirm('드론대출 신청을 하시겠습니까?')) {
        return false;
      }

      if ($('select#device_code').val() == '') {
        alert('수령장소를 선택하세요.');
        $('select#device_code').focus();
        return false;
      }

      if (doAjaxPost($('form#librarySearch'))) {
        history.back();
      }
    });

  });
</script>

<!-- contents-title-->
<div id="contents-title">
    <h2>드론대출 신청을 위한 선택사항<span style="font-weight:300">을 확인하세요.</span></h2>
</div>
<!-- /contents-title-->

<form:form modelAttribute="librarySearch" action="save.do" method="post" onsubmit="return false;">
    <div class="delibery_info">
        <input type="hidden" name="regNo" value="${librarySearch.regNo}">
        <input type="hidden" name="book_name" value="${librarySearch.book_name}">
        <input type="hidden" name="author" value="${librarySearch.author}">
        <input type="hidden" name="manageCode" value="${librarySearch.manageCode}">
        <input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />

        <div class="" style="padding:10px 0;font-size:120%">(<span style="color:red;font-weight:bold;">*</span>) 항목은 필수 입력값입니다.</div>
        <table class="editTbl">
            <colgroup>
                <col width="28%" />
                <col width="*"/>
            </colgroup>
            <tbody>
            <tr>
                <th>신청인</th>
                <td>
                    ${sessionScope.member.member_name}
                </td>
            </tr>
            <tr>
                <th>수령장소</th>
                <td>
                    <form:select path="device_code">
                        <form:options items="${deviceList}" itemLabel="pickup_place" itemValue="device_code"/>
                    </form:select>
                </td>
            </tr>
            <tr>
                <th>도서명</th>
                <td>${librarySearch.book_name} / ${librarySearch.author}</td>
            </tr>
            <tr>
                <th>등록번호</th>
                <td>${librarySearch.regNo}</td>
            </tr>
            </tbody>
        </table>
        <div class="btnArea" style="text-align: center; padding-top: 25px;">
            <a href="javascript:history.back();" id="cancel-btn" class="btn btn02">취소</a>
            <a href="#" id="save-btn" class="btn btn03">확인</a>
        </div>
    </div>
</form:form>