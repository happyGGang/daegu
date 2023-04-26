<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
function copyToClipboard(s) {
	var $temp = jQuery("<input>");
	jQuery("body").append($temp);
	$temp.val(s).select();
	document.execCommand("copy");
	$temp.remove();
	alert('복사되었습니다.');
}
$(document).ready(function() {
$.get('../calendar9.do?manageCode=HR', function(data) {
var li = '<li>등록된 휴관일이 없습니다.</li>';
if (data && data.length > 0) {
li = '';
$.each(data, function(i, v) {
li += ('<li>'+v+'</li>');
});
}
$('ul.close_day').html(li);
});
})
</script>

<div class="doc-body">
  <h3>이용시간</h3>
  <div class="time_box">
    <ul>
      <li class="book13 mb10" style="margin-right:20px;">
      <div> <span>평일 09:00 ~ 18:00</span> </div>
      </li>
      <li class="book11 mb10">
      <div> <span>주말 09:00 ~ 17:00</span> </div>
      </li>
      <li class="book08" style="width:100%;">
      <div>
        <span class="month_info">이번달 휴관일은</span>
        <ul class="close_day">
          <li>불러오는 중...</li>
        </ul>
        <span>일 입니다.</span>
        <p>월요일과 공휴일은 휴관입니다.</p>
      </div>
      </li>
    </ul>
  </div>
  <h3>주제별 자료현황<span class="sm_text sm_text02" style="margin-top:10px;">(단위 : 권)</span></h3>
  <div class="rsv-info"></div>
  <div class="auto-scroll">
    <table class="tbl-type01" summary="주제별 자료현황을 나타내는 표">
    <caption class="disnone">
    주제별 자료현황
    </caption>
    <colgroup>
    <col width="*">
    <col width="8%">
    <col width="8%">
    <col width="8%">
    <col width="8%">
    <col width="8%">
    <col width="8%">
    <col width="8%">
    <col width="8%">
    <col width="8%">
    <col width="8%">
    <col width="8%">
    </colgroup>
    <thead>
    <tr>
      <th>구 분</th>
      <th>총류</th>
      <th>철학</th>
      <th>종교</th>
      <th>사회<br>
      과학</th>
      <th>자연<br>
      과학</th>
      <th>기술<br>
      과학</th>
      <th>예술</th>
      <th>언어</th>
      <th>문학</th>
      <th>역사</th>
      <th>총계</th>
    </tr>
    </thead>
    <tbody>
    <tr>
      <th>권수</th>
    <td>201</td>
    <td>181</td>
    <td>102</td>
    <td>495</td>
    <td>323</td>
    <td>337</td>
    <td>256</td>
    <td>267</td>
    <td>2,717</td>
    <td>448</td>
    <td>5,327</td>
    </tr>
    <tr>
      <th>비율</th>
    <td>3.7</td>
    <td>3.4</td>
    <td>2</td>
    <td>9.3</td>
    <td>6.1</td>
    <td>6.3</td>
    <td>4.8</td>
    <td>5</td>
    <td>51</td>
    <td>8.4</td>
    <td>100</td>
    </tr>
    </tbody>
    </table>
  </div>
  <h3>별치기호별 자료현황<span class="sm_text sm_text02" style="margin-top:10px;">(단위 : 권)</span></h3>
  <div class="rsv-info"></div>
  <div class="auto-scroll">
    <table class="tbl-type01" summary="별치기호별 자료현황을 나타내는 표">
    <caption class="disnone">
    별치기호별 자료현황
    </caption>
    <colgroup>
    <col width="*">
    <col width="20%">
    <col width="20%">
    <col width="20%">
    <col width="20%">
    </colgroup>
    <thead>
    <tr>
      <th>구 분</th>
      <th>유아</th>
      <th>아동</th>
      <th>일반</th>
      <th>총계</th>
    </tr>
    </thead>
    <tbody>
    <tr>
      <th>권수</th>
    <td>1,082</td>
    <td>1,979</td>
    <td>2,266</td>
    <td>5,327</td>
    </tr>
    <tr>
      <th>비율</th>
    <td>20.3</td>
    <td>37.2</td>
    <td>42.5</td>
    <td>100</td>
    </tr>
    </tbody>
    </table>
  </div>
  <h3>간행물 현황<span class="sm_text sm_text02" style="margin-top:10px;">[2023.3.31. 기준] (단위 : 권)</span></h3>
  <div class="rsv-info"></div>
  <div class="auto-scroll">
    <table class="tbl-type01" summary="황금도서관 간행물 현황을 나타내는 표">
    <caption class="disnone">
    황금도서관 간행물 현황
    </caption>
    <colgroup>
    <col width="*">
    <col width="14.2%">
    <col width="14.2%">
    <col width="14.2%">
    <col width="14.2%">
    <col width="14.2%">
    <col width="14.2%">
    </colgroup>
    <thead>
    <tr>
      <th>구분</th>
      <th>신문</th>
      <th>주간</th>
      <th>격주간</th>
      <th>월간</th>
      <th>계간</th>
      <th>계</th>
    </tr>
    </thead>
    <tbody>
    <tr>
      <th>국내</th>
      <td>2</td>
      <td>2</td>
      <td>1</td>
      <td>13</td>
      <td>1</td>
      <td>19</td>
    </tr>
    </tbody>
    </table>
  </div>
  <h3>시설안내</h3>
  <div class="rsv-info"></div>
  <div class="auto-scroll">
    <table class="tbl-type01" summary="책숲길도서관의 시설안내를 나타내는 표">
    <caption class="disnone">
    책숲길도서관의 시설안내
    </caption>
    <colgroup>
    <col width="20%">
    <col width="*">
    <col width="30%">
    </colgroup>
    <thead>
    <tr>
      <th scope="col">층별</th>
      <th scope="col">공간구성</th>
      <th scope="col">면적(㎡)</th>
    </tr>
    </thead>
    <tbody>
    <tr>
      <th scope="row" rowspan="4">1층</th>
      <td>자료실</td>
      <td>333.42</td>
    </tr>
    <tr>
      <td>사무실 및 프로그램실</td>
      <td>37.54</td>
    </tr>
    <tr>
      <td>기타공간(복도 및 화장실)</td>
      <td>108.85</td>
    </tr>
    <tr>
      <td>총면적</td>
      <td>479.81</td>
    </tr>
    </tbody>
    </table>
  </div>
  <h3>위치안내</h3>
  <link rel="stylesheet" href="/resources/common/css/emap/OpenLayers-6.4.3.css" type="text/css">
	<script src="https://cdn.polyfill.io/v2/polyfill.min.js?features=requestAnimationFrame,Element.prototype.classList,URL"></script>
	<script type="text/javascript" src="/resources/common/js/emap/OpenLayers-6.4.3.js"></script>
	<script type="text/javascript" src="/resources/common/js/emap/proj4.js"></script>
	<script type="text/javascript" src="/resources/common/js/emap/wmts_ngiiMap_v6.4.3.js?apikey=2375C203D51981F12172FEAB7D7AFD44"></script>
	<script>
	var map1;
	window.onload = function(){
		map1 = new ngii_wmts.map("map1",{mapMode:3});
		map1._setMapMode('0');
		map1._showpoint(1101481.5443, 1761780.5808,7);
	}
	;
	</script>

	<div class="mapWrap" style="position:relative;">
	  <div id="map1" style="width:100%;height:500px;"></div>
	  <ul class="map-btn">
		<li><a href="javascript:ngii_wmts.findMapObject(0)._setMapMode('0');">일반</a></li>
		<li><a href="javascript:ngii_wmts.findMapObject(0)._setMapMode('1');">색약</a></li>
		<li><a href="javascript:ngii_wmts.findMapObject(0)._setMapMode('2');">큰글</a></li>
		<li class="img-li"><a href="javascript:map1.zoomIn();"><img src="/resources/common/img/map-plus-icon.png" alt="지도 확대 버튼" title="지도 확대 버튼"></a></li>
		<li class="img-li"><a href="javascript:map1.zoomOut();"><img src="/resources/common/img/map-minus-icon.png" alt="지도 축소 버튼" title="지도 축소 버튼"></a></li>
	  </ul>
	</div>

  <div class="info_box">
    <p class="info_add">대구광역시 수성구 청솔로2길 64 황금2동행정복지센터 1층</p>
    <p class="info_tel">053-668-1660</p>
  </div>
  
  <h3>교통편 안내</h3>
  <h4>주변 지하철역</h4>
  <ul>
    <li><span class="ico_subway3" style="font-size:11px;">어린이회관</span>1번 출구</li>
  </ul>
  <h4>주변 버스정류장<span class="sm_text">버스번호를 클릭하시면 노선도를 검색하실 수 있습니다.</span></h4>
  <ul class="bus_list">
    <li><a href="http://businfo.daegu.go.kr/ba/index/index.do" target="_blank" class="newWin" title="새창으로 열립니다."><span class="ico_bus_m">간선<span class="num">100</span></span><i class="fa fa-external-link"></i></a></li>
    <li><a href="http://businfo.daegu.go.kr/ba/index/index.do" target="_blank" class="newWin" title="새창으로 열립니다."><span class="ico_bus_m">간선<span class="num">204</span></span><i class="fa fa-external-link"></i></a></li>
    <li><a href="http://businfo.daegu.go.kr/ba/index/index.do" target="_blank" class="newWin" title="새창으로 열립니다."><span class="ico_bus_m">간선<span class="num">234</span></span><i class="fa fa-external-link"></i></a></li>
    <li><a href="http://businfo.daegu.go.kr/ba/index/index.do" target="_blank" class="newWin" title="새창으로 열립니다."><span class="ico_bus_m">간선<span class="num">814</span></span><i class="fa fa-external-link"></i></a></li>
    <li><a href="http://businfo.daegu.go.kr/ba/index/index.do" target="_blank" class="newWin" title="새창으로 열립니다."><span class="ico_bus_m">간선<span class="num">8140</span></span><i class="fa fa-external-link"></i></a></li>
    <li><a href="http://businfo.daegu.go.kr/ba/index/index.do" target="_blank" class="newWin" title="새창으로 열립니다."><span class="ico_bus_j">지선<span class="num">수성1</span></span><i class="fa fa-external-link"></i></a></li>
    <li><a href="http://businfo.daegu.go.kr/ba/index/index.do" target="_blank" class="newWin" title="새창으로 열립니다."><span class="ico_bus_j">지선<span class="num">수성1-1</span></span><i class="fa fa-external-link"></i></a></li>
    <li><a href="http://businfo.daegu.go.kr/ba/index/index.do" target="_blank" class="newWin" title="새창으로 열립니다."><span class="ico_bus_g">급행<span class="num">급행3</span></span><i class="fa fa-external-link"></i></a></li>
    <div class="clear"></div>
  </ul>
  <p class="basic_btn">
	<a href="https://businfo.daegu.go.kr:8095/dbms_web/content/businfo/lowfloorbus" class="btn_go newWin" target="_blank" title="저상버스 운행정보 바로가기(새창열림)"> <span>저상버스 운행정보 바로가기</span> <i class="fa fa-external-link"></i></a>
  </p>

  <h3>자가용 이용시</h3>
  <ul class="con">
    <li>시내방향에서 오시는 경우: 달구벌대로를 따라 이동 후 범어네거리에서 ‘수성구민운동장’ 방면으로 900m 지점 우회전 한 뒤, 어린이회관삼거리에서 1.4km 지점 우회전 한 뒤, ‘청솔로4길‘ 방면으로 700m 지점</li>
    <li>시지, 사월역 오시는 경우: 달구벌대로로 따라 범어네거리에서  ‘어린이회관’ 방면으로 좌회전 한 뒤, ‘청솔로4길’ 방면으로 좌회전한 후 700m 지점</li>
    <li>지산동 방향에서 오시는 경우: ‘희망교’ 방면으로 좌회전 한 뒤, 241m 지점 우회전 한 뒤, 77m ‘청솔로 2길’ 방면으로 우회전한 후 100m 지점에서 우회전</li>
  </ul>

  <h3>휠체어 사용시 소요시간</h3>
  <ul class="con">
    <li>어린이회관건너1(길건너 분): 100-1, 234, 814, 8140, 수성1-1, 급행3</li>
    <li>어린이회관건너2(길건너 10분): 204</li>
  </ul>
</div>