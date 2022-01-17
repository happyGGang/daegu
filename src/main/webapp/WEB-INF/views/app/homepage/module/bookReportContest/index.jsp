<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript">
$(function() {

	$('select#rowCount').on('change', function() {
		$('#viewPage').val(1);
		doGetLoad('index.do', $('form#bookReportContest').serialize());
	});
	
	$('a.view_btn').on('click', function(e){
		e.preventDefault();
		$('#book_report_idx').val($(this).data('key'));
		doGetLoad('view.do', serializeCustom($('form#bookReportContest')));
	});
	
	$('a#apply_btn').on('click', function(e) {
		e.preventDefault();
		doGetLoad('step2.do', serializeCustom($('form#bookReportContest')));
	});
	
	$('button#search_btn').on('click', function(e){
		e.preventDefault();
		$('#viewPage').val(1);
		doGetLoad('index.do', serializeCustom($('form#bookReportContest')));
	});
});
</script>
<div class="doc-body">
  <div class="roomicon">
    <div class="inner icowrap"><span class="ico ico5"></span> <strong>독서디베이트 대회</strong>
      <p>「2021 수성인문학제」 독서디베이트 참여 사례를 작성하여 제출해주세요.</p>
    </div>
  </div>
  <h3>참여방법</h3>
  <ul class="con">
    <li>모집기간 : 9. 1.(수) ~ 9. 25.(토)</li>
    <li>제출서류 : 참가신청서, 토론개요서(요약서, 입론서), 규정 준수 및 심사결과 동의서</li>
    <li>참여방법 : 수성구립도서관(범어·용학·고산) 홈페이지 신청 및 방문<br>
      ※ 수성구립도서관(범어·용학·고산) 홈페이지에서 대회규정, 작성방법 등 숙지한 후 제출서류 작성 후 제출</li>
    <li>참가대상 : 초등 5~6학년, 중학생(2인 1팀)</li>
    <li>참가방법 : 주어진 논제에 따라 팀별 대전(예선 및 본선)</li>
  </ul>
  <div class="sm_box02">
    <h4>대회개요</h4>
    <ul class="con">
      <li>2021 : 논제</li>
      <ul>
        <li class="dep01">예선 : 꿈은 꼭 있어야 할까?</li>
        <li class="dep01">본선 : 미래를 위해 현재를 참아야 할까?</li>
      </ul>
    </ul>
  </div>
</div>
<h3>1차 예선</h3>
<ul class="con">
  <li> 방 법 : 온라인 신청서 및 토론개요소 평가 후 본선 진출자 4팀 선정</li>
  <li>결 과 : 2021. 9. 30.(목) ※ 홈페이지 결과 발표 및 유선연락 <br>
    ※ 본선 진출 4팀 사전교육 토론역량강화 및 K-CEDA 디베이트 기법 2021. 10. 2.(토) 예정 </li>
</ul>
<h3>본선 </h3>
<ul class="con">
  <li>대회일시 : 2021. 10. 16.(토) 11:00</li>
</ul>
<h3>시상</h3>
<ul class="con">
  <li>시상식 : 2021. 10. 16.(토) 15:30(예정)</li>
  <li>시상내역</li>
</ul>
<div class="rsv-info"></div>
<div class="auto-scroll">
  <table class="tbl-type01" summary="독서디베이트 대회 시상내역을 나타내는 표">
    <caption class="disnone">
    독후감 공모 시상내역
    </caption>
    <colgroup>
    <col width="15%">
    <col width="">
    <col width="">
    <col width="">
    </colgroup>
    <thead>
      <tr>
        <th scope="col">구 분</th>
        <th scope="col">최우수</th>
        <th scope="col">우수</th>
        <th scope="col">장려</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <th>시상팀</th>
        <td>1팀</td>
        <td>1팀</td>
        <td>2팀</td>
      </tr>
      <tr>
        <th>상품</th>
        <td>문화상품권 40만원</td>
        <td>문화상품권 20만원</td>
        <td>문화상품권 10만원</td>
      </tr>
    </tbody>
  </table>
</div>
<ul class="con">
  <li class="bg_none" style="padding:10px 0 2px;">※ 상품금액에 의한 제세공과금 본인부담</li>
  <li class="bg_none" style="padding-left:0;">※ 훈격과 시상인원은 참여인원 및 심사결과에 따라 조정 가능</li>
</ul>
<a href="https://library.daegu.go.kr/board/boardFile/download/761/453990/258556.do" target="_blank" class="newWin" title="새창으로 열립니다." style="border:1px solid #ddd;padding:7px 15px;font-size:14px;"> 신청서 다운로드&nbsp;&nbsp;<img src="/resources/common/img/download_icon.png"></a>
<form:form modelAttribute="bookReportContest" id="bookReportContest" action="edit.do" >
  <form:hidden path="menu_idx"/>
  <form:hidden path="homepage_id"/>
  <form:hidden path="book_report_idx"/>
  <input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
    <div class="link_btn02"> <a href="#" id="apply_btn">참여신청</a> </div>
    <!-- 20210902 게시판 주석처리 YUNHAESU -->
  <%-- 
  <div class="infodesk"> 총 <b style="color:#ff0000;">${paging.totalDataCount}</b>건
    <form:select path="rowCount" cssClass="selectmenu new_select_box">
      <form:option value="10">10개씩보기</form:option>
      <form:option value="20">20개씩보기</form:option>
      <form:option value="30">30개씩보기</form:option>
      <form:option value="50">50개씩보기</form:option>
      <form:option value="100">100개씩보기</form:option>
      <form:option value="${paging.totalDataCount}">전체 보기</form:option>
    </form:select>
  </div>
  
  <div class="wrapper-bbs">
    <div class="table-wrap">
      <table class="bbs center" summary="독서릴레이 우수사례공모">
        <caption>
        독서릴레이 우수사례공모
        </caption>
        <colgroup>
        <col width="10%">
        <col width="15%">
        <col width="20%">
        <col width="30%">
        <col width="">
        </colgroup>
        <thead>
          <tr>
            <th scope="col">번호</th>
            <th scope="col">성명</th>
            <th scope="col">학교명</th>
            <th scope="col">등록일</th>
          </tr>
        </thead>
        <tbody id="board_tbody">
          <c:forEach var="i" varStatus="status" items="${bookReportContestList}">
            <tr>
              <td>${paging.listRowNum - status.index}</td>
              <c:choose>
                <c:when test="${authMBA or member.admin}">
                  <c:set var="user_name" value="${i.user_name}"/>
                </c:when>
                <c:otherwise>
                  <c:set var="user_name" value="${fn:substring(i.user_name, -1, 1)}**"/>
                </c:otherwise>
              </c:choose>
              <td><a href="#" class="view_btn" data-key="${i.book_report_idx}">${user_name}</a></td>
              <td>${i.school_name}</td>
              <td><fmt:formatDate value="${i.add_date}" pattern="yyyy-MM-dd" /></td>
            </tr>
          </c:forEach>
          <c:if test="${fn:length(bookReportContestList) < 1}">
            <tr>
              <td class="dataEmpty" colspan="5">등록된 게시물이 없습니다.</td>
            </tr>
          </c:if>
        </tbody>
      </table>
    </div>
    <jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
    <jsp:param name="formId" value="#bookReportContest"/>
    </jsp:include>
    <div class="search txt-center" style="margin-top:25px;"><!-- 하단 정렬 시 margin-top 입력 -->
      <fieldset>
        <form:select path="search_type" cssClass="selectmenu new_select_box">
          <form:option value="user_name">이름</form:option>
          <form:option value="school_name">학교명</form:option>
        </form:select>
        <form:input path="search_text" cssClass="text new_text01" cssStyle="width:200px;"/>
        <button id="search_btn" style="background:none;background-color:#2c75cb;border-color:#1962ba;padding:5px 10px 6px;"><i class="fa fa-search"></i><span>검색</span></button>
      </fieldset>
    </div>
  </div> --%>
</form:form>
