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
$.get('../calendar9.do?manageCode=BK', function(data) {
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
        <p>일요일과 공휴일은 휴관입니다.</p>
      </div>
      </li>
    </ul>
  </div>
  <h3>자료현황<span class="sm_text sm_text02" style="margin-top:10px;">[2022.4.30. 기준] (단위 : 권)</span></h3>
  <div class="rsv-info"></div>
  <div class="auto-scroll">
    <table class="tbl-type01" summary="물망이도서관 장서현황을 나타내는 표">
    <caption class="disnone">
    물망이도서관 장서현황
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
    <col width="8%">
    </colgroup>
    <thead>
    <tr>
      <th>구 분</th>
      <th>000<br>
      총류</th>
      <th>100<br>
      철학</th>
      <th>200<br>
      종교</th>
      <th>300<br>
      사회<br>
      과학</th>
      <th>400<br>
      자연<br>
      과학</th>
      <th>500<br>
      기술<br>
      과학</th>
      <th>600<br>
      예술</th>
      <th>700<br>
      언어</th>
      <th>800<br>
      문학</th>
      <th>900<br>
      역사</th>
      <th>총계(권)</th>
      <th>비율(%)</th>
    </tr>
    </thead>
    <tbody>
    <tr>
      <th>일반</th>
    <td>269</td>
    <td>529</td>
    <td>172</td>
    <td>975</td>
    <td>352</td>
    <td>792</td>
    <td>276</td>
    <td>201</td>
    <td>2,754</td>
    <td>607</td>
    <td>6,927</td>
    <td>21.1</td>
    </tr>
    <tr>
      <th>아동</th>
    <td>737</td>
    <td>362</td>
    <td>255</td>
    <td>1,066</td>
    <td>1,425</td>
    <td>362</td>
    <td>352</td>
    <td>358</td>
    <td>5,342</td>
    <td>1,734</td>
    <td>11,993</td>
    <td>36.5</td>
    </tr>
    <tr>
      <th>유아</th>
    <td>28</td>
    <td>43</td>
    <td>7</td>
    <td>621</td>
    <td>256</td>
    <td>52</td>
    <td>105</td>
    <td>57</td>
    <td>2,590</td>
    <td>152</td>
    <td>3,911</td>
    <td>11.9</td>
    </tr>
    <tr>
      <th>영어</th>
    <td>114</td>
    <td>3</td>
    <td>6</td>
    <td>147</td>
    <td>245</td>
    <td>22</td>
    <td>39</td>
    <td>1,317</td>
    <td>1,836</td>
    <td>52</td>
    <td>3,781</td>
    <td>11.5</td>
    </tr>
    <tr>
      <th>보존서고 </th>
    <td>594</td>
    <td>210</td>
    <td>76</td>
    <td>989</td>
    <td>593</td>
    <td>184</td>
    <td>169</td>
    <td>160</td>
    <td>2,589</td>
    <td>722</td>
    <td>6,286</td>
    <td>19.1</td>
    </tr>
    <tr>
      <th>총계(권)</th>
    <td>1,742</td>
    <td>1,147</td>
    <td>516</td>
    <td>3,798</td>
    <td>2,871</td>
    <td>1,412</td>
    <td>941</td>
    <td>2,093</td>
    <td>15,111</td>
    <td>3,267</td>
    <td>32,898</td>
    <td>100</td>
    </tr>
    <tr>
      <th>비율(%)</th>
    <td>5.3</td>
    <td>3.5</td>
    <td>1.6</td>
    <td>11.5</td>
    <td>8.7</td>
    <td>4.3</td>
    <td>2.9</td>
    <td>6.4</td>
    <td>45.9</td>
    <td>9.9</td>
    <td>100</td>
    <td>　</td>
    </tr>
    </tbody>
    </table>
  </div>
  <h3>간행물 현황<span class="sm_text sm_text02" style="margin-top:10px;">[2022.4.30. 기준] (단위 : 권)</span></h3>
  <div class="rsv-info"></div>
  <div class="auto-scroll">
    <table class="tbl-type01" summary="물망이도서관 간행물 현황을 나타내는 표">
    <caption class="disnone">
    물망이도서관 간행물 현황
    </caption>
    <colgroup>
    <col width="*">
    <col width="13%">
    <col width="13%">
    <col width="13%">
    <col width="13%">
    <col width="13%">
    <col width="13%">
    <col width="13%">
    </colgroup>
    <thead>
    <tr>
      <th>구분</th>
      <th>신문</th>
      <th>주간</th>
      <th>격주간</th>
      <th>월간</th>
      <th>격월간</th>
      <th>계간</th>
      <th>계</th>
    </tr>
    </thead>
    <tbody>
    <tr>
      <th>국내</th>
      <td>3</td>
      <td>0</td>
      <td>1</td>
      <td>11</td>
      <td>0</td>
      <td>0</td>
      <td>15</td>
    </tr>
    </tbody>
    </table>
  </div>
  <h3>시설안내</h3>
  <div class="rsv-info"></div>
  <div class="auto-scroll">
    <table class="tbl-type01" summary="물망이도서관의 시설안내를 나타내는 표">
    <caption class="disnone">
    물망이도서관의 시설안내
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
      <th scope="row" rowspan="5">4층</th>
      <td>어린이 및 일반자료실</td>
      <td>181</td>
    </tr>
    <tr>
      <td>유아자료실</td>
      <td>17</td>
    </tr>
    <tr>
      <td>사무실 및 수서실</td>
      <td>30</td>
    </tr>
    <tr>
      <td>기타공간(복도 및 화장실)</td>
      <td>79</td>
    </tr>
    <tr>
      <td>총면적</td>
      <td>307</td>
    </tr>
    </tbody>
    </table>
  </div>
  <h3>위치안내</h3>
<link rel="stylesheet" type="text/css" href="/resources/common/css/locationMap.css"/>


<div class="map_wrap">
<div id="map" style="position:relative;border:1px solid #ebebeb;height:500px;">

<!-- 지도 확대, 축소 컨트롤 div 입니다 -->
<div class="custom_zoomcontrol radius_border"> 
<a href="#" onclick="zoomIn()"><img src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/ico_plus.png" alt="확대"></a>  
<a href="#" onclick="zoomOut()"><img src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/ico_minus.png" alt="축소"></a>
</div>
<div style="position:absolute;right:10px;bottom:10px;z-index:181818"><a href="https://map.kakao.com/link/to/물망이도서관, 35.85476577,128.6190075" class="btn btn4" target="_blank">길찾기</a></div>
</div>
</div>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=93baba79f6b6154b2068eb7550666f5f"></script> 
<script>
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
	mapOption = { 
	center: new daum.maps.LatLng(35.85476577,128.6190075), // 지도의 중심좌표
	level: 2 // 지도의 확대 레벨
	};

	var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

	// 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
	var mapTypeControl = new daum.maps.MapTypeControl();

	// 지도타입 컨트롤의 지도 또는 스카이뷰 버튼을 클릭하면 호출되어 지도타입을 바꾸는 함수입니다
	function setMapType(maptype) { 
	    var roadmapControl = document.getElementById('btnRoadmap');
	    var skyviewControl = document.getElementById('btnSkyview'); 
	    if (maptype === 'roadmap') {
		map.setMapTypeId(kakao.maps.MapTypeId.ROADMAP);    
		roadmapControl.className = 'selected_btn';
		skyviewControl.className = 'btn';
	    } else {
		map.setMapTypeId(kakao.maps.MapTypeId.HYBRID);    
		skyviewControl.className = 'selected_btn';
		roadmapControl.className = 'btn';
	    }
	}

	// 지도 확대, 축소 컨트롤에서 확대 버튼을 누르면 호출되어 지도를 확대하는 함수입니다
	function zoomIn() {
	    map.setLevel(map.getLevel() - 1);
	}

	// 지도 확대, 축소 컨트롤에서 축소 버튼을 누르면 호출되어 지도를 확대하는 함수입니다
	function zoomOut() {
	    map.setLevel(map.getLevel() + 1);
	}

	// 마커를 표시할 위치와 title 객체 배열입니다 
	var positions = [
	    {
		title: '물망이도서관', 
		latlng: new daum.maps.LatLng(35.85476577,128.6190075)
	    }
	];

	// 마커 이미지의 이미지 주소입니다
	var imageSrc = "http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
	    
	for (var i = 0; i < positions.length; i ++) {
	    
	    // 마커 이미지의 이미지 크기 입니다
	    var imageSize = new daum.maps.Size(24, 35); 
	    
	    // 마커 이미지를 생성합니다    
	    var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize); 
	    
	    // 마커를 생성합니다
	    var marker = new daum.maps.Marker({
		map: map, // 마커를 표시할 지도
		position: positions[i].latlng, // 마커를 표시할 위치
		title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
		image : markerImage // 마커 이미지 
	    });
	}
</script>



  <div class="info_box">
    <p class="info_add">대구광역시 수성구 명덕로 443-2(수성동3가) 수성2,3가동 행정복지센터 4층</p>
    <p class="info_tel">053-666-4390</p>
  </div>
</div>
<h1></h1>