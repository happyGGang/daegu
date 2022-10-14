<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>
<script type="text/javascript">
  $(function() {
    $('.dialog-common').dialog({ //모달창 기본 스크립트 선언
      autoOpen: false,
      resizable: false,
      modal: true,
      open: function(){
        $('.ui-widget-overlay').addClass('custom-overlay');
      },
      close: function(){
        $('.ui-widget-overlay').removeClass('custom-overlay');
      },
      buttons: [
        {
          text: "저장",
          "class": 'btn btn1',
          click: function() {
            if ( doAjaxPost($('#lockerEdit')) ) {
              location.reload();
            }
          }
        },{
          text: "취소",
          "class": 'btn',
          click: function() {
            $(this).dialog('destroy');
          }
        }
      ]
    });

    $("#dialog-1").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
      width: 400,
      height: 380
    });

  });

</script>
<!-- 대구교육 소식지 신청 등록, 수정 form -->
<form:form id="hashtagEdit" modelAttribute="hashtag" method="post" action="save.do" >
    <form:hidden path="homepage_id"/>
    <table class="type2">
        <colgroup>
            <col width="130" />
            <col width="*"/>
        </colgroup>
        <tbody>
        <tr>
            <th>사물함명</th>
            <td>
                <%--<form:input path="locker_name" class="text" cssStyle="width:100%"/>--%>

            </td>
        </tr>
        <tr>
            <th>설명</th>
            <td>
                <%--<form:textarea path="locker_desc" class="text" cssStyle="width:100%; height:130px;"/>--%>
            </td>
        </tr>
        <tr>
            <th>상태</th>
            <td>
                <%--<form:radiobutton path="status" value="1"/><label for="status1" style="cursor:pointer;">비어있음</label>&nbsp;
                <form:radiobutton path="status" value="2"/><label for="status2" style="cursor:pointer;">신청완료</label>&nbsp;--%>
            </td>
        </tr>
        </tbody>
    </table>
</form:form>
