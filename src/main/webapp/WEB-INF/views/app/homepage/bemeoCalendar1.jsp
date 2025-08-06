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
					$.get('../calendar9.do?manageCode=BJ', function (data) {
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
				<h3>주제별 자료현황<span class="sm_text sm_text02" style="margin-top:10px;">[2025.8.1. 기준] (단위 : 권)</span></h3>
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
							<td>1,514 </td>
							<td>1,369 </td>
							<td>495 </td>
							<td>4,637 </td>
							<td>3,044 </td>
							<td>2,576 </td>
							<td>1,076 </td>
							<td>1,814 </td>
							<td>16,031 </td>
							<td>2,850 </td>
							<td>35,406 </td>
						  </tr>
						  <tr>
							<th>비율</th>
							<td>4.3 </td>
							<td>3.9 </td>
							<td>1.4 </td>
							<td>13.1 </td>
							<td>8.6 </td>
							<td>7.3 </td>
							<td>3.0 </td>
							<td>5.1 </td>
							<td>45.3 </td>
							<td>8.0 </td>
							<td>100 </td>
						  </tr>
						</tbody>
					</table>
				</div>
				<h3>별치기호별 자료현황<span class="sm_text sm_text02" style="margin-top:10px;">[2025.8.1. 기준] (단위 : 권)</span></h3>
				<div class="rsv-info"></div>
				<div class="auto-scroll">
					<table class="tbl-type01" summary="별치기호별 자료현황을 나타내는 표">
						<caption class="disnone">
							별치기호별 자료현황
						</caption>
						<colgroup>
							<col width="*">
							<col width="12.5%">
							<col width="12.5%">
							<col width="12.5%">
							<col width="12.5%">
							<col width="12.5%">
							<col width="12.5%">
							<col width="12.5%">
						</colgroup>
						<thead>
						<tr>
							<th>구분</th>
							<th>아동</th>
							<th>유아</th>
							<th>일반</th>
							<th>큰글</th>
							<th>참고</th>
							<th>영어</th>
							<th>총계</th>
						  </tr>
						</thead>
						<tbody>
						 <tr>
							<th>권수</th>
							<td>10,889 </td>
							<td>5,912 </td>
							<td>14,794 </td>
							<td>101 </td>
							<td>234 </td>
							<td>3,476 </td>
							<td>35,406 </td>
						  </tr>
						  <tr>
							<th>비율</th>
							<td>30.8</td>
							<td>16.7</td>
							<td>41.8</td>
							<td>0.3</td>
							<td>0.7</td>
							<td>9.8</td>
							<td>100</td>
						  </tr>
						</tbody>
					</table>
				</div>
				<p>보존서고: 3,806권 포함</p>
				<h3>간행물 현황<span class="sm_text sm_text02" style="margin-top:10px;">[2025.8.1. 기준] (단위 : 권)</span></h3>
				<div class="rsv-info"></div>
				<div class="auto-scroll">
					<table class="tbl-type01" summary="책숲길도서관 간행물 현황을 나타내는 표">
						<caption class="disnone">
							책숲길도서관 간행물 현황
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
								<td>2</td>
								<td>0</td>
								<td>1</td>
								<td>8</td>
								<td>0</td>
								<td>1</td>
								<td>12</td>
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
								<th scope="row" rowspan="5">4층</th>
								<td>자료실</td>
								<td>192</td>
							</tr>
							<tr>
								<td>유아자료실</td>
								<td>33</td>
							</tr>
							<tr>
								<td>문화강좌실</td>
								<td>27</td>
							</tr>
							<tr>
								<td>사무실(데스크)</td>
								<td>22</td>
							</tr>
							<tr>
								<td>기타공간(화장실, 로비, 복도 등)</td>
								<td>114.55</td>
							</tr>
							<tr>
								<th scope="row" colspan="2">총면적</th>
								<td>338.55</td>
							</tr>
						</tbody>
					</table>
				</div>
				<h3>위치안내</h3>
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
						map1._showpoint(1100453.8756, 1761495.4999, 7);
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
					<p class="info_add">대구시 수성구 수성로215(중동) 수옥빌딩 4층</p>
					<p class="info_tel">053-668-1650</p>
				</div>

				<h4>주변 버스정류장<span class="sm_text">버스번호를 클릭하시면 노선도를 검색하실 수 있습니다.</span></h4>
				<ul class="bus_list">
					<li><a href="http://businfo.daegu.go.kr/ba/index/index.do" target="_blank" class="newWin"
							title="새창으로 열립니다."><span class="ico_bus_m">간선<span class="num">304</span></span><i
								class="fa fa-external-link"></i></a></li>
					<li><a href="http://businfo.daegu.go.kr/ba/index/index.do" target="_blank" class="newWin"
							title="새창으로 열립니다."><span class="ico_bus_m">간선<span class="num">413</span></span><i
								class="fa fa-external-link"></i></a></li>
					<li><a href="http://businfo.daegu.go.kr/ba/index/index.do" target="_blank" class="newWin"
							title="새창으로 열립니다."><span class="ico_bus_j">지선<span class="num">수성4</span></span><i
								class="fa fa-external-link"></i></a></li>
					<li><a href="http://businfo.daegu.go.kr/ba/index/index.do" target="_blank" class="newWin"
							title="새창으로 열립니다."><span class="ico_bus_g">급행<span class="num">급행2</span></span><i
								class="fa fa-external-link"></i></a></li>
					<div class="clear"></div>
				</ul>
				<p class="basic_btn">
					<a href="https://businfo.daegu.go.kr:8095/dbms_web/content/businfo/lowfloorbus" class="btn_go newWin"
						target="_blank" title="저상버스 운행정보 바로가기(새창열림)"> <span>저상버스 운행정보 바로가기</span> <i
							class="fa fa-external-link"></i></a>
				</p>

				<h3>자가용 이용시</h3>
				<ul class="con">
					<li>시내방향에서 오시는 경우 : 신천대로 진입 후 대봉교지하차도 지나 어린이회관 방면으로 오른쪽 출구로 나간 후, 희망교 건너 약 500m 지나 파동방면(수성로) 우회전 200m 지점</li>
					<li>범어동, 시지 방면에서 오시는 경우 : 달구벌대로 수성교 방면 이동 후, 수성네거리에서 좌회전(수성로) 후 약 2km 지점</li>
					<li>지산동 방면에서 오시는 경우 : 무학로 따라 이동 후 상동네거리에서 중동네거리(수성로) 방면 우회전 후 약 2km지점 유턴 후 200m 지점</li>
					<li>대명동 방면에서 오시는 경우 : 희망교 건너 약 500m 지나 파동방면(수성로) 우회전 200m 지점</li>
				</ul>

				<h3>휠체어 사용시 소요시간</h3>
				<ul class="con">
					<li>수성구보건소 앞(3분) : 304, 413, 수성4, 급행2</li>
					<li>수성구보건소 건너(길건너 5분) : 304, 413, 수성4, 급행2</li>
				</ul>
			</div>