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
      <p>「2022 수성인문학제」 독서디베이트 참여 사례를 작성하여 제출해주세요.</p>
    </div>
  </div>
  <h3>모집요강</h3>
  <ul class="con">
    <li>모집기간 : 9. 13.(화) ~ 9. 30.(금)</li>
    <li>참가대상 : 선착순 30팀(2인 1조)
		<ul class="con2">
			<li>초등 5~6학년 15팀 / 중등 1~3학년 15팀</li>
		</ul>
	</li>
    <li>참가방법 : 주어진 논제에 따라 대전
		<ul class="con2">
			<li>1차 예선전 : 개인전 / 2차 결승전 : 팀전</li>
		</ul>
	</li>
    <li>제출서류 : 참가신청서, 토론개요서, 참가동의서</li>
    <li>접수방법 : 수성구립도서관(범어·용학·고산) 홈페이지 신청 및 방문 접수<br />※ 수성구립도서관(범어·용학·고산) 홈페이지에서 대회규정, 작성방법 숙지 후 서류 제출</li>
  </ul>
  <div class="sm_box02">
    <h4>대회개요</h4>
    <ul class="con">
      <li>도서 : 단톡방을 나갔습니다</li>
      <li>논제 : SNS는 우정을 쌓는데 반드시 필요하다.</li>
      </ul>
    </ul>
  </div>
</div>
<h3>1차 예선전</h3>
<ul class="con">
  <li>대회일시 : 2022. 10. 8.(토) 14:00</li>
  <li>심사방법 : 개인전 – 토론개요서 평가 및 원탁토의(20분)</li>
  <li>결과발표 : 홈페이지 공고 및 유선연락 </li>
</ul>
<h3>독서 디베이트 특강</h3>
<ul class="con">
  <li>강연일시 : 2022. 10. 15.(토) 14:00 ~ 16:00</li>
  <li>대상 : 예선전 합격 8팀 / 총 16명</li>
  <li>주제 : 토론 역량 강화를 위한 워크숍</li>
</ul>
<h3>2차 결승전</h3>
<ul class="con">
  <li>대회일시 : 2022. 10. 22.(토) 10:00 ~ 12:00</li>
  <li>참가대상 : 예선전 합격 8팀 / 총 16명</li>
  <li>심사방법 : 팀별 리그전 및 4강 토너먼트(30분)</li>
  <li>결과발표 : 홈페이지 공고 및 유선연락</li>
</ul>
<h3>시상식</h3>
<ul class="con">
  <li>시상일자 : - 2022. 10. 22.(토) 오후 예정</li>
  <li>시상내역</li>
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
		<th>초등부</th>
		<td>1팀</td>
		<td>1팀</td>
		<td>2팀</td>
	  </tr>
	  <tr>
		<th>중등부</th>
		<td>1팀</td>
		<td>1팀</td>
		<td>2팀</td>
	  </tr>
	  <tr>
		<th colspan="2">상품</th>
		<td>문화상품권 50만원</td>
		<td>문화상품권 30만원</td>
		<td>문화상품권 20만원</td>
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
<a href="https://library.daegu.go.kr/board/boardFile/download/949/480113/292442.do" target="_blank" class="newWin" title="새창으로 열립니다." style="border:1px solid #ddd;padding:7px 15px;font-size:14px;"> 신청서 다운로드&nbsp;&nbsp;<img src="/resources/common/img/download_icon.png"></a>
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
