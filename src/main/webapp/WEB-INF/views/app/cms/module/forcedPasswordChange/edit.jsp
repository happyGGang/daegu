<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<script type="text/javascript">
  $(function () {
    $form = $('form#forcedPasswordChangeEdit');

    $('.dialog-common').dialog({ //모달창 기본 스크립트 선언
      autoOpen: false,
      resizable: false,
      modal: true,
      open: function () {
        $('.ui-widget-overlay').addClass('custom-overlay');
      },
      close: function () {
        $('.ui-widget-overlay').removeClass('custom-overlay');
        $('body > div.ui-dialog').remove();
      },
      buttons: [
        {
          text: "저장",
          "class": 'btn btn1',
          click: function () {
            if ($('input#member_name').val() == '') {
              alert('이름을 입력해주세요.');
              return false;
            }

            if (doAjaxPost($form)) {
              $(this).dialog('destroy');
                location.reload();
            }
          }
        }, {
          text: "취소",
          "class": 'btn',
          click: function () {
            $(this).dialog('destroy');
          }
        }
      ]
    });
  });
</script>

<form:form modelAttribute="forcedPasswordChangeOne" id="forcedPasswordChangeEdit" method="post" action="/cms/module/forcedPasswordChange/save.do">
    <form:hidden path="forced_password_change_idx"/>
    <form:hidden path="editMode"/>
    <table class="type2">
        <colgroup>
            <col width="130"/>
            <col width="*"/>
        </colgroup>
        <tbody>
        <tr id="memberIdTr">
            <th>등록ID</th>
            <td>
                <c:choose>
                    <c:when test="${forcedPasswordChangeOne.editMode eq 'ADD' }">
                        <form:input path="member_id" class="text"/>
                    </c:when>
                    <c:otherwise>
                        <form:input path="member_id" class="text"/>
                    </c:otherwise>
                </c:choose>
            </td>
        </tr>
        <tr>
            <th>신청자 성명</th>
            <td>
                <form:input path="member_name" class="text" cssStyle="width:100px"/>
            </td>
        </tr>
        <tr>
            <th>비밀번호 변경 여부</th>
            <td>
				<form:radiobutton path="forced_password_change_status" value="Y" id="changeYes"/>
					<label for="changeYes">예</label>
				<form:radiobutton path="forced_password_change_status" value="N" id="changeNo"/>
					<label for="changeNo">아니오</label>
            </td>
        </tr>
        <tr>
            <th>사유</th>
            <td>
                <form:input path="reason" class="text" style="width:100%"/>
            </td>
        </tr>
        </tbody>
    </table>
</form:form>
