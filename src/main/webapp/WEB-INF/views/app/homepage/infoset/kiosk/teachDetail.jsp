<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<% pageContext.setAttribute("crlf", "\r\n"); %>
<% pageContext.setAttribute("lf", "\n"); %>

<tiles:insertAttribute name="header" />
<script src="/resources/cms/js/malsup.jquery.form.min.js"
	type="text/javascript"></script>
<script type="text/javascript">
	$(function() {
		$('a.add').on('click',function(e) {
			var $this = $(this);
			doGetLoad(
					'/${homepage.context_path}/kiosk/studentEdit.do',
					'editMode=ADD&homepage_id='
							+ $this.attr('keyValue1')
							+ '&group_idx='
							+ $this.attr('keyValue2')
							+ '&category_idx='
							+ $this.attr('keyValue3')
							+ '&teach_idx='
							+ $this.attr('keyValue4')
							+ '&large_category_idx='
							+ $this.attr('keyValue5')
							+ '&apply_status='
							+ $this.attr('apply_status')
							+ '&menu_idx=${teach.menu_idx}');

			e.preventDefault();
		});
	});

</script>

<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
<div class="culturedetail-wrap">
	<div class="header">
		<h1>문화강좌</h1>
		<p>Cultural Lecture</p>
	</div>
	<div class="contents">
		<div class="">
			<div class="culturedetail-info-box-01">
				<div class="culturedetail-info-01">
					<div class="outer">
						<div class="inner">
							<h2>강의명</h2>
							<p>${teach.teach_name}</p>
						</div>
					</div>
				</div>
				<div class="culturedetail-info-02">
					<div class="outer">
						<div class="inner">
							<h2>강의기간</h2>
							<p>${teach.start_date} ~ ${teach.end_date}</p>
						</div>
					</div>
				</div>
				<div class="culturedetail-info-03">
					<div class="outer">
						<div class="inner">
							<h2>접수기간</h2>
							<p>${teach.start_join_date} ${teach.start_join_time} ~ ${teach.end_join_date} ${teach.end_join_time}</p>
						</div>
					</div>
				</div>
				<div class="culturedetail-info-04">
					<div class="culturedetail-info-04-left">
						<div class="outer">
							<div class="inner">
							<h2>온라인접수</h2>
							<p><span class="">${teach.teach_join_count}</span> / ${teach.teach_limit_count}</p>
							</div>
							<c:if test="${teach.teach_offline_count ne 0}">
								<div class="inner">
								<h2>오프라인 접수</h2>
								<p><span class="">${teach.teach_off_join_count}</span> / ${teach.teach_offline_count}</p>
								</div>
							</c:if>
						</div>
					</div>
					<div class="culturedetail-info-04-right">
						
							<div class="outer">
								<div class="inner">
								<h2>후보자접수</h2>
								<p><c:if test="${teach.teach_backup_count ne 0}"><span class="">${teach.teach_backup_join_count}</span> / ${teach.teach_backup_count}</c:if><c:if test="${teach.teach_backup_count eq 0}"><span class="">0</span> / 0</c:if></p>
								</div>
							</div>
						
					</div>
					<div class="end"></div>
				</div>
			</div>

			<div class="culturedetail-info-box-02">
				<ul>
					<li><span class="">강사명</span> ${teach.teacher_name}</li>
					<li><span class="">강의장소</span> ${teach.teach_stage}</li>
					<li><span class="">강의대상</span> ${teach.teach_target}</li>
					<li>
						<span class="">강의요일</span>
						<c:choose>
							<c:when test="${teach.teach_day_yn eq 'Y'}"> ${teach.teach_day_txt}</c:when>
							<c:otherwise>
							<c:forEach var="i" varStatus="stats_j" items="${teach.teach_day_arr}">
							<c:choose>
								<c:when test="${i eq '1'}">일</c:when>
								<c:when test="${i eq '2'}">월</c:when>
								<c:when test="${i eq '3'}">화</c:when>
								<c:when test="${i eq '4'}">수</c:when>
								<c:when test="${i eq '5'}">목</c:when>
								<c:when test="${i eq '6'}">금</c:when>
								<c:when test="${i eq '7'}">토</c:when>
							</c:choose>
							<c:if test="${!stats_j.last}">
								,
							</c:if>
							</c:forEach>
							</c:otherwise>
						</c:choose>
					</li>
					<li><span class="">강의시간</span> ${teach.start_time} ~ ${teach.end_time}</li>
					<li>
					<span class="">강의설명</span>
					<c:set var="desc" value="${fn:replace(teach.teach_desc, crlf, '<br/>')}"></c:set>
					<c:set var="desc" value="${fn:replace(desc, lf, '<br/>')}"></c:set>
					<div class="overflow-y culturedetail-info-etc">
						${desc}
					</div>
					</li>
				</ul>
			</div>

			<div class="culturedetail-request-button-box">
				<c:choose>
					<c:when test="${teach.teach_status eq '0'}">
						<a href="" class="btn button2 add" keyValue1="${teach.homepage_id}" keyValue2="${teach.group_idx}" keyValue3="${teach.category_idx}" keyValue4="${teach.teach_idx}" keyValue5="${teach.large_category_idx}" apply_status="1" style="display:inline-block;width:45%;">수강신청</a>
					</c:when>
					<c:when test="${teach.teach_status eq '1'}">
						<a href="" class="btn button4 add" keyValue1="${teach.homepage_id}" keyValue2="${teach.group_idx}" keyValue3="${teach.category_idx}" keyValue4="${teach.teach_idx}" keyValue5="${teach.large_category_idx}" apply_status="2" style="display:inline-block;width:45%;">대기자신청</a>
					</c:when>
					<c:when test="${teach.teach_status eq '2' or i.teach_status eq '10'}">
						<a href="#" class="btn button7" style="display:inline-block;width:45%;">신청완료</a>
					</c:when>
					<c:when test="${teach.teach_status eq '3'}">
						<a href="#" class="btn button7" style="display:inline-block;width:45%;">대기자 신청완료</a>
					</c:when>
					<c:when test="${teach.teach_status eq '9'}">
						<a href="#" class="btn button6" style="display:inline-block;width:45%;">수강종료</a>
					</c:when>
					<c:when test="${teach.teach_status eq '4'}">
						<a href="#" class="btn button5" style="display:inline-block;width:45%;">접수마감</a>
					</c:when>
					<c:when test="${teach.teach_status eq '5'}">
						<a href="#" class="btn button7" style="display:inline-block;width:45%;">정원마감</a>
					</c:when>
					<c:when test="${teach.teach_status eq '6'}">
						<a href="#" class="btn button3" style="display:inline-block;width:45%;">신청대기</a>
					</c:when>
				</c:choose>
				<a href="javascript:history.back(-1);" class="btn button8" style="display:inline-block;width:45%;">뒤로가기</a>
			</div>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/app/homepage/${homepage.context_path}/kiosk/menuNavigation.jsp" flush="false" />
<tiles:insertAttribute name="footer" />