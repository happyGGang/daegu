<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript">
$(function() {
	
	$('a#apply_btn').on('click', function(e) {
		e.preventDefault();
		doGetLoad('step2.do', serializeCustom($('form#bookRelayClub')));
	});
});
</script>

<form:form modelAttribute="bookRelayClub" id="bookRelayClub" action="step2.do" >
<form:hidden path="menu_idx"/>
	<h4>「2020 수성북」을 읽고 싶은 독서동아리의 참여 신청을 받습니다.</h4>
	<ul>
		<li>대상 : 독서동아리</li>
		<li>운영기간 : 2020. 6. 2.(화) ~ 10.31.(토)</li>
		<li>운영방법 : 도서관 홈페이지 신청 → 방문 수령(수성북, 독서노트) → 릴레이 진행 → 반납</li>
	</ul>
	<p>※ 독서노트 : 책자형(수성구립도서관 배부), SNS(인스타그램) 활용</p>
	<div class="txt-box">문의 : 668-1600</div>
	<div class="button bbs-btn center">
		<a href="#" id="apply_btn" class="btn btn1">참여신청</a>
	</div>
</form:form>

