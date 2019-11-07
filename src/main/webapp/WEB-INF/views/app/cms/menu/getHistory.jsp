<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tag" uri="/WEB-INF/config/tld/customTag.tld"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Content-Script-Type" content="text/javascript">
<meta http-equiv="Content-Style-Type" content="text/css">
<title>사진 첨부하기 :: SmartEditor2</title>
<link rel="stylesheet" type="text/css" href="/resources/common/css/fontawesome.min.css"/>
<link rel="stylesheet" type="text/css" href="/resources/common/css/select2.min.css"/>
<link rel="stylesheet" type="text/css" href="/resources/common/css/jquery.mmenu.css"/>
<link rel="stylesheet" type="text/css" href="/resources/common/css/default.css"/>
<link rel="stylesheet" type="text/css" href="/resources/common/css/login.css"/>
<link rel="stylesheet" type="text/css" href="/resources/board/css/default.css"/>
<link rel="stylesheet" type="text/css" href="/resources/common/css/jquery-ui-1.12.0.min.css">
<link rel="stylesheet" type="text/css" href="/resources/homepage/${contextPath}/css/default.css"/>
<link rel="stylesheet" type="text/css" href="/resources/book/css/common.css"/>
<script src="/resources/common/js/jquery-1.12.4.min.js"></script>
<script>
jQuery.noConflict();
jQuery(document).ready(function() {
	jQuery('a#menu_html_add').on('click', function(e) {
		e.preventDefault();
		
		jQuery.ajax({
			url : 'getMenuHtmlStrOne.do?homepage_id=${homepage_id}&menu_idx=${menu_idx}&html_idx=' + jQuery(this).attr('keyValue'),
			async : true ,
			success : function(data) {
				opener.parent.wrap_and_insert(data);
				opener.parent.oEditors.getById["html"].exec("LOAD_CONTENTS_FIELD");
			}
		});
	});
});
</script>
</head>
<body>

<div class="table-scroll">
	<table class="">
		<thead>
			<tr class="center">
				<th width="50">순번</th>
				<th width="160">수정일</th>
				<th width="120">등록자정보</th>
				<th width="140">등록IP</th>
				<th>기능</th>
			</tr>
		</thead>
		<tbody style="height:185px">
		<c:if test="${fn:length(menuHtmlList) < 1}">
			<tr>
				<td colspan="5">데이터가 존재하지 않습니다.</td>
			</tr>
		</c:if>
		<c:forEach var="i" varStatus="status" items="${menuHtmlList}">
			<tr>
				<td width="50">
				<c:choose>
				<c:when test="${status.index eq 0}">
				사용중
				</c:when>
				<c:otherwise>
				${status.index}
				</c:otherwise>
				</c:choose>
				</td>
				<td width="160"><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM.dd HH:mm:ss"/></td>
				<td width="120">${i.add_id}</td>
				<td width="140">${i.add_ip}</td>
				<td>
					<a href="" class="btn btn1" id="menu_html_add" keyValue="${i.html_idx}"><i class="fa fa-plus"></i><span>HTML 복사해오기</span></a>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</div>
</body>
</html>