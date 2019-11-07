<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
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
					if(doAjaxPost($('#boardRegexFilter'))) {
						$(this).dialog('destroy');
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
		width: 500,
		height: 400
	});
});

</script>
<form:form modelAttribute="boardRegexFilter" action="save.do" method="post" onsubmit="return false;">
<form:hidden path="editMode"/>
<form:hidden path="regex_idx"/>
<table class="type2">
	<colgroup>
		<col width="130"/>
		<col width="*"/>
	</colgroup>
	<tbody> 
		<tr>
			<th>정규표현식_문자</th>
			<td>
				<form:input path="regex_str" maxlength="200" cssClass="text" cssStyle="width:95%;"/>
				<div class="ui-state-highlight">
					<i class="fa fa-question-circle"></i><em>예) [0-9]{2}(0[1-9]|1[012])(0[1-9]|1[0-9]|2[0-9]|3[01])-?[012349][0-9]{6}</em>
				</div>
			</td>
		</tr>
		<tr>
			<th>사용여부</th>
			<td>
				<form:select path="use_yn">
					<form:option value="Y">YES</form:option>
					<form:option value="N">NO</form:option>
				</form:select>
			</td>
		</tr>
		<tr>
			<th>설명</th>
			<td>
				<form:input path="remark" cssStyle="width:300px;" cssClass="text" maxlength="50"/>
			</td>
		</tr>
		<tr>
			<th>등록일</th>
			<td>
			<c:choose>
			<c:when test="${boardRegexFilter.editMode eq 'MODIFY'}">
				<fmt:formatDate value="${boardRegexFilter.add_date}" pattern="yyyy.MM.dd" />
			</c:when>
			<c:otherwise>
				자동으로 등록됩니다.
			</c:otherwise>
			</c:choose>
			</td>
		</tr>
		<tr>
			<th>등록ID</th>
			<td>${boardRegexFilter.add_id}</td>
		</tr>
	</tbody>
</table>
</form:form>