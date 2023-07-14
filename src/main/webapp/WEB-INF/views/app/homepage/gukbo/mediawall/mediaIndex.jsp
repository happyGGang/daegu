<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<tiles:insertAttribute name="header" />
<script>
var weathers = new Array('thunderstorm with light rain','thunderstorm with rain','thunderstorm with heavy rain','light thunderstorm','thunderstorm','heavy thunderstorm','ragged thunderstorm','thunderstorm with light drizzle','thunderstorm with drizzle','thunderstorm with heavy drizzle','light intensity drizzle','drizzle','heavy intensity drizzle','light intensity drizzle rain','drizzle rain','heavy intensity drizzle rain','shower rain and drizzle','heavy shower rain and drizzle','shower drizzle','light rain','moderate rain','heavy intensity rain','very heavy rain','extreme rain','freezing rain','light intensity shower rain','shower rain','heavy intensity shower rain','ragged shower rain','light snow','snow','heavy snow','sleet','light shower sleet','shower sleet','light rain and snow','rain and snow','light shower snow','shower snow','heavy shower snow','mist','smoke','haze','sand/dust whirls','fog','sand','dust','volcanic ash','squalls','tornado','clear sky','few clouds','scattered clouds','broken clouds','overcast clouds');

var weatherskor = new Array('뇌우','뇌우','뇌우','뇌우','뇌우','뇌우','뇌우','뇌우','뇌우','뇌우','이슬비','이슬비','이슬비','이슬비','이슬비','이슬비','이슬비','이슬비','비 약간','적당한 비','비 많이','비 많이','폭우','우박','소나기 약간','소나기','폭우 수준의 소나기','오락가락한 소나기','눈 약간','눈','폭설','진눈째비','약간의 진눈깨비','갑자기 진눈깨비','약간의 비와 눈','비와 눈','갑자기 약간 눈','갑자기 눈','폭설','안개','연기','안개','모래/먼지 소용돌이','모래','모래','먼지','화산재','토네이도','토네이도','맑음','구름 약간','약간 흐림','흐림 구름','많이 흐림');
var i;

$.ajax({
	url: 'https://api.openweathermap.org/data/2.5/weather?lat=35.868464&lon=128.6016669&appid=3bcf7eca7fc5d5df252135e43043a0a7',
	dataType: "json",
	type: "GET",
	async: "false",
	success: function(data) {
		console.log(data);
		$('.weather-box span.feels_like').html(Math.floor((data.main.feels_like - 273.15)*10)/10+'°');
		$('.weather-box .weather_icon').addClass('w'+data.weather[0].icon);
		$('.weather-box span.temp').html(Math.floor((data.main.temp - 273.15)*10)/10+'°');

		for(i = 0; i < weathers.length; i++)
		{
			if(weathers[i] == data.weather[0].description)
			{
				var kor = weatherskor[i];
			}
		}
		$('.weather-box span.description').html(kor);
	}
});

$(function() {
	var now = new Date();

	let y = now.getFullYear();
	let mo = now.getMonth();
	let d = now.getDate();
	let dow = now.getDay();
	var week = new Array('일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일');
	var today = new Date().getDay();
	var todayLabel = week[today];

	$('#years').text(y);
	$('#months').text(mo);
	$('#days').text(d);
	$('#dayofweeks').text(todayLabel);
});
</script>
<div class="movie-wrap">
	<div class="contents">
		<div class="left-sec">
			<div class="text small-txt">
				The National Debt<br/>Redemption Movement<br/>Memorial Library
			</div>
			<div class="">

				<div class="clock">
					<div class="circle" id="sc" style="--clr:#fff"><i></i></div>
					<div class="circle circle2" id="mn" style="--clr:#fff"><i></i></div>
					<div class="circle circle3" id="hr" style="--clr:#fff"><i></i></div>
				</div>

				<div id="date" class="date-txt">
					<span id="years"></span>년 <span id="months"></span>월 <span id="days"></span>일 (<span id="dayofweeks"></span>)
				</div>

				<div id="time" class="time-txt">
					<div id="hours" style="--clr:#fff">00</div>
					<div id="minutes" style="--clr:#fff">00</div>
					<div id="seconds" style="--clr:#fff">00</div>
				</div>

				<script>
					let hr = document.querySelector('#hr');
					let mn = document.querySelector('#mn');
					let sc = document.querySelector('#sc');

					setInterval(()=>{
						var day = new Date();

						let hh = day.getHours() * 30;
						let mm = day.getMinutes() * 6;
						let ss = day.getSeconds() * 6;
						let hr = hh+(mm/12);
						$('#hr').css('transform', 'rotateZ('+hr+'deg)');
						$('#mn').css('transform', 'rotateZ('+mm+'deg)');
						$('#sc').css('transform', 'rotateZ('+ss+'deg)');

						let hours = document.getElementById('hours');
						let minutes = document.getElementById('minutes');
						let seconds = document.getElementById('seconds');
						//let ampm = document.getElementById('ampm');

						let h = day.getHours();
						let m = day.getMinutes();
						let s = day.getSeconds();
						//let am = h >= 12 ? "PM" : "AM";

						//convert 24hr clock to 12hr clock
						if(h > 12)
						{
							//h = h - 12;
						}
						//add zero before single digital number
						h = (h < 10) ? "0" + h : h;
						m = (m < 10) ? "0" + m : m;
						s = (s < 10) ? "0" + s : s;

						hours.innerHTML = h;
						minutes.innerHTML = m;
						seconds.innerHTML = s;
						//ampm.innerHTML = am;
					});
				</script>
			</div>
		</div>

		<div class="center-sec ">
			<!-- 영상 영역 -->
			<div id="movie-box" class="movie-box">
				<div class="outer">
					<div class="inner">
						<video id="video-box" src="/resources/common/movie/mediawall/dglib_campaign.mp4" autoplay muted loop></video>
					</div>
				</div>
			</div>
		</div>

		<div class="right-sec">
			<div class="weather-box">
				<h2>TODAY’S WEATHER</h2>
				<div class="feels_like">체감 <span class="feels_like"></span></div>
				<div class="weather_icon"></div>
				<div class="temp"><span class="temp"></span></div>
				<div class="description"><span class="description"></span></div>
			</div>
		</div>
	</div>
</div>
<tiles:insertAttribute name="footer" />