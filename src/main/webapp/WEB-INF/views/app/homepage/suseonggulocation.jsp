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
		<div class="custom_mapcontrol"><a href="/dgportal/suseonggu/suseonggumap.html" target="_blank">&nbsp;</a></div>
	</div>
</div>

<div class="library-info-box">
	<ul>
		<!-- -->
		<li>
			<div class="info-box">
				<div class="tit num01">
					<p>대구광역시립수성도서관</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 수성구 만촌로 151</p>
					<p class="tel">053-231-2551</p>
				</div>
			</div>
		</li>
		<!-- mg-->
		<li class="mg">
			<div class="info-box">
				<div class="tit num02">
					<p>범어도서관</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 수성구 달구벌대로 2451</p>
					<p class="tel">053-668-1600</p>
				</div>
			</div>
		</li>
		<!-- -->
		<li>
			<div class="info-box">
				<div class="tit num03">
					<p>용학도서관</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 수성구 지범로41길 36</p>
					<p class="tel">053-668-1700</p>
				</div>
			</div>
		</li>
		<!-- -->
		<li>
			<div class="info-box">
				<div class="tit num04">
					<p>고산도서관</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 수성구 달구벌대로650길 6(신매동)</p>
					<p class="tel">053-668-1900</p>
				</div>
			</div>
		</li>
		<!-- mg-->
		<li class="mg">
			<div class="info-box">
				<div class="tit num05">
					<p>파동도서관</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 수성구 파동로3길 62 파동평생학습센터 1층</p>
					<p class="tel">053-668-1801</p>
				</div>
			</div>
		</li>
		<!-- -->
		<li>
			<div class="info-box">
				<div class="tit num06">
					<p>무학숲도서관</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 수성구 청수로40길 73-10(지산동)</p>
					<p class="tel">053-668-1760</p>
				</div>
			</div>
		</li>
		<!-- -->
		<li>
			<div class="info-box">
				<div class="tit num07">
					<p>책숲길도서관</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 수성구 수성로215(중동) 수옥빌딩 4층</p>
					<p class="tel">053-668-1651</p>
				</div>
			</div>
		</li>
		<!-- mg-->
		<li class="mg">
			<div class="info-box">
				<div class="tit num08">
					<p>물망이도서관</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 수성구 명덕로 443-2 수성2,3가동 행정복지센터 4층</p>
					<p class="tel">053-666-4390</p>
				</div>
			</div>
		</li>
		<!-- -->
		<li>
			<div class="info-box">
				<div class="tit num09">
					<p>황금책문화센터도서관</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 수성구 청솔로2길 64 황금2동행정복지센터 1층</p>
					<p class="tel">053-668-1660</p>
				</div>
			</div>
		</li>
		<!-- -->
		<li>
			<div class="info-box">
				<div class="tit num10">
					<p>수성못그림책도서관</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 수성구 무학로 112, 1층</p>
					<p class="tel">053-668-1770</p>
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
	
		optionss.x='35.8721329094016';
		optionss.y='128.63906132752';

		daegu_map_data.push({idx:'59',title:'대구광역시립수성도서관', tel : '053-231-2551', point:{x:'35.8721329094016',y:'128.63906132752'}, address:'대구광역시 수성구 만촌로 151',no:'1' });
		daegu_map_data.push({idx:'58',title:'범어도서관', tel : '053-668-1600', point:{x:'35.8593751012399',y:'128.630676348493'}, address:'대구광역시 수성구 달구벌대로 2451',no:'2' });
		daegu_map_data.push({idx:'57',title:'용학도서관', tel : '053-668-1700', point:{x:'35.821253',y:'128.6461284'}, address:'대구광역시 수성구 지범로41길 36',no:'3' });
		daegu_map_data.push({idx:'56',title:'고산도서관', tel : '053-668-1900', point:{x:'35.8379053106723',y:'128.710632720214'}, address:'대구광역시 수성구 달구벌대로650길 6(신매동)',no:'4' });
		daegu_map_data.push({idx:'55',title:'파동도서관', tel : '053-668-1801', point:{x:'35.8104539258976',y:'128.618146184099'}, address:'대구광역시 수성구 파동로3길 62 파동평생학습센터 1층',no:'5' });
		daegu_map_data.push({idx:'54',title:'무학숲도서관', tel : '053-668-1821', point:{x:'35.8352614435461',y:'128.630574771678'}, address:'대구광역시 수성구 청수로40길 73-10(지산동)',no:'6' });
		daegu_map_data.push({idx:'53',title:'책숲길도서관', tel : '053-668-1650', point:{x:'35.8448425307153',y:'128.612376649774'}, address:'대구광역시 수성구 수성로215(중동) 수옥빌딩 4층',no:'7' });
		daegu_map_data.push({idx:'52',title:'물망이도서관', tel : '053-666-4390', point:{x:'35.8547657653853',y:'128.619007545444'}, address:'대구광역시 수성구 명덕로 443-2(수성동3가) 수성2,3가동 행정복지센터 4층',no:'8' });
		daegu_map_data.push({idx:'51',title:'황금책문화센터도서관', tel : '053-792-8582', point:{x:'35.8470347',y:'128.6237032'}, address:'대구광역시 수성구 청솔로2길 64 황금2동행정복지센터 1층',no:'9' });
		daegu_map_data.push({idx:'50',title:'수성못그림책도서관', tel : '053-668-1770', point:{x:'35.8294627',y:'128.6206166'}, address:'대구광역시 수성구 무학로 112, 1층',no:'10' });
	
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