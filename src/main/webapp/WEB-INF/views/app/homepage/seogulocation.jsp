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
		<div class="custom_mapcontrol"><a href="/dgportal/seogu/seogumap.html" target="_blank">&nbsp;</a></div>
	</div>
</div>

<div class="library-info-box">
	<ul>
		<!-- -->
		<li>
			<div class="info-box">
				<div class="tit num01">
					<p>대구광역시립서부도서관</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 서구 국채보상로49길 12</p>
					<p class="tel">053-231-2400<br><br></p>
				</div>
			</div>
		</li>
		<!-- mg-->
		<li class="mg">
			<div class="info-box">
				<div class="tit num02">
					<p>서구어린이도서관</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 서구 문화로 123<br />(이현동)</p>
					<p class="tel">053-663-3701</p>
				</div>
			</div>
		</li>
		<!-- -->
		<li>
			<div class="info-box">
				<div class="tit num03">
					<p>비산도서관</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 서구 달서로 14길 13<br />(비산동)</p>
					<p class="tel">053-663-3721</p>
				</div>
			</div>
		</li>
		<!-- -->
		<li>
			<div class="info-box">
				<div class="tit num04">
					<p>서구영어도서관</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 서구 평리로 35길 90-6</p>
					<p class="tel">053-663-3861</p>
				</div>
			</div>
		</li>
		<!-- mg-->
		<li class="mg">
			<div class="info-box">
				<div class="tit num05">
					<p>비원도서관</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 서구 달서천로 61안길 10</p>
					<p class="tel">053-663-3873</p>
				</div>
			</div>
		</li>
		<!-- -->
		<li>
			<div class="info-box">
				<div class="tit num06">
					<p>원고개도서관</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 서구 달서로 43길 12</p>
					<p class="tel">053-231-3941</p>
				</div>
			</div>
		</li>
		<!-- -->
		<li>
			<div class="info-box">
				<div class="tit num07">
					<p>New평리도서관</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 서구 평리로73길 37</p>
					<p class="tel">053-663-3881<br><br></p>
				</div>
			</div>
		</li>
		<!-- mg-->
		<li class="mg">
			<div class="info-box">
				<div class="tit num08">
					<p>내당2.3동드림도서관</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 서구 달서로5길 31-1(내당2·3동)</p>
					<p class="tel">053-521-9100</p>
				</div>
			</div>
		</li>
		<!-- -->
		<li>
			<div class="info-box">
				<div class="tit num09">
					<p>내당4동어린이도서관</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 서구 서대구로3길46 (내당4동)(2층)</p>
					<p class="tel">053-663-4234</p>
				</div>
			</div>
		</li>
		<!-- -->
		<li>
			<div class="info-box">
				<div class="tit num10">
					<p>비산7동작은도서관</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 서구 서대구로63안길 30-22(비산동)</p>
					<p class="tel">053-663-3649</p>
				</div>
			</div>
		</li>
		<!-- mg-->
		<li class="mg">
			<div class="info-box">
				<div class="tit num11">
					<p style="font-size:98%;">새마을문고대구서구지부작은도서관</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 서구 평리로35길 90-6(영어도서관 2층)</p>
					<p class="tel">053-554-5163</p>
				</div>
			</div>
		</li>
		<!-- -->
		<li>
			<div class="info-box">
				<div class="tit num12">
					<p>서구청작은도서관</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 서구 국채보상로 257(평리동)</p>
					<p class="tel">053-663-3637</p><br>
				</div>
			</div>
		</li>
		<!-- -->
		<li>
			<div class="info-box">
				<div class="tit num13">
					<p>달성토성마을다락방작은도서관</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 서구 국채보상로83길 21(비산2.3동)</p>
					<p class="tel">053-663-3645</p>
				</div>
			</div>
		</li>
		<!-- mg-->
		<li class="mg">
			<div class="info-box">
				<div class="tit num14">
					<p style="font-size:98%;">서구어린이영어도서관</p>
				</div>
				<div class="txt">
					<p class="add">대구광역시 서구 문화로 160</p>
					<p class="tel">053-663-3951</p><br>
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
	
	optionss.x='35.8578027577781';
	optionss.y='128.539097820561';

	daegu_map_data.push({idx:'59',title:'대구광역시립서부도서관', tel : '053-231-2449', point:{x:'35.8578027577781',y:'128.539097820561'}, address:'대구광역시 달서구 죽전1길 176 (구.죽전중) 2층',no:'1' });
	daegu_map_data.push({idx:'58',title:'서구어린이도서관', tel : '053-663-3701', point:{x:'35.8742787980867',y:'128.546380223162'}, address:'대구광역시 서구 문화로 123',no:'2' });
	daegu_map_data.push({idx:'57',title:'비산도서관', tel : '053-663-3721', point:{x:'35.8685788218055',y:'128.57331647507'}, address:'대구광역시 서구 달서로 14길 13',no:'3' });
	daegu_map_data.push({idx:'56',title:'서구영어도서관', tel : '053-663-3861', point:{x:'35.867878',y:'128.544274'}, address:'대구광역시 서구 평리로 35길 90-6',no:'4' });
	daegu_map_data.push({idx:'55',title:'비원도서관', tel : '053-663-3873', point:{x:'35.8860881575549',y:'128.569284590416'}, address:'대구광역시 서구 달서천로 61안길 10',no:'5' });
	daegu_map_data.push({idx:'54',title:'원고개도서관', tel : '053-663-3942', point:{x:'35.8818789923792',y:'128.570797020986'}, address:'대구광역시 서구 달서로 43길 12',no:'6' });
	daegu_map_data.push({idx:'53',title:'New평리도서관', tel : '053-521-9100', point:{x:'35.8678139',y:'128.5620383'}, address:'대구광역시 서구 평리로73길 37',no:'7' });
	daegu_map_data.push({idx:'53',title:'내당2.3동드림도서관', tel : '053-521-9100', point:{x:'35.8643313624622',y:'128.568756874411'}, address:'대구광역시 서구 달서로5길 31-1(내당2·3동)',no:'8' });
	daegu_map_data.push({idx:'52',title:'내당4동어린이도서관', tel : '053-663-4234', point:{x:'35.8590204867088',y:'128.551843118421'}, address:'대구광역시 서구 서대구로3길46 (내당4동)(2층)',no:'9' });
	daegu_map_data.push({idx:'51',title:'비산7동작은도서관', tel : '053-663-3649', point:{x:'35.8858973495298',y:'128.553897616805'}, address:'대구광역시 서구 서대구로63안길 30-22(비산동)',no:'10' });
	daegu_map_data.push({idx:'49',title:'<span style="font-size:85%;">새마을문고대구서구지부작은도서관</span>', tel : '053-663-3865', point:{x:'35.867994',y:'128.544266'}, address:'대구광역시 서구 평리로35길 90-6(영어도서관 2층)',no:'11' });
	daegu_map_data.push({idx:'48',title:'서구청작은도서관', tel : '053-663-3637', point:{x:'35.8723219470535',y:'128.559289496989'}, address:'대구광역시 서구 국채보상로 257(평리동)',no:'12' });
	daegu_map_data.push({idx:'50',title:'<span style="font-size:95%;">달성토성마을다락방작은도서관</span>', tel : '053-663-3645', point:{x:'35.8733150060675',y:'128.575372901347'}, address:'대구광역시 서구 국채보상로83길 21(비산2.3동)',no:'13' });
	daegu_map_data.push({idx:'60',title:'<span style="font-size:95%;">서구어린이영어도서관</span>', tel : '053-663-3951', point:{x:'35.874317',y:'128.550486'}, address:'대구광역시 서구 문화로 160',no:'14' });

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