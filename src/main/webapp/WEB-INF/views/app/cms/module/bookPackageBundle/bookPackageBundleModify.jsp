<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
function modifyBookPackageBundle() {
	if ( doAjaxPost($('#bookPackageBundle')) ) {
		location.reload();
	}
}
</script>
<form:form modelAttribute="bookPackageBundle" action="modifyBookPackageBundle.do" >
<form:hidden path="book_package_bundle_idx"/>
	<p>(<span style="color: red;font-weight: bold;">*</span>)</b>표시항목은 필수입력항목입니다.</p>
	<table class="type2">
		<colgroup>
			<col width="40%">
			<col width="60%">
		</colgroup>
		<tbody id="board_tbody">
			<tr>
				<th>학생추천도서 꾸러미 제목(<span style="color: red;font-weight: bold;">*</span>)</th>
				<td>
					<form:input path="book_package_bundle_title" class="text" cssStyle="width:100%"/>
					<div class="ui-state-highlight">
						<em>꾸러미 제목을 설정하셔야 꾸러미 등록이 가능합니다.</em>
					</div>
				</td>
			</tr>
			<tr>
	        	<th>대출가능권수</th>
	        	<td>
	        		<form:select path="loan_count" cssClass="seletmenu">
	        			<form:option value="">권수</form:option>
		        		<c:forEach var="i" begin="1" end="50" >
		        		<form:option value="${i}">${i} 권</form:option>
		        		</c:forEach>
	        		</form:select>
	        	</td>
	        </tr>
	        <tr>
	        	<th>소장권수</th>
	        	<td>
	        		<form:select path="quantity">
	        			<form:option value="">권수</form:option>
	        			<c:forEach var="i" begin="1" end="50" >
		        		<form:option value="${i}">${i} 권</form:option>
		        		</c:forEach>
	        		</form:select>
	        	</td>
	        </tr>
	        <tr>
	        	<th>수준별</th>
	        	<td>
	        		<form:select path="grade">
	        			<form:option value="">수준별보기</form:option>
	        			<form:option value="3">초등1-2학년</form:option>
	        			<form:option value="4">초등3-4학년</form:option>
	        			<form:option value="5">초등5-6학년</form:option>
	        			<form:option value="6">중학생</form:option>
	        			<form:option value="7">고등학생</form:option>
	        		</form:select>
	        	</td>
	        </tr>
		</tbody>
	</table>
</form:form>