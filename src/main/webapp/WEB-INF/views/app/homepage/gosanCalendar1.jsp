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
          $.get('../calendar9.do?manageCode=FG', function (data) {
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
				<div> <span>평일 09:00 ~ 20:00</span> </div>
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

		  <h3>장서현황 (단위 : 권)<span class="sm_text sm_text02" style="margin-top:10px;">(2025. 1. 31. 기준)</span></h3>
		  <div class="rsv-info"></div>
		  <div class="auto-scroll">
			<table class="tbl-type01" summary="사월역작은도서관 장서현황을 안내해 드립니다.">
			  <caption class="disnone">
				사월역작은도서관의 장서현황
			  </caption>
			  <colgroup>
				<col width="*" class="col1">
				<col width="8.5%" class="col2">
				<col width="8.5%" class="col3">
				<col width="8.5%" class="col4">
				<col width="8.5%" class="col5">
				<col width="8.5%" class="col6">
				<col width="8.5%" class="col7">
				<col width="8.5%" class="col8">
				<col width="8.5%" class="col9">
				<col width="8.5%" class="col10">
				<col width="8.5%" class="col11">
				<col width="8.5%" class="col12">
			  </colgroup>
			  <thead>
				<tr>
				  <th colspan="2">구분</th>
				  <th>총류</th>
				  <th>철학</th>
				  <th>종교</th>
				  <th>사회<br>과학</th>
				  <th>자연<br>과학</th>
				  <th>기술<br>과학</th>
				  <th>예술</th>
				  <th>언어</th>
				  <th>문학</th>
				  <th>역사</th>
				  <th>총계</th>
				</tr>
			  </thead>
			  <tbody>
				<tr>
					<th rowspan="2">어린이</th>
					<th>유아</th>
					<td>40</td>
					<td>59</td>
					<td>65</td>
					<td>447</td>
					<td>168</td>
					<td>23</td>
					<td>29</td>
					<td>23</td>
					<td>981</td>
					<td>229</td>
					<td>2,063</td>
				</tr>
				<tr>
					<th>아동</th>
					<td>232</td>
					<td>88</td>
					<td>33</td>
					<td>380</td>
					<td>187</td>
					<td>125</td>
					<td>28</td>
					<td>159</td>
					<td>1,176</td>
					<td>407</td>
					<td>2,815</td>
				</tr>
				<tr>
					<th colspan="2">일반</th>
					<td>217</td>
					<td>536</td>
					<td>165</td>
					<td>1,043</td>
					<td>248</td>
					<td>695</td>
					<td>284</td>
					<td>136</td>
					<td>2,245</td>
					<td>654</td>
					<td>6,223</td>
				</tr>
				<tr>
					<th colspan="2" rowspan="2">총계</th>
					<td>489</td>
					<td>681</td>
					<td>263</td>
					<td>1,870</td>
					<td>603</td>
					<td>843</td>
					<td>341</td>
					<td>317</td>
					<td>4,402</td>
					<td>1,290</td>
					<td>11,101</td>
				</tr>
				<tr>
					<td>4.4%</td>
					<td>6.2%</td>
					<td>2.4%</td>
					<td>16.8%</td>
					<td>5.4%</td>
					<td>7.6%</td>
					<td>3.1%</td>
					<td>2.9%</td>
					<td>39.7%</td>
					<td>11.6%</td>
					<td>100%</td>
				</tr>
			  </tbody>
			</table>
		  </div>

		  <link rel="stylesheet" type="text/css" href="/resources/common/css/locationMap.css" />

		  <h3>위치안내</h3>
		  <!-- * 카카오맵 - 지도퍼가기 -->
		  <!-- 1. 지도 노드 -->
		  <div id="daumRoughmapContainer1720147155483" class="root_daum_roughmap root_daum_roughmap_landing"
			style="width: 100%;"></div>

		  <!--
			2. 설치 스크립트
			* 지도 퍼가기 서비스를 2개 이상 넣을 경우, 설치 스크립트는 하나만 삽입합니다.
		-->
		  <script charset="UTF-8" class="daum_roughmap_loader_script"
			src="https://ssl.daumcdn.net/dmaps/map_js_init/roughmapLoader.js"></script>

		  <!-- 3. 실행 스크립트 -->
		  <script charset="UTF-8">
			new daum.roughmap.Lander({
			  "timestamp": "1720147155483",
			  "key": "2jx4z",
			  "mapHeight": "500"
			}).render();
		  </script>

		  <div class="info_box">
			<p class="info_add">대구광역시 수성구 성동로 70 2층</p>
			<p class="info_tel">053-668-1940</p>
		  </div>
      </div>