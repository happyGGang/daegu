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
.tour2map1layer1 .text1{font-size:14px !important;padding-bottom:20px !important;color:rgba(255,255,255,0.8) !important;}

@media all and (min-width: 768px) and (max-width: 1023px) {
	.map_bg {height: auto;}
}

@media all and (max-width: 767px) {
	.map_bg {height: auto;}
}
</style>

<link rel="stylesheet" type="text/css" href="/resources/common/css/locationMap.css"/>

<div class="center" style="margin-bottom:30px;">
	<a href="https://library.daegu.go.kr/nearbylib/intro/search/index.do?menu_idx=20#search_result" class="btn_link02 newWin" title="자료검색 바로 가기"><span>자료검색 바로 가기</span><span class="ico ico_link"></span><i class="fa fa-external-link"></i></a>  
</div>

<div class="map_wrap">
	<div id="daegu_map" class="daegu_map">
		<div class="custom_mapcontrol"><a href="/dgportal/bukgu/bukgumap.html" target="_blank">&nbsp;</a></div>
	</div>
</div>

<div class="tab_menu on" style="margin-top:20px;">
	<ul class="no3">
	  <li class="active"><a href="#tabCon1">연경지구 CGV</a></li>
	  <li><a href="#tabCon2">이시아폴리스 메가박스</a></li>
	  <li><a href="#tabCon3">반야월 이마트</a></li>
	</ul>
</div>

<div class="tabConts" id="tabCon1" style="display:block">
	연경지구 CGV
</div>

<div class="tabConts" id="tabCon2">
	이시아폴리스 메가박스
</div>

<div class="tabConts" id="tabCon3">
	반야월 이마트
</div>



<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=93baba79f6b6154b2068eb7550666f5f&libraries=services,clusterer"></script>
<script type="text/javascript" src="/resources/common/js/daum_map_nearbylib_app.js"></script>
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

	daegu_map_data.push({idx:'59',title:'연경지구 CGV', tel:'1544-1122', point:{x:'35.9412785',y:'128.6227308'}, address:'북구 동화천로 290',no:'1' });
	daegu_map_data.push({idx:'58',title:'이시아폴리스 메가박스', tel:'1544-0070', point:{x:'35.9207316',y:'128.6357086'}, address:'동구 팔공로49길 51',no:'2' });
	daegu_map_data.push({idx:'57',title:'반야월 이마트', tel:'053-665-1234', point:{x:'35.8708661',y:'128.7274592'}, address:'동구 안심로 389-2',no:'3' });

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
		//map.setCenter(marker.getPosition());
		map.panBy(0, -100);
	} 
	/* ]add overlay */

	daegu_map.init('daegu_map', optionss, daegu_map_data);
});
/*]]>*/
</script>