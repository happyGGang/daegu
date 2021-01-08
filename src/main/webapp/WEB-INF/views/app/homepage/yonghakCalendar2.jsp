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
<style>
.mb10 {
	margin-bottom: 20px;
}
.time_box ul li div {
	background-position: 40px 20px !important;
}

@media all and (min-width: 768px) and (max-width: 1023px) {
.time_box ul li:first-child div, .time_box ul li:nth-child(2) div {
	padding: 30px 20px 30px 120px
}
.time_box ul li:last-child div {
	padding: 20px 20px 40px 120px
}
.time_box ul li.book08 div {
	background-position: 40px 15px !important;
}
}
</style>

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
        <div> <span class="month_info">이번달 휴관일은</span>
          <ul class="close_day">
            <li>불러오는 중...</li>
          </ul>
          <span>일 입니다.</span>
          <p>월요일과 공휴일은 휴관입니다.</p>
        </div>
      </li>
    </ul>
  </div>
  <h3>장서현황<span class="sm_text sm_text02" style="margin-top:10px;">[기준 : 2020.12.31] (단위 : 권)</span></h3>
  <div class="rsv-info"></div>
  <div class="auto-scroll">
    <table class="tbl-type01" summary="무학숲도서관 장서현황을 안내해 드립니다.">
      <caption class="disnone">
      무학숲도서관의 장서현황
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
          <th scope="col">대상</th>
          <th scope="col">총류</th>
          <th scope="col">철학</th>
          <th scope="col">종교</th>
          <th scope="col">사회과학</th>
          <th scope="col">자연과학</th>
          <th scope="col">기술과학</th>
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
          <td>224 </td>
          <td>120 </td>
          <td>81 </td>
          <td>365 </td>
          <td>970 </td>
          <td>334 </td>
          <td>113 </td>
          <td>150 </td>
          <td>1,925 </td>
          <td>716 </td>
          <td>4,998 </td>
        </tr>
        <tr>
          <th scope="row">유아</th>
          <td>61 </td>
          <td>114 </td>
          <td>86 </td>
          <td>420 </td>
          <td>404 </td>
          <td>81 </td>
          <td>87 </td>
          <td>73 </td>
          <td>1,975 </td>
          <td>82 </td>
          <td>3,383 </td>
        </tr>
        <tr>
          <th scope="row">일반</th>
          <td>226 </td>
          <td>374 </td>
          <td>135 </td>
          <td>812 </td>
          <td>458 </td>
          <td>696 </td>
          <td>248 </td>
          <td>129 </td>
          <td>1,945 </td>
          <td>386 </td>
          <td>5,409 </td>
        </tr>
        <tr>
          <th scope="row">합계</th>
          <td>511 </td>
          <td>608 </td>
          <td>302 </td>
          <td>1,597 </td>
          <td>1,832 </td>
          <td>1,111 </td>
          <td>448 </td>
          <td>352 </td>
          <td>5,845 </td>
          <td>1,184 </td>
          <td>13,790 </td>
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
  <div style="font:normal normal 400 12px/normal dotum, sans-serif; width:100%; height:auto; color:#333; position:relative">
    <div style="height: 100%;"><a href="https://map.kakao.com/?urlX=868325.0&amp;urlY=652481.0&amp;itemId=2037913572&amp;q=%EC%88%98%EC%84%B1%EA%B5%AC%EB%A6%BD%EB%AC%B4%ED%95%99%EC%88%B2%EB%8F%84%EC%84%9C%EA%B4%80&amp;srcid=2037913572&amp;map_type=TYPE_MAP&amp;from=roughmap" target="_blank"><img class="map" src="//t1.daumcdn.net/roughmap/imgmap/90c5c96721d6cfb7de64d8d465fd3a771e29841852dfc4856845c165d66ae7c0" width="100%" height="auto"></a></div>
  </div>
  <div class="info_box">
    <p class="info_add">대구광역시 수성구 청수로40길 73-10(지산동)</p>
    <p class="info_tel">053-668-1821</p>
  </div>
  <div style="text-align:center;">
    <div class="link_btn02" style="display:inline-block;"> <a href="https://library.daegu.go.kr/yonghak/board/index.do?menu_idx=35&manage_idx=677&board_idx=0&group_idx=0&category1=003&rowCount=10&_boardIdxArray=on&_boardIdxArray=on&_boardIdxArray=on&_boardIdxArray=on&_boardIdxArray=on&_boardIdxArray=on&_boardIdxArray=on&_boardIdxArray=on&_boardIdxArray=on&_boardIdxArray=on&viewPage=1&searchStartDate=2019-12-28&searchEndDate=2020-12-28&search_type=title%2Bcontent">공지사항 바로가기 </a> </div>
    <div class="link_btn02" style="display:inline-block;"> <a href="/yonghak/module/teach/index.do?menu_idx=32&searchCate1=17">문화강좌 바로가기</a> </div>
  </div>
</div>
