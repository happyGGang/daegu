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
					$.get('../calendar9.do?manageCode=BK', function (data) {
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
				<h3>주제별 자료현황<span class="sm_text sm_text02" style="margin-top:10px;">[2023.6.30. 기준] (단위 : 권)</span></h3>
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
								<td>1,778</td>
								<td>1,231</td>
								<td>559</td>
								<td>3,994</td>
								<td>3,037</td>
								<td>1,544</td>
								<td>963</td>
								<td>2,155</td>
								<td>16,043</td>
								<td>3,386</td>
								<td>34,690</td>
							</tr>
							<tr>
								<th>비율</th>
								<td>5.1</td>
								<td>3.5</td>
								<td>1.6</td>
								<td>11.5</td>
								<td>8.7</td>
								<td>4.4</td>
								<td>2.8</td>
								<td>6.2</td>
								<td>46.4</td>
								<td>9.8</td>
								<td>100</td>
							</tr>
						</tbody>
					</table>
				</div>
				<h3>별치기호별 자료현황<span class="sm_text sm_text02" style="margin-top:10px;">[2023.6.30. 기준] (단위 : 권)</span></h3>
				<div class="rsv-info"></div>
				<div class="auto-scroll">
					<table class="tbl-type01" summary="별치기호별 자료현황을 나타내는 표">
						<caption class="disnone">
							별치기호별 자료현황
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
								<th>구 분</th>
								<th>아동</th>
								<th>유아</th>
								<th>일반</th>
								<th>큰글</th>
								<th>영어</th>
								<th>총계</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<th>권수</th>
								<td>15,474</td>
								<td>4,594</td>
								<td>10,082</td>
								<td>70</td>
								<td>4,470</td>
								<td>34,690</td>
							</tr>
							<tr>
								<th>비율</th>
								<td>44.6</td>
								<td>13.2</td>
								<td>29.0</td>
								<td>0.2</td>
								<td>13.0</td>
								<td>100</td>
							</tr>
						</tbody>
					</table>
				</div>
				<p>보존서고: 6,508권 포함</p>
				<h3>간행물 현황<span class="sm_text sm_text02" style="margin-top:10px;">[2023.6.30. 기준] (단위 : 권)</span></h3>
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
								<td>10</td>
								<td>0</td>
								<td>0</td>
								<td>14</td>
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
				<!-- * 카카오맵 - 지도퍼가기 -->
				<!-- 1. 지도 노드 -->
				<div id="daumRoughmapContainer1689899261535" class="root_daum_roughmap root_daum_roughmap_landing" style="width: 100%;"></div>

				<!--2. 설치 스크립트
				* 지도 퍼가기 서비스를 2개 이상 넣을 경우, 설치 스크립트는 하나만 삽입합니다.-->
				<script charset="UTF-8" class="daum_roughmap_loader_script"
					src="https://ssl.daumcdn.net/dmaps/map_js_init/roughmapLoader.js"></script>

				<!-- 3. 실행 스크립트 -->
				<script charset="UTF-8">
					new daum.roughmap.Lander({
						"timestamp": "1689899261535",
						"key": "2fko7",
						//"mapWidth": "970",
						"mapHeight": "500"
					}).render();
				</script>

				<div class="info_box">
					<p class="info_add">대구광역시 수성구 명덕로 443-2(수성동3가) 수성2,3가동 행정복지센터 4층</p>
					<p class="info_tel">053-666-4390</p>
				</div>

				<h3>교통편 안내</h3>
				<h4>주변 지하철역</h4>
				<ul>
					<li><span class="ico_subway3">수성시장</span>4번 출구</li>
				</ul>
				<br />
				<h4>주변 버스정류장<span class="sm_text">버스번호를 클릭하시면 노선도를 보실 수 있습니다.</span></h4>
				<ul class="bus_list">
					<li><a
							href="http://businfo.daegu.go.kr/ba/route/mainSec.do?act=list&amp;route_id=3000309000&amp;stop_busyn=N&amp;move_dir=1&amp;d_t_cd=1&amp;view_cp_num=N"
							target="_blank" title="234번 버스 운행경로 보기(새창)" class="newWin"><span class="ico_bus_m">간선<span
									class="num">234</span></span><i class="fa fa-external-link"></i></a></li>
					<li><a
							href="http://businfo.daegu.go.kr/ba/route/mainSec.do?act=list&amp;route_id=3000449000&amp;stop_busyn=N&amp;move_dir=1&amp;d_t_cd=1&amp;view_cp_num=N"
							target="_blank" title="323번 버스 운행경로 보기(새창)" class="newWin"><span class="ico_bus_m">간선<span
									class="num">323</span></span><i class="fa fa-external-link"></i></a></li>
					<li><a
							href="http://businfo.daegu.go.kr/ba/route/mainSec.do?act=list&amp;route_id=3000509000&amp;stop_busyn=N&amp;move_dir=1&amp;d_t_cd=1&amp;view_cp_num=N"
							target="_blank" title="413번 버스 운행경로 보기(새창)" class="newWin"><span class="ico_bus_m">간선<span
									class="num">413</span></span><i class="fa fa-external-link"></i></a></li>
					<li><a
							href="http://businfo.daegu.go.kr/ba/route/mainSec.do?act=list&amp;route_id=3000609005&amp;stop_busyn=N&amp;move_dir=1&amp;d_t_cd=1&amp;view_cp_num=N"
							target="_blank" title="509번 버스 운행경로 보기(새창)" class="newWin"><span class="ico_bus_m">간선<span
									class="num">509</span></span><i class="fa fa-external-link"></i></a></li>
					<li><a
							href="http://businfo.daegu.go.kr/ba/route/mainSec.do?act=list&amp;route_id=3000649000&amp;stop_busyn=N&amp;move_dir=1&amp;d_t_cd=1&amp;view_cp_num=N"
							target="_blank" title="323-1번 버스 운행경로 보기(새창)" class="newWin"><span class="ico_bus_m">간선<span
									class="num">323-1</span></span><i class="fa fa-external-link"></i></a></li>
					<li><a
							href="http://businfo.daegu.go.kr/ba/route/mainSec.do?act=list&amp;route_id=3000649000&amp;stop_busyn=N&amp;move_dir=1&amp;d_t_cd=1&amp;view_cp_num=N"
							target="_blank" title="403번 버스 운행경로 보기(새창)" class="newWin"><span class="ico_bus_m">간선<span
									class="num">403</span></span><i class="fa fa-external-link"></i></a></li>
					<li><a
							href="http://businfo.daegu.go.kr/ba/route/mainSec.do?act=list&amp;route_id=3000849102&amp;stop_busyn=N&amp;move_dir=1&amp;d_t_cd=0&amp;view_cp_num=N"
							target="_blank" title="410번 버스 운행경로 보기(새창)" class="newWin"><span class="ico_bus_m">간선<span
									class="num">410</span></span><i class="fa fa-external-link"></i></a></li>
					<li><a
							href="http://businfo.daegu.go.kr/ba/route/mainSec.do?act=list&amp;route_id=3000909002&amp;stop_busyn=N&amp;move_dir=1&amp;d_t_cd=1&amp;view_cp_num=N"
							target="_blank" title="410-1번 버스 운행경로 보기(새창)" class="newWin"><span class="ico_bus_m">간선<span
									class="num">410-1</span></span><i class="fa fa-external-link"></i></a></li>
					<div class="clear"></div>
				</ul>
				<ul class="bus_list">
					<li><a
							href="http://businfo.daegu.go.kr/ba/route/mainSec.do?act=list&amp;route_id=3000309000&amp;stop_busyn=N&amp;move_dir=1&amp;d_t_cd=1&amp;view_cp_num=N"
							target="_blank" title="동구1번 버스 운행경로 보기(새창)" class="newWin"><span class="ico_bus_j">지선<span
									class="num">동구1</span></span><i class="fa fa-external-link"></i></a></li>
					<li><a
							href="http://businfo.daegu.go.kr/ba/route/mainSec.do?act=list&amp;route_id=3000309000&amp;stop_busyn=N&amp;move_dir=1&amp;d_t_cd=1&amp;view_cp_num=N"
							target="_blank" title="동구1-1번 버스 운행경로 보기(새창)" class="newWin"><span class="ico_bus_j">지선<span
									class="num">동구1-1</span></span><i class="fa fa-external-link"></i></a></li>
					<li><a
							href="http://businfo.daegu.go.kr/ba/route/mainSec.do?act=list&amp;route_id=3000309000&amp;stop_busyn=N&amp;move_dir=1&amp;d_t_cd=1&amp;view_cp_num=N"
							target="_blank" title="순환2번 버스 운행경로 보기(새창)" class="newWin"><span class="ico_bus_j">지선<span
									class="num">순환2</span></span><i class="fa fa-external-link"></i></a></li>
					<li><a
							href="http://businfo.daegu.go.kr/ba/route/mainSec.do?act=list&amp;route_id=3000309000&amp;stop_busyn=N&amp;move_dir=1&amp;d_t_cd=1&amp;view_cp_num=N"
							target="_blank" title="순환2-1번 버스 운행경로 보기(새창)" class="newWin"><span class="ico_bus_j">지선<span
									class="num">순환2-1</span></span><i class="fa fa-external-link"></i></a></li>
					<li><a
							href="http://businfo.daegu.go.kr/ba/route/mainSec.do?act=list&amp;route_id=3000309000&amp;stop_busyn=N&amp;move_dir=1&amp;d_t_cd=1&amp;view_cp_num=N"
							target="_blank" title="수성4번 버스 운행경로 보기(새창)" class="newWin"><span class="ico_bus_j">지선<span
									class="num">수성4</span></span><i class="fa fa-external-link"></i></a></li>
					<div class="clear"></div>
				</ul>
				<p class="basic_btn">
					<a href="https://businfo.daegu.go.kr:8095/dbms_web/content/businfo/lowfloorbus" class="btn_go newWin"
						target="_blank" title="저상버스 운행정보 바로가기(새창열림)"> <span>저상버스 운행정보 바로가기</span> <i
							class="fa fa-external-link"></i></a>
				</p>
				<br />
				<h4>자가용 이용시</h4>
				<ul class="con">
					<li>시내방향에서 오시는 경우 : 달구벌대로를 따라 이동 후 삼덕네거리에서 ‘수성교’ 방면으로 약 1.1km 지점 좌회전 한 뒤, 명덕로 방면으로 600m 지점</li>
					<li>시지, 사월역 오시는 경우 : 달구벌대로로 따라 범어네거리에서 ‘어린이회관’ 방면으로 좌회전 한 뒤, ‘대봉교’ 방면으로 우회전 후 600m 지점</li>
					<li>지산동 방향에서 오시는 경우 : 지범로로 499m 이동 후, ‘대봉교’ 방면으로 약 3.5km 지점 좌회전 후 600m 지점</li>
				</ul>
				<br />

				<h3>휠체어 사용 시 소요시간</h3>
				<ul class="con">
					<li>수성3가롯데캐슬 건너(길건너 8분) : 234, 323-1, 413, 509, 동구1-1, 순환2-1</li>
					<li>수성3가롯데캐슬 앞(5분) : 234, 323, 413, 509, 동구1, 순환2</li>
					<li>수성시장 앞(길건너 8분) : 403, 410, 수성4</li>
					<li>수성시장 건너(6분) : 410-1</li>
				</ul>
			</div>