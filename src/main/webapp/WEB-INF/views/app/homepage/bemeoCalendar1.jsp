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
	$.get('../calendar9.do?manageCode=BJ', function(data) {
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
  <h3>자료현황<span class="sm_text sm_text02" style="margin-top:10px;">[2021.7.31. 기준] (단위 : 권)</span></h3>
  <div class="rsv-info"></div>
  <div class="auto-scroll">
    <table class="tbl-type01" summary="책숲길도서관 장서현황을 나타내는 표">
      <caption class="disnone">
      책숲길도서관 장서현황
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
          <td>462</td>
          <td>679</td>
          <td>221</td>
          <td>1,494</td>
          <td>297</td>
          <td>1,500</td>
          <td>459</td>
          <td>235</td>
          <td>4,616</td>
          <td>784</td>
          <td>10,747</td>
          <td>33.6</td>
        </tr>
        <tr>
          <th>아동</th>
          <td>720</td>
          <td>256</td>
          <td>104</td>
          <td>771</td>
          <td>1,153</td>
          <td>234</td>
          <td>243</td>
          <td>257</td>
          <td>3,648</td>
          <td>1,252</td>
          <td>8,638</td>
          <td>27.0</td>
        </tr>
        <tr>
          <th>유아</th>
          <td>67</td>
          <td>52</td>
          <td>19</td>
          <td>865</td>
          <td>606</td>
          <td>96</td>
          <td>65</td>
          <td>31</td>
          <td>2,788</td>
          <td>23</td>
          <td>4,612</td>
          <td>14.4</td>
        </tr>
        <tr>
          <th>영어</th>
          <td>1</td>
          <td>1</td>
          <td>3</td>
          <td>154</td>
          <td>161</td>
          <td>18</td>
          <td>39</td>
          <td>834</td>
          <td>1,240</td>
          <td>26</td>
          <td>2,477</td>
          <td>7.8</td>
        </tr>
        <tr>
          <th>보존서고 </th>
          <td>149</td>
          <td>125</td>
          <td>58</td>
          <td>970</td>
          <td>790</td>
          <td>239</td>
          <td>218</td>
          <td>348</td>
          <td>2,075</td>
          <td>497</td>
          <td>5,469</td>
          <td>17.1</td>
        </tr>
        <tr>
          <th>총계(권)</th>
          <td>1,399</td>
          <td>1,113</td>
          <td>405</td>
          <td>4,254</td>
          <td>3,007</td>
          <td>2,087</td>
          <td>1,024</td>
          <td>1,705</td>
          <td>14,367</td>
          <td>2,582</td>
          <td>31,943</td>
          <td>100</td>
        </tr>
        <tr>
          <th>비율(%)</th>
          <td>4.4</td>
          <td>3.5</td>
          <td>1.3</td>
          <td>13.3</td>
          <td>9.4</td>
          <td>6.5</td>
          <td>3.2</td>
          <td>5.3</td>
          <td>45.0</td>
          <td>8.1</td>
          <td>100</td>
          <td>　</td>
        </tr>
      </tbody>
    </table>
  </div>
  <h3>간행물 현황<span class="sm_text sm_text02" style="margin-top:10px;">[2021.7.31. 기준] (단위 : 권)</span></h3>
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
          <td>14</td>
          <td>2</td>
          <td>0</td>
          <td>19</td>
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
  <div style="font:normal normal 400 12px/normal dotum, sans-serif; width:100%; height:auto; color:#333; position:relative">
    <div style="height: auto;"> <a href="https://map.kakao.com/?urlX=864171.0&amp;urlY=655073.0&amp;itemId=12296217&amp;q=%EC%88%98%EC%84%B1%EA%B5%AC%EB%A6%BD%20%EC%B1%85%EC%88%B2%EA%B8%B8%EB%8F%84%EC%84%9C%EA%B4%80&amp;srcid=12296217&amp;map_type=TYPE_MAP&amp;from=roughmap" target="_blank"> <img class="map" src="//t1.daumcdn.net/roughmap/imgmap/227cf995a7796d24750d1e7d5e7ce6d91b4b6f2cf653aa617604435fb7d283d5" width="100%" height="auto"> </a> </div>
  </div>
  <div class="info_box">
    <p class="info_add">대구시 수성구 수성로215(중동) 수옥빌딩 4층</p>
    <p class="info_tel">053-668-1811</p>
  </div>
</div>
