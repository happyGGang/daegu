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
		<div class="custom_mapcontrol"><a href="/dgportal/donggu/donggumap.html" target="_blank">&nbsp;</a></div>
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
					<p class="add">동구 아양로41길 56</p>
					<p class="tel">053-231-2841</p>
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
					<p class="add">동구 금호강변로 360</p>
					<p class="tel">053-980-2600</p>
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
					<p>율하북작은도서관</p>
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
					<p>동일도서관</p>
				</div>
				<div class="txt">
					<p class="add">동구 동촌로 374-3</p>
					<p class="tel">053-755-6003</p>
				</div>
			</div>
		</li>
		<!-- mg-->
		<li class="mg">
			<div class="info-box">
				<div class="tit num23">
					<p>한들마을도서관</p>
				</div>
				<div class="txt">
					<p class="add">동구 팔공로101길 47</p>
					<p class="tel">053-985-1513</p>
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
	
		optionss.x='35.8901537';
		optionss.y='128.6216009';

		daegu_map_data.push({idx:'59',title:'대구광역시립동부도서관', tel : '053-231-2200', point:{x:'35.8901537',y:'128.6216009'}, address:'대구광역시 동구 신암북로 11길 54',no:'1' });
	
		daegu_map_data.push({idx:'58',title:'대구2ㆍ28기념학생도서관', tel : '053-980-2600', point:{x:'35.8905698',y:'128.6337372'}, address:'대구광역시 동구 금호강변로 360',no:'2' });
	
		daegu_map_data.push({idx:'57',title:'대구안심도서관', tel : '053-231-2841', point:{x:'35.864646',y:'128.7025332'}, address:'대구광역시 동구 아양로41길 56',no:'3' });
	
		daegu_map_data.push({idx:'56',title:'대구신천도서관', tel : '053-980-2600', point:{x:'35.871436',y:'128.617776'}, address:'대구광역시 동구 동부로6길 65',no:'4' });
	
		daegu_map_data.push({idx:'55',title:'신암2동작은도서관', tel : '053-662-3633', point:{x:'35.8799695',y:'128.6127068'}, address:'대구광역시 동구 신성로 56(신암2동행정복지센터 2층)',no:'5' });
	
		daegu_map_data.push({idx:'54',title:'신암3동작은도서관', tel : '070-7755-5631', point:{x:'35.8810491',y:'128.6188883'}, address:'대구광역시 동구 아양로8길 10-1 (동구여성문화공간 3층)',no:'6' });

		daegu_map_data.push({idx:'42',title:'신암5동작은도서관', tel : '053-662-3485', point:{x:'35.8897559',y:'128.6330629'}, address:'대구광역시 동구 아양로37길 92(신암5동주민센터 2층)',no:'7' });
	
		daegu_map_data.push({idx:'53',title:'신천3동작은도서관', tel : '053-662-3734', point:{x:'35.8753917',y:'128.6237458'}, address:'대구광역시 동구 장등로 90(신천3동 행정복지센터 3층)',no:'8' });
	
		daegu_map_data.push({idx:'52',title:'효목1동작은도서관', tel : '053-662-3775', point:{x:'35.8816142',y:'128.6449448'}, address:'대구광역시 동구 화랑로41길 46(효목1동 행정복지센터 2층)',no:'9' });
	
		daegu_map_data.push({idx:'51',title:'효목2동작은도서관', tel : '053-662-3794', point:{x:'35.8781522',y:'128.6412466'}, address:'대구광역시 동구 화랑로 25길 45(효목2동 행정복지센터 1층)',no:'10' });
	
		daegu_map_data.push({idx:'49',title:'도평동작은도서관', tel : '053-662-3810', point:{x:'35.9100034',y:'128.6500078'}, address:'대구광역시 동구 팔공로24길 171(도평동 행정복지센터 3층)',no:'11' });
	
		daegu_map_data.push({idx:'48',title:'불로어울림작은도서관', tel : '070-4214-0007', point:{x:'35.909725',y:'128.6415999'}, address:'대구광역시 동구 팔공로24길 5(불로전통시장 상인교육관 3층)',no:'12' });
	
		daegu_map_data.push({idx:'47',title:'지저동작은도서관', tel : '070-7755-5633', point:{x:'35.8934142',y:'128.6383092'}, address:'대구광역시 동구 해동로3길 80(지저동 행정복지센터 3층)',no:'13' });

		daegu_map_data.push({idx:'46',title:'동촌역사작은도서관', tel : '070-4214-6859', point:{x:'35.8903035',y:'128.6501713'}, address:'대구 동구 동촌역사로 3길 35',no:'14' });
	
		daegu_map_data.push({idx:'45',title:'방촌동작은도서관', tel : '070-4251-5854', point:{x:'35.8813411',y:'128.664457'}, address:'대구 동구 동촌로46길 2(방촌종합상가 2층)',no:'15' });
	
		daegu_map_data.push({idx:'44',title:'해안동작은도서관', tel : '070-7755-5632', point:{x:'35.8820761',y:'128.6716797'}, address:'대구광역시 동구 방촌로 29길 46 (해안동 행정복지센터 3층)',no:'16' });
	
		daegu_map_data.push({idx:'43',title:'반야월역사작은도서관', tel : '053-662-4110', point:{x:'35.8724796',y:'128.7254918'}, address:'대구광역시 동구 신서로 50(대구선2공원 내 철도역사 1동)',no:'17' });
	
		//daegu_map_data.push({idx:'39',title:'초록우산 도서관', tel : '053-964-3335', point:{x:'35.8698335',y:'128.709637'}, address:'대구광역시 동구 율하동로 26길 67(대구종합사회복지관)',no:'18' });
	
		daegu_map_data.push({idx:'41',title:'늘푸른작은도서관', tel : '053-983-8211', point:{x:'35.8935022',y:'128.6451719'}, address:'대구광역시 동구 입석로 5(동촌종합사회복지관)',no:'18' });
	
		daegu_map_data.push({idx:'38',title:'꿈날자문고작은도서관', tel : '053-247-0755', point:{x:'35.8702298',y:'128.7259751'}, address:'대구광역시 동구 안심로73길 22(롯데캐슬 레전드관리사무소)',no:'19' });

		daegu_map_data.push({idx:'37',title:'행복작은도서관', tel : '053-755-9392', point:{x:'35.8702091',y:'128.6213122'}, address:'대구광역시 동구 송라로2길17-6(제일기독종합사회복지관)',no:'20' });
	
		daegu_map_data.push({idx:'35',title:'율하북작은도서관', tel : '053-965-5955', point:{x:'35.8640922',y:'128.6920047'}, address:'대구광역시 동구 율하서로59(율하휴먼시아5단지 관리실)',no:'21' });
	
		daegu_map_data.push({idx:'35',title:'동일도서관', tel : '053-755-6003', point:{x:'35.8764604',y:'128.6800965'}, address:'대구광역시 동구 동촌로 374-3',no:'22' });
	
		daegu_map_data.push({idx:'34',title:'한들마을도서관', tel : '053-985-1513', point:{x:'35.941557',y:'128.6425066'}, address:'대구광역시 동구 팔공로101길 47',no:'23' });
	
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