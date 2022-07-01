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
		<div class="custom_mapcontrol"><a href="/dgportal/dalseogu/dalseogumap.html" target="_blank">&nbsp;</a></div>
	</div>
</div>

<div class="library-info-box">
	<ul>
		<!-- -->
		<li>
			<div class="info-box">
				<div class="tit num01">
					<p>대구광역시립두류도서관</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 달서구 공원순환로 8 (두류동)</p>
					<p class="tel">053-231-2700</p>
				</div>
			</div>
		</li>
		<!-- mg-->
		<li class="mg">
			<div class="info-box">
				<div class="tit num02">
					<p>성서도서관</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 달서구 선원남로 129 (이곡동)</p>
					<p class="tel">053-667-4900</p>
				</div>
			</div>
		</li>
		<!-- -->
		<li>
			<div class="info-box">
				<div class="tit num03">
					<p>달서어린이도서관</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 달서구 송현로 45<br />(상인동)</p>
					<p class="tel">053-667-4860</p>
				</div>
			</div>
		</li>
		<!-- -->
		<li>
			<div class="info-box">
				<div class="tit num04">
					<p>도원도서관</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 달서구 한실로 113<br />(도원동)</p>
					<p class="tel">053-667-4840</p>
				</div>
			</div>
		</li>
		<!-- mg-->
		<li class="mg">
			<div class="info-box">
				<div class="tit num05">
					<p>본리도서관</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 달서구 당산로 37-25 (본리동)</p>
					<p class="tel">053-667-4930</p>
				</div>
			</div>
		</li>
		<!-- -->
		<li>
			<div class="info-box">
				<div class="tit num06">
					<p>달서가족문화도서관</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 달서구 조암남로 137 (대천동)</p>
					<p class="tel">053-667-4970</p>
				</div>
			</div>
		</li>
		<!-- -->
		<li>
			<div class="info-box">
				<div class="tit num07">
					<p>달서영어도서관</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 달서구 중흥로 6길 10 (송현동)</p>
					<p class="tel">053-667-4950</p>
				</div>
			</div>
		</li>
		<!-- mg-->
		<li class="mg">
			<div class="info-box">
				<div class="tit num08">
					<p>이곡2동작은도서관</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 달서구 계대동문로77 (이곡동 1191-3)</p>
					<p class="tel">053-667-4368</p>
				</div>
			</div>
		</li>
		<!-- -->
		<li>
			<div class="info-box">
				<div class="tit num09">
					<p>용산1동작은도서관</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 달서구 용산로212-7 (용산동 934-6)</p>
					<p class="tel">053-667-4279</p>
				</div>
			</div>
		</li>
		<!-- -->
		<li>
			<div class="info-box">
				<div class="tit num10">
					<p>장기동작은도서관</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 달서구 장기로277 (장기동 817-2)</p>
					<p class="tel">053-667-4244</p>
				</div>
			</div>
		</li>
		<!-- mg-->
		<li class="mg">
			<div class="info-box">
				<div class="tit num11">
					<p>죽전동작은도서관</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 달서구 와룡로54길 28 (죽전동 204-12)</p>
					<p class="tel">053-667-4214</p>
				</div>
			</div>
		</li>
		<!-- -->
		<li>
			<div class="info-box">
				<div class="tit num12">
					<p>달서아트센터도서관</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 달서구 문화회관길160 (장기동 722-1)</p>
					<p class="tel">053-584-9274</p>
				</div>
			</div>
		</li>
		<!-- -->
		<li>
			<div class="info-box">
				<div class="tit num13">
					<p>행정정보문고센터</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 달서구 학산로 45 (월성동 281)</p>
					<p class="tel">053-667-4815</p>
				</div>
			</div>
		</li>
		<!-- mg-->
		<li class="mg">
			<div class="info-box">
				<div class="tit num14">
					<p>학산작은도서관</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 달서구 학산로 140(본동 804-2)</p>
					<p class="tel">053-721-8970</p>
				</div>
			</div>
		</li>
		<!-- -->
		<li>
			<div class="info-box">
				<div class="tit num15">
					<p>대구학생문화센터</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 달서구 용산로 181 대구학생문화센터 2층</p>
					<p class="tel">053-231-1254</p>
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
	
	optionss.x='35.8526137879105';
	optionss.y='128.560435130444';

	daegu_map_data.push({idx:'59',title:'대구광역시립두류도서관', tel : '053-231-2700', point:{x:'35.8526137879105',y:'128.560435130444'}, address:'대구광역시 달서구 공원순환로 8',no:'1' });
	daegu_map_data.push({idx:'58',title:'성서도서관', tel : '053-667-4900', point:{x:'35.8574115335529',y:'128.514459232431'}, address:'대구광역시 달서구 선원남로 129 (이곡동)',no:'2' });
	daegu_map_data.push({idx:'57',title:'달서어린이도서관', tel : '053-667-4860', point:{x:'35.8224803563508',y:'128.547014357069'}, address:'대구광역시 달서구 송현로 45(상인동)',no:'3' });
	daegu_map_data.push({idx:'56',title:'도원도서관', tel : '053-667-4840', point:{x:'35.8067933787751',y:'128.5390485116'}, address:'대구광역시 달서구 한실로 113(도원동)',no:'4' });
	daegu_map_data.push({idx:'55',title:'본리도서관', tel : '053-667-4930', point:{x:'35.8405592500203',y:'128.541813956432'}, address:'대구광역시 달서구 당산로 37-25(본리동)',no:'5' });
	daegu_map_data.push({idx:'54',title:'달서가족문화도서관', tel : '053-667-4970', point:{x:'35.8174869853999',y:'128.519186842697'}, address:'대구광역시 달서구 조암남로 137 (대천동)',no:'6' });
	daegu_map_data.push({idx:'53',title:'달서영어도서관', tel : '053-667-4950', point:{x:'35.831256500065',y:'128.555213095042'}, address:'대구광역시 달서구 중흥로 6길 10 (송현동)',no:'7' });
	daegu_map_data.push({idx:'52',title:'이곡2동작은도서관', tel : '053-667-4368', point:{x:'35.8557547032754',y:'128.500776149161'}, address:'대구광역시 달서구 계대동문로77 (이곡동 1191-3)',no:'8' });
	daegu_map_data.push({idx:'51',title:'용산1동작은도서관', tel : '053-667-4279', point:{x:'35.8566624983138',y:'128.531223930229'}, address:'대구광역시 달서구 용산로212-7 (용산동 934-6)',no:'9' });
	daegu_map_data.push({idx:'49',title:'장기동작은도서관', tel : '053-667-4244', point:{x:'35.8433491694642',y:'128.529974709497'}, address:'대구광역시 달서구 장기로277 (장기동 817-2)',no:'10' });
	daegu_map_data.push({idx:'48',title:'죽전동작은도서관', tel : '053-667-4214', point:{x:'35.8557951418932',y:'128.539806645735'}, address:'대구광역시 달서구 와룡로54길 28 (죽전동 204-12)',no:'11' });
	daegu_map_data.push({idx:'47',title:'달서아트센터도서관', tel : '053-584-9274', point:{x:'35.843422578812',y:'128.522826730437'}, address:'대구광역시 달서구 문화회관길160 (장기동 722-1) ',no:'12' });
	daegu_map_data.push({idx:'46',title:'행정정보문고센터', tel : '053-667-4815', point:{x:'35.8295250192427',y:'128.532293871771'}, address:'대구광역시 달서구 학산로 45 (월성동 281)',no:'13' });
	daegu_map_data.push({idx:'45',title:'학산작은도서관', tel : '053-721-8970', point:{x:'35.8332859011084',y:'128.541804663116'}, address:'대구광역시 달서구 학산로 140(본동 804-2)',no:'14' });
	daegu_map_data.push({idx:'44',title:'대구학생문화센터', tel : '053-231-1254', point:{x:'35.8530407',y:'128.5294985'}, address:'대구광역시 달서구 용산로 181 대구학생문화센터 2층',no:'15' });

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