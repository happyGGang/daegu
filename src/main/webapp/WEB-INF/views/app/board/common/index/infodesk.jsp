<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="infodesk">
	<c:if test="${fn:length(category1List) > 0}">
<!-- 	게시판 분류1 :  -->
	<label for="category1"></label>
	<form:select path="category1" cssStyle="width:160px;" cssClass="selectmenu" >
		<form:option value="">== 전체 ==</form:option>
		<form:options itemLabel="code_name" itemValue="code_id" items="${category1List}"/>
	</form:select>
	</c:if>
	<c:if test="${fn:length(category2List) > 0}">
<!-- 	게시판 분류2 : -->
	<label for="category2"></label>
	<form:select path="category2" cssStyle="width:160px;" cssClass="selectmenu" title="카테코리 선택" >
		<form:option value="">== 전체 ==</form:option>
		<form:options itemLabel="code_name" itemValue="code_id" items="${category2List}"/>
	</form:select>
	</c:if>
	<c:if test="${boardManage.manage_idx eq '282' or boardManage.manage_idx eq '195'}">
	도서관 :
	<form:select path="homepage_id" cssClass="selectmenu" cssStyle="width:250px;" title="도서관 선택">
		<form:option value="" label="-전체-"></form:option>
		<c:forEach var="i" varStatus="status" items="${homepageList}">
		<c:if test="${i.homepage_id ne 'h30' and i.homepage_id ne 'h31' and i.homepage_id ne 'h33' and i.homepage_id ne 'h34'}">
		<form:option value="${i.homepage_id}" label="${i.homepage_name}" />
		</c:if>
		</c:forEach>
	</form:select>
	<a href="#" id="libSelect" class="btn1 btn">이동</a>
	</c:if>
	<div class="button btn-group inline">
		<span class="bbs-result">총 게시물 : <b><fmt:formatNumber value="${paging.totalDataCount}" pattern="#,###"/> </b>건</span>
<!-- 		<label for="rowCount" /> -->
		<form:select path="rowCount" cssClass="selectmenu" cssStyle="width:110px;" title="보기 개수 선택">
			<c:if test="${boardManage.board_type eq 'GALLERY' or boardManage.board_type eq 'BOOK'}">
			<c:forEach var="i" begin="8" end="16" step="4">
				<form:option value="${i}">${i}개씩 보기</form:option>
			</c:forEach>
			</c:if>
			<c:if test="${boardManage.board_type ne 'GALLERY'}">
			<c:forEach var="i" begin="10" end="50" step="10">
				<form:option value="${i}">${i}개씩 보기</form:option>
			</c:forEach>
			</c:if>
		</form:select>
	<a href="#" id="rowCountSelect" class="btn btn1">이동</a>
	</div>
</div>