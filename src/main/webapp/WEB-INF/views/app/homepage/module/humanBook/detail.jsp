<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link type="text/css" rel="stylesheet" href="/resources/common/css/bootstrap.min.css?3.3.6"/>
<link type="text/css" rel="stylesheet" href="/resources/common/css/bootstrap-multiselect.css"/>
<link type="text/css" rel="stylesheet" href="/resources/common/css/mir_home_sub_community.css" />
<link type="text/css" rel="stylesheet" href="/resources/common/css/mir_home_sub_common.css" />
<script type="text/javascript">
$(function(){

	$('button#apply-btn').on('click', function(e) {
		e.preventDefault();
		doGetLoad('/${homepage.context_path}/module/humanApply/apply.do', serializeCustom($('form#humanBook')));
	});

	$('a#list-btn').on('click', function(e) {
		e.preventDefault();
		$('input#human_book_idx').remove();
		doGetLoad('list.do', serializeCustom($('form#humanBook')));
	});

});
</script>
<form:form modelAttribute="humanBook">
<form:hidden path="menu_idx"/>
<form:hidden path="homepage_id"/>
<form:hidden path="human_book_idx"/>
<form:hidden path="viewPage"/>
</form:form>

<div class="humanbook_view humanbook_view_user cf">
	<div class="image col-md-3">
		<c:choose>
			<c:when test="${not empty humanBook.server_file_name}">
			<img src="/data/humanBook/${humanBook.homepage_id}/${humanBook.server_file_name}" alt="${humanBook.human_book_title}">
			</c:when>
			<c:otherwise>
			<img src="/resources/common/img/img_empty_user.png" alt="${humanBook.human_book_title}">
			</c:otherwise>
		</c:choose>
	</div>
	<div class="profile col-md-9">

		<dl class="humanbook_view_user">
			<dt class="title cf">
				<p>${humanBook.human_book_title}</p>
				<button type="button" id="apply-btn" class="btn btn1 btn_sarambook_register" data-human_book_idx="${humanBook.human_book_idx}">열람신청하기</button>
			</dt>
			<dd class="first"><span class="label label-default label_orange">사람책</span> ${humanBook.teacher_name}</dd>
			<dd class="first"><span class="label label-default label_mint">주제</span>
				<c:forEach items="${activityCateList}" var="code">
					<c:if test="${code.code_id eq humanBook.activity_category}">
					${code.code_name}
					</c:if>
				</c:forEach>
			</dd>
			<dd class="first"><span class="label label-default label_blue">가능요일</span>
				<c:forTokens items="${humanBook.activity_day}" delims="," var="day">
					<c:if test="${day eq '1'}">일</c:if>
					<c:if test="${day eq '2'}">월</c:if>
					<c:if test="${day eq '3'}">화</c:if>
					<c:if test="${day eq '4'}">수</c:if>
					<c:if test="${day eq '5'}">목</c:if>
					<c:if test="${day eq '6'}">금</c:if>
					<c:if test="${day eq '7'}">토</c:if>
				</c:forTokens>
			</dd>
			<dd class="first"><span class="label label-default label_blue">가능시간</span>
				<c:forTokens items="${humanBook.activity_time}" delims="," var="time">
					<c:if test="${time eq '1'}">오전(10:00~12:00)</c:if>
					<c:if test="${time eq '2'}">오후(13:00~17:00)</c:if>
					<c:if test="${time eq '3'}">${i.activity_time_txt}</c:if>
				</c:forTokens>
			</dd>
		</dl>

	</div>
	<div style="clear:both;padding-top:10px;"></div>

	<!-- 사람책 자기소개 -->
	<c:if test="${homepage.homepage_id ne 'h51'}">
	<div class="introduce col-md-12">
		<label for="Instructor" class="col-md-3 control-label"><b>활동가능지역</b></label>
		<div class="col-md-9">
			<p>${humanBook.teacher_content}</p>
		</div>
	</div>
	</c:if>
	<!-- 주요경력 -->
	<div class="career col-md-12">
		<!--<label for="scUserCareer" class="col-md-3 control-label"><b>주요경력</b></label>-->
		<label for="scUserCareer" class="col-md-3 control-label"><b>주요경력</b></label>
		<div class="col-md-9">
			<p>${humanBook.human_book_content}</p>
		</div>
	</div>


</div>

<div>
	<a href="#" id="list-btn" class="btn btn2">목록으로</a>
</div>



