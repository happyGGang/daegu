<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${boardManage.ebook_yn eq 'Y'}">
	<dd class="info info2">
		<div class="add-fields">
			<i>E-Book URL</i><a href="" class="btn btn2" id="ebook_btn" keyValue="${board.ebook_url}">E-Book 바로보기</a>
		</div>
	</dd>
</c:if>