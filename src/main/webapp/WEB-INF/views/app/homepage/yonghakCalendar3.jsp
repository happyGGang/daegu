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
	$.get('../calendar9.do?manageCode=BE', function(data) {
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
				<li class="book13 mb10" style="width:100%;">
					<div><span>화~일 09:00 ~ 21:00</span></div>
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
		<h3>장서현황<span class="sm_text sm_text02" style="margin-top:10px;">[기준 : 2025.4.30] (단위 : 권)</span></h3>
		<div class="rsv-info"></div>
		<div class="auto-scroll">
			<table class="tbl-type01" summary="수성못그림책도서관의 장서현황을 안내해 드립니다.">
				<caption class="disnone">
					수성못그림책도서관의 장서현황
				</caption>
				<colgroup>
					<col width="">
					<col width="14%">
					<col width="14%">
					<col width="14%">
					<col width="14%">
					<col width="14%">
					<col width="14%">
					<col width="14%">
				</colgroup>
				<thead>
					<tr>
						<th>구분</th>
						<th>그림책<br>(국내작가)</th>
						<th>그림책<br>(국외작가)</th>
						<th>빅북</th>
						<th>팝업북</th>
						<th>이론서</th>
						<th>점자도서</th>
						<th>총 계</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<th>수성못그림책도서관</th>
						<td >3,366</td>
						<td >3,871</td>
						<td >119</td>
						<td >15</td>
						<td >77</td>
						<td >30</td>
						<td >7,478</td>
				</tbody>
			</table>
		</div>
		<h3>정기간행물 현황<span class="sm_text sm_text02" style="margin-top:10px;">[기준 : 2025.4.30] (단위 : 종)</span></h3>
		<div class="rsv-info"></div>
		<div class="auto-scroll">
			<table class="tbl-type01" summary="수성못그림책도서관의 정기간행물현황을 안내해 드립니다.">
				<caption class="disnone">
					수성못그림책도서관의 정기간행물현황
				</caption>
			
				<thead>
					<tr>
					<th>구분</th>
					<th>신문</th>
					<th>주간지</th>
					<th>격주간지</th>
					<th>월간지</th>
					<th>격월간지</th>
					<th>계간지</th>
					<th>총 계</th>
					</tr>
				</thead>
				<tbody>
					<tr>
					<th>수성못그림책도서관</th>
					<td>4</td>
					<td>1</td>
					<td>1</td>
					<td>10</td>
					<td>2</td>
					<td>4</td>
					<td>22</td>
					</tr>
				</tbody>
			</table>
		</div>
		<h3>시설안내</h3>
		<div class="rsv-info"></div>
		<div class="auto-scroll">
			<table class="tbl-type01" summary="수성못그림책도서관의 시설안내를 나타내는 표">
				<caption class="disnone">
					수성못그림책도서관의 시설안내
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
						<th rowspan="6">1층</th>
						<td>자료실</td>
						<td>313.55</td>
					</tr>
					<tr>
						<td>열린서가</td>
						<td>23.06</td>
					</tr>
					<tr>
						<td>강좌실</td>
						<td>29.83</td>
					</tr>
					<tr>
						<td>데스크</td>
						<td>20.65</td>
					</tr>
					<tr>
						<td>카페</td>
						<td>13.35</td>
					</tr>
					<tr>
						<td>기타공간(화장실, 기계실 등)</td>
						<td>37.55</td>
					</tr>
					<tr>
						<th colspan="2">총면적</th>
						<td>437.99</td>
					</tr>
				</tbody>
			</table>
		</div>
		<h3>위치안내</h3>
		<ul class="con">
			<li>대구광역시 수성구 무학로 112, 1층</li>
		</ul>
		<img src="/data/menuResources/h51/186/1722999030286.jpg">
		<div class="tel_box02">
			<p>문의 : 053-668-1770</p>
		</div>
		<div style="text-align:center;">
			<div class="link_btn02" style="display:inline-block;"> <a href="https://library.daegu.go.kr/yonghak/board/index.do?menu_idx=35&manage_idx=677&board_idx=0&group_idx=0&category1=004&rowCount=10&_boardIdxArray=on&_boardIdxArray=on&_boardIdxArray=on&_boardIdxArray=on&_boardIdxArray=on&_boardIdxArray=on&_boardIdxArray=on&_boardIdxArray=on&_boardIdxArray=on&_boardIdxArray=on&viewPage=1&searchStartDate=2023-08-01&searchEndDate=2024-08-01&search_type=title%2Bcontent">공지사항 바로가기</a></div>
		</div>
	</div>
</div>
