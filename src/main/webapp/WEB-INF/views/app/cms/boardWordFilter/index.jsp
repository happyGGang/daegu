<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
$(function() {
	$('a#btn_save').on('click', function(e) {
		e.preventDefault();
		var content = $('textarea#word').val().trim();
		var useY = $('input#use_yn1').is(':checked');
		if (useY && content.length < 1) {
			alert('필터링할 단어를 입력해주세요. 필터링할 단어가 없을 경우 \'사용안함\'을 선택하세요.');
			return false;
		}
		if(doAjaxPost($('#boardWordFilter'))) {
			location.reload();
		}
	});
});
</script>
<div class="wrapper wrapper-white">
<form:form modelAttribute="boardWordFilter" action="save.do" method="post" onsubmit="return false;">
	<div class="column ban">
		<div>
			<div class="infodesk">
				게시판 단어 필터링 사용유무 : 
				<form:radiobutton path="use_yn" value="Y" label="사용함"/>
				<form:radiobutton path="use_yn" value="N" label="사용안함"/>
				<div class="button btn-group inline">
					<c:if test="${authC}">
					<a href="" class="btn btn5 left" id="btn_save"><i class="fa fa-plus"></i><span>저장</span></a>
					</c:if>
				</div>
			</div>
			<div class="table-wrap">
				<div class="ui-state-highlight">
					<i class="fa fa-question-circle"></i><em>단어와 단어를 , 로 구분하여 주세요.(예 : 개나리, 십장생)</em>
				</div>
				<form:textarea path="word" cssStyle="width:100%; height:200px;"/>
			</div>
		</div>
	</div>
</form:form>	
</div>