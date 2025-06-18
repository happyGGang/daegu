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

					if ($('input[name="teach_code"]:checked').length == 0) {
						alert('강좌 구분을 1개 이상 선택하셔야 합니다. 블랙리스트 해제는 해당 아이디 삭제를 해주세요.');
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

	$("#teach_code_all").click(function (){
		let checked = $(this).prop("checked");
		$("input[name='teach_code']").prop("checked",checked);
	});
	// 개별 teach_code 클릭시 teach_code_all 상태 갱신
	$('input[name="teach_code"]').on('change', function() {
		let total = $('input[name="teach_code"]').length;
		let checked = $('input[name="teach_code"]:checked').length;

		if (total === checked) {
			$('#teach_code_all').prop('checked', true);
		} else {
			$('#teach_code_all').prop('checked', false);
		}
	});


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
	         			</c:when>
	         			<c:otherwise>
	         				${blackListOne.member_id}
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
				<th>강좌 구분</th>
				<td>
					<input id="teach_code_all" name="teach_code_all" type="checkbox" value="ALL" <c:if test="${teachAllChecked}">checked</c:if> >
					<label for="teach_code_all">전체</label>
					<c:choose>
						<c:when test="${blackListOne.teach_code ne null and blackListOne.teach_code ne ''}">
							<c:forEach items="${teachCodeList}" var="i">
								<c:set var="checkStr" value="${fn:indexOf(blackListOne.teach_code, i.teach_code) != -1 ? 'checked' : '' }"/>
								<form:checkbox path="teach_code" label="${i.code_name}" value="${i.teach_code}" checked="${checkStr}" cssStyle="margin-left:5px;" />
							</c:forEach>
						</c:when>
						<c:otherwise>
							<form:checkboxes items="${teachCodeList}" path="teach_code" itemLabel="code_name" itemValue="teach_code" cssStyle="margin-left:5px;"/>
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
