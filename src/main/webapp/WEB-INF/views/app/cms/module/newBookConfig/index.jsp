<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript">
$(document).ready(function() {
	
	$('a#dialog-save').on('click', function(e) {
		e.preventDefault();
		
// 		if($('input[name="shelfCode"]:checked').length < 1) {
// 			alert('선택된 자료실이 없습니다.');
// 			return false;
// 		}
		
		if(confirm('신착자료 자료실을 설정하시겠습니까?')) {
			doAjaxPost($('form#newBookConfig'));
		}
	});
	
});
</script>
<form:form  modelAttribute="newBookConfig" action="save.do" method="POST">
	<form:hidden path="homepage_id"/>
	<form:hidden path="editMode"/>
	<div class="infodesk">
		<div class="button">
			<a href="" class="btn btn5 left" id="dialog-save"><i class="fa fa-plus"></i><span>저장</span></a>
		</div>
	</div>
	<table class="type1">
		<thead>
			<tr class="center">
				<th>${homepage.homepage_name} 신착자료 자료실 선택</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>
					<ul>
						<c:forEach items="${shelfList}" var="i" varStatus="status">
						<li style="width: 20%; float: left;">
							<form:checkbox path="shelf_code_arr" value="${i.CODE}" label="${i.DESCRIPTION}" checked="${i.CHECKED}"/>
						</li>
						</c:forEach>
					</ul>
				</td>
			</tr>
			<c:if test="${fn:length(shelfList) < 1}">
			<tr>
				<td colspan="4">자료실 정보가 없습니다.</td>
			</tr>
			</c:if>
		</tbody>
	</table>
	<br>
	<div class="ui-state-highlight">
		<em>* 현재 기능 제한을 적용중이면 붉은색으로 표시가 됩니다.</em><br>
		<em>* 현재 일자가 사용기간이지만 사용여부가 '미사용'으로 설정시, 기능제한이 적용되지 않습니다.(우선순위1: 사용여부, 우선순위2 : 기간)</em>
	</div>
</form:form>

<div id="dialog-1" class="dialog-common" title="희망도서신청"></div>
