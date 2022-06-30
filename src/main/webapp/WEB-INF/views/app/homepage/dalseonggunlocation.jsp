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

<h3>지도</h3>

<div class="map_wrap">
	<div id="daegu_map" class="daegu_map">
		<!-- 지도 확대, 축소 컨트롤 div 입니다
		<div class="custom_zoomcontrol radius_border"> 
		<a href="#" onclick="zoomIn()"><img src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/ico_plus.png" alt="확대"></a>  
		<a href="#" onclick="zoomOut()"><img src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/ico_minus.png" alt="축소"></a>
		</div>
		 -->
		<div class="custom_mapcontrol"><a href="/dgportal/dalseonggun/dalseonggunmap.html" target="_blank">&nbsp;</a></div>
	</div>
</div>

<div class="library-info-box">
	<ul>
		<!-- -->
		<li>
			<div class="info-box">
				<div class="tit num01">
					<p>대구광역시립달성도서관</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 달성군 현풍면 현풍동로19길 26</p>
					<p class="tel">053-231-2150</p>
				</div>
			</div>
		</li>
		<!-- mg-->
		<li class="mg">
			<div class="info-box">
				<div class="tit num02">
					<p>달성군립도서관</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 달성군 다사읍 달구벌대로174길 10-13</p>
					<p class="tel">053-231-2150</p>
				</div>
			</div>
		</li>
		<!-- -->
		<li>
			<div class="info-box">
				<div class="tit num03">
					<p>화원읍작은도서관</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 달성군 화원읍 비슬로 2594 (군민독서실1,2층)</p>
					<p class="tel">053-668-3346</p>
				</div>
			</div>
		</li>
		<!-- -->
		<li>
			<div class="info-box">
				<div class="tit num04">
					<p>논공읍작은도서관</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 달성군 논공읍 논공로 697-9 (종합사회복지관2층)</p>
					<p class="tel">053-615-9191</p>
				</div>
			</div>
		</li>
		<!-- mg-->
		<li class="mg">
			<div class="info-box">
				<div class="tit num05">
					<p>다사읍작은도서관</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 달성군 다사읍 매곡로12길 37 (다사읍자치센터별관)</p>
					<p class="tel">053-591-3342</p>
				</div>
			</div>
		</li>
		<!-- -->
		<li>
			<div class="info-box">
				<div class="tit num06">
					<p>다사읍서재작은도서관</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 달성군 다사읍 서재본길 25 (다사서재출장소2층)</p>
					<p class="tel">053-588-6261</p>
				</div>
			</div>
		</li>
		<!-- -->
		<li>
			<div class="info-box">
				<div class="tit num07">
					<p>유가읍작은도서관</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 달성군 유가읍 테크노상업로 95 (유가읍사무소2층)</p>
					<p class="tel">053-614-8048</p>
				</div>
			</div>
		</li>
		<!-- mg-->
		<li class="mg">
			<div class="info-box">
				<div class="tit num08">
					<p>옥포읍작은도서관</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 달성군 옥포읍 비슬로 2215 (옥포읍자치센터1층)</p>
					<p class="tel">053-614-8314</p>
				</div>
			</div>
		</li>
		<!-- -->
		<li>
			<div class="info-box">
				<div class="tit num09">
					<p>가창면 참꽃작은도서관</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 달성군 가창면 가창로220길 8 (청소년문화의집1층)</p>
					<p class="tel">053-760-7731</p>
				</div>
			</div>
		</li>
		<!-- -->
		<li>
			<div class="info-box">
				<div class="tit num10">
					<p>하빈면작은도서관</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 달성군 하빈면 하빈로84길 23 (하빈면민복지회관3층)</p>
					<p class="tel">-</p>
				</div>
			</div>
		</li>
		<!-- mg-->
		<li class="mg">
			<div class="info-box">
				<div class="tit num11">
					<p>구지면작은도서관</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 달성군 구지면 창리로11길 90 (구.구지면 농촌상담소)</p>
					<p class="tel">053-614-0985</p>
				</div>
			</div>
		</li>
		<!-- -->
		<li>
			<div class="info-box">
				<div class="tit num12">
					<p>달성군청소년센터 작은도서관</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 달성군 논공읍 논공로 252 (청소년센터3층)</p>
					<p class="tel">053-670-1323</p>
				</div>
			</div>
		</li>
		<!-- -->
		<li>
			<div class="info-box">
				<div class="tit num13">
					<p>달성군청도서관</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 달성군 논공읍 달성군청로 33 (달성군청)</p>
					<p class="tel">053-668-3239</p>
				</div>
			</div>
		</li>
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
	
	optionss.x='35.6987734244329';
	optionss.y='128.447687886093';

	daegu_map_data.push({idx:'59',title:'대구광역시립달성도서관', tel : '053-231-2150', point:{x:'35.6987734244329',y:'128.447687886093'}, address:'대구광역시 달성군 현풍면 현풍동로19길 26',no:'1' });
	daegu_map_data.push({idx:'58',title:'달성군립도서관', tel : '053-231-2150', point:{x:'35.8592968795804',y:'128.462410475657'}, address:'대구광역시 달성군 다사읍 달구벌대로174길 10-13',no:'2' });
	daegu_map_data.push({idx:'57',title:'화원읍작은도서관', tel : '053-668-3346', point:{x:'35.8042335195515',y:'128.500718751053'}, address:'대구광역시 달성군 화원읍 비슬로 2594 (군민독서실1,2층)',no:'3' });
	daegu_map_data.push({idx:'56',title:'논공읍작은도서관', tel : '053-615-9191', point:{x:'35.7301956975906',y:'128.45178080326'}, address:'대구광역시 달성군 논공읍 논공로 697-9 (종합사회복지관2층)',no:'4' });
	daegu_map_data.push({idx:'55',title:'다사읍작은도서관', tel : '053-591-3342', point:{x:'35.8648158934292',y:'128.457307362395'}, address:'대구광역시 달성군 다사읍 매곡로12길 37 (다사읍자치센터별관)',no:'5' });
	daegu_map_data.push({idx:'54',title:'다사읍서재작은도서관', tel : '053-588-6261', point:{x:'35.8722208677966',y:'128.494256685648'}, address:'대구광역시 달성군 다사읍 서재본길 25 (다사서재출장소2층)',no:'6' });
	daegu_map_data.push({idx:'52',title:'유가읍작은도서관', tel : '053-614-8048', point:{x:'35.6943341355787',y:'128.459646544423'}, address:'대구광역시 달성군 유가읍 테크노상업로 95 (유가읍사무소2층)',no:'7' });
	daegu_map_data.push({idx:'51',title:'옥포읍작은도서관', tel : '053-614-8314', point:{x:'35.7893939008833',y:'128.463403781067'}, address:'대구광역시 달성군 옥포읍 비슬로 2215 (옥포읍자치센터1층)',no:'8' });
	daegu_map_data.push({idx:'49',title:'가창면 참꽃작은도서관', tel : '053-760-7731', point:{x:'35.8023200879016',y:'128.623413571364'}, address:'대구광역시 달성군 가창면 가창로220길 8 (청소년문화의집1층)',no:'9' });
	daegu_map_data.push({idx:'48',title:'하빈면작은도서관', tel : '', point:{x:'35.8995133295819',y:'128.445876932419'}, address:'대구광역시 달성군 하빈면 하빈로84길 23 (하빈면민복지회관3층)',no:'10' });
	daegu_map_data.push({idx:'47',title:'구지면작은도서관', tel : '053-614-0985', point:{x:'35.6604041035004',y:'128.415118518014'}, address:'대구광역시 달성군 구지면 창리로11길 90 (구.구지면 농촌상담소)',no:'11' });
	daegu_map_data.push({idx:'46',title:'달성군청소년센터 작은도서관', tel : '053-670-1323', point:{x:'35.7238932618227',y:'128.455082141863'}, address:'대구광역시 달성군 논공읍 논공로 252 (청소년센터3층)',no:'12' });
	daegu_map_data.push({idx:'45',title:'달성군청도서관', tel : '053-668-3239', point:{x:'35.7746629175875',y:'128.43138936958'}, address:'대구광역시 달성군 논공읍 달성군청로 33 (달성군청)',no:'13' });

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
		map.panBy(0, -100);
	} 
	/* ]add overlay */

	daegu_map.init('daegu_map', optionss, daegu_map_data);
});
/*]]>*/
</script>