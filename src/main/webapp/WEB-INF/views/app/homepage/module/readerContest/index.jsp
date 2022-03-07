<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript">
$(function() {
	
	$('a#apply_btn').on('click', function(e) {
		e.preventDefault();
		doGetLoad('step2.do', serializeCustom($('form#readerContest')));
	});
});
</script>

<form:form modelAttribute="readerContest" id="readerContest" action="step2.do" >
  <form:hidden path="menu_idx"/>
  <input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
  <div class="doc-body">
    <h3>개최개요</h3>
    <div class="time_box">
      <ul>
        <li class="book02 mb10" style="margin-right:20px;">
          <div> <span>사업목적</span>
            <p>독서인구 저변 확대를 위해<br />다독을 장려하는 공모전 진행</p>
          </div>
        </li>
        <li class="book03">
          <div> <span>참가대상</span>
            <p><b>웹형 :</b> 전국민 선착순 장년부 100명<br /><b>책자형 :</b> 전국민 선착순 소년부, 장년부 300명</p>
          </div>
        </li>
      </ul>
    </div>

    <h3>참여방법</h3>
    <ul class="con" style="padding-bottom:0;">
      <li><b>웹형 :</b> SNS 인스타그램(@suseong_lib)에 책표지사진 포함 서평작성 → (#2022수성인문학제#수성북#독서릴레이)태그 후 게재</li>
      <li><b>책자형</b></li>
    </ul>
    </ul>
	<div class="step_box">
      <ol class="no4">
        <li>
        <div class="box">
          <p class="num">STEP 01</p>
          수성구립도서관 홈페이지 <br>독서노트 신청
        </div>
        </li>
        <li>
        <div class="box">
          <p class="num">STEP 02</p>
          도서관 방문수령<br>(독서노트)
        </div>
        </li>
        <li>
        <div class="box">
          <p class="num">STEP 03</p>
          다독 및<br />서평작성
        </div>
        </li>
        <li>
        <div class="box style1">
          <p class="num">STEP 04</p>
          도서관 방문<br>독서노트 제출
        </div>
        </li>
      </ol>
    </div>
	<ul class="con2">
		<li>단, 2022수성북 1권 이상 포함해서 서평작성</li>
		<li>단, 서평 1건당 300자 이상 ~ 1000자 이내</li>
	</ul>

	<h3>신청기간</h3>
    <ul class="con">
      <li><b>웹형 :</b> 2022. 4. 1.(금) ~ 9. 30.(금) ※온라인은 최초 1건 등록일 기준</li>
      <li><b>책자형 :</b> 2022. 9. 1.(목) ~ 9. 30.(금)</li>
      </ul>
    </ul>

    <div class="sm_box02 note_img">
      <h4>독서노트소개</h4>
      <ul class="con">
        <li>[웹형]</li>
        <ul>
          <li class="dep01">인스타그램(@suseong_lib 게시물 확인)  </li>
        </ul>
        <li>[책자형]</li>
        <ul style="padding-bottom:0;">
          <li class="dep01">배부기간 : 3. 16.(수) ~ 소진시까지</li>
          <li class="dep01">배부처 : 수성구립도서관(범어·용학·고산)</li>
          <li class="dep01">배부방법 : 홈페이지 신청서 작성 → 방문수령</li>
        </ul>
      </ul>
    </div>

    <h3>심사방법</h3>
    <div class="sm_box02">
      <ul class="con" style="padding-bottom:0;">
        <li>웹형 : 표절방지프로그램 CopyKiller 사용 
        <li>웹형, 책자형 : 외부심사위원 위촉 심사</li>
      </ul>
    </div>

    <h3>시상</h3>
    <ul class="con">
      <li>발표 : 2022년 10월 중 개별통보 및 홈페이지 발표</li>
      <li>시상 : 인문학대잔치(10월 중)</li>
      <li>시상내역</li>
    </ul>
    <div class="rsv-info"></div>
    <div class="auto-scroll">
      <table class="tbl-type01" summary="다독자 공모 시상내역을 나타내는 표">
        <caption class="disnone">
        다독자 공모 시상내역
        </caption>
        <colgroup>
        <col width="*">
        <col width="11%">
        <col width="11%">
        <col width="11%">
        <col width="11%">
        <col width="11%">
        <col width="11%">
        <col width="11%">
        <col width="11%">
        </colgroup>
        <thead>
          <tr>
            <th rowspan="2">구분/대상</th>
            <th colspan="4">소년부</th>
            <th colspan="4">장년부</th>
          </tr>
          <tr>
            <th class="no-line">수성 독서대상</th>
            <th class="no-line">최우수</th>
            <th class="no-line">우수</th>
            <th class="no-line">장려</th>
            <th class="no-line">수성 독서대상</th>
            <th class="no-line">최우수</th>
            <th class="no-line">우수</th>
            <th class="no-line">장려</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <th>온라인</th>
			<td colspan="4">-</td>
			<td rowspan="2">1명</td>
			<td>1명</td>
			<td>1명</td>
			<td>2명</td>
          </tr>
          <tr>
            <th>오프라인</th>
			<td>1명</td>
			<td>1명</td>
			<td>1명</td>
			<td>2명</td>
			<td>1명</td>
			<td>1명</td>
			<td>2명</td>
          </tr>
          <tr>
            <th>상품</th>
			<td>갤럭시탭</td>
			<td>무선 이어폰</td>
			<td>무선고속 충전기</td>
			<td>블루투스 스피커</td>
			<td>갤럭시탭</td>
			<td>무선 이어폰</td>
			<td>무선고속 충전기</td>
			<td>블루투스 스피커</td>
          </tr>
        </tbody>
      </table>
    </div>
    <ul class="con">
      <li class="bg_none" style="padding:10px 0 2px;">※ 상품금액에 의한 제세공과금 본인부담</li>
      <li class="bg_none" style="padding-left:0;">※ 훈격과 시상인원은 참여인원 및 심사결과에 따라 조정 가능</li>
    </ul>
  </div>
  <div class="link_btn02"> <a href="#" id="apply_btn">참여신청</a> </div>
</form:form>
