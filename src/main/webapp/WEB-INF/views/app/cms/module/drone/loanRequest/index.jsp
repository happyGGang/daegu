<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
  $(function(){
    $('input#search_start_request_date').datepicker({
      maxDate: $('input#search_end_request_date').val(),
      dateFormat:'yy-mm-dd'
    });

    $('input#search_end_request_date').datepicker({
      minDate: $('input#search_start_request_date').val(),
      dateFormat:'yy-mm-dd'
    });

    $('a.modifyStatus').on('click', function(e) {

      var editMode = 'MODIFY_STATUS';
      var request_idx = $(this).attr('keyValue1');
      var manage_code = $(this).attr('keyValue2');
      var user_key = $(this).attr('keyValue3');
      var request_status = $(this).attr('keyValue4');
      var request_status_name = $(this).attr('keyValue5');

      e.preventDefault();
      if(confirm('대출상태를 '+request_status_name+'(으)로 변경 하시겠습니까?')) {

        $('form#modifyStatus #editMode').val(editMode);
        $('form#modifyStatus #request_idx').val(request_idx);
        $('form#modifyStatus #manage_code').val(manage_code);
        $('form#modifyStatus #user_key').val(user_key);
        $('form#modifyStatus #request_status').val(request_status);

        if(doAjaxPost($('form#modifyStatus'))) {
          location.reload();
        }
      }
    });

    $('#search_start_request_date').change(function(e) {
      e.preventDefault();
      $('#viewPage').val(1);
      doGetLoad('index.do', $('form#loanRequest').serialize());
    });

    $('#search_end_request_date').change(function(e) {
      e.preventDefault();
      $('#viewPage').val(1);
      doGetLoad('index.do', $('form#loanRequest').serialize());
    });

    $('select#search_request_status').change(function(e) {
      e.preventDefault();
      $('#viewPage').val(1);
      doGetLoad('index.do', $('form#loanRequest').serialize());
    });

    $('#search_request_date').change(function(e) {
      e.preventDefault();
      $('#viewPage').val(1);
      doGetLoad('index.do', $('form#loanRequest').serialize());
    });

    $('a#dialog-modify').on('click', function(e) {
      $('#dialog-1').load('statusHistory.do?editMode=MODIFY&request_idx=' + $(this).attr('keyValue1') + '&manage_code=' + $(this).attr('keyValue2')+ '&user_key=' + $(this).attr('keyValue3'), function( response, status, xhr ) {
        $('#dialog-1').dialog('open');
      });

      e.preventDefault();
    });

    $('.requestCancel').on('click',function(e) {
      e.preventDefault();

      var editMode = 'CANCEL';
      var requestIdx = $(this).attr('keyValue1');
      var manageCode = $(this).attr('keyValue2');
      var userkey = $(this).attr('keyValue3');
      var requestStatus = $(this).attr('keyValue4');

      $('form#cancelLoanForm #cancelEditMode').val(editMode);
      $('form#cancelLoanForm #cancelRequestIdx').val(requestIdx);
      $('form#cancelLoanForm #cancelManageCode').val(manageCode);
      $('form#cancelLoanForm #cancelUserkey').val(userkey);

      if (!confirm('드론대출 신청을 취소 하시겠습니까?')) {
        return false;
      }

      if (doAjaxPost($('form#cancelLoanForm'))) {
        location.reload();
      }
    })

    $('.modifyApplyStatus').on('click',function(e) {
      if(confirm('드론대출 신청가능여부를 변경하시겠습니까?')) {
        $('form#modifyApplyStatus #use_yn').val($(this).attr('keyValue1'));

        if (doAjaxPost($('form#modifyApplyStatus'))) {
          location.reload();
        }
      }
    });

  });
</script>

<form:form id="cancelLoanForm" modelAttribute="loanRequest" method="post" action="save.do">
    <form:hidden id="cancelEditMode"   path="editMode" />
    <form:hidden id="cancelManageCode" path="manage_code" />
    <form:hidden id="cancelRequestIdx" path="request_idx" />
    <form:hidden id="cancelUserkey"    path="user_key" />
    <form:hidden id="cancelrequestStatus" path="request_status" />
</form:form>

<form:form id="modifyStatus" modelAttribute="loanRequest" method="post" action="save.do">
    <form:hidden path="editMode"/>
    <form:hidden path="request_idx"/>
    <form:hidden path="manage_code"/>
    <form:hidden path="user_key"/>
    <form:hidden path="request_status"/>
</form:form>

<form:form id="modifyApplyStatus" modelAttribute="loanRequest" method="post" action="modifyApplyStatus.do">
    <form:hidden path="device_idx"/>
    <form:hidden path="use_yn"/>
</form:form>

<form:form modelAttribute="loanRequest" method="get" action="index.do">
    <form:hidden id="homepage_id" path="homepage_id"/>

    <div class="search">
        <label class="blind">검색</label>
        <c:set var="today" value="<%=new java.util.Date()%>" />
        <c:set var="date"><fmt:formatDate value="${today}" pattern="yyyy-MM-dd" /></c:set>
        신청일 : <form:input path="search_start_request_date" value="${empty loanRequest.search_start_request_date ? date : loanRequest.search_start_request_date}" class="text ui-calendar" readonly="true"/>
        ~ <form:input path="search_end_request_date" value="${empty loanRequest.search_end_request_date ? date : loanRequest.search_end_request_date}" class="text ui-calendar" readonly="true"/>
        상태 :
        <form:select path="search_request_status">
            <form:option value="">전체</form:option>
            <form:options items="${status}" itemLabel="code_name" itemValue="code_id"/>
        </form:select>

        <span style="font-size:14px; float: right;">
            <span>${deviceUsedCount > 0 ? '신청가능' : '신청불가능'}</span>
            <a href="#" class="btn btn1 modifyApplyStatus" keyValue1="${deviceUsedCount > 0 ? 'N' : 'Y'}">신청여부변경</a>
        </span>
    </div>

    <table class="type1 center">
        <thead>
        <tr>
            <th width="10">번호</th>
            <th width="50">회원아이디</th>
            <th width="50">회원이름</th>
            <th width="180">책이름 / 저자(등록번호)</th>
            <th width="100">수령장소(장비코드)</th>
            <th width="100">현재상태 -> 다음상태</th>
            <th width="10">신청순번</th>
            <th width="75">신청일</th>
            <th width="50">대출일</th>
            <th width="50">반납일</th>
            <th width="45">기능</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="i" varStatus="status" items="${loanRequestList}">
            <tr>
                <td>${paging.listRowNum - status.index}</td>
                <td>${i.member_id}</td>
                <td>${i.member_name}</td>
                <td>${i.book_name} <br/> ${i.author}<br/>(${i.reg_no})</td>
                <td>${i.pickup_place}<br/>(${i.device_code})</td>
                <td>
                    <c:if test="${i.prev_request_status eq '2000' and i.request_status eq '2002'}">
                        미대출
                    </c:if>
                        ${i.request_status_name}
                    <c:if test="${i.request_status ne '0000' and i.request_status ne '1002'and i.request_status ne '2002' and (i.prev_request_status ne '2000' or i.request_status ne '2002')}">
                    ->
                        <c:choose>
                            <c:when test="${i.request_status eq '2000'}">
                                <c:set var="next_request_status" value="${fn:split(i.next_request_status,',')}" />
                                <c:set var="next_request_status_name" value="${fn:split(i.next_request_status_name,',')}" />

                                <a href="#" class="btn btn2 modifyStatus"  keyValue1="${i.request_idx}" keyValue2="${i.manage_code}" keyValue3="${i.user_key}" keyValue4="${next_request_status[0]}" keyValue5="${next_request_status_name[0]}">${next_request_status_name[0]}</a>

                                <a href="#" class="btn btn2 modifyStatus"  keyValue1="${i.request_idx}" keyValue2="${i.manage_code}" keyValue3="${i.user_key}" keyValue4="${next_request_status[1]}" keyValue5="${next_request_status_name[1]}">${next_request_status_name[1]}</a>
                            </c:when>
                            <c:otherwise>
                                <a href="#" class="btn btn2 modifyStatus"  keyValue1="${i.request_idx}" keyValue2="${i.manage_code}" keyValue3="${i.user_key}" keyValue4="${i.next_request_status}" keyValue5="${i.next_request_status_name}">${i.next_request_status_name}</a>
                            </c:otherwise>
                        </c:choose>
                    </c:if>
                </td>
                <td>${i.request_rank}</td>
                <td><fmt:formatDate value="${i.add_date}" pattern="yyyy-MM-dd HH:mm"/></td>
                <td>${i.loan_date}</td>
                <td>${i.return_date}</td>
                <td>
                    <c:if test="${i.request_status eq '1000'}">
                        <a href="" class="btn btn5 requestCancel" keyValue1="${i.request_idx}" keyValue2="${i.manage_code}" keyValue3="${i.user_key}">신청취소</a>
                    </c:if>
                    <a href="" class="btn btn3" id="dialog-modify" keyValue1="${i.request_idx}" keyValue2="${i.manage_code}" keyValue3="${i.user_key}">상태이력</a>
                </td>
            </tr>
        </c:forEach>
        <c:if test="${fn:length(loanRequestList) < 1}">
            <tr>
                <td colspan="11" style="height:100%">조회된 데이터가 없습니다.</td>
            </tr>
        </c:if>
        </tbody>
    </table>

    <jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
        <jsp:param name="formId" value="#loanRequest"/>
    </jsp:include>

</form:form>

<div id="dialog-1" class="dialog-common" title="상태이력"></div>

