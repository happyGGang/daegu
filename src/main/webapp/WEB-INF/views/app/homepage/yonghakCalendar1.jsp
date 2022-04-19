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
$.get('../calendar9.do?manageCode=BG', function(data) {
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
  <h3>장서현황<span class="sm_text sm_text02" style="margin-top:10px;">[기준 : 2022.3.31.] (단위 : 권)</span></h3>
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
      <th>어린이</th>
    <td>687</td>
    <td>340</td>
    <td>146</td>
    <td>849</td>
    <td>1,250</td>
    <td>381</td>
    <td>320</td>
    <td>263</td>
    <td>3,876</td>
    <td>1,206</td>
    <td>9,318</td>
    </tr>
    <tr>
      <th>유아</th>
    <td>66</td>
    <td>84</td>
    <td>42</td>
    <td>853</td>
    <td>404</td>
    <td>82</td>
    <td>77</td>
    <td>76</td>
    <td>2,635</td>
    <td>34</td>
    <td>4,353</td>
    </tr>
    <tr>
      <th>일반</th>
    <td>514</td>
    <td>961</td>
    <td>309</td>
    <td>2,194</td>
    <td>645</td>
    <td>1,216</td>
    <td>594</td>
    <td>324</td>
    <td>5,488</td>
    <td>1,066</td>
    <td>13,311</td>
    </tr>
    <tr>
      <th>합계</th>
    <td>1,267</td>
    <td>1,385</td>
    <td>497</td>
    <td>3,896</td>
    <td>2,299</td>
    <td>1,679</td>
    <td>991</td>
    <td>663</td>
    <td>11,999</td>
    <td>2,306</td>
    <td>26,982</td>
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
    <col width="20%">
    <col width="20%">
    <col width="20%">
    <col width="20%">
    </colgroup>
    <thead>
    <tr>
      <th>구분</th>
      <th>신문</th>
      <th>주간지</th>
      <th>월간지</th>
      <th>총 계</th>
    </tr>
    </thead>
    <tbody>
    <tr>
      <th>파동도서관</th>
      <td>3</td>
      <td>1</td>
      <td>11</td>
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
  <div style="font:normal normal 400 12px/normal dotum, sans-serif; width:100%; height:auto; color:#333; position:relative">
    <div style="height: 100%;"><a href="https://map.kakao.com/?urlX=865655.0&amp;urlY=645547.0&amp;itemId=12364926&amp;q=%ED%8C%8C%EB%8F%99%EB%8F%84%EC%84%9C%EA%B4%80&amp;srcid=12364926&amp;map_type=TYPE_MAP&amp;from=roughmap" target="_blank"><img class="map" src="//t1.daumcdn.net/roughmap/imgmap/7b0723edb6d2359b38b180f8b82fb26473f04ea195b405fe2b43da2dffdc0790" width="100%" height="auto" ></a></div>
  </div>
  <div class="info_box">
    <p class="info_add">대구광역시 수성구 파동로3길 62 파동평생학습센터 1층</p>
    <p class="info_tel">053-668-1801</p>
  </div>
  <div style="text-align:center;">
    <div class="link_btn02" style="display:inline-block;"> <a href="https://library.daegu.go.kr/yonghak/board/index.do?menu_idx=35&manage_idx=677&board_idx=0&group_idx=0&category1=002&rowCount=10&_boardIdxArray=on&_boardIdxArray=on&_boardIdxArray=on&_boardIdxArray=on&_boardIdxArray=on&_boardIdxArray=on&_boardIdxArray=on&_boardIdxArray=on&_boardIdxArray=on&_boardIdxArray=on&viewPage=1&searchStartDate=2019-12-28&searchEndDate=2020-12-28&search_type=title%2Bcontent">공지사항 바로가기 </a> </div>
    <div class="link_btn02" style="display:inline-block;"> <a href="/yonghak/module/teach/index.do?menu_idx=100&searchCate1=30&homepage_id=h51">문화강좌 바로가기</a> </div>
  </div>
</div>
