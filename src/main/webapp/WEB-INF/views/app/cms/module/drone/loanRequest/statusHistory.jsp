<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script>
  $(function() {
    $('#dialog-1.dialog-common').dialog({ //모달창 기본 스크립트 선언
      autoOpen: false,
      resizable: false,
      modal: true,
      open: function () {
        $('#dialog-1.ui-widget-overlay').addClass('custom-overlay');
      },
      close: function () {
        $('#dialog-1.ui-widget-overlay').removeClass('custom-overlay');
      },
      buttons: [
         {
          text: "취소",
          "class": 'btn',
          click: function () {
            $(this).dialog('destroy');
          }
        }
      ]
    });

    $("#dialog-1").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
      width: 750,
      height: 550
    });
  })
</script>

<table class="type1 center">
    <thead>
    <tr>
        <th width="10">번호</th>
        <th width="150">변경 전 상태 -> 변경 후 상태</th>
        <th width="130">작업일시</th>
        <th width="50">작업자</th>
        <th width="80">작업자IP</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="i" varStatus="status" items="${history}">
        <tr>
            <td>${status.count}</td>
            <td>${i.prev_request_status_name} -> ${i.request_status_name}</td>
            <td><fmt:formatDate value="${i.work_date}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
            <td>${i.work_id}</td>
            <td>${i.work_ip}</td>
        </tr>
    </c:forEach>
    <c:if test="${fn:length(history) < 1}">
        <tr>
            <td colspan="8" style="height:100%">조회된 데이터가 없습니다.</td>
        </tr>
    </c:if>
    </tbody>
</table>


