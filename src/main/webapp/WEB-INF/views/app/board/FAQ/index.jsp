<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
$(function(){
	var article = $('.faq .article');
	article.addClass('hidden');
	article.find('.a').slideUp(0);

	$('.faq .article .trigger').click(function(e){
		e.preventDefault();
		var myArticle = $(this).parents('.article:first');
		if(myArticle.hasClass('hidden')){
			article.addClass('hidden').removeClass('show');
			article.find('.a').slideUp(100);
			myArticle.removeClass('hidden').addClass('show');
			myArticle.find('.a').slideDown(100);
		} else {
			myArticle.removeClass('show').addClass('hidden');
			myArticle.find('.a').slideUp(100);
		}
	});

	$('.faq .hgroup .trigger').click(function(e){
		e.preventDefault();
		var hidden = $('.faq .article.hidden').length;
		if(hidden > 0){
			article.removeClass('hidden').addClass('show');
			article.find('.a').slideDown(100);
		} else {
			article.removeClass('show').addClass('hidden');
			article.find('.a').slideUp(100);
		}
	});

});
</script>
<c:if test="${boardManage.add_html_use_yn eq 'Y' and fn:length(boardManage.top_html) > 0}">
${boardManage.top_html}
</c:if>
<jsp:include page="/WEB-INF/views/app/board/common/index/script.jsp" flush="false" />
<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
<form:form modelAttribute="board" action="index.do" method="get" onsubmit="return false;">
<jsp:include page="/WEB-INF/views/app/board/common/form_param.jsp" flush="false" />
<form:hidden path="board_mode"/>
<div class="wrapper-bbs">
	<div class="infodesk">
		<c:if test="${fn:length(category1List) > 0}">
		게시판 분류1 :
		<form:select path="category1" cssStyle="width:160px;" cssClass="selectmenu" >
			<form:option value="">== 전체 ==</form:option>
			<form:options itemLabel="code_name" itemValue="code_id" items="${category1List}"/>
		</form:select>
		</c:if>
		<c:if test="${fn:length(category2List) > 0}">
		게시판 분류2 :
		<form:select path="category2" cssStyle="width:160px;" cssClass="selectmenu" >
			<form:option value="">== 전체 ==</form:option>
			<form:options itemLabel="code_name" itemValue="code_id" items="${category2List}"/>
		</form:select>
		</c:if>
	</div>
	<div class="faqArea">
		<ul  class="faq">
			<c:forEach var="i" varStatus="status" items="${boardList}">
			<li class="article hidden">
				<div class="q blue">
					<a class="trigger" href="#"><span>${i.category1_name} Q.</span> ${i.title}</a>
				</div>
				<div class="a">
					<span class="tit">A.</span>
					<div class="aContent">${i.content}</div>
				</div>
			</li>
			</c:forEach>
			<c:if test="${fn:length(boardList) < 1}">
			<li class="article">
				<div class="q">
					<a class="trigger" href="#">데이터가 존재하지 않습니다.</a>
				</div>
			</li>
			</c:if>
		</ul>
	</div>
	<div class="button bbs-btn right">
		<c:if test="${authMBA}">
		<c:choose>
		<c:when test="${board.delete_yn eq 'Y'}">
			<a href="" class="btn btn2" id="board_normal_btn"></i><span>일반 게시물 보기</span></a>
			<a href="" class="btn btn1" id="board_recovery_btn"></i><span>게시물 복구</span></a>
				<a href="" class="btn btn5" id="board_delete_btn"></i><span>완전 삭제</span></a>
		</c:when>
		<c:otherwise>
			<c:if test="${authMBA}">
			<a href="index.do?menu_idx=${param.menu_idx}&manage_idx=${boardManage.manage_idx}&board_mode=admin&viewPage=1" class="btn btn4" id="board_manage_btn"><span>관리</span></a>
			</c:if>
<!-- 			<a href="" class="btn btn4" id="board_deleteRecovery_btn"><span>삭제 게시물 보기</span></a> -->
			<c:if test="${authC}">
			<a href="" class="btn btn1 write" id="board_edit_btn"><i class="fa fa-pencil"></i><span>글쓰기</span></a>
			</c:if>
		</c:otherwise>
		</c:choose>
		</c:if>
	</div>
	<jsp:include page="/WEB-INF/views/app/board/common/index/paging.jsp" flush="false">
		<jsp:param name="formId" value="#board"/>
	</jsp:include>
</div>
</form:form>
<c:if test="${boardManage.add_html_use_yn eq 'Y' and fn:length(boardManage.bottom_html) > 0}">
${boardManage.bottom_html}
</c:if>