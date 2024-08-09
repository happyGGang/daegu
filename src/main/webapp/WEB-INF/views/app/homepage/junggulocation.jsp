<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<style>
.map_bg {
	background-position: right 0 !important;
	height: 600px;
}
.info_box p {
	padding-right: 40px;
}

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
		<!-- 지도 확대, 축소 컨트롤 div 입니다
		<div class="custom_zoomcontrol radius_border"> 
		<a href="#" onclick="zoomIn()"><img src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/ico_plus.png" alt="확대"></a>  
		<a href="#" onclick="zoomOut()"><img src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/ico_minus.png" alt="축소"></a>
		</div>
		 -->
		<div class="custom_mapcontrol"><a href="/dgportal/junggu/junggumap.html" target="_blank">&nbsp;</a></div>
	</div>
</div>

<div class="library-info-box">
	<ul>
		<!-- -->
		<li>
			<div class="info-box">
				<div class="tit num01">
					<p>국채보상운동기념도서관</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 중구 공평로 10길 25(동인동2가)</p>
					<p class="tel">053-231-2000</p>
				</div>
			</div>
		</li>
		<!-- mg-->
		<li class="mg">
			<div class="info-box">
				<div class="tit num02">
					<p>2·28민주운동기념회관도서관</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 중구 2.28길 9 (남산동 2113-10)</p>
					<p class="tel">053-257-2280</p>
				</div>
			</div>
		</li>
		<!-- -->
		<li>
			<div class="info-box">
				<div class="tit num03">
					<p>대구중구영어도서관</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 중구 달구벌대로440길 27 (대봉동)</p>
					<p class="tel">053-661-3960</p>
				</div>
			</div>
		</li>
		<!-- -->
		<li>
			<div class="info-box">
				<div class="tit num04">
					<p>남산4동작은도서관</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 중구 남산로1길 42, 남산4동 행정복지센터 2층</p>
					<p class="tel">053-661-3765</p>
				</div>
			</div>
		</li>
		<!-- mg-->
		<li class="mg">
			<div class="info-box">
				<div class="tit num05">
					<p>동인느티나무도서관</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 중구 동덕로 38길 47 (동인동3가)</p>
					<p class="tel">053-661-3325</p>
				</div>
			</div>
		</li>
		<!-- -->
		<li>
			<div class="info-box">
				<div class="tit num06">
					<p>중구청교양정보실</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 중구 국채보상로139길 1, 중구청 10층</p>
					<p class="tel">053-661-3241</p>
				</div>
			</div>
		</li>
		<!-- -->
		<li>
			<div class="info-box">
				<div class="tit num07">
					<p>대신동작은도서관</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 중구 달구벌대로389길 50, 대신동주민센터 1층</p>
					<p class="tel">053-661-3685</p>
				</div>
			</div>
		</li>
		<!-- mg-->
		<li class="mg">
			<div class="info-box">
				<div class="tit num08">
					<p>삼덕마루 작은도서관</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 중구 동덕로 26길 103 (삼덕동3가)</p>
					<p class="tel">053-661-3603</p>
				</div>
			</div>
		</li>
		<!-- -->
		<li>
			<div class="info-box">
				<div class="tit num09">
					<p>대봉2동작은도서관</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 중구 대봉로47길 31 (대봉동)</p>
					<p class="tel">053-661-3603</p>
				</div>
			</div>
		</li>
		<!-- -->
	</ul>
</div>

<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=93baba79f6b6154b2068eb7550666f5f&libraries=services,clusterer"></script>
<script type="text/javascript" src="/resources/common/js/daum_map_tour_app.js"></script>
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
	
	optionss.x='35.8650932704217';
	optionss.y='128.602663610319';

	daegu_map_data.push({idx:'59',title:'국채보상운동기념도서관',tel:'053-231-2000',point:{x:'35.8686883',y:'128.601256'},address:'대구광역시 중구 공평로 10길 25(동인동2가)',no:'1' });
	daegu_map_data.push({idx:'58',title:'2·28민주운동기념회관도서관',tel:'053-257-2280',point:{x:'35.8584072',y:'128.5904583'},address:'대구광역시 중구 2.28길 9 (남산동 2113-10)',no:'2' });
	daegu_map_data.push({idx:'57',title:'대구중구영어도서관', tel : '053-661-3960', point:{x:'35.8615455232041',y:'128.604392066834'}, address:'대구광역시 중구 달구벌대로440길 27',no:'3' });
	daegu_map_data.push({idx:'56',title:'남산4동작은도서관', tel : '053-661-3765', point:{x:'35.858223498446',y:'128.580572162371'}, address:'대구광역시 중구 남산로1길 42, 남산4동 행정복지센터 2층',no:'4' });
	daegu_map_data.push({idx:'55',title:'동인느티나무도서관', tel : '053-661-3325', point:{x:'35.8713151154646',y:'128.607202675691'}, address:'대구광역시 중구 동덕로 38길 47',no:'5' });
	daegu_map_data.push({idx:'54',title:'중구청교양정보실', tel : '053-661-3241', point:{x:'35.8693266953365',y:'128.606158632625'}, address:'대구광역시 중구 국채보상로139길 1, 중구청 10층',no:'6' });
	daegu_map_data.push({idx:'53',title:'대신동작은도서관', tel : '053-661-3685', point:{x:'35.8655529000034',y:'128.576339509154'}, address:'대구광역시 중구 달구벌대로389길 50, 대신동주민센터 1층',no:'7' });
	daegu_map_data.push({idx:'52',title:'삼덕마루 작은도서관', tel : '053-661-3603', point:{x:'35.8646389956382',y:'128.609046629431'}, address:'대구광역시 중구 동덕로 26길 103',no:'8' });
	daegu_map_data.push({idx:'51',title:'대봉2동작은도서관', tel : '053-661-3603', point:{x:'35.8587641205695',y:'128.599368285288'}, address:'대구광역시 중구 대봉로47길 31',no:'9' });

	daegu_map = new map_app();
	
	/* add overlay [ */
	daegu_map.close_overlay = function(idx)  {
		this._overlay[idx].setMap(null);
	}

	daegu_map.marker_click = function(marker, data) {
		
		var map = this.map;
		var infoStr  = '<div class="tour2map1layer1">';
		infoStr += '	<a href="#" onclick="return false;" class="wrap1 a1">';
		infoStr += '		<strong class="h1">'+ data.title +'</strong>';
		
		infoStr += '		<span class="text1"><span class="t1">주소 : '+ data.address +'<br/>연락처 : '+  data.tel +'</span></span>';
		infoStr += '	</a>';
		infoStr += '	<a href="#?" onclick="daegu_map.close_overlay('+ data.idx +');return false;" class="b1 close"><i class="ic1 bsContain">×</i><span class="blind">닫기</span></a>';
		infoStr += '</div>';
		
		this._overlay[data.idx] = new daum.maps.CustomOverlay({
			content: infoStr,
			map: map,
			position: marker.getPosition()
		});
		this._overlay[data.idx].setMap(map);
		map.setCenter(marker.getPosition());
		//map.panBy(0, -100);
	} 
	/* ]add overlay */

	daegu_map.init('daegu_map', optionss, daegu_map_data);
});
/*]]>*/
</script>