<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<tiles:insertAttribute name="header" />
<link rel="stylesheet" type="text/css" href="/resources/common/css/kiosk/swiper.min.css"  />
<script type="text/javascript">
</script>
<div class="info-wrap">
	<div class="header">
		<div class="head">
			<h2>Book recommendation</h2>
			<span class="time"><span id="hours" class="time-txt" style="--clr:#fff"></span>:<span id="minutes" class="time-txt" style="--clr:#fff"></span></span>
		</div>
		<div class="end"></div>
		<script>
			setInterval(()=>{
				var day = new Date();

				let hours = document.getElementById('hours');
				let minutes = document.getElementById('minutes');

				let h = day.getHours();
				let m = day.getMinutes();

				h = (h < 10) ? "0" + h : h;
				m = (m < 10) ? "0" + m : m;

				hours.innerHTML = h;
				minutes.innerHTML = m;
			});
		</script>
	</div>
	<div class="contents">
		<div class="">
			<h3>국채보상운동기념도서관 이용안내</h3>

			<h4>이용시간</h4>
			<div class="cont-box">
				<table class="">
				<thead>
				<tr>
					<th>구분</th>
					<th>평일</th>
					<th>토ㆍ일요일</th>
					<th>대표전화</th>
				</tr>
				</thead>
				<tbody>
				<tr>
					<td>임시자료실</td>
					<td>09:00 ~ 22:00</td>
					<td>09:00 ~ 17:00</td>
					<td>231-2053 ~ 55</td>
				</tr>
				</tbody>
				</table>
			</div>

			<h4>휴관일</h4>
			<div class="cont-box">
				<ul>
					<li>매월 첫째, 셋째 월요일 및 관공서 공휴일</li>
					<li>관공서 공휴일(단, 일요일과 겹칠 경우 휴관), 관장이 필요하다고 인정하는 날</li>
				</ul>
			</div>

			<h4>자료대출</h4>
			<div class="cont-box">
				<h5>일반대출</h5>
				<ul>
					<li>1인 10권 15일간 (대출일 포함)</li>
					<li>동일도서 재대출 : 반납일로부터 5일 후 가능</li>
				</ul>

				<div class="guide-line"></div>

				<h5>예약</h5>
				<ul>
					<li>원하는 자료가 대출되었을 경우 인터넷 또는 전화로 예약신청 가능</li>
					<li>이전 이용자 도서가 반납되면 문자서비스로 통보 (예약만기일 : 통보받은 날로부터 3일)</li>
					<li>도서예약은 1인 2권, 1권당 2명까지 예약가능합니다.</li>
				</ul>

				<div class="guide-line"></div>

				<h5>주의사항</h5>
				<ul>
					<li>우리도서관 <자료대출규정>에 의거하여,</li>
					<li>회원증 사용 <br/>- 대출회원증은 회원본인만 사용할 수 있으며 타인에게 대여할 수 없습니다. (제9조)</li>
					<li>회원의 의무 <br/>- 회원증 관리 및 도서분실 및 훼손시 변상의 책임이 있습니다. (제6조)</li>
					<li>반납일 지연 <br/>- 연체일수만큼 대출이 중지됩니다. (제13조)</li>
				</ul>
			</div>


		</div>
	</div>
</div>
<tiles:insertAttribute name="footer" />