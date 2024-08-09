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

<div class="map_wrap" style="height:auto;">
	<div id="daegu_map" class="daegu_map">
		<!-- 지도 확대, 축소 컨트롤 div 입니다
		<div class="custom_zoomcontrol radius_border"> 
		<a href="#" onclick="zoomIn()"><img src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/ico_plus.png" alt="확대"></a>  
		<a href="#" onclick="zoomOut()"><img src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/ico_minus.png" alt="축소"></a>
		</div>
		 -->
		<div class="custom_mapcontrol"><a href="/dgportal/bukgu/bukgumap.html" target="_blank">&nbsp;</a></div>
	</div>
</div>

<div class="library-info-box">
	<ul>
		<!-- -->
		<li>
			<div class="info-box">
				<div class="tit num01">
					<p>대구광역시립북부도서관</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 북구 옥산로 75 (침산동)</p>
					<p class="tel">053-231-2600</p>
				</div>
			</div>
		</li>
		<!-- mg-->
		<li class="mg">
			<div class="info-box">
				<div class="tit num02">
					<p>구수산도서관</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 북구 대천로 21 (읍내동)</p>
					<p class="tel">053-320-5150</p>
				</div>
			</div>
		</li>
		<!-- -->
		<li>
			<div class="info-box">
				<div class="tit num03">
					<p>태전도서관</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 북구 영송로 36-16(태전동)</p>
					<p class="tel">053-320-5180</p>
				</div>
			</div>
		</li>
		<!-- -->
		<li>
			<div class="info-box">
				<div class="tit num04">
					<p>대현도서관</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 북구 대현남로 43<br />(대현동)</p>
					<p class="tel">053-320-5170</p>
				</div>
			</div>
		</li>
		<!-- mg-->
		<li class="mg">
			<div class="info-box">
				<div class="tit num05">
					<p>산격1동작은도서관</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 북구 연암로 36길 6(산격1동), 산격1동주민센터 3층</p>
					<p class="tel">053-320-5193</p>
				</div>
			</div>
		</li>
		<!-- -->
		<li>
			<div class="info-box">
				<div class="tit num06">
					<p>북구영어작은도서관</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 북구 고성로 31길 21(고성동 3가), 고성동행정복지센터 1층</p>
					<p class="tel">053-320-5190</p>
				</div>
			</div>
		</li>
		<!-- -->
		<li>
			<div class="info-box">
				<div class="tit num07">
					<p>침산1동작은도서관</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 북구 침산남로13길 16(침산동), 침산1동주민센터 2층</p>
					<p class="tel">053-320-5191</p>
				</div>
			</div>
		</li>
		<!-- mg-->
		<li class="mg">
			<div class="info-box">
				<div class="tit num08">
					<p>서변동작은도서관</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 북구 호국로57길 6, 유니버시아드레포츠센터 1층</p>
					<p class="tel">053-320-5194</p>
				</div>
			</div>
		</li>
		<!-- -->
		<li>
			<div class="info-box">
				<div class="tit num09">
					<p>노원행복도서관</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 북구 노원로 134</p>
					<p class="tel">053-320-5198<br><br></p>
				</div>
			</div>
		</li>
		<!---->
		<li>
			<div class="info-box">
				<div class="tit num10">
					<p>한강공원부키도서관</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 북구 사수동 811</p>
					<p class="tel">053-320-5199</p>
				</div>
			</div>
		</li>
		<!-- mg-->
		<li class="mg">
			<div class="info-box">
				<div class="tit num11">
					<p>시청작은도서관</p>
				</div>
				<div class="txt">
					<p class="add">북구 연암로 40 (산격청사 별관3동)</p>
					<p class="tel">053-803-6060</p>
				</div>
			</div>
		</li>
		<!-- -->
		<li>
			<div class="info-box">
				<div class="tit num12">
					<p>꿈꾸는마을도서관도토리</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 북구 구암로 146</p>
					<p class="tel">053-327-0645</p>
				</div>
			</div>
		</li>
		<!-- -->
		<li>
			<div class="info-box">
				<div class="tit num13">
					<p>더불어숲도서관</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 북구 학남로17길 2 </p>
					<p class="tel">053-326-0937</p>
				</div>
			</div>
		</li>
		<!-- mg-->
		<li class="mg">
			<div class="info-box">
				<div class="tit num14">
					<p>연암공공도서관</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 북구 동북로26길 25-1</p>
					<p class="tel">053-956-4422</p>
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
	
	optionss.x='35.8851259563135';
	optionss.y='128.583844263017';

	daegu_map_data.push({idx:'59',title:'대구광역시립북부도서관', tel:'053-231-2600', point:{x:'35.8851259563135',y:'128.583844263017'}, address:'대구광역시 북구 옥산로 75 (침산동)',no:'1' });
	daegu_map_data.push({idx:'58',title:'구수산도서관', tel:'053-320-5150', point:{x:'35.9387440917381',y:'128.55240517489'}, address:'대구광역시 북구 대천로 21 (읍내동)',no:'2' });
	daegu_map_data.push({idx:'57',title:'태전도서관', tel:'053-320-5180', point:{x:'35.9285577192463',y:'128.54620122749'}, address:'대구광역시 북구 영송로 36-16(태전동)',no:'3' });
	daegu_map_data.push({idx:'56',title:'대현도서관', tel:'053-320-5170', point:{x:'35.8818931927918',y:'128.607389999937'}, address:'대구광역시 북구 대현남로 43(대현동)',no:'4' });
	daegu_map_data.push({idx:'55',title:'산격1동작은도서관', tel:'053-320-5193', point:{x:'35.9005135472476',y:'128.597103166871'}, address:'대구광역시 북구 연암로 36길 6(산격1동), 산격1동주민센터 3층',no:'5' });
	daegu_map_data.push({idx:'54',title:'북구영어작은도서관', tel:'053-320-5190', point:{x:'35.8818550927522',y:'128.583514539572'}, address:'대구광역시 북구 고성로 31길 21(고성동 3가), 고성동행정복지센터 1층',no:'6' });
	daegu_map_data.push({idx:'53',title:'침산1동작은도서관', tel:'053-320-5191', point:{x:'35.8903255867369',y:'128.581357220285'}, address:'대구광역시 북구 침산남로13길 16(침산동), 침산1동주민센터 2층',no:'7' });
	daegu_map_data.push({idx:'51',title:'서변동작은도서관', tel:'053-320-5194', point:{x:'35.9279987494581',y:'128.597948326757'}, address:'대구광역시 북구 호국로57길 6, 유니버시아드레포츠센터 1층',no:'8' });
	daegu_map_data.push({idx:'49',title:'노원행복도서관', tel:'053-320-5198', point:{x:'35.8969492969157',y:'128.575761642876'}, address:'대구광역시 북구 노원로 134',no:'9' });
	daegu_map_data.push({idx:'48',title:'한강공원부키도서관', tel:'053-320-5199', point:{x:'35.8941995',y:'128.6024372'}, address:'북구 연암로 40 (산격청사 별관3동)',no:'10' });
	daegu_map_data.push({idx:'48',title:'시청작은도서관', tel:'053-320-5199', point:{x:'35.898698373371',y:'128.51362596382'}, address:'대구광역시 북구 사수동 811',no:'11' });
	daegu_map_data.push({idx:'47',title:'꿈꾸는마을도서관도토리', tel:'053-327-0645', point:{x:'35.9315271',y:'128.5564402'}, address:'대구광역시 북구 구암로 146',no:'12' });
	daegu_map_data.push({idx:'46',title:'더불어숲도서관', tel:'053-326-0937', point:{x:'35.944734',y:'128.5698923'}, address:'대구광역시 북구 학남로17길 2 ',no:'13' });
	daegu_map_data.push({idx:'45',title:'연암공공도서관', tel:'053-956-4422', point:{x:'35.8995862',y:'128.6055034'}, address:'대구광역시 북구 동북로26길 25-1',no:'14' });

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