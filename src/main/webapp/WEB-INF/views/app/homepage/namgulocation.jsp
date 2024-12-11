<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>




<link rel="stylesheet" type="text/css" href="/resources/common/css/locationMap.css"/>

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
					<p>대구광역시립남부도서관</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 남구 앞산순환로 512</p>
					<p class="tel">053-231-2300</p>
				</div>
			</div>
		</li>
		<!-- mg-->
		<li class="mg">
			<div class="info-box">
				<div class="tit num02">
					<p>이천어울림도서관</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 남구 이천로 124</p>
					<p class="tel">053-664-3571</p>
				</div>
			</div>
		</li>
		<!-- -->
		<li>
			<div class="info-box">
				<div class="tit num03">
					<p>대명어울림도서관</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 남구 두류공원로 38-1</p>
					<p class="tel">053-664-3555</p>
				</div>
			</div>
		</li>
		<!-- -->
		<li>
			<div class="info-box">
				<div class="tit num04">
					<p>꿈틀작은도서관</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 남구 성명공원길18(대명동, 2층)</p>
					<p class="tel">053-621-8667</p>
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
		//map.panBy(0, -100);
	} 
	/* ]add overlay */

	daegu_map.init('daegu_map', optionss, daegu_map_data);
});
/*]]>*/
</script>