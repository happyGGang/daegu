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
		<div class="custom_mapcontrol"><a href="/dgportal/namgu/namgumap.html" target="_blank">&nbsp;</a></div>
	</div>
</div>

<div class="library-info-box">
	<ul>
		<!-- -->
		<li>
			<div class="info-box">
				<div class="tit num01">
					<p>대구광역시립동부도서관</p>
				</div>
				<div class="txt">
					<p class="add">동구 신암북로 11길 54</p>
					<p class="tel">053-231-2200</p>
				</div>
			</div>
		</li>
		<!-- mg-->
		<li class="mg">
			<div class="info-box">
				<div class="tit num02">
					<p>대구2ㆍ28기념학생도서관</p>
				</div>
				<div class="txt">
					<p class="add">동구 금호강변로 360</p>
					<p class="tel">053-980-2600</p>
				</div>
			</div>
		</li>
		<!-- -->
		<li>
			<div class="info-box">
				<div class="tit num03">
					<p>대구안심도서관</p>
				</div>
				<div class="txt">
					<p class="add">동구 아양로41길 56</p>
					<p class="tel">053-231-2841</p>
				</div>
			</div>
		</li>
		<!-- -->
		<li>
			<div class="info-box">
				<div class="tit num04">
					<p>대구신천도서관</p>
				</div>
				<div class="txt">
					<p class="add">동구 동부로6길 65</p>
					<p class="tel">053-980-2600</p>
				</div>
			</div>
		</li>
		<!-- mg-->
		<li class="mg">
			<div class="info-box">
				<div class="tit num05">
					<p>신암2동작은도서관</p>
				</div>
				<div class="txt">
					<p class="add">동구 신성로 56</p>
					<p class="tel">053-662-3633</p>
				</div>
			</div>
		</li>
		<!-- -->
		<li>
			<div class="info-box">
				<div class="tit num06">
					<p>신암3동작은도서관</p>
				</div>
				<div class="txt">
					<p class="add">동구 아양로8길 10-1</p>
					<p class="tel">070-7755-5631</p>
				</div>
			</div>
		</li>
		<!-- -->
		<li>
			<div class="info-box">
				<div class="tit num07">
					<p>신암5동작은도서관</p>
				</div>
				<div class="txt">
					<p class="add">동구 아양로37길 92</p>
					<p class="tel">053-662-3485</p>
				</div>
			</div>
		</li>
		<!-- mg-->
		<li class="mg">
			<div class="info-box">
				<div class="tit num08">
					<p>신천3동작은도서관</p>
				</div>
				<div class="txt">
					<p class="add">동구 장등로 90</p>
					<p class="tel">053-662-3734</p>
				</div>
			</div>
		</li>
		<!-- -->
		<li>
			<div class="info-box">
				<div class="tit num09">
					<p>효목1동작은도서관</p>
				</div>
				<div class="txt">
					<p class="add">동구 화랑로41길 46</p>
					<p class="tel">053-662-3775</p>
				</div>
			</div>
		</li>
		<!-- -->
		<li>
			<div class="info-box">
				<div class="tit num10">
					<p>효목2동작은도서관</p>
				</div>
				<div class="txt">
					<p class="add">동구 화랑로 25길 45</p>
					<p class="tel">053-662-3794</p>
				</div>
			</div>
		</li>
		<!-- mg-->
		<li class="mg">
			<div class="info-box">
				<div class="tit num11">
					<p>도평동작은도서관</p>
				</div>
				<div class="txt">
					<p class="add">동구 팔공로24길 171</p>
					<p class="tel">053-662-3810</p>
				</div>
			</div>
		</li>
		<!-- -->
		<li>
			<div class="info-box">
				<div class="tit num12">
					<p>불로어울림작은도서관</p>
				</div>
				<div class="txt">
					<p class="add">동구 팔공로24길 5</p>
					<p class="tel">070-4214-0007</p>
				</div>
			</div>
		</li>
		<!-- -->
		<li>
			<div class="info-box">
				<div class="tit num13">
					<p>지저동작은도서관</p>
				</div>
				<div class="txt">
					<p class="add">동구 해동로3길 80</p>
					<p class="tel">070-7755-5633</p>
				</div>
			</div>
		</li>
		<!-- mg-->
		<li class="mg">
			<div class="info-box">
				<div class="tit num14">
					<p>동촌역사작은도서관</p>
				</div>
				<div class="txt">
					<p class="add">동구 동촌역사로 3길 35</p>
					<p class="tel">070-4214-6859</p>
				</div>
			</div>
		</li>
		<!-- -->
		<li>
			<div class="info-box">
				<div class="tit num15">
					<p>방촌동작은도서관</p>
				</div>
				<div class="txt">
					<p class="add">동구 동촌로46길 2</p>
					<p class="tel">070-4251-5854</p>
				</div>
			</div>
		</li>
		<!-- -->
		<li>
			<div class="info-box">
				<div class="tit num16">
					<p>해안동작은도서관</p>
				</div>
				<div class="txt">
					<p class="add">동구 방촌로 29길 46</p>
					<p class="tel">070-7755-5632</p>
				</div>
			</div>
		</li>
		<!-- mg-->
		<li class="mg">
			<div class="info-box">
				<div class="tit num17">
					<p>반야월역사작은도서관</p>
				</div>
				<div class="txt">
					<p class="add">동구 신서로 50</p>
					<p class="tel">053-662-4110</p>
				</div>
			</div>
		</li>
		<!-- -->
		<li>
			<div class="info-box">
				<div class="tit num18">
					<p>늘푸른작은도서관</p>
				</div>
				<div class="txt">
					<p class="add">동구 입석로 5</p>
					<p class="tel">053-983-8211</p>
				</div>
			</div>
		</li>
		<!-- -->
		<li>
			<div class="info-box">
				<div class="tit num19">
					<p>꿈날자문고작은도서관</p>
				</div>
				<div class="txt">
					<p class="add">동구 안심로73길 22</p>
					<p class="tel">053-247-0755</p>
				</div>
			</div>
		</li>
		<!-- mg-->
		<li class="mg">
			<div class="info-box">
				<div class="tit num20">
					<p>행복작은도서관</p>
				</div>
				<div class="txt">
					<p class="add">동구 송라로2길17-6</p>
					<p class="tel">053-755-9392</p>
				</div>
			</div>
		</li>
		<!-- -->
		<li>
			<div class="info-box">
				<div class="tit num21">
					<p>율하5주민작은도서관</p>
				</div>
				<div class="txt">
					<p class="add">동구 율하서로59</p>
					<p class="tel">053-965-5955</p>
				</div>
			</div>
		</li>
		<!-- -->
		<li>
			<div class="info-box">
				<div class="tit num22">
					<p>방촌어린이작은도서관</p>
				</div>
				<div class="txt">
					<p class="add">동구 동촌로 46길 17</p>
					<p class="tel">053-981-8276</p>
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
	
	optionss.x='35.8320561611199';
	optionss.y='128.58075142379';

	daegu_map_data.push({idx:'59',title:'대구광역시립남부도서관', tel : '053-231-2300', point:{x:'35.8320561611199',y:'128.58075142379'}, address:'대구광역시 남구 앞산순환로 512',no:'1' });
	daegu_map_data.push({idx:'58',title:'이천어울림도서관', tel : '053-664-3571', point:{x:'35.8523906311032',y:'128.598813734157'}, address:'대구광역시 남구 이천로 124',no:'2' });
	daegu_map_data.push({idx:'57',title:'대명어울림도서관', tel : '053-664-3555', point:{x:'35.841571576524',y:'128.573782930777'}, address:'대구광역시 남구 두류공원로 38-1',no:'3' });
	daegu_map_data.push({idx:'56',title:'꿈틀작은도서관', tel : '053-621-8667', point:{x:'35.8479361251304',y:'128.572326741767'}, address:'대구광역시 남구 성명공원길18(대명동, 2층)',no:'4' });

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