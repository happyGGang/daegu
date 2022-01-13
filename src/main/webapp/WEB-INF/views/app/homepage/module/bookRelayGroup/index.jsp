<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript">
$(function() {
	
	$('a#apply_btn').on('click', function(e) {
		e.preventDefault();
		doGetLoad('step2.do', serializeCustom($('form#bookRelayGroup')));
	});
});
</script>

<form:form modelAttribute="bookRelayGroup" id="bookRelayGroup" action="step2.do" >
<form:hidden path="menu_idx"/>
<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
	<div class="roomicon">
			<div class="inner icowrap"><span class="ico ico5"></span> <strong>독서릴레이</strong>
				<p>「2021 수성북」을 읽고 싶은 단체(동아리, 기관)의 참여 신청을 받습니다.</p>
			</div>
		</div>

		<ul class="con">
			<li>대상 : 단체</li>
			<li>운영기간 : 2021. 3. 24.(수) ~ 9. 30.(목)</li>
			<li>운영방법 : 수성구립도서관 홈페이지 신청 → 방문수령(수성북, 독서노트) → 릴레이 진행 → 반납<br /><span style="margin-left:80px;font-size:15px;">※ 독서노트 : 책자형(수성구립도서관 배부), SNS(인스타그램) 활용</span><br /><span style="margin-left:80px;font-size:15px;">※ 인스타그램 활용시(@suseong_lib 게시물 확인)</span></li>
			<li>문의 : 668-1600</li>
		</ul>
	<div class="link_btn02">
		<a href="#" id="apply_btn" >참여신청</a>
	</div>
</form:form>

