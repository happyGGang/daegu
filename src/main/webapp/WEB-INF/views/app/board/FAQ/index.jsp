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
<style>
.faqArea{clear:both;margin:0 auto;border-top:2px solid #3970b8;border-bottom:1px solid #d6d6d6;}
.faq{margin:0;padding:0;list-style:none;}
.faq .q{margin:0;border-top:1px solid #ddd;}
.faq .q a.trigger{display:block;padding:15px;font-weight:bold;color:#333;text-align:left;text-decoration:none !important;font-size:14px;}
.faq .q span{font-size:14px;font-weight:bold;color:#e32c2c;margin-right:5px;}
.faq .hidden .q a.trigger{background:none;font-size:14px;}
.faq .q a.trigger:hover{background:#f5fbfd;color:#e32c2c;}
.faq .a{position:relative;margin:0;padding:10px 15px;line-height:1.5;background:#fdfcf5;overflow:hidden;padding-bottom:10px;padding-top:10px;border-top:1px dashed #ddd;}
.faq .a .tit{font-size:14px;font-weight:bold;color:#e32c2c;display:inline-block;width:14px;position:absolute;top:14px;left:15px;}
.faq .a .aContent{margin-left:25px;padding:5px 0;}
.faq .a .aContent p{line-height:20px;}
.faq .a .aContent span, .faq .a .aContent p, .faq .a .aContent strong{font-size:13px !important;}
.faq .goQna{
width:650px;padding:10px 0 10px 35px;margin:10px 0 7px 25px;border:1px dashed #ccc;background:url('/resources/board/img/ico_tip.gif') #fff no-repeat 10px 12px;font-size:13px;font-weight:bold;
-webkit-border-radius:6px;-moz-border-radius:6px;border-radius:6px;
}
.faq .goQna span{vertical-align:top;margin-right:7px;font-size:13px;}

.faq .q.blue span{color:#2e91ed;}
.faq .q.blue a.trigger:hover,
.faq .q.blue a.trigger:active,
.faq .q.blue a.trigger:focus{color:#2e91ed;}
.faq .a.blue .tit{color:#2e91ed !important;}

</style>
<c:if test="${boardManage.add_html_use_yn eq 'Y' and fn:length(boardManage.top_html) > 0}">
${boardManage.top_html}
</c:if>
<jsp:include page="/WEB-INF/views/app/board/common/index/script.jsp" flush="false" />
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
					<a class="trigger" href="#"><span>Q.</span> ${i.title}</a>
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
			<a href="" class="btn btn4" id="board_manage_btn"><span>관리</span></a>
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