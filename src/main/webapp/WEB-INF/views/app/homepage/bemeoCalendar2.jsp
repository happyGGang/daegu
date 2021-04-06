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
        <div> <span>평일 09:00 ~ 18:00</span> </div>
      </li>
      <li class="book11 mb10">
        <div> <span>주말 09:00 ~ 17:00</span> </div>
      </li>
      <li class="book08" style="width:100%;">
        <div> <span class="month_info">이번달 휴관일은</span>
          <ul class="close_day">
            <li>불러오는 중...</li>
          </ul>
          <span>일 입니다.</span>
          <p>일요일과 공휴일은 휴관입니다.</p>
        </div>
      </li>
    </ul>
  </div>
  <h3>자료현황<span class="sm_text sm_text02" style="margin-top:10px;">[2021.3.31. 기준] (단위 : 권)</span></h3>
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
    <td>237</td>
    <td>475</td>
    <td>169</td>
    <td>862</td>
    <td>312</td>
    <td>750</td>
    <td>296</td>
    <td>190</td>
    <td>2,761</td>
    <td>691</td>
    <td>6,743</td>
    <td>22.0</td>
        </tr>
        <tr>
          <th>아동</th>
    <td>709</td>
    <td>335</td>
    <td>232</td>
    <td>1,022</td>
    <td>1,365</td>
    <td>306</td>
    <td>336</td>
    <td>327</td>
    <td>4,965</td>
    <td>1,671</td>
    <td>11,268</td>
    <td>36.8</td>
        </tr>
        <tr>
          <th>유아</th>
    <td>28</td>
    <td>23</td>
    <td>7</td>
    <td>522</td>
    <td>246</td>
    <td>41</td>
    <td>105</td>
    <td>46</td>
    <td>2,305</td>
    <td>150</td>
    <td>3,473</td>
    <td>11.4</td>
        </tr>
        <tr>
          <th>영어</th>
    <td>113</td>
    <td>1</td>
    <td>6</td>
    <td>129</td>
    <td>239</td>
    <td>18</td>
    <td>39</td>
    <td>1,285</td>
    <td>1,583</td>
    <td>22</td>
    <td>3,435</td>
    <td>11.2</td>
        </tr>
        <tr>
          <th>보존서고 </th>
    <td>571</td>
    <td>185</td>
    <td>53</td>
    <td>941</td>
    <td>574</td>
    <td>139</td>
    <td>123</td>
    <td>146</td>
    <td>2,343</td>
    <td>595</td>
    <td>5,670</td>
    <td>18.5</td>
        </tr>
        <tr>
          <th>총계(권)</th>
    <td>1,658</td>
    <td>1,019</td>
    <td>467</td>
    <td>3,476</td>
    <td>2,736</td>
    <td>1,254</td>
    <td>899</td>
    <td>1,994</td>
    <td>13,957</td>
    <td>3,129</td>
    <td>30,589</td>
    <td>100</td>
        </tr>
        <tr>
          <th>비율(%)</th>
    <td>5.4</td>
    <td>3.3</td>
    <td>1.5</td>
    <td>11.4</td>
    <td>8.9</td>
    <td>4.1</td>
    <td>2.9</td>
    <td>6.5</td>
    <td>45.6</td>
    <td>10.2</td>
    <td>100</td>
    <td>　</td>
        </tr>
      </tbody>
    </table>
  </div>
  <h3>간행물 현황<span class="sm_text sm_text02" style="margin-top:10px;">[2021.3.31. 기준] (단위 : 권)</span></h3>
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
  <div style="font:normal normal 400 12px/normal dotum, sans-serif; width:100%; height:auto; color:#333; position:relative">
    <div style="height: auto;"> <a href="https://map.kakao.com/?urlX=865623.0&amp;urlY=657839.0&amp;itemId=24011085&amp;q=%EC%88%98%EC%84%B12%2C3%EA%B0%80%EB%8F%99%ED%96%89%EC%A0%95%EB%B3%B5%EC%A7%80%EC%84%BC%ED%84%B0&amp;srcid=24011085&amp;map_type=TYPE_MAP&amp;from=roughmap" target="_blank"> <img class="map" src="//t1.daumcdn.net/roughmap/imgmap/39006293b240dc34651c4df5353b2025c26a7773052d165b522c2f4c3ed36452" width="100%" height="auto"> </a> </div>
  </div>
  <div class="info_box">
    <p class="info_add">대구광역시 수성구 명덕로 443-2(수성동3가) 수성2,3가동 행정복지센터 4층</p>
    <p class="info_tel">053-666-4390</p>
  </div>
</div>
