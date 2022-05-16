<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript" src="/resources/common/js/jquery-barcode.js"></script>
<script type="text/javascript">
$(function(){

	var settings = {
		barWidth: 2,
		barHeight: 70,
		fontSize : 12,
		output : 'bmp'
	};

	$("#barcodeTarget").barcode('${sessionScope.member.user_no}', "code128", settings);
	$("#barcodeTarget").css("margin","0 auto");

});

function clock()
{
	var today = new Date();



	var years = $('#years');
	var months = $('#month');
	var days = $('#day');
	var weeks = $('#week');

	var hours = $('#hours');
	var minutes = $('#minutes');
	var seconds = $('#seconds');

	var year = today.getFullYear();
	var month = today.getMonth();
	var date = today.getDate();
	var day = today.getDay();
	var week = ['일', '월', '화', '수', '목', '금', '토'];

	var h = today.getHours();
	var m = today.getMinutes();
	var s = today.getSeconds();

	years.html(year);
	months.html(month+1);
	days.html(date);
	weeks.html(week[day]);
	hours.html(h);
	minutes.html(m);
	seconds.html(s);
}

var interval = setInterval(clock, 1000);
</script>
<style>
#clock {padding:2% 0 38%;}
#clock h2 {position:relative;display:block;color:#fff;text-align:center;margin:10px 0;font-weight:700;text-transform:uppercase;letter-spacing:0.4em;font-size:0.8em;}
#clock #time {display:flex;justify-content:center;align-items:center;}
#clock #time div {position:relative;margin:0 5px;-webkit-box-reflect:below 1px linear-gradient(transparent,#0004);}
#clock #time div span {position:relative;display:block;width:100px;height:80px;background:#2196f3;color:#fff;font-weight:300;display:flex;justify-content:center;align-items:center;font-size:3em;z-index:10;box-shadow:0 0 0 1px rgba(0,0,0,0.2);}
#clock #time div span:nth-child(2) {height:30px;font-size:0.7em;letter-spacing:0.2em;font-weight:500;z-index:9;box-shadow:none;background:#127fd6;text-transform:uppercase;}
#clock #time div:last-child span {background:#ff006a;}
#clock #time div:last-child span:nth-child(2) {background:#ec0062;}
</style>
<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
<div style="text-align:center;padding:0 0 10px 0;font-size:27px;font-weight:bold">${sessionScope.member.member_name}</div>

<div id="barcodeTarget" class="barcodeTarget" style="padding:0px;overflow:auto;"></div>
<div style="text-align:center">${sessionScope.member.user_no}</div>

<div class="loanNum" style="padding-top:20px;text-align:center;font-size:27px;font-weight:bold;">
<span id="years">0000</span><span>년</span>  <span id="month">00</span><span>월</span> <span id="day">00</span><span>일</span> <span id="week"></span><span>요일</span>
</div>

<div id="clock">
	<div id="time">
		<div><span id="hours">00</span><span>Hours</span></div>
		<div><span id="minutes">00</span><span>Minutes</span></div>
		<div><span id="seconds">00</span><span>Seconds</span></div>
	</div>
</div>
<!-- 컨트롤러에서 체크되어야 하는 부분 : 로그인 여부 체크 후, 로그인 상태에서는 대출번호 있는 회원인지 체크 ${sessionScope.member.user_no} 가 있나 없나 판단-->