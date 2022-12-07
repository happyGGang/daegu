<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script>
	$(function(){
		$('div.tab_menu.on > ul > li > a').on('click',function(e){
			e.preventDefault();
			if(!($(this).parent().hasClass('active'))){
				$(this).parents('ul').children().removeClass('active');
				$(this).parent().addClass('active');
				var activeTab = $(this).attr('href');
				$('.tabConts').hide();
				$(activeTab).show();
			}
		});
	});
</script>

<style>
.map_bg {
	background-position: right 0 !important;
	height: 600px;
}
.info_box p {
	padding-right: 40px;
}
.tour2map1layer1{width:300px !important;text-align:center !important;}
.tour2map1layer1 .wrap1{border:none !important;background:rgba(0,0,0,0.8) !important;}
.tour2map1layer1 .wrap1>.h1{font-size:20px !important;margin:0 !important;padding-top:20px !important;color:#fff !important;}
.tour2map1layer1 .text1{font-size:14px !important;padding-bottom:10px !important;color:rgba(255,255,255,0.8) !important;}
.nbl-link-btn-box{margin-bottom:20px;}
.nbl-link-btn-box a{font-size:13px;line-height:15px;}

@media all and (min-width: 768px) and (max-width: 1023px) {
	.map_bg {height: auto;}
}

@media all and (max-width: 767px) {
	.map_bg {height: auto;}
}
</style>

<link rel="stylesheet" type="text/css" href="/resources/common/css/locationMap.css"/>

<div class="map_wrap">
	<div id="daegu_map" class="daegu_map">
		<div class="custom_mapcontrol"><a href="/dgportal/bukgu/bukgumap.html" target="_blank">&nbsp;</a></div>
	</div>
</div>

<div class="tab_menu on" style="margin:40px 0 15px;">
	<ul class="no5">
	  <li class="active"><a href="#tabCon1">구수산도서관</a></li>
	  <li><a href="#tabCon2">동부도서관</a></li>
	  <li><a href="#tabCon3">2·28기념학생도서관</a></li>
	  <li><a href="#tabCon4">신천도서관</a></li>
	  <li><a href="#tabCon5">안심도서관</a></li>
	</ul>
</div>

<!--구수산도서관-->
<div class="tabConts" id="tabCon1" style="display:block">
	<h3 class="nbl first">이용시간</h3>
	<ul class="nbl-use-time no4">
		<li>
			<strong>종합자료실</strong>
			<p>
				<span class="left">평일</span>
				<span class="right">09:00 ~ 22:00</span>
			</p>
			<p class="end"></p>
			<p>
				<span class="left">토·일요일</span>
				<span class="right">09:00 ~ 17:00</span>
			</p>
		</li>
		<li>
			<strong>문학실</strong>
			<p>
				<span class="left">평일</span>
				<span class="right">09:00 ~ 22:00</span>
			</p>
			<p class="end"></p>
			<p>
				<span class="left">토·일요일</span>
				<span class="right">09:00 ~ 17:00</span>
			</p>
		</li>
		<li>
			<strong>꿈키움실, 미디어창작실</strong>
			<p>
				<span class="left">평일</span>
				<span class="right">09:00 ~ 17:30</span>
			</p>
			<p class="end"></p>
			<p>
				<span class="left">토·일요일</span>
				<span class="right">09:00 ~ 17:00</span>
			</p>
		</li>
		<li>
			<strong>북카페</strong>
			<p>
				<span class="left">평일</span>
				<span class="right">09:00 ~ 20:00</span>
			</p>
			<p class="end"></p>
			<p>
				<span class="left">토·일요일</span>
				<span class="right">09:00 ~ 17:00</span>
			</p>
		</li>
	</ul>

	<h3 class="nbl">휴관일</h3>
	<ul class="nbl-list">
		<li>매월 2·4째주 월요일</li>
		<li>관공서의 공휴일 및 국가가 정한 임시공휴일</li>
		<li>근로자의 날(5. 1.)</li>
		<li>기타 장서점검 및 도서관장이 필요하다고 인정하는 날</li>
	</ul>
</div>

<!--동부도서관-->
<div class="tabConts" id="tabCon2">
	<h3 class="nbl first">이용시간</h3>
	<ul class="nbl-use-time no4">
		<li>
			<strong>일반열람실</strong>
			<p>
				<span class="left">평일</span>
				<span class="right">07:00 ~ 22:00</span>
			</p>
			<p class="end"></p>
			<p>
				<span class="left">토·일요일</span>
				<span class="right">07:00 ~ 22:00</span>
			</p>
		</li>
		<li>
			<strong>종합·디지털자료실</strong>
			<p>
				<span class="left">평일</span>
				<span class="right">09:00 ~ 19:00</span>
			</p>
			<p class="end"></p>
			<p>
				<span class="left">토·일요일</span>
				<span class="right">09:00 ~ 17:00</span>
			</p>
		</li>
		<li>
			<strong>어린이열람실, 영어문화정보실</strong>
			<p>
				<span class="left">평일</span>
				<span class="right">09:00 ~ 18:00</span>
			</p>
			<p class="end"></p>
			<p>
				<span class="left">토·일요일</span>
				<span class="right">09:00 ~ 17:00</span>
			</p>
		</li>
		<li>
			<strong>어르신방/장애인실</strong>
			<p>
				<span class="left">평일</span>
				<span class="right">09:00 ~ 18:00</span>
			</p>
			<p class="end"></p>
			<p>
				<span class="left">토·일요일</span>
				<span class="right">09:00 ~ 17:00</span>
			</p>
		</li>
	</ul>

	<h3 class="nbl">휴관일</h3>
	<ul class="nbl-list">
		<li>매월 첫 번째 및 세 번째 월요일</li>
		<li>'관공서의 공휴일에 관한 규정’에서 정한 공휴일(다만, 일요일은 개관하되, 일요일과 다른 공휴일이 겹치는 경우에는 휴관)</li>
		<li>임시휴관 : 관장이 필요하다고 인정하는 날</li>
	</ul>
</div>

<!--2·28기념학생도서관-->
<div class="tabConts" id="tabCon3">
	<h3 class="nbl first">이용시간</h3>
	<ul class="nbl-use-time no3">
		<li>
			<strong>일반자료실</strong>
			<p>
				<span class="left">평일</span>
				<span class="right">09:00 ~ 19:00</span>
			</p>
			<p class="end"></p>
			<p>
				<span class="left">토·일요일</span>
				<span class="right">09:00 ~ 17:00</span>
			</p>
		</li>
		<li>
			<strong>어린이자료실</strong>
			<p>
				<span class="left">평일</span>
				<span class="right">09:00 ~ 18:00</span>
			</p>
			<p class="end"></p>
			<p>
				<span class="left">토·일요일</span>
				<span class="right">09:00 ~ 17:00</span>
			</p>
		</li>
		<li>
			<strong>불로작은도서관</strong>
			<p>
				<span class="left">평일</span>
				<span class="right">09:00 ~ 18:00</span>
			</p>
			<p class="end"></p>
			<p>
				<span class="left">토·일요일</span>
				<span class="right">-</span>
			</p>
		</li>
	</ul>

	<h3 class="nbl">휴관일</h3>
	<ul class="nbl-list">
		<li>본관(일반자료실, 어린이자료실) : 매월 두 번째, 네 번째 월요일, 일요일을 제외한 법정공휴일</li>
		<li>불로작은도서관 : 주말 및 관공서의 공휴일(22.7.1.부터)</li>
		<li>특별한 사유가 발생으로 도서관장이 지정한 날</li>
	</ul>
</div>

<!--신천도서관-->
<div class="tabConts" id="tabCon4">
	<h3 class="nbl first">이용시간</h3>
	<ul class="nbl-use-time no2">
		<li>
			<strong>어린이자료실</strong>
			<p>
				<span class="left">평일</span>
				<span class="right">09:00 ~ 18:00</span>
			</p>
			<p class="end"></p>
			<p>
				<span class="left">토·일요일</span>
				<span class="right">09:00 ~ 17:00</span>
			</p>
		</li>
		<li>
			<strong>종합자료실</strong>
			<p>
				<span class="left">평일</span>
				<span class="right">09:00 ~ 20:00</span>
			</p>
			<p class="end"></p>
			<p>
				<span class="left">토·일요일</span>
				<span class="right">09:00 ~ 17:00</span>
			</p>
		</li>
	</ul>

	<h3 class="nbl">휴관일</h3>
	<ul class="nbl-list">
		<li>매주 월요일</li>
		<li>일요일을 제외한 관공서 공휴일</li>
	</ul>
</div>

<!--안심도서관-->
<div class="tabConts" id="tabCon5">
	<h3 class="nbl first">이용시간</h3>
	<ul class="nbl-use-time no3">
		<li>
			<strong>어린이자료실</strong>
			<p>
				<span class="left">평일</span>
				<span class="right">09:00 ~ 18:00</span>
			</p>
			<p class="end"></p>
			<p>
				<span class="left">토·일요일</span>
				<span class="right">09:00 ~ 17:00</span>
			</p>
		</li>
		<li>
			<strong>종합자료실</strong>
			<p>
				<span class="left">평일</span>
				<span class="right">09:00 ~ 22:00</span>
			</p>
			<p class="end"></p>
			<p>
				<span class="left">토·일요일</span>
				<span class="right">09:00 ~ 17:00</span>
			</p>
		</li>
		<li>
			<strong>디지털자료실</strong>
			<p>
				<span class="left">평일</span>
				<span class="right">09:00 ~ 22:00</span>
			</p>
			<p class="end"></p>
			<p>
				<span class="left">토·일요일</span>
				<span class="right">09:00 ~ 17:00</span>
			</p>
		</li>
	</ul>

	<h3 class="nbl">휴관일</h3>
	<ul class="nbl-list">
		<li>매주 월요일</li>
		<li>일요일을 제외한 관공서 공휴일</li>
	</ul>
</div>



<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=93baba79f6b6154b2068eb7550666f5f&libraries=services,clusterer"></script>
<script type="text/javascript" src="/resources/common/js/daum_map_nearbylib_app2.js"></script>
<script type="text/javascript">
/*<![CDATA[*/
var daegu_map;//overlay때문에 window에추가함.

jQuery(function($){
	var optionss = {
		level : 9,
		use_marker_click : true,
		iw_template : false
	};

	var daegu_map_data = new Array();
	
	optionss.x='35.9412785';
	optionss.y='128.6227308';

	daegu_map_data.push({idx:'59',title:'구수산도서관', tel:'053-320-5150', point:{x:'35.9387852',y:'128.5523825'}, address:'북구 대천로 21',no:'1',link:'https://library.daegu.go.kr/bukgs/intro/search/index.do?menu_idx=9'});
	daegu_map_data.push({idx:'58',title:'동부도서관', tel:'053-231-2200', point:{x:'35.8901537',y:'128.6216009'}, address:'동구 신암북로11길 54',no:'2',link:'https://library.daegu.go.kr/dongbu/intro/search/index.do?menu_idx=13'});
	daegu_map_data.push({idx:'57',title:'2·28기념학생도서관', tel:'053-231-2841', point:{x:'35.8905698',y:'128.6337372'}, address:'동구 아양로41길 56',no:'3',link:'https://library.daegu.go.kr/228/intro/search/index.do?menu_idx=13'});
	daegu_map_data.push({idx:'56',title:'신천도서관', tel:'053-980-2600', point:{x:'35.871436',y:'128.617776'}, address:'동구 동부로6길 65',no:'4',link:'https://library.daegu.go.kr/donggu/intro/search/index.do?menu_idx=9'});
	daegu_map_data.push({idx:'55',title:'안심도서관', tel:'053-980-2600', point:{x:'35.8590312',y:'128.701814'}, address:'동구 금호강변로 360',no:'5',link:'https://library.daegu.go.kr/donggu/intro/search/index.do?menu_idx=9'});

	daegu_map = new map_app();
	
	/* add overlay [ */
	daegu_map.close_overlay = function(idx)  {
		this._overlay[idx].setMap(null);
	}

	daegu_map.marker_click = function(marker, data) {
		
		var map = this.map;
		var infoStr  = '<div class="tour2map1layer1">';
		infoStr += '	<div href="#" onclick="return false;" class="wrap1 a1">';
		infoStr += '		<strong class="h1">'+ data.title +'</strong>';
		
		infoStr += '		<span class="text1"><span class="t1">주소 : '+ data.address +'<br/>연락처 : '+  data.tel +'</span></span>';
		infoStr += '		<div class="nbl-link-btn-box"><a href="#?" onclick="window.open(\''+ data.link +'\')" class="btn">자료검색 바로가기</a></div>';
		infoStr += '	</div>';
		infoStr += '	<a href="#?" onclick="daegu_map.close_overlay('+ data.idx +');return false;" class="b1 close"><i class="ic1 bsContain">×</i><span class="blind">닫기</span></a>';
		infoStr += '</div>';
		
		this._overlay[data.idx] = new daum.maps.CustomOverlay({
			content: infoStr,
			map: map,
			position: marker.getPosition()
		});
		this._overlay[data.idx].setMap(map);
		//map.setCenter(marker.getPosition());
		map.panBy(0, -100);
	} 
	/* ]add overlay */

	daegu_map.init('daegu_map', optionss, daegu_map_data);
});
/*]]>*/
</script>