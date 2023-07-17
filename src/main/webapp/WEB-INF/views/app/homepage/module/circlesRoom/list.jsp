<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tag" uri="/WEB-INF/config/tld/cmsTag.tld"%>
<script src="//spi.maps.daum.net/imap/map_js_init/postcode.v2.js"></script>
<script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>
<script type="text/javascript">
$(document).ready(function() {
	$('a#req_cancle').on('click', function(e) {
		e.preventDefault();
		if(confirm('삭제 하시겠습니까?')) {
			$('input#editMode_d').val('DELETE');
			$('input#circles_idx_d').val($(this).attr('keyValue'));
			doAjaxPost($('form#circlesRoomDel'));
		}
	});
	
	$('select#circles_div').on('change', function() {
		doGetLoad('list.do', serializeCustom($('form#circlesRoomView')));
	});
});
</script>
<form:form modelAttribute="circlesRoom" id="circlesRoomDel" action="save.do" method="POST">
<form:hidden path="homepage_id" id="homepage_id_d"/>
<form:hidden path="menu_idx" id="menu_id_d"/>
<form:hidden path="editMode" id="editMode_d"/>
<form:hidden path="circles_idx" id="circles_idx_d"/>
</form:form>

<form:form modelAttribute="circlesRoom" id="circlesRoomView">
<form:hidden path="homepage_id"/>
<form:hidden path="menu_idx"/>

<form:select path="circles_div" cssClass="selectmenu">
	<form:option value="">전체</form:option>
	<form:options items="${circlesDivCode}" itemLabel="code_name" itemValue="code_id"/>
</form:select>

<div>
	<table>
		<thead>
			<tr>
				<th>No</th>
				<th>신청인</th>
				<th>연락처</th>
				<th>신청인원</th>
				<th>사용일</th>
				<th>사용시간</th>
				<th>상태</th>
				<th>관리</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${myCirclesRoom}" var="i" varStatus="status">
			<tr>
				<td>${fn:length(myCirclesRoom)-status.index}</td>
				<td>${i.user_name}</td>
				<td>${i.user_phone}</td>
				<td>${i.visit_num}</td>
				<td>${i.visit_date}</td>
				<td>
					<c:forTokens items="${i.visit_time}" var="reqTime" delims=",">
						<c:forEach items="${reqTimeCode}" var="code">
							<c:if test="${code.code_id eq reqTime}">
							<p>${code.code_name}</p>
							</c:if>
						</c:forEach>
					</c:forTokens>
				</td>
				<td>
					<c:choose>
					<c:when test="${i.status eq 0}">
						<span>신청</span>
					</c:when>
					<c:when test="${i.status eq 1}">
						<span>승인</span>
					</c:when>
					<c:when test="${i.status eq 2}">
						<span>미승인</span>
					</c:when>
					</c:choose>
				</td>
				<td>
					<c:choose>
						<c:when test="${i.status eq 1}">
						
						</c:when>
						<c:otherwise>
						<a href="#" id="req_cancle" keyValue="${i.circles_idx}">[취소]</a>
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
</form:form>
