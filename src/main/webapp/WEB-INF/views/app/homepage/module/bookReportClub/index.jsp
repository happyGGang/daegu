<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript">
$(function() {

	$('select#rowCount').on('change', function() {
		$('#viewPage').val(1);
		doGetLoad('index.do', $('form#bookReportClub').serialize());
	});
	
	$('a.view_btn').on('click', function(e){
		e.preventDefault();
		$('#book_report_idx').val($(this).data('key'));
		doGetLoad('view.do', serializeCustom($('form#bookReportClub')));
	});
	
	$('a#apply_btn').on('click', function(e) {
		e.preventDefault();
		doGetLoad('step2.do', serializeCustom($('form#bookReportClub')));
	});
	
	$('button#search_btn').on('click', function(e){
		e.preventDefault();
		$('#viewPage').val(1);
		doGetLoad('index.do', serializeCustom($('form#bookReportClub')));
	});
});
</script>
<style>
	.step_box ol li{background:url("/resources/common/img/bu_arrow.png") no-repeat 8px 50px}
</style>
<div class="doc-body">
  <div class="roomicon">
    <div class="inner icowrap"><span class="ico ico5"></span> <strong>인문독서동아리 경연대회</strong>
      <p>우수한 독서동아리 사례를 발표하는 자리를 마련하여 독서동아리 활성화 계기 마련 및 사기 진작</p>
    </div>
  </div>
  <h3>모집요강</h3>
  <ul class="con">
    <li>운영기간 : 9월 ~ 10월  </li>
    <li>참여대상 : 전국에서 활동 중인 인문독서동아리 
		<ul class="con2">
			<li>상시 활동 중인 8인 이상의 동아리</li>
			<li>2년 이상의 활동실적이 경과한 동아리</li>
			<li>매월 1회 이상 독서모임 진행 중인 동아리<br />※ 정치, 종교, 상업 등 특수 목적 동아리는 신청불가</li>
    <li>방법 : 현장발표 및 심사</li>
  </ul>
  <h4>추진절차</h4>
  <div class="step_box">
    <ol class="no3">
      <li>
        <div class="box">
          <p class="num">모집</p>
          9.13.(화)~9.30(금)</div>
      </li>
      <li>
        <div class="box">
          <p class="num">발표 및 심사</p>
          10.15.(토)</div>
      </li>
      <li>
        <div class="box">
          <p class="num">시상식</p>
          10.22.(토)</div>
      </li>
    </ol>
  </div>
</div>
<h3>모집</h3>
<ul class="con">
  <li>모집기간 : 9. 13.(화) ~ 9. 30.(금)</li>
  <li>모집방법 : 도서관 홈페이지 게시판 신청 및 방문접수</li>
  <li>참여대상 : 선착순 20팀(소년부 및 장년부 각 10팀정도)</li>
  <li>제출서류 : 참가신청서, 독서동아리 소개서, 발표개요서</li>
</ul>
<h3>발표 및 심사</h3>
<ul class="con">
  <li>발표일자 : 10. 15.(토) 10:00~12:00</li>
  <li>참가대상 : 전국민 독서동아리</li>
  <li>방법 : 독서동아리 활동내용을 5분이상 발표, 자유형식</li>
  <li>결과발표 : 홈페이지 공고 및 유선연락  </li>
</ul>
<h3>시상식</h3>
<ul class="con">
  <li>시상일시 : 10. 22.(토) 15:00  </li>
  <li>장소 : 1층 야외광장 무대</li>
  <li>시상사항(5팀)</li>
</ul>
<div class="rsv-info"></div>
<div class="auto-scroll">
  <table class="tbl-type01" summary="독서디베이트 대회 시상내역을 나타내는 표">
    <caption class="disnone">
    독후감 공모 시상내역
    </caption>
    <colgroup>
    <col width="12.5%">
    <col width="12.5%">
    <col width="25%">
    <col width="25%">
    <col width="25%">
    </colgroup>
    <thead>
      <tr>
        <th scope="col" colspan="2">구분</th>
        <th scope="col">대상</th>
        <th scope="col">최우수</th>
        <th scope="col">우수</th>
      </tr>
    </thead>
    <tbody>
	  <tr>
		<th rowspan="2">시상팀</th>
		<th>소년부</th>
		<td rowspan="2">1팀</td>
		<td>1팀</td>
		<td>1팀</td>
	  </tr>
	  <tr>
		<th>장년부</th>
		<td>1팀</td>
		<td>1팀</td>
	  </tr>
	  <tr>
		<th colspan="2">상품</th>
		<td>문화상품권 500,000원</td>
		<td>문화상품권 300,000원</td>
		<td>문화상품권 200,000원</td>
	  </tr>
	  <tr>
		<th colspan="2">훈격</th>
		<td>수성구청장</td>
		<td>수성구의회의장</td>
		<td>범어도서관장</td>
	  </tr>
    </tbody>
  </table>
</div>
<ul class="con">
  <li class="bg_none" style="padding:10px 0 2px;">※ 훈격과 시상인원은 참여인원 및 심사결과에 따라 조절될 수 있음</li>
</ul>
<a href="https://library.daegu.go.kr/board/boardFile/download/949/480172/292543.do" target="_blank" class="newWin" title="새창으로 열립니다." style="border:1px solid #ddd;padding:7px 15px;font-size:14px;"> 신청서 다운로드&nbsp;&nbsp;<img src="/resources/common/img/download_icon.png"></a>
<form:form modelAttribute="bookReportClub" id="bookReportClub" action="edit.do" >
  <form:hidden path="menu_idx"/>
  <form:hidden path="homepage_id"/>
  <form:hidden path="book_club_idx"/>
  <input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
    <div class="link_btn02"> <a href="#" id="apply_btn">참여신청</a> </div>
</form:form>
