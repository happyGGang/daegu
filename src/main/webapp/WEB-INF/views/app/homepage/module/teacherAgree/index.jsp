<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript">
$(function() {
	
	var $form = $('form#teacherAgree');
	
	$('a#save-btn').on('click', function(e) {
		e.preventDefault();
		$('input#editMode').val('ADD');
		doAjaxPost($form);
	});
	
	$('a#cancel-btn').on('click', function(e) {
		e.preventDefault();
		$('input#editMode').val('DELETE');
		doAjaxPost($form);
	});
	
});
</script>
<form:form modelAttribute="teacherAgree" action="save.do" method="POST" onsubmit="return false;">
	<form:hidden path="editMode"/>
	<form:hidden path="menu_idx"/>
	
	<h3 class="tmg">강사이력 정보 제공 동의</h2>
	<div class="txt-box" style="margin-bottom: 20px;">
		<ul class="con2">
			<li>강사이력 보관을 위한 정보제공에 동의 합니다.</li>
			<c:if test="${not empty teacherAgreeOne.agree_date}">
			<li>동의 일자  : <fmt:formatDate value="${teacherAgreeOne.agree_date}" pattern="yyy-MM-dd"/> </li>
			</c:if>
		</ul>
	</div>
	
	
	<c:forEach items="${termsList}" var="terms">
		${terms.contents }
	</c:forEach>
	
</form:form>

	<div class="btn-wrap" style="text-align: center;">
		<c:if test="${empty teacherAgreeOne.agree_date}">
		<a href="#" id="save-btn" class="btn btn1">동의</a>
		</c:if>
		<c:if test="${not empty teacherAgreeOne.agree_date}">
		<a href="#" id="cancel-btn" class="btn">동의취소</a>
		</c:if>
	</div>