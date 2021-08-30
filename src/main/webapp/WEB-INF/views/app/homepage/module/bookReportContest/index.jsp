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
		doGetLoad('edit.do', serializeCustom($('form#bookReportContest')));
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
      <p><2021 수성인문학제></p>
    </div>
  </div>
  <h3>참여방법</h3>
  <ul class="con">
    <li>모집기간
    <ul class="con2">
      <li>2021-09-01(수) ~ 2021-09.25(토)</li>
    </ul>
    <li>제출서류</li>
    <ul class="con2">
      <li>참가신청서, 토론개요소(요약서, 입론서), 규정 준수 및 심사결과 동의서</li>
    </ul>
    <li>참여방법</li>
    <ul class="con2">
      <li>수성구립도서관(범어·용학·고산) 홈페이지 신청 및 방문</li>
      <li>※ 수성구립도서관(범어·용학·고산) 홈페이지에서 대회규정, 작성방법 등 숙지한 후 제출서류 작성 후 제출</li>
    </ul>
    <li>참가대상</li>
    <ul class="con2">
      <li>초등 5~6학년, 중학생(2인 1팀)</li>
    </ul>
    <li>참가방법</li>
    <ul class="con2">
      <li>주어진 논제에 따라 팀별 대전(예선 및 본선)</li>
    </ul>
  </ul>
    <div class="sm_box02 note_img">
      <h4>대회개요</h4>
      <ul class="con">
        <li>2021 : 논제</li>
        <ul>
          <li class="dep01">예선 : 꿈은 꼭 있어야 한다.</li>
          <li class="dep01">본선 : 미래를 위해 현재를 참아야 할까?</li>
        </ul>
      </ul>
    </div>
  </div>
  <h3>1차 예선</h3>
  <ul class="con">
    <li>방법
    <ul class="con2">
      <li>온라인 신청서 및 토론개요소 평가 후 본선 진출자 4팀 선정</li>
    </ul>
    <li>결과</li>
      <ul class="con2">
		<li>021. 9. 30.(목) ※ 홈페이지 결과 발표 및 유선연락</li>
		<li>※ 본선 진출 4팀 사전교육(토론역량강화 및 K-CEDA 디베이트 기법) 2021. 10. 2.(토) 예정 </li>
      </ul>
    <li>본선</li>
      <ul class="con2">
      <li>대회일시 : 2021. 10. 16.(토) 11:00</li>
    </ul>
  </ul>
  
  <h3>시상</h3>
    <ul class="con">
      <li>시상식 : 2021. 10. 16.(토) 15:30(예정)</li>
      <li>시상내역</li>
    </ul>
    <div class="rsv-info"></div>
    <div class="auto-scroll">
      <table class="tbl-type01" summary="독후감 공모 시상내역을 나타내는 표">
        <caption class="disnone">
        독후감 공모 시상내역
        </caption>
        <colgroup>
        <col width="15%">
        <col width="15%">
        <col width="15%">
        <col width="15%">
        </colgroup>
        <thead>
          <tr>
            <th class="no-line"></th>
            <th class="no-line">최우수</th>
            <th class="no-line">우수</th>
            <th class="no-line">장려</th>
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
<form:form modelAttribute="bookReportContest" id="bookReportContest" action="edit.do" >
	<form:hidden path="menu_idx"/>
	<form:hidden path="homepage_id"/>
	<form:hidden path="book_report_idx"/>
	<c:if test="${sessionScope.member.loginType eq 'HOMEPAGE' and sessionScope.member.login}">
		<div class="button bbs-btn fl_right_btn">
			<a href="#" id="apply_btn" class="btn btn1">참여신청</a>
		</div>
	</c:if>
	<div class="infodesk">
		총 <b style="color:#ff0000;">${paging.totalDataCount}</b>건
		
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
				<caption>독서릴레이 우수사례공모</caption>
				<colgroup>
					<col width="8%">
					<col width="12%">
					<col width="12%">
					<col width="12%">
					<col width="12%">
				</colgroup>
				<thead>
					<tr>
						<th>번호</th>
						<th>성명</th>
						<th>참여분야</th>
						<th>학교명</th>
						<th>등록일</th>
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
							<td>
								<c:if test="${i.participation_field eq 0}">소년부(초등~중등)</c:if>
								<c:if test="${i.participation_field eq 1}">장년부(고등~일반)</c:if>
							</td>
							<td>${i.school_name}</td>
							<td>
								<fmt:formatDate value="${i.add_date}" pattern="yyyy-MM-dd" />
							</td>
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
		
	</div>
</form:form>
