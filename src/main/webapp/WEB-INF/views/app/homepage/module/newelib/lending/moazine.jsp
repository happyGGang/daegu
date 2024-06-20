<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<h2>국내 최대 다양한 전자잡지 서비스 제공</h2>
<br/>
<div class="txt-box">
<ul class="con">
	<li>총 200여종의 분야별 매거진과 과월호 포함 총 20,000여권 서비스 제공</li>
	<li>최신호 및 해당 잡지 과월호 동시 서비스 제공</li>
	<li>디지털 매거진 목차, 썸네일 이미지를 통한 빠른 기사 열람</li>
	<li>선명한 이미지, 우수한 가독성</li>
	<li>콘텐츠 본문검색 기사별 열람 서비스 제공</li>
</ul>
</div>
<br/><br/>
<p style="text-align: center;"><img src="/resources/homepage/elib/img/moazine.png" style="width: 80%;"></p>
<br/>
<p>&nbsp;</p>
<p style="color: red;">
	<b>※ 로그인 후 이용 가능합니다.</b>
</p>
<c:choose>
<c:when test="${member.login && !(member.status_code == '0001' || member.status_code == '0')}">
<script>
$(document).ready(function() {
	$('a#go-btn').on('click', function(e) {
		alert('대출회원만 이용 가능합니다.');
		location.href = "/${homepage.context_path}/intro/login/index.do?menu_idx=35";
	});
});
</script>
<div class="btn_area txt-center">
	<a href="#" id="go-btn" class="btn btn2 newWin"> <b>모아진</b> <span>바로가기</span> <i class="fa fa-external-link"></i></a>
</div>
</c:when>
<c:when test="${member.login && member.unAgreeFlag != '0001'}">
<script>
$(document).ready(function() {
	$('a#go-btn').on('click', function(e) {
		alert('통합회원만 이용 가능합니다.');
		location.href = "/${homepage.context_path}/intro/login/index.do?menu_idx=35";
	});
});
</script>
<div class="btn_area txt-center">
	<a href="#" id="go-btn" class="btn btn2 newWin"> <b>모아진</b> <span>바로가기</span> <i class="fa fa-external-link"></i></a>
</div>
</c:when>
<c:when test="${member.login}">
<script>
$(document).ready(function() {
	$('a#go-btn').on('click', function(e) {
		e.preventDefault();
		var $form = $('form#book');
		$form.prop('action', './extlink_save.do');
		doAjaxPost($form);
		var moazineWindow = window.open('','moazineWindow');
		moazineWindow.location.href = 'https://dl.moazine.com/lib/main.asp?dl=9MtJb2T3nzH3kK1lY2yWl5i10MhjU00d3gU1';
	});
});
</script>
<form name="book" id="book" method="POST">
<input type="hidden" name="editMode" value="EXTLINK">
<input type="hidden" name="com_code" value="MOAZ">
</form>
<div class="btn_area txt-center">
	<a href="#" id="go-btn" class="btn btn2 newWin" title="새창으로 열립니다."> <b>모아진</b> <span>바로가기</span> <i class="fa fa-external-link"></i></a>
</div>
</c:when>
<c:otherwise>
<script>
$(document).ready(function() {
	$('a#go-btn').on('click', function(e) {
		alert('로그인 후 이용가능합니다.');
		location.href = "/${homepage.context_path}/intro/login/index.do?menu_idx=35";
	});
});
</script>
<div class="btn_area txt-center">
	<a href="#" id="go-btn" class="btn btn2 newWin"> <b>모아진</b> <span>바로가기</span> <i class="fa fa-external-link"></i></a>
</div>
</c:otherwise>
</c:choose>
