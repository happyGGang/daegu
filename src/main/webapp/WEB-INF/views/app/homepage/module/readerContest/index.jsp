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
          <div> <span>참가자격</span>
            <p>수성구립도서관 이용자</p>
          </div>
        </li>
        <li class="book03">
          <div> <span>신청기간</span>
            <p>2021. 3. 24.(수) ~ 9. 30.(목)</p>
          </div>
        </li>
      </ul>
    </div>
    <h3>참여방법</h3>
    <ul class="con">
      <li>「2021 수성북」 1권 이상을 포함해서 서평 작성</li>
      <li>서평 1건당 300자 ~ 1,000자 이내</li>
      <li>오프라인</li>
      <ul>
        <li class="dep01">제출기간 : 9. 1.(수) ~ 9. 30.(목)</li>
        <li class="dep01">방　　법 : 독서노트 방문 제출(범어‧용학‧고산도서관)</li>
      </ul>
      <li>온라인</li>
      <ul>
        <li class="dep01">제출기간 : 3. 24.(수) ~ 9. 30.(목)</li>
        <li class="dep01">방　　법 : 책표지 사진, 서평 게재(@suseong_lib 게시물 참고)</li>
      </ul>
    </ul>
    <div class="sm_box02 note_img">
      <h4>독서노트소개</h4>
      <ul class="con">
        <li>[책자형]</li>
        <ul>
          <li class="dep01">배부기간 : 3. 24.(수) ~ 소진시</li>
          <li class="dep01">배부처 : 수성구립도서관(범어·용학·고산)</li>
          <li class="dep01">배부방법 : 신청서 작성(홈페이지) → 방문수령</li>
        </ul>
        <li>[웹형]</li>
        <ul>
          <li class="dep01">인스타그램(@suseong_lib) 게시물 확인 → 책표지 사진 포함 서평작성(#2021수성인문학제#수성북#독서릴레이 태그 후 게재)</li>
        </ul>
      </ul>
    </div>
    <h3>시상</h3>
    <ul class="con">
      <li>발표 : 2021년 10월 중 개별 통보 및 홈페이지 발표</li>
      <li>시상 : 인문학대잔치(10월 예정)</li>
      <li>시상내역</li>
    </ul>
    <div class="rsv-info"></div>
    <div class="auto-scroll">
      <table class="tbl-type01" summary="다독자 공모 시상내역을 나타내는 표">
        <caption class="disnone">
        다독자 공모 시상내역
        </caption>
        <colgroup>
        <col width="20%">
        <col width="15%">
        <col width="15%">
        <col width="15%">
        <col width="15%">
        <col width="*">
        </colgroup>
        <thead>
          <tr>
            <th colspan="6">독서릴레이 우수 사례(단체)</th>
          </tr>
          <tr>
            <th rowspan="2" class="no-line">상훈/대상
              </td>
            <th colspan="2" class="no-line">소년부
              </td>
            <th colspan="2" class="no-line">장년부
              </td>
            <th class="no-line">상품
              </td>
          </tr>
          <tr>
            <th class="no-line">온라인</th>
            <th class="no-line">오프라인</th>
            <th class="no-line">온라인</th>
            <th class="no-line">오프라인</th>
            <th class="no-line">　</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <th>수성독서대상</th>
            <td colspan="2">1</td>
            <td colspan="2">1</td>
            <td>갤럭시 탭</td>
          </tr>
          <tr>
            <th>최우수</th>
            <td>1</td>
            <td>1</td>
            <td>1</td>
            <td>1</td>
            <td>무선 이어폰</td>
          </tr>
          <tr>
            <th>우수</th>
            <td>1</td>
            <td>1</td>
            <td>1</td>
            <td>1</td>
            <td>무선 고속충전기</td>
          </tr>
          <tr>
            <th>장려</th>
            <td>2</td>
            <td>2</td>
            <td>2</td>
            <td>2</td>
            <td>블루투스 스피커</td>
          </tr>
        </tbody>
      </table>
    </div>
    <ul class="con">
      <li class="bg_none" style="padding:10px 0 2px;">※ 상품금액에 의한 제세공과금 본인부담</li>
      <li class="bg_none" style="padding-left:0;">※ 훈격과 시상인원은 참여인원 및 심사결과에 따라 조정 가능</li>
    </ul>
    <h3>심사방법</h3>
    <div class="sm_box02">
      <ul class="con">
        <li>표절방지프로그램 CopyKiller 사용, 표절이 판단될 경우 미인정
        <li>심사위원 위촉, 심사</li>
      </ul>
    </div>
  </div>
  <div class="link_btn02"> <a href="#" id="apply_btn">참여신청</a> </div>
</form:form>
