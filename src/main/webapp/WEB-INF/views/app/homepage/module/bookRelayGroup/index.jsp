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
			<p>「2022 수성북」을 읽고 싶은 단체(동아리, 기관)의 참여 신청을 받습니다.</p>
		</div>
	</div>

	<ul class="con">
		<li>대상 : 지역의 단체 / 1단체 10권 이하</li>
		<li>운영기간 : 2022. 3. 22.(화) ~ 9. 30.(금)</li>
	</ul>

	<div class="step_box">
      <ol class="no4">
        <li>
        <div class="box">
          <p class="num">STEP 01</p>
          수성구립도서관<br>홈페이지 신청
        </div>
        </li>
        <li>
        <div class="box">
          <p class="num">STEP 02</p>
          도서관 방문수령<br>(수성북, 독서노트)
        </div>
        </li>
        <li>
        <div class="box">
          <p class="num">STEP 03</p>
          독서릴레이<br>진행
        </div>
        </li>
        <li>
        <div class="box style1">
          <p class="num">STEP 04</p>
          도서관<br>방문 반납
        </div>
        </li>
      </ol>
    </div>
	<p>※ 독서노트 : 책자형(범어, 용학, 고산도서관에서 배부), SNS(인스타그램: @suseong_lib) 활용</p>

	<ul class="con">
		<li>문의 : 053-668-1600</li>
	</ul>

	<div class="link_btn02">
		<a href="#" id="apply_btn" >참여신청</a>
	</div>
</form:form>

