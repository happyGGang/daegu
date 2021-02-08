<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript">
if (!String.prototype.startsWith) {
    Object.defineProperty(String.prototype, 'startsWith', {
        value: function(search, pos) {
            pos = !pos || pos < 0 ? 0 : +pos;
            return this.substring(pos, pos + search.length) === search;
        }
    });
}
$(function() {
	$form = $('form#blackListEdit');

	$('.dialog-common').dialog({ //모달창 기본 스크립트 선언
		autoOpen: false,
		resizable: false,
		modal: true,
	    open: function(){
	        $('.ui-widget-overlay').addClass('custom-overlay');
	    },
	    close: function(){
	        $('.ui-widget-overlay').removeClass('custom-overlay');
	        $('body > div.ui-dialog').remove();
	    },
		buttons: [
			{
				text: "저장",
				"class": 'btn btn1',
				click: function() {
					if ($('input[name="black_type"]:checked').length == 0) {
						alert('블랙 구분 1개 이상 선택하셔야 합니다. 블랙리스트 해제는 해당 아이디 삭제를 해주세요.');
						return false;
					}

					if ($('input#member_name').val() == '') {
						alert('이름을 입력해주세요.');
						return false;
					}

					if(doAjaxPost($form)) {

						$(this).dialog('destroy');
						if ( '${blackListOne.after_click_btn}' != '' ) {
							$('${blackListOne.after_click_btn}').click();
						}
						else {
							location.reload();
						}
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

// 	$('#blackListEdit a.idCheck').on('click', function(e) {
// 		$('#blackListEdit #member_name').val("");
// 		$.get('/cms/module/blackList/checkId.do?homepage_id=' + $('#homepage_id').val() + '&member_id='+ $('#blackListEdit #member_id').val() + '&member_key='+ $('#blackListEdit #member_key').val() + '&search_api_type=' + $('[name="search_api_type"]:checked').val(), function(response) {
// 			if ( response.resultMsg != null ) {
// 				alert(response.resultMsg);
// 			}
// 			else {
// 				$('#blackListEdit #member_key').val(response.memberInfo.SEQ_NO);
// 				$('#blackListEdit #member_name').val(response.memberInfo.USER_NAME);
// 			}
// 		});
// 		e.preventDefault();
// 	});

// 	if ('${blackListOne.member_id}'.length == 14 && ('${blackListOne.member_id}'.startsWith('***') || '${blackListOne.member_id}'.startsWith('1470'))) {
// 		$('input#search_api_type2').prop('checked', true);
// 	}

});
</script>
<form:form modelAttribute="blackListOne" id="blackListEdit" method="post" action="/cms/module/blackList/save.do">
	<form:hidden path="homepage_id"/>
	<form:hidden path="black_idx"/>
	<form:hidden path="editMode"/>
	<table class="type2">
		<colgroup>
	       <col width="130" />
	       <col width="*"/>
       	</colgroup>
       	<tbody>
        	<tr id="memberIdTr">
	         	<th>신청자ID</th>
	         	<td>
	         		<c:choose>
	         			<c:when test="${blackListOne.editMode eq 'ADD' }">
	         				<form:input path="member_id" class="text" />
<%-- 	         				<form:radiobutton path="search_api_type" value="ID" label="ID"/> --%>
<%-- 	         				<form:radiobutton path="search_api_type" value="USERID" label="대출번호"/> --%>
<!-- 	         				<a class="btn btn1 idCheck">ID 확인</a> -->
	         			</c:when>
	         			<c:otherwise>
	         				${blackListOne.member_id}
	         			</c:otherwise>
	         		</c:choose>
	       		</td>
	       	</tr>
<!-- 	       	<tr> -->
<!-- 				<th>신청자 성명</th> -->
<!-- 				<td> -->
<%-- 					<form:input path="member_name" class="text" cssStyle="width:100px" readonly="true"/> --%>
<!-- 				</td> -->
<!-- 			</tr> -->
			<tr>
				<th>블랙 구분</th>
				<td>
					<c:choose>
						<c:when test="${blackListOne.black_type ne null and blackListOne.black_type ne ''}">
							<c:forEach items="${blackTypeList}" var="i">
								<c:set var="checkStr" value="${fn:indexOf(blackListOne.black_type, i.code_id) != -1 ? 'checked' : '' }"/>
								<form:checkbox path="black_type" label="${i.code_name}" value="${i.code_id}" checked="${checkStr}" />
							</c:forEach>
						</c:when>
						<c:otherwise>
							<form:checkboxes items="${blackTypeList}" path="black_type" itemLabel="code_name" itemValue="code_id"/>
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
        	<tr>
	         	<th>사유</th>
	         	<td><form:input path="reason" class="text" style="width:100%"/></td>
        	</tr>
		</tbody>
	</table>
</form:form>
