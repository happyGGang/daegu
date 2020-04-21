<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
$(document).ready(function() {
	$('a#checkPass').on('click', function(e) {
		e.preventDefault();
		doAjaxPost($('form#board'));
	});

	$('input#user_password').on('keyup', function(e) {
		if (e.keyCode == 13) {
			$('a#checkPass').click();
		}
	});
});
</script>
<form:form modelAttribute="board" action="checkPassword.do" method="post" onsubmit="return false;">
<form:hidden path="editMode"/>
<div class="wrapper-bbs">
	<table class="bbs-edit">
	<caption>비밀번호 확인</caption>
		<tbody>
			<tr>
				<th>비밀번호 확인</th>
				<td colspan="3">
					<form:password path="user_password" cssStyle="width:35%" cssClass="text" maxlength="20"/>
					<a href="#" id="checkPass" class="btn btn01">확인</a>
				</td>
			</tr>
		</tbody>
	</table>

</div>
</form:form>
