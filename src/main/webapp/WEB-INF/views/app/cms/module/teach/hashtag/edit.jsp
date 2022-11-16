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
            if ( doAjaxPost($('#hashtagEdit')) ) {
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
      height: 260
    });

    $("#hashtag_code").keydown(function(e) {
      var double_check_yn = $('#double_check_yn').val();

      if (double_check_yn == 'Y') {
        $('#double_check_yn').val("N");
      }
    });


    $('a#check-btn').on('click', function(e) {
      e.preventDefault();
      if ($('#hashtag_code').val() == null || $('#hashtag_code').val() == '') {
        alert('해시태그코드를 입력해주세요.');
        return false;
      }

      $('#checkHashtag #check_hashtag_code').val($('#hashtagEdit #hashtag_code').val());

      if (doAjaxPost($('#checkHashtag'))) {
        $('#double_check_yn').val("Y");
      }
    });



  });

</script>

<form:form id="checkHashtag" modelAttribute="hashtag" action="check.do" onsubmit="return false;">
    <form:hidden id="check_hashtag_code" path="hashtag_code"/>
</form:form>
<form:form id="hashtagEdit" modelAttribute="hashtag" method="post" action="save.do" >
    <form:hidden path="homepage_id"/>
    <form:hidden path="double_check_yn"/>
    <form:hidden path="editMode"/>
    <form:hidden path="hashtag_idx"/>
    <table class="type2">
        <colgroup>
            <col width="130" />
            <col width="*"/>
        </colgroup>
        <tbody>
        <tr>
            <th>해시태그코드</th>
            <td>
                <c:choose>
                    <c:when test="${hashtag.editMode eq 'MODIFY'}">
                        ${hashtag.hashtag_code}
                    </c:when>
                    <c:otherwise>
                        <form:input path="hashtag_code" class="text" cssStyle="width:50%"/> <a href="#" id="check-btn" class="btn btn1">중복확인</a>
                    </c:otherwise>
                </c:choose>
            </td>
        </tr>
        <tr>
            <th>해시태그명</th>
            <td>
                <form:input path="hashtag_name" class="text" cssStyle="width:100%"/>
            </td>
        </tr>
        <tr>
            <th>사용유무</th>
            <td>
                <form:radiobutton path="use_yn" checked="${hashtag.editMode eq 'ADD' ? 'true' : '' }" value="Y"  /><label for="use_yn1" style="cursor:pointer;">사용</label>&nbsp;
                <form:radiobutton path="use_yn" value="N"/><label for="use_yn2" style="cursor:pointer;">미사용</label>&nbsp;
            </td>
        </tr>
        </tbody>
    </table>
</form:form>
