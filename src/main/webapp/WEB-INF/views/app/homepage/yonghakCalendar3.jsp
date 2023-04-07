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
  <div class="time_box">
    <ul>
      <li class="book08" style="width:100%;">
        <div> <span class="month_info">이번달 휴관일은</span>
          <ul class="close_day">
            <li>불러오는 중...</li>
          </ul>
          <span>일 입니다.</span>
          <p>휴관일을 확인하셔서 이용에 불편이 없으시길 바랍니다.</p>
        </div>
      </li>
    </ul>
  </div>
  <h3>시설별 이용시간</h3>
  <div class="rsv-info"></div>
  <div class="auto-scroll">
    <table class="tbl-type01" summary="용학도서관 시설별 이용시간을 안내해 드립니다.">
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
          <td>09:00~18:00</td>
          <td rowspan="2">09:00~17:00</td>
        </tr>
        <tr>
          <th scope="row">종합자료실</th>
          <td rowspan="2">09:00~22:00</td>
        </tr>
        <tr>
          <th scope="row">일반열람실</th>
          <td>09:00~22:00</td>
        </tr>
        <tr>
          <th scope="row">독서토론실</th>
          <td>09:00~20:00</td>
          <td>09:00~16:00</td>
        </tr>
      </tbody>
    </table>
  </div>
</div>
