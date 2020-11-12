<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page import="java.util.Random"%>
<%
Random rnd = new Random();
int listNum1 = rnd.nextInt(10);
int listNum2 = 0;
int listNum3 = 0;
do {
	listNum2 = rnd.nextInt(10);
} while (listNum1 == listNum2);
do {
	listNum3 = rnd.nextInt(10);
} while (listNum1 == listNum3 || listNum2 == listNum3);
%>
<c:set var="listNum1" value="<%=listNum1%>"></c:set>
<c:set var="listNum2" value="<%=listNum2%>"></c:set>
<c:set var="listNum3" value="<%=listNum3%>"></c:set>
<tiles:insertAttribute name="header" />
<script type="text/javascript">
	$(function() {
		$('#homeup').click(function () {
			$('body,html').animate({
				scrollTop: 0
			}, 800);
			return false;
		});

		// 팝업 관련 코드 START
		$('.close-btn').on('click', function() {
			var $this = $(this);
			var checkInput = $this.parent().find('input[data-day="'+$this.data('day')+'"]');
			var popupId = checkInput.val();
			if (checkInput.prop('checked')) {
				var todayDate = new Date();
				todayDate = new Date(
						parseInt(todayDate.getTime() / 86400000) * 86400000 + 54000000);
				if($this.data('day') == 7) {
					todayDate.setDate(todayDate.getDate() + 7);
				}
				document.cookie = popupId + "=no"
						+ "; path=/; expires="
						+ todayDate.toGMTString() + ";";
			}

			$('div#' + popupId).hide();
		});

		$('input[id*=pop]').on('click', function(e) {
			e.preventDefault();
			$(this).prop('checked', true);
			$(this).parent('div').next('a').data('day', $(this).data('day'));
			$(this).parent('div').next('a').click();
		});

		$('#popupLayer > div').each(function(i, v) {
			var result = '';
			var name = $(v).attr('id');
			var nameOfCookie = name + "=";
			var x = 0;
			while (x <= document.cookie.length) {
				var y = (x + nameOfCookie.length);
				if (document.cookie.substring(x, y) == nameOfCookie) {
					if ((endOfCookie = document.cookie
							.indexOf(";", y)) == -1)
						endOfCookie = document.cookie.length;
					result = unescape(document.cookie
							.substring(y, endOfCookie));
				}
				x = document.cookie.indexOf(" ", x) + 1;
				if (x == 0)
					break;
			}

			if (result != 'no') {
				if  (window.innerWidth < $(v).width() ) {
					$(v).css('width', 'auto');
				}
				$(v).show();
			}
		});
		// 팝업 관련 코드 END


		$('div#holiday-box').load('calendar3.do');
		$('ul.newBookUl').load('newBook.do');
		$('ul.bestBookUl').load('bestBook.do');

		$('#main-search-btn').on('click', function() {
			if( $('input#search_text_1').val() == '' ) {
				alert('검색어를 입력하세요.');
				$('input#search_text_1').focus();
				return false;
			}
				$('#mainSearchForm').submit();
		});

});
</script>
<div id="wrap">
	<tiles:insertAttribute name="top" />
	<tiles:insertAttribute name="topMenu" />

	<div class="popupWrap section">
		<div id="popupLayer">
			<homepageTag:popup popupList="${popupList}" />
		</div>
	</div>

	<div id="container" class="main">

		<div class="main1">
			<div class="section">

				<div class="popupzone-box">
					<div class="popZone">
						<div class="cont">
							<c:choose>
								<c:when test="${fn:length(popupZoneList) > 0}">
									<homepageTag:popupZone popupZoneList="${popupZoneList}"/>
								</c:when>
								<c:otherwise>
								<ul class="popupImg">
									<li>
										<img src="/resources/homepage/${homepage.context_path}/img/popupnone.png" alt="noimg" style="width:100%;"/>
									</li>
								</ul>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
				</div>

				<div class="search-box">
					<form id="mainSearchForm" action="/${homepage.context_path}/intro/search/index.do">
						<input type="hidden" name="menu_idx" value="13">
						<input type="hidden" name="booktype" value="BOOKANDNONBOOK">
						<fieldset>
							<legend class="blind">통합검색</legend>
							<div class="main-box">
								<div class="box1">
									<label for="search_text_1" class="blind">통합자료검색</label>
									<input name="title" id="search_text_1" type="text" class="text" placeholder="검색어를 입력하세요" style="ime-mode:active;"/>
								</div>
								<button id="main-search-btn">소장자료검색</button>
							</div>
						</fieldset>
					</form>
				</div>
			</div>
		</div>

		<div class="main2">
			<div class="section">
				<div class="notice-box">
					<div class="tit">
						<h2>공지사항</h2>
						<a href="/${homepage.context_path}/board/index.do?menu_idx=36&manage_idx=132" class="btn-more">더보기</a>
					</div>
					<div class="con">
						<ul>

							<li class="on-cont">
								<a href="#">
									<strong>작은도서관 부분개관에 따른 희망도서신청 재개하오니 이용에 참고하시기 바랍니다.<br/><span class="datetime">2020. 08. 15.</span></strong>
									<p class="txt">작은도서관 부분개관에 따른 희망도서신청 재개하오니 이용에 참고하시기 바랍니다.</p>
								</a>
							</li>

							<li><a href="#">
								<strong>사회적 거리두기 조정 시행에 따른 ㅅㅂ도서관 운영 안내</strong>
								<span class="date">2020-10-12</span></a>
							</li>
							
							<li><a href="#">
								<strong>10월 가족문화한마당 공연 안내</strong>
								<span class="date">2020-10-10</span></a>
							</li>

							<li>
								<a href="#">
								<strong>9월 가족 추억쌓기 당첨자 발표</strong>
								<span class="date">2020-10-05</span>
								</a>
							</li>

						</ul>
					</div>
				</div>


				<div class="culture-box">
					<div class="tit">
						<h2>문화프로그램</h2>
						<a href="/${homepage.context_path}/board/index.do?menu_idx=60&manage_idx=121" class="btn-more">더보기</a>
					</div>
					<div class="con">
						<ul>

							<li class="on-cont">
								<a href="#">
									<div class="cont">
										<strong>ㅅㅂ도서관 편의시설 운영 안내(2020.10.15~)</strong>
										<span class="txt"><b>접수</b>  2020. 08. 15. ~ 2020. 09. 30.</span>
										<span class="txt"><b>운영</b>  2020. 10. 01. ~ 2020. 12. 20.</span>
									</div>
									<p class="one-status-box status002">접수중</p>
								</a>
							</li>

							<li>
								<a href="#">
									<strong>사회적 거리두기 조정 시행에 따른 ㅅㅂ도서관 운영 안내</strong>
									<span class="status-box status001">대기</span>
								</a>
							</li>
							
							<li>
								<a href="#">
									<strong>10월 가족문화한마당 공연 안내</strong>
									<span class="status-box status002">접수중</span>
								</a>
							</li>

							<li>
								<a href="#">
									<strong>9월 가족 추억쌓기 당첨자 발표</strong>
									<span class="status-box status003">마감</span>
								</a>
							</li>

						</ul>
					</div>
				</div>
			</div>
		</div>

		<div class="main3">
			<div class="section">
				<div class="qmenu">
					<ul>
						<homepageTag:quickMenu quickMenuList="${quickMenuList}" />
					</ul>
				</div>
			</div>
		</div>

		<div class="main4">
			<div class="section">

				<div class="book-box tabS">
					
					<div class="title">
						<h2>추천도서</h2>

						<ul class="tabMenuS">
							<li class="on"><a href="#tab1" class='t-tabs'>성인</a></li>
							<li><a href="#tab2" class='t-tabs'>어린이</a></li>
						</ul>

						<a href="/${homepage.context_path}/board/index.do?menu_idx=60&manage_idx=121" class="btn-more">더보기</a>
					</div>

					<div class="box con" data-tab="tab1">
						<ul class="book_photo">
							
							<li>
								<a href="">
									<span class="con-image">
									
									
										<img src="/resources/common/img/noImg2.png" alt="등록된 이미지가 없습니다.  상세보기"/>
									
									
									
									</span>
									<span class="con-title">1진정성 마케팅 ...</span>
								</a>
							</li>
							
							
							<li>
								<a href="">
									<span class="con-image">
									
									
										<img src="/resources/common/img/noImg2.png" alt="등록된 이미지가 없습니다.  상세보기"/>
									
									
									
									</span>
									<span class="con-title">주식회사 히어로즈 : ...</span>
								</a>
							</li>
							
							
							<li>
								<a href="">
									<span class="con-image">
									
									
										<img src="/resources/common/img/noImg2.png" alt="등록된 이미지가 없습니다.  상세보기"/>
									
									
									
									</span>
									<span class="con-title">All the piec...</span>
								</a>
							</li>
							
						</ul>
					</div>

					<div class="box con" data-tab="tab2" style="display:none;">
						<ul class="book_photo">
							
							<li>
								<a href="">
									<span class="con-image">
									
									
										<img src="/resources/common/img/noImg2.png" alt="등록된 이미지가 없습니다.  상세보기"/>
									
									
									
									</span>
									<span class="con-title">2진정성 마케팅 : 끌리...</span>
								</a>
							</li>
							
							
							<li>
								<a href="">
									<span class="con-image">
									
									
										<img src="/resources/common/img/noImg2.png" alt="등록된 이미지가 없습니다.  상세보기"/>
									
									
									
									</span>
									<span class="con-title">주식회사 히어로즈 : ...</span>
								</a>
							</li>
							
							
							<li>
								<a href="">
									<span class="con-image">
									
									
										<img src="/resources/common/img/noImg2.png" alt="등록된 이미지가 없습니다.  상세보기"/>
									
									
									
									</span>
									<span class="con-title">All the piec...</span>
								</a>
							</li>

						</ul>
					</div>
				</div>

				<div class="calendar-box" id="holiday-box">
				</div>

			</div>
		</div>
		
		<div class='main5'>
			<div class="section">
				<div class="tit">
					<h3>도서관안내</h3>
					<p>지도의 아이콘을 클릭하시면 해당 도서관의 간략 정보를 확인하실 수 있습니다.</p>
				</div>
<script>
$(function() {
	$('.divbInfomationConts').hide();
	$('.divbInfomationContsDetail').hide();
	$('#divbInfo1').show();
	$('#divbInfoDetail1').show();

	$(".maps").on("click", function(e){
		e.preventDefault();
		var libCode = $(this).data('value');
		$("#librarySelectBox > option[value='"+libCode+"']").attr("selected", "selected");
		$('.divbInfomationConts').hide();
		$('#divbInfo'+libCode).show();
		$('.divbInfomationContsDetail').hide();
		$('#divbInfoDetail'+libCode).show();
	});

	$("#librarySelectBox").on("change", function(e) {
		e.preventDefault();
		var libCode = $(this).val();
		$('.divbInfomationConts').hide();
		$('#divbInfo'+libCode).show();
		$('.divbInfomationContsDetail').hide();
		$('#divbInfoDetail'+libCode).show();
	});

});
</script>
				<div class="map-area">
					<div class="map-box">
						<img src="/resources/homepage/${homepage.context_path}/img/main-map.png" id="mapImg" alt="대구 동구 지도" title="대구 동구 지도" border="0" usemap="#Map" />
						<map name="Map" id="Map">
						<area shape="circle" coords="242,311,8" href="#lib-selector" alt="(공공)안심도서관" class="maps" data-value="1"/>
						<area shape="circle" coords="36,299,8" href="#lib-selector" alt="(공공)신천도서관" class="maps" data-value="2"/>
						<area shape="circle" coords="24,307,9" href="#lib-selector" alt="(공립)신암2동 작은도서관" class="maps" data-value="3"/>
						<area shape="circle" coords="57,282,8" href="#lib-selector" alt="(공립)신암3동 작은도서관" class="maps" data-value="4"/>
						<area shape="circle" coords="63,315,8" href="#lib-selector" alt="(공립)신천3동 작은도서관" class="maps" data-value="5"/>
						<area shape="circle" coords="101,288,8" href="#lib-selector" alt="(공립)효목1동 작은도서관" class="maps" data-value="7"/>
						<area shape="circle" coords="87,302,9" href="#lib-selector" alt="(공립)효목2동 작은도서관" class="maps" data-value="8"/>
						<area shape="circle" coords="219,149,8" href="#lib-selector" alt="(공립)도평동 작은도서관" class="maps" data-value="9"/>
						<area shape="circle" coords="147,177,8" href="#lib-selector" alt="(공립)불로어울림 작은도서관" class="maps" data-value="10"/>
						<area shape="circle" coords="112,232,8" href="#lib-selector" alt="(공립)지저동 작은도서관" class="maps" data-value="11"/>
						<area shape="circle" coords="142,237,8" href="#lib-selector" alt="(공립)동촌역사 작은도서관" class="maps" data-value="12"/>
						<area shape="circle" coords="152,280,8" href="#lib-selector" alt="(공립)방촌동 작은도서관" class="maps" data-value="13"/>
						<area shape="circle" coords="202,215,8" href="#lib-selector" alt="(공립)해안동 작은도서관" class="maps" data-value="14"/>
						<area shape="circle" coords="295,323,7" href="#lib-selector" alt="(공립)반야월역사 작은도서관" class="maps" data-value="15"/>
						<area shape="circle" coords="85,274,8" href="#lib-selector" alt="(공립)동구청 작은도서관" class="maps" data-value="16"/>
						<area shape="circle" coords="72,285,6" href="#lib-selector" alt="(사립)신암5동 작은도서관" class="maps" data-value="17"/>
						<area shape="circle" coords="211,264,8" href="#lib-selector" alt="(사립)방촌어린이도서관" class="maps" data-value="18"/>
						<area shape="circle" coords="213,355,9" href="#lib-selector" alt="(사립)율하5주민도서관" class="maps" data-value="19"/>
						<area shape="circle" coords="325,267,8" href="#lib-selector" alt="(사립)꿈날자문고" class="maps" data-value="20"/>
						<area shape="circle" coords="57,304,6" href="#lib-selector" alt="(사립)행복도서관" class="maps" data-value="21"/>
						<area shape="circle" coords="157,235,8" href="#lib-selector" alt="(사립)늘푸른 도서관" class="maps" data-value="22"/>
						<area shape="circle" coords="334,321,7" href="#lib-selector" alt="(사립)초록우산도서관" class="maps" data-value="23"/>
						</map>
					</div>
					<div class="map-info">
					</div>
				</div>
				<div class="info-area">
					<div class="box">
						<ul>
							<li>
								<select name="librarySelectBox" id="librarySelectBox" class="librarySelectBox">
									<option value="1">(공공)안심도서관</option>
									<option value="2">(공공)신천도서관</option>
									<option value="3">(공립)신암2동 작은도서관</option>
									<option value="4">(공립)신암3동 작은도서관</option>
									<option value="5">(공립)신천3동 작은도서관</option>
									<!-- <option value="6">(공립)신천4동 작은도서관</option> -->
									<option value="7">(공립)효목1동 작은도서관</option>
									<option value="8">(공립)효목2동 작은도서관</option>
									<option value="9">(공립)도평동 작은도서관</option>
									<option value="10">(공립)불로어울림 작은도서관</option>
									<option value="11">(공립)지저동 작은도서관</option>
									<option value="12">(공립)동촌역사 작은도서관</option>
									<option value="13">(공립)방촌동 작은도서관</option>
									<option value="14">(공립)해안동 작은도서관</option>
									<option value="15">(공립)반야월역사 작은도서관</option>
									<option value="16">(공립)동구청 작은도서관</option>
									<option value="17">(사립)신암5동 작은도서관</option>
									<option value="18">(사립)방촌어린이도서관</option> 
									<option value="19">(사립)율하5주민도서관</option>
									<option value="20">(사립)꿈날자문고</option> 
									<option value="21">(사립)행복도서관</option>
									<option value="22">(사립)늘푸른 도서관</option>
									<option value="23">(사립)초록우산도서관</option>
								</select>
							</li>
							<li>
								<div class="divbInfomationConts" id="divbInfo1">
									대구광역시 동구 금호강변로 360<br/>053-980-2600
								</div>
								<div class="divbInfomationConts" id="divbInfo2">
									대구광역시 동구 동부로 6길 65<br/>053-980-2600
								</div>
								<div class="divbInfomationConts" id="divbInfo3">
									대구광역시 동구 신성로 56<br/>(신암2동주민센터 2층)<br/>053-662-3633
								</div>
								<div class="divbInfomationConts" id="divbInfo4">
									대구광역시 동구 아양로8길 10-1<br/>(동구여성문화공간 3층)<br/>070-7755-5631
								</div>
								<div class="divbInfomationConts" id="divbInfo5">
									대구광역시 동구 장등로 90<br/>(신천3동주민센터 3층)<br/>053-662-3734
								</div>
								<div class="divbInfomationConts" id="divbInfo6">
									대구광역시 동구 화랑로 3길 10-13<br/>(신천4 경로당 2층)<br/>070-4203-6859
								</div>
								<div class="divbInfomationConts" id="divbInfo7">
									대구광역시 동구 화랑로 41길 46<br/>(효목1동주민센터 2층)<br/>053-662-3775
								</div>
								<div class="divbInfomationConts" id="divbInfo8">
									대구광역시 동구 화랑로 25길 45<br/>(효목2동 주민센터 1층)<br/>053-662-3794
								</div>
								<div class="divbInfomationConts" id="divbInfo9">
									대구광역시 동구 팔공로24길 171<br/>(도평동주민센터 3층)<br/>053-662-3810
								</div>
								<div class="divbInfomationConts" id="divbInfo10">
									대구광역시 동구 팔공로24길 5<br/>(불로전통시장 상인교육관 3층)<br/>070-4214-0007
								</div>
								<div class="divbInfomationConts" id="divbInfo11">
									대구광역시 동구 해동로3길 80<br/>(지저동 주민센터 3층)<br/>070-7755-5633
								</div>
								<div class="divbInfomationConts" id="divbInfo12">
									대구 동구 동촌역사로 3길 35<br/>070-4214-6859
								</div>
								<div class="divbInfomationConts" id="divbInfo13">
									대구광역시 동구 동촌로 46길 2<br/>(방촌종합상가 2층)<br/>070-4251-5854
								</div>
								<div class="divbInfomationConts" id="divbInfo14">
									대구광역시 동구 방촌로 29길 46<br/>(해안동 주민센터 3층)<br/>070-7755-5632
								</div>
								<div class="divbInfomationConts" id="divbInfo15">
									대구광역시 동구 신서로 50<br/>(대구선2공원 내 철도역사 1동)<br/>053-662-4110
								</div>
								<div class="divbInfomationConts" id="divbInfo16">
									대구광역시 동구 아양로 207<br/>(동구청1층)<br/>053-662-2489
								</div>
								<div class="divbInfomationConts" id="divbInfo17">
									대구광역시 동구 아양로37길 92<br/>(신암5동주민센터 2층)<br/>053-662-3485
								</div>
								<div class="divbInfomationConts" id="divbInfo18">
									대구광역시 동구 동촌로 46길 17<br/>053-981-8276
								</div>
								<div class="divbInfomationConts" id="divbInfo19">
									대구광역시 동구 율하서로59<br/>(율하휴먼시아5단지 관리실)<br/>053-965-5955
								</div>
								<div class="divbInfomationConts" id="divbInfo20">
									대구광역시 동구 안심로73길 22<br/>(롯데캐슬 레전드관리사무소)<br/>053-247-0755
								</div>
								<div class="divbInfomationConts" id="divbInfo21">
									대구광역시 동구 송라로2길 17-6<br/>(제일기독종합사회복지관)<br/>053-755-9392
								</div>
								<div class="divbInfomationConts" id="divbInfo22">
									대구광역시 동구 입석로 5<br/>(동촌종합사회복지관)<br/>053-983-8211
								</div>
								<div class="divbInfomationConts" id="divbInfo23">
									대구광역시 동구 율하동로 26길 67<br/>(대구종합사회복지관)<br/>053-964-3335
								</div>
							</li>
						</ul>
					</div>

					<div class="box2">
						<div class="divbInfomationContsDetail" id="divbInfoDetail1">
							<ul>
								<li>
									<dt>이용시간</dt>
									<dd>평일 어린이자료실 09:00~18:00</dd>
									<dd>평일 종합자료실 09:00~22:00</dd>
									<dd>평일 디지털자료실 09:00~22:00</dd>
									<dd>주말 09:00~17:00</dd>
								</li>
								<li>
									<dt>휴관일</dt>
									<dd>매주 월요일</dd>
									<dd>일요일을 제외한 관공서 공휴일</dd>
								</li>
							</ul>
						</div>
						<div class="divbInfomationContsDetail" id="divbInfoDetail2">
							<ul>
								<li>
									<dt>이용시간</dt>
									<dd>평일 어린이자료실 09:00~18:00</dd>
									<dd>평일 종합자료실 09:00~20:00</dd>
									<dd>주말 09:00~17:00</dd>
								</li>
								<li>
									<dt>휴관일</dt>
									<dd>매주 월요일</dd>
									<dd>일요일을 제외한 관공서 공휴일</dd>
								</li>
							</ul>
						</div>
						<div class="divbInfomationContsDetail" id="divbInfoDetail3">
							<ul>
								<li>
									<dt>이용시간</dt>
									<dd>평일 09:00~18:00</dd>
								</li>
								<li>
									<dt>휴관일</dt>
									<dd>매주 토ㆍ일요일</dd>
									<dd>관공서 공휴일</dd>
								</li>
							</ul>
						</div>
						<div class="divbInfomationContsDetail" id="divbInfoDetail4">
							<ul>
								<li>
									<dt>이용시간</dt>
									<dd>09:00 ~ 18:00</dd>
								</li>
								<li>
									<dt>휴관일</dt>
									<dd>매주 토ㆍ일요일</dd>
									<dd>관공서 공휴일</dd>
								</li>
							</ul>
						</div>
						<div class="divbInfomationContsDetail" id="divbInfoDetail5">
							<ul>
								<li>
									<dt>이용시간</dt>
									<dd>평일 09:00~18:00</dd>
								</li>
								<li>
									<dt>휴관일</dt>
									<dd>매주 토ㆍ일요일</dd>
									<dd>관공서 공휴일</dd>
								</li>
							</ul>
						</div>
						<div class="divbInfomationContsDetail" id="divbInfoDetail6">
							<ul>
								<li>
									<dt>이용시간</dt>
									<dd>평일 09:00~18:00</dd>
								</li>
								<li>
									<dt>휴관일</dt>
									<dd>매주 토ㆍ일요일</dd>
									<dd>관공서 공휴일</dd>
								</li>
							</ul>
						</div>
						<div class="divbInfomationContsDetail" id="divbInfoDetail7">
							<ul>
								<li>
									<dt>이용시간</dt>
									<dd>평일 09:00~18:00</dd>
								</li>
								<li>
									<dt>휴관일</dt>
									<dd>매주 토ㆍ일요일</dd>
									<dd>관공서 공휴일</dd>
								</li>
							</ul>
						</div>
						<div class="divbInfomationContsDetail" id="divbInfoDetail8">
							<ul>
								<li>
									<dt>이용시간</dt>
									<dd>평일 09:00~18:00</dd>
								</li>
								<li>
									<dt>휴관일</dt>
									<dd>매주 토ㆍ일요일</dd>
									<dd>관공서 공휴일</dd>
								</li>
							</ul>
						</div>
						<div class="divbInfomationContsDetail" id="divbInfoDetail9">
							<ul>
								<li>
									<dt>이용시간</dt>
									<dd>평일 09:00~18:00</dd>
								</li>
								<li>
									<dt>휴관일</dt>
									<dd>매주 토ㆍ일요일</dd>
									<dd>관공서 공휴일</dd>
								</li>
							</ul>
						</div>
						<div class="divbInfomationContsDetail" id="divbInfoDetail10">
							<ul>
								<li>
									<dt>이용시간</dt>
									<dd>평일 09:00~18:00</dd>
								</li>
								<li>
									<dt>휴관일</dt>
									<dd>매주 토ㆍ일요일</dd>
									<dd>관공서 공휴일</dd>
								</li>
							</ul>
						</div>
						<div class="divbInfomationContsDetail" id="divbInfoDetail11">
							<ul>
								<li>
									<dt>이용시간</dt>
									<dd>평일 09:00~18:00</dd>
								</li>
								<li>
									<dt>휴관일</dt>
									<dd>매주 토ㆍ일요일</dd>
									<dd>관공서 공휴일</dd>
								</li>
							</ul>
						</div>
						<div class="divbInfomationContsDetail" id="divbInfoDetail12">
							<ul>
								<li>
									<dt>이용시간</dt>
									<dd>평일 09:00~18:00</dd>
								</li>
								<li>
									<dt>휴관일</dt>
									<dd>매주 토ㆍ일요일</dd>
									<dd>관공서 공휴일</dd>
								</li>
							</ul>
						</div>
						<div class="divbInfomationContsDetail" id="divbInfoDetail13">
							<ul>
								<li>
									<dt>이용시간</dt>
									<dd>평일 09:00~18:00</dd>
								</li>
								<li>
									<dt>휴관일</dt>
									<dd>매주 토ㆍ일요일</dd>
									<dd>관공서 공휴일</dd>
								</li>
							</ul>
						</div>
						<div class="divbInfomationContsDetail" id="divbInfoDetail14">
							<ul>
								<li>
									<dt>이용시간</dt>
									<dd>평일 09:00~18:00</dd>
								</li>
								<li>
									<dt>휴관일</dt>
									<dd>매주 토ㆍ일요일</dd>
									<dd>관공서 공휴일</dd>
								</li>
							</ul>
						</div>
						<div class="divbInfomationContsDetail" id="divbInfoDetail15">
							<ul>
								<li>
									<dt>이용시간</dt>
									<dd>평일 09:00~18:00</dd>
								</li>
								<li>
									<dt>휴관일</dt>
									<dd>매주 토ㆍ일요일</dd>
									<dd>관공서 공휴일</dd>
								</li>
							</ul>
						</div>
						<div class="divbInfomationContsDetail" id="divbInfoDetail16">
							<ul>
								<li>
									<dt>이용시간</dt>
									<dd>평일 09:00~18:00</dd>
								</li>
								<li>
									<dt>휴관일</dt>
									<dd>매주 토ㆍ일요일</dd>
									<dd>관공서 공휴일</dd>
								</li>
							</ul>
						</div>
						<div class="divbInfomationContsDetail" id="divbInfoDetail17">
							<ul>
								<li>
									<dt>이용시간</dt>
									<dd>평일 09:00~18:00</dd>
								</li>
								<li>
									<dt>휴관일</dt>
									<dd>매주 토ㆍ일요일</dd>
									<dd>관공서 공휴일</dd>
								</li>
							</ul>
						</div>
						<div class="divbInfomationContsDetail" id="divbInfoDetail18">
							<ul>
								<li>
									<dt>이용시간</dt>
									<dd>평일 09:00~18:00</dd>
								</li>
								<li>
									<dt>휴관일</dt>
									<dd>매주 토ㆍ일요일</dd>
									<dd>관공서 공휴일</dd>
								</li>
							</ul>
						</div>
						<div class="divbInfomationContsDetail" id="divbInfoDetail19">
							<ul>
								<li>
									<dt>이용시간</dt>
									<dd>평일 09:00~18:00</dd>
								</li>
								<li>
									<dt>휴관일</dt>
									<dd>매주 토ㆍ일요일</dd>
									<dd>관공서 공휴일</dd>
								</li>
							</ul>
						</div>
						<div class="divbInfomationContsDetail" id="divbInfoDetail20">
							<ul>
								<li>
									<dt>이용시간</dt>
									<dd>평일 09:00~18:00</dd>
								</li>
								<li>
									<dt>휴관일</dt>
									<dd>매주 토ㆍ일요일</dd>
									<dd>관공서 공휴일</dd>
								</li>
							</ul>
						</div>
						<div class="divbInfomationContsDetail" id="divbInfoDetail21">
							<ul>
								<li>
									<dt>이용시간</dt>
									<dd>평일 09:00~18:00</dd>
								</li>
								<li>
									<dt>휴관일</dt>
									<dd>매주 토ㆍ일요일</dd>
									<dd>관공서 공휴일</dd>
								</li>
							</ul>
						</div>
						<div class="divbInfomationContsDetail" id="divbInfoDetail22">
							<ul>
								<li>
									<dt>이용시간</dt>
									<dd>평일 09:00~18:00</dd>
								</li>
								<li>
									<dt>휴관일</dt>
									<dd>매주 토ㆍ일요일</dd>
									<dd>관공서 공휴일</dd>
								</li>
							</ul>
						</div>
						<div class="divbInfomationContsDetail" id="divbInfoDetail23">
							<ul>
								<li>
									<dt>이용시간</dt>
									<dd>평일 09:00~18:00</dd>
								</li>
								<li>
									<dt>휴관일</dt>
									<dd>매주 토ㆍ일요일</dd>
									<dd>관공서 공휴일</dd>
								</li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class='main6'>
			<div class="section">
				<div class="banner-wrap type5">
					<div class="banner-t5">
						<h3>배너모음</h3>
						<div class="control">
							<a class="prev" href="#prev"><img src="/resources/homepage/${homepage.context_path}/img/banner-prev.png" alt="이전" /><span class="blind">이전</span></a>
							<a class="next" href="#next"><img src="/resources/homepage/${homepage.context_path}/img/banner-next.png" alt="다음" /><span class="blind">다음</span></a>
							<a class="stop active" href="#stop"><img src="/resources/homepage/${homepage.context_path}/img/banner-stop.png" alt="정지" /><span class="blind">정지</span></a>
							<a class="play" href="#play"><img src="/resources/homepage/${homepage.context_path}/img/banner-start.png" alt="시작" /><span class="blind">시작</span></a>
							<a class="more" href="/${homepage.context_path}/bannermap/index.do?menu_idx=93"><img src="/resources/homepage/${homepage.context_path}/img/banner-more.png" alt="더보기" /><span class="blind">더보기</span></a>
						</div>
					</div>
					<div class="banner-box5">
						<!--
						<ul class="banner-roll">
							<li>
							<span>
							<a href="https://www.juso.go.kr/openIndexPage.do" target="_blank">
							<img src="/data/banner/h53/1602753558277" alt="새주소안내"/></a></span></li>
							<li>
							<span>
							<a href="https://www.keris.or.kr/main/main.do" target="_blank">
							<img src="/data/banner/h53/1602753585628" alt="한국교육학술정보원"/></a></span></li>
							<li>
							<span>
							<a href="https://www.nl.go.kr/NL/contents/N50203010000.do" target="_blank">
							<img src="/data/banner/h53/1602753658566" alt="사서에게물어보세요"/></a></span></li>
							<li>
							<span>
							<a href="https://www.nl.go.kr/kolisnet/index.do" target="_blank">
							<img src="/data/banner/h53/1602753682524" alt="국가자료종합목록"/></a></span></li>
							<li>
							<span>
							<a href="http://book.nl.go.kr/iplls/Index.do" target="_blank">
							<img src="/data/banner/h53/1602753732469" alt="책이음"/></a></span></li>
							<li>
							<span>
							<a href="https://www.nanet.go.kr/main.do" target="_blank">
							<img src="/data/banner/h53/1602753746743" alt="국회도서관"/></a></span></li>
							<li>
							<span>
							<a href="http://info.edunet.net/" target="_blank">
							<img src="/data/banner/h53/1602753761378" alt="온라인학습"/></a></span></li>
							<li>
							<span>
							<a href="https://www.moe.go.kr/main.do" target="_blank">
							<img src="/data/banner/h53/1602753777663" alt="교육부"/></a></span></li>
							<li>
							<span>
							<a href="https://www.mcst.go.kr/kor/main.jsp" target="_blank">
							<img src="/data/banner/h53/1602753832020" alt="문화체육관광부"/></a></span></li>
							<li>
							<span>
							<a href="https://www.nl.go.kr/" target="_blank">
							<img src="/data/banner/h53/1602753845553" alt="국립중앙도서관"/></a></span></li>
							<li>
							<span>
							<a href="https://www.nlcy.go.kr/index.do" target="_blank">
							<img src="/data/banner/h53/1602753859371" alt="국립어린이도서관"/></a></span></li>
							<li>
							<span>
							<a href="https://www.data.go.kr/" target="_blank">
							<img src="/data/banner/h53/1602753873328" alt="공공데이터포탈"/></a></span></li>
							<li>
							<span>
							<a href="http://library.daegu.go.kr/dgportal/index.do" target="_blank">
							<img src="/data/banner/h53/1602753891087" alt="통합검색"/></a></span></li>
						</ul>
						-->
						<homepageTag:banner bannerList="${bannerList}"/>
					</div>
				</div>
			</div>
		</div>
	</div>

	<tiles:insertAttribute name="footer" />

</div>

</body>
</html>