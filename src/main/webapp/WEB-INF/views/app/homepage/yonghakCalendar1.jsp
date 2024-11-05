<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
        $(document).ready(function () {
          $.get('../calendar9.do?manageCode=BG', function (data) {
            var li = '<li>등록된 휴관일이 없습니다.</li>';
            if (data && data.length > 0) {
              li = '';
              $.each(data, function (i, v) {
                li += ('<li>' + v + '</li>');
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
              <div> <span>월~금 09:00 ~ 18:00</span> </div>
            </li>
            <li class="book11 mb10">
              <div> <span>토 09:00 ~ 17:00</span> </div>
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
        <h3>장서현황<span class="sm_text sm_text02" style="margin-top:10px;">[기준 : 2024.10.31.] (단위 : 권)</span></h3>
        <div class="rsv-info"></div>
        <div class="auto-scroll">
          <table class="tbl-type01" summary="파동도서관 장서현황을 안내해 드립니다.">
            <caption class="disnone">
              파동도서관의 장서현황
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
                <th scope="row">어린이</th>
				<td>711</td>
				<td>364</td>
				<td>165</td>
				<td>854</td>
				<td>1,269</td>
				<td>380</td>
				<td>291</td>
				<td>281</td>
				<td>3,810</td>
				<td>1,209</td>
				<td>9,334</td>
              </tr>
              <tr>
                <th scope="row">유아</th>
				<td>64</td>
				<td>92</td>
				<td>42</td>
				<td>914</td>
				<td>402</td>
				<td>86</td>
				<td>80</td>
				<td>72</td>
				<td>3,090</td>
				<td>34</td>
				<td>4,876</td>
              </tr>
              <tr>
                <th scope="row">일반</th>
                <td>555</td>
				<td>1,090</td>
				<td>341</td>
				<td>2,195</td>
				<td>646</td>
				<td>1,365</td>
				<td>566</td>
				<td>320</td>
				<td>5,927</td>
				<td>1,191</td>
				<td>14,196</td>
              </tr>
              <tr>
                <th scope="row">총계</th>
                <td>1,330</td>
				<td>1,546</td>
				<td>548</td>
				<td>3,963</td>
				<td>2,317</td>
				<td>1,831</td>
				<td>937</td>
				<td>673</td>
				<td>12,827</td>
				<td>2,434</td>
				<td>28,406</td>
              </tr>
            </tbody>
          </table>
        </div>
        <h3>정기간행물 현황<span class="sm_text sm_text02" style="margin-top:10px;">(단위 : 종)</span></h3>
        <div class="rsv-info"></div>
        <div class="auto-scroll">
          <table class="tbl-type01" summary="파동도서관 정기간행물현황을 안내해 드립니다.">
            <caption class="disnone">
              파동도서관의 정기간행물현황
            </caption>
            <colgroup>
              <col width="*">
              <col width="25%">
              <col width="25%">
              <col width="25%">
            </colgroup>
            <thead>
              <tr>
                <th>구분</th>
                <th>신문</th>
                <th>월간지</th>
                <th>총 계</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <th>파동도서관</th>
                <td>3</td>
                <td>12</td>
                <td>15</td>
              </tr>
            </tbody>
          </table>
        </div>
        <h3>시설안내</h3>
        <div class="rsv-info"></div>
        <div class="auto-scroll">
          <table class="tbl-type01" summary="파동도서관의 시설안내를 나타내는 표">
            <caption class="disnone">
              파동도서관의 시설안내
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
                <th scope="row" rowspan="5">파동평생학습센터 1층</th>
                <td>어린이 및 일반자료실</td>
                <td>148.98</td>
              </tr>
              <tr>
                <td>유아자료실</td>
                <td>44</td>
              </tr>
              <tr>
                <td>문화강좌실</td>
                <td>21.75</td>
              </tr>
              <tr>
                <td>사무실</td>
                <td>19.11</td>
              </tr>
              <tr>
                <td>화장실, 계단 등</td>
                <td>178.01</td>
              </tr>
              <tr>
                <th scope="row" colspan="2">총면적</th>
                <td>411.85</td>
              </tr>
            </tbody>
          </table>
        </div>
        <h3>위치안내</h3>
        <link rel="stylesheet" type="text/css" href="/resources/common/css/locationMap.css" />

        <link rel="stylesheet" href="/resources/common/css/emap/OpenLayers-6.4.3.css" type="text/css">
        <script type="text/javascript" src="/resources/common/js/emap/OpenLayers-6.4.3.js"></script>
        <script type="text/javascript" src="/resources/common/js/emap/proj4.js"></script>
        <script type="text/javascript"
          src="/resources/common/js/emap/wmts_ngiiMap_v6.4.3.js?apikey=2375C203D51981F12172FEAB7D7AFD44"></script>
        <script>
          var map1;
          window.onload = function () {
            map1 = new ngii_wmts.map("map1", { mapMode: 3 });
            map1._setMapMode('0');
            map1._showpoint(1101018.5015, 1757687.1205, 7);
          }
            ;
        </script>

        <div class="mapWrap" style="position:relative;">
          <div id="map1" style="width:100%;height:500px;"></div>
          <ul class="map-btn">
            <li><a href="javascript:ngii_wmts.findMapObject(0)._setMapMode('0');">일반</a></li>
            <li><a href="javascript:ngii_wmts.findMapObject(0)._setMapMode('1');">색약</a></li>
            <li><a href="javascript:ngii_wmts.findMapObject(0)._setMapMode('2');">큰글</a></li>
            <li class="img-li"><a href="javascript:map1.zoomIn();"><img src="/resources/common/img/map-plus-icon.png"
                  alt="지도 확대 버튼" title="지도 확대 버튼"></a></li>
            <li class="img-li"><a href="javascript:map1.zoomOut();"><img src="/resources/common/img/map-minus-icon.png"
                  alt="지도 축소 버튼" title="지도 축소 버튼"></a></li>
          </ul>
        </div>

        <div class="info_box">
          <p class="info_add">대구광역시 수성구 파동로3길 62 파동평생학습센터 1층</p>
          <p class="info_tel">053-668-1750</p>
        </div>

        <h3>버스 이용</h3>
        <h4>2차대자연맨션건너(162m, 도보 2분-휠체어 4분)</h4>
        <ul class="con">
          <li>240, 304, 405, 413, 449, 가창2, 0</li>
        </ul>
        <h4>2차대자연맨션앞(185m, 도보 2분-휠체어 4분)</h4>
        <ul class="con">
          <li>240, 304, 405, 413, 449, 가창2, 0</li>
          <p class="basic_btn">
            <a href="https://businfo.daegu.go.kr:8095/dbms_web/content/businfo/lowfloorbus" class="btn_go newWin"
              target="_blank" title="저상버스 운행정보 바로가기(새창열림)"> <span>저상버스 운행정보 바로가기</span> <i
                class="fa fa-external-link"></i></a>
          </p>
        </ul>

        <h3>자가용 이용</h3>
        <h4>수성구청에서 파동도서관으로 자가용을 이용해서 오시는 길을 안내해드립니다.</h4>
        <ul class="con">
          <li>수성구청 입구에서 출발 → ‘달구벌대로’방면으로 우회전 → 0.43km 직진 후 수성구청역에서 유턴 → 0.8km 직진 후 범어네거리에서 ‘어린이회관, 수성구민운동장’방면으로 좌회전 →
            3.2km 직진 후 두산오거리에서 ‘파동’방면으로 우회전 → 1.4km 직진 후 ‘청도, 가창’방면으로 좌회전 → 2.2km 직진 후 우회전 → 71m 직진 후 ‘파동로3길’방면으로 좌회전 →
            60m 직진 후 수성구립 파동도서관 도착</li>
        </ul>

        <!-- <div style="text-align:center;">
    <div class="link_btn02" style="display:inline-block;"> <a href="https://library.daegu.go.kr/yonghak/board/index.do?menu_idx=35&manage_idx=677&board_idx=0&group_idx=0&category1=002&rowCount=10&_boardIdxArray=on&_boardIdxArray=on&_boardIdxArray=on&_boardIdxArray=on&_boardIdxArray=on&_boardIdxArray=on&_boardIdxArray=on&_boardIdxArray=on&_boardIdxArray=on&_boardIdxArray=on&viewPage=1&searchStartDate=2019-12-28&searchEndDate=2020-12-28&search_type=title%2Bcontent">공지사항 바로가기 </a> </div>
    <div class="link_btn02" style="display:inline-block;"> <a href="/yonghak/module/teach/index.do?menu_idx=100&searchCate1=30&homepage_id=h51">문화강좌 바로가기</a> </div>
  </div> -->
      </div>