<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tag" uri="/WEB-INF/config/tld/cmsTag.tld" %>
<script type="text/javascript">
$(function(){

});
</script>
<form:form modelAttribute="teach" method="post" action="anonyApplyList.do" >
	<form:hidden path="homepage_id"/>
	<form:hidden path="editMode"/>
	<form:hidden path="menu_idx"/>
	<table class="type1">
		<colgroup>
	       <col width="160" />
	       <col width="*"/>
       	</colgroup>
       	<tbody>
	        <tr>
	         	<th>신청인 성명</th>
	         	<td><form:input path="apply_name" cssClass="text"/></td>
	        </tr>
	        <tr>
	         	<th>비밀번호</th>
	         	<td><form:password path="apply_password" cssClass="text" maxlength="20"/></td>
	        </tr>
		</tbody>
	</table>
	<br/>
	<div style="text-align: center;">
		<button id="save-btn" class="btn btn2">확인</button>
	</div>
</form:form>
