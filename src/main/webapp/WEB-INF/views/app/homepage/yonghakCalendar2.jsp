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
$.get('../calendar9.do?manageCode=BH', function(data) {
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
      <div> <span>화~금 09:00 ~ 18:00</span> </div>
      </li>
      <li class="book11 mb10">
      <div> <span>토~일 09:00 ~ 17:00</span> </div>
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
  <h3>장서현황<span class="sm_text sm_text02" style="margin-top:10px;">[기준 : 2023.1.31.] (단위 : 권)</span></h3>
  <div class="rsv-info"></div>
  <div class="auto-scroll">
    <table class="tbl-type01" summary="무학숲도서관 장서현황을 안내해 드립니다.">
    <caption class="disnone">
    무학숲도서관의 장서현황
    </caption>
    <colgroup>
    <col width="*">
    <col width="8.5%">
    <col width="8.5%">
    <col width="8.5%">
    <col width="8.5%">
    <col width="8.5%">
    <col width="8.5%">
    <col width="8.5%">
    <col width="8.5%">
    <col width="8.5%">
    <col width="8.5%">
    <col width="8.5%">
    </colgroup>
    <thead>
    <tr>
      <th height="35" scope="col">구분</th>
      <th scope="col">총류</th>
      <th scope="col">철학</th>
      <th scope="col">종교</th>
      <th scope="col">사회<br>
      과학</th>
      <th scope="col">자연<br>
      과학</th>
      <th scope="col">기술<br>
      과학</th>
      <th scope="col">예술</th>
      <th scope="col">언어</th>
      <th scope="col">문학</th>
      <th scope="col">역사</th>
      <th scope="col">합계</th>
    </tr>
    </thead>
    <tbody>
    <tr>
      <th>어린이</th>
    <td valign="middle"><p><span lang="EN-US">247</span></p></td>
    <td valign="middle"><p><span lang="EN-US">138</span></p></td>
    <td valign="middle"><p><span lang="EN-US">84</span></p></td>
    <td valign="middle"><p><span lang="EN-US">416</span></p></td>
    <td valign="middle"><p><span lang="EN-US">1,140</span></p></td>
    <td valign="middle"><p><span lang="EN-US">429</span></p></td>
    <td valign="middle"><p><span lang="EN-US">135</span></p></td>
    <td valign="middle"><p><span lang="EN-US">175</span></p></td>
    <td valign="middle"><p><span lang="EN-US">2,229</span></p></td>
    <td valign="middle"><p><span lang="EN-US">772</span></p></td>
    <td valign="middle"><p><span lang="EN-US">5,765</span></p></td>
    </tr>
    <tr>
      <th>유아</th>
    <td valign="middle"><p><span lang="EN-US">60</span></p></td>
    <td valign="middle"><p><span lang="EN-US">116</span></p></td>
    <td valign="middle"><p><span lang="EN-US">86</span></p></td>
    <td valign="middle"><p><span lang="EN-US">444</span></p></td>
    <td valign="middle"><p><span lang="EN-US">437</span></p></td>
    <td valign="middle"><p><span lang="EN-US">87</span></p></td>
    <td valign="middle"><p><span lang="EN-US">90</span></p></td>
    <td valign="middle"><p><span lang="EN-US">72</span></p></td>
    <td valign="middle"><p><span lang="EN-US">2,245</span></p></td>
    <td valign="middle"><p><span lang="EN-US">82</span></p></td>
    <td valign="middle"><p><span lang="EN-US">3,719</span></p></td>
    </tr>
    <tr>
      <th>일반</th>
    <td valign="middle"><p><span lang="EN-US">258</span></p></td>
    <td valign="middle"><p><span lang="EN-US">434</span></p></td>
    <td valign="middle"><p><span lang="EN-US">162</span></p></td>
    <td valign="middle"><p><span lang="EN-US">1,018</span></p></td>
    <td valign="middle"><p><span lang="EN-US">579</span></p></td>
    <td valign="middle"><p><span lang="EN-US">881</span></p></td>
    <td valign="middle"><p><span lang="EN-US">299</span></p></td>
    <td valign="middle"><p><span lang="EN-US">152</span></p></td>
    <td valign="middle"><p><span lang="EN-US">2,241</span></p></td>
    <td valign="middle"><p><span lang="EN-US">454</span></p></td>
    <td valign="middle"><p><span lang="EN-US">6,478</span></p></td>
    </tr>
    <tr>
      <th>합계</th>
    <td valign="middle"><p><span lang="EN-US">565</span></p></td>
    <td valign="middle"><p><span lang="EN-US">688</span></p></td>
    <td valign="middle"><p><span lang="EN-US">332</span></p></td>
    <td valign="middle"><p><span lang="EN-US">1,878</span></p></td>
    <td valign="middle"><p><span lang="EN-US">2,156</span></p></td>
    <td valign="middle"><p><span lang="EN-US">1,397</span></p></td>
    <td valign="middle"><p><span lang="EN-US">524</span></p></td>
    <td valign="middle"><p><span lang="EN-US">399</span></p></td>
    <td valign="middle"><p><span lang="EN-US">6,715</span></p></td>
    <td valign="middle"><p><span lang="EN-US">1,308</span></p></td>
    <td valign="middle"><p><span lang="EN-US">15,962</span></p></td>
    </tr>
    </tbody>
    </table>
  </div>
  <h3>정기간행물 현황<span class="sm_text sm_text02" style="margin-top:10px;">(단위 : 종)</span></h3>
  <div class="rsv-info"></div>
  <div class="auto-scroll">
    <table class="tbl-type01" summary="무학숲도서관의 정기간행물현황을 안내해 드립니다.">
    <caption class="disnone">
    무학숲도서관의 정기간행물현황
    </caption>
    <colgroup>
    <col width="*">
    <col width="16.6%">
    <col width="16.6%">
    <col width="16.6%">
    <col width="16.6%">
    <col width="16.6%">
    </colgroup>
    <thead>
    <tr>
      <th>구분</th>
      <th>신문</th>
      <th>주간지</th>
      <th>계간지</th>
      <th>월간지</th>
      <th>총 계</th>
    </tr>
    </thead>
    <tbody>
    <tr>
      <th>무학숲도서관</th>
      <td>5</td>
      <td>2</td>
      <td>1</td>
      <td>13</td>
      <td>21</td>
    </tr>
    </tbody>
    </table>
  </div>
  <h3>시설안내</h3>
  <div class="rsv-info"></div>
  <div class="auto-scroll">
    <table class="tbl-type01" summary="무학숲도서관의 시설안내를 나타내는 표">
    <caption class="disnone">
    무학숲도서관의 시설안내
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
      <th scope="row" rowspan="5">1층</th>
      <td>자료실</td>
      <td>176.10</td>
    </tr>
    <tr>
      <td>유아자료실</td>
      <td>39.69</td>
    </tr>
    <tr>
      <td>스토리텔링룸</td>
      <td>22.54</td>
    </tr>
    <tr>
      <td>사무실</td>
      <td>17.28</td>
    </tr>
    <tr>
      <td>기타공간(화장실, 수유실 등)</td>
      <td>45.89</td>
    </tr>
    <tr>
      <th scope="row" colspan="2">총면적</th>
      <td>301.5</td>
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
  	map1._showpoint(1102109.6226, 1760451.6197,7);
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
    <p class="info_add">대구광역시 수성구 청수로40길 73-10(지산동)</p>
    <p class="info_tel">053-668-1821</p>
    <p class="info_fax">053-668-1739</p>
  </div>

  <h3>교통편 안내</h3>
  <h4>버스 이용</h4>
  <ul class="con">
    <li>교통연수원 앞(622m, 도보 9분-휠체어 18분) / 교통연수원 건너(746m, 도보 11분-휠체어 22분) : 204, 403, 449, 814
    <li>캐슬골드파크(1102동)(619m, 도보 10분-휠체어 20분) / 캐슬골드파크(1504동)(498m, 도보 7분-휠체어 14분) : 100, 100-1, 234, 349, 수성3-1, 순환3, 수성4</li>
    <li>대우트럼프월드수성 앞(846m, 도보 14분-휠체어 28분) / 대우트럼프월드수성 건너(732m, 도보 11분-휠체어 22분) : 수성3, 수성3-1, 204, 814, 수성1, 수성1-1, 8140</li>
  </ul>
  <p class="basic_btn" style="margin-top:0;">
  <a href="https://businfo.daegu.go.kr:8095/dbms_web/content/businfo/lowfloorbus" class="btn_go newWin" target="_blank" title="저상버스 운행정보 바로가기(새창열림)"> <span>저상버스 운행정보 바로가기</span> <i class="fa fa-external-link"></i></a>
  </p>
  <br />
  <h4>지하철 이용</h4>
  <ul>
    <li><span class="ico_subway3">황금역</span>황금역 출구(964m, 도보 16분-휠체어 32분)</li>
  </ul>
  <br />
  <h4>자가용 이용</h4>
  <ul class="con">
    <li>수성구청에서 무학숲도서관으로 자가용을 이용해서 오시는 길을 안내해드립니다.</li>
    <li>수성구청입구에서 출발 → 달구벌대로에서 우회전 → 0.68km 직진 후 우회전 → 1.9km 직진 후 우회전 → 1km 직진 후 북성교회에서 유턴 → 0.14km 직진 후 올리브영에서 우회전 → 0.35km 직진 후 좌회전</li>
  </ul>
</div>

<div style="text-align:center;">
  <div class="link_btn02" style="display:inline-block;"> <a href="https://library.daegu.go.kr/yonghak/board/index.do?menu_idx=35&manage_idx=677&board_idx=0&group_idx=0&category1=003&rowCount=10&_boardIdxArray=on&_boardIdxArray=on&_boardIdxArray=on&_boardIdxArray=on&_boardIdxArray=on&_boardIdxArray=on&_boardIdxArray=on&_boardIdxArray=on&_boardIdxArray=on&_boardIdxArray=on&viewPage=1&searchStartDate=2019-12-28&searchEndDate=2020-12-28&search_type=title%2Bcontent">공지사항 바로가기 </a> </div>
  <div class="link_btn02" style="display:inline-block;"> <a href="/yonghak/module/teach/index.do?menu_idx=100&searchCate1=30&homepage_id=h51">문화강좌 바로가기</a> </div>
</div>
</div>
