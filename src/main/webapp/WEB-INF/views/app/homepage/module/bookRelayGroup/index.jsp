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

<style>
	.pc-view{display:inline-block;}

	@media (max-width:570px){
		.pc-view{display:none;}
	}
</style>

<form:form modelAttribute="bookRelayGroup" id="bookRelayGroup" action="step2.do" >
<form:hidden path="menu_idx"/>
<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
	<div class="roomicon">
		<div class="inner icowrap"><span class="ico ico5"></span> <strong>독서릴레이</strong>
			<p>「2023 수성북」을 읽고 싶은 단체(동아리, 기관)의 참여 신청을 받습니다.</p>
		</div>
	</div>

	<ul class="con">
		<li>대상 : 7인이상으로 구성된 단체(동아리, 기관)</li>
		<li>운영기간 : 2023년 3월 ~ 10월(약 8개월)</li>
		<li>운영내용 : 수성북 6종 중 연령층 영역별 독서 릴레이</li>
		<li>운영방법</li>
	</ul>

	<div class="step_box">
      <ol class="no5">
        <li>
        <div class="box">
          <p class="num">STEP 01</p>
          수성구립도서관<br>홈페이지 신청
        </div>
        </li>
        <li>
        <div class="box">
          <p class="num">STEP 02</p>
          도서관 방문수령<br>(독서노트)
        </div>
        </li>
        <li>
        <div class="box">
          <p class="num">STEP 03</p>
          수성북 대출<br>방문 수령
        </div>
        </li>
        <li>
        <div class="box">
          <p class="num">STEP 04</p>
          릴레이<br>진행
        </div>
        </li>
        <li>
        <div class="box style1">
          <p class="num">STEP 05</p>
          반납<br class="pc-view" /><br class="pc-view"/></span>
        </div>
        </li>
      </ol>
    </div>
	<p>※ 반납장소 : 범어-사무실(1층) / 용학-정보데스크(1층) / 고산-사무실(4층)</p>
	<p style="margin-bottom:10px;">※ 단체 릴레이 도서 반납기한: 10월까지</p>

	<ul class="con">
		<li>문의 : 053-668-1600</li>
	</ul>

	<div class="link_btn02">
		<a href="#" id="apply_btn" >참여신청</a>
	</div>
</form:form>

