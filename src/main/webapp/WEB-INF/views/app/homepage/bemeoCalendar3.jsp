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
	$.get('../calendar9.do?manageCode=BD', function(data) {
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
@media all and (min-width: 768px) and (max-width: 1023px) {
	.time_box ul li > div {
		background-position: 30px 10px !important;
	}
}
</style>

<div class="doc-body">
  <div class="time_box">
    <ul>
      <li class="book08" style="width:100%;">
        <div> <span class="month_info">이번달 휴관일은</span>
          <ul class="close_day">
            <li>불러오는 중...</li>
          </ul>
          <span>일 입니다.</span>
          <p>휴관일 안내 : 매주 월요일 및 국경일, 정부지정 공휴일(공휴일과 일요일이 겹칠경우 휴관)</p>
        </div>
      </li>
    </ul>
  </div>
  <h3>시설별 이용시간</h3>
  <div class="rsv-info"></div>
  <div class="auto-scroll">
    <table class="tbl-type01" summary="범어도서관의 시설별 이용시간을 안내해 드립니다.">
      <caption class="disnone">
      시설별 이용시간
      </caption>
      <colgroup>
      <col width="*">
      <col width="35%">
      <col width="35%">
      </colgroup>
      <thead>
        <tr>
          <th scope="col">시설명</th>
          <th scope="col">평일</th>
          <th scope="col">토·일요일</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th scope="row">어린이자료실</th>
          <td>09:00 ~ 18:00</td>
          <td rowspan="3">09:00 ~ 17:00</td>
        </tr>
        <tr>
          <th scope="row">국제자료실</th>
          <td>09:00 ~ 20:00</td>
        </tr>
        <tr>
          <th scope="row">종합자료실 1, 2, 3</th>
          <td>09:00 ~ 20:00</td>
        </tr>
        <tr>
          <th scope="row">크리에이티브팩토리 범어</th>
          <td>10:00 ~ 19:00</td>
          <td>10:00 ~ 16:00</td>
        </tr>
        <tr>
          <th scope="row">카페 더 로즈 범어</th>
          <td>09:00 ~ 18:00</td>
          <td>09:00 ~ 17:00</td>
        </tr>
      </tbody>
    </table>
  </div>
</div>
