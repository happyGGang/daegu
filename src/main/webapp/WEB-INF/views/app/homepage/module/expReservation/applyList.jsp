<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
$(function() {
	$('input#searchDateFrom').datepicker({
		maxDate: $('input#searchDateTo').val(), 
		onClose: function(selectedDate){
			$('input#searchDateTo').datepicker('option', 'minDate', selectedDate);
		}
	});
	$('input#searchDateTo').datepicker({
		minDate: $('input#searchDateFrom').val(), 
		onClose: function(selectedDate){
			$('input#searchDateFrom').datepicker('option', 'maxDate', selectedDate);
		}
	});
	
	$('a#search-btn').on('click', function(e) {
		e.preventDefault();
		doGetLoad('applyList.do', $('form#expApply').serialize());
	});
	
	$('a.cancel').on('click', function(e) {
		e.preventDefault();
		if (confirm("해당 신청을 취소하시겠습니까? 취소후 해당 체험에 대해 재신청 가능합니다.")) {
			$('input#homepage_id').val($(this).attr('keyValue1'));
			$('input#reservation_idx').val($(this).attr('keyValue2'));
			$('input#editMode').val('CANCEL');
			
			if(doAjaxPost($('form#expApply'))){
				location.reload();
			}
		}
	});
});
</script>

<form:form modelAttribute="expApply" action="/${homepage.context_path}/module/expReservation/save.do" method="POST">
<form:hidden path="menu_idx"/>
<form:hidden path="reservation_idx"/>
<form:hidden path="editMode"/>
	<div id="libraryList" class="bbs-notice" style="margin-top:10px;margin-bottom:20px;" >
		<form:hidden path="homepage_id"/>
		조회기간: <form:input path="searchDateFrom" cssClass="text ui-calendar"/><label for="searchDateFrom" class="blind">시작일</label>~
				<form:input path="searchDateTo" cssClass="text ui-calendar"/><label for="searchDateTo" class="blind">종료일</label>
				<a href="#" id="search-btn" class="btn btn1">조회</a>
				<br/>
		
	</div>
	<c:if test="${fn:length(expApplyUserList) <1 }">
		<div class="nodata" style="text-align: center;">
			<i class="fa fa-frown-o"></i>신청 내역이 없습니다.
		</div>
	</c:if>
	<div class="op_wrap">
		<div class="smain">
			<c:forEach items="${expApplyUserList}" var="i">
				<div class="item">
					<div class="op_title category">
						<span style="font-weight:bold;">${i.program_name}</span>
					</div>
				
					<div class="box">
						<div class="box2">
							<ul class="con2">
								<li class="first"><div><label>신청구분</label> : ${i.reservation_type eq 'individual' ? '개인신청' : '단체신청'}</div></li>
								<li>
									<div>
										<label>신청현황</label> : 총신청인원( 신청한 인원/ 최대 가능 인원) :
										<c:choose>
											<c:when test="${i.total_people ne 0}">
												<span style="font-weight:bold;"> ${i.apply_people_count} / ${i.total_people}</span><br/>
											</c:when>
											<c:otherwise>
												<span style="font-weight:bold;">제한없음</span><br/>
											</c:otherwise>
										</c:choose>
										<c:if test="${i.reservation_type eq 'team'}">
											<label>&nbsp;</label>&nbsp;&nbsp;&nbsp;신청가능팀수( 신청한 팀수 / 최대신청가능 팀수) :
											<c:choose>
												<c:when test="${i.enable_number_of_team ne 0}">
													<span style="font-weight:bold;"> ${i.apply_count} / ${i.enable_number_of_team}</span><br/>
												</c:when>
												<c:otherwise>
													<span style="font-weight:bold";>제한없음</span><br/>
												</c:otherwise>
											</c:choose>
											<label>&nbsp;</label>&nbsp;&nbsp;&nbsp;팀별 최대신청 인원수 :
											<c:choose>
												<c:when test="${i.maximum_people_of_team ne 0}">
													<span style="font-weight:bold;">${i.maximum_people_of_team}</span>
												</c:when>
												<c:otherwise>
													<span style="font-weight:bold;">제한없음</span>
												</c:otherwise>
											</c:choose>
										</c:if>
									</div>
								</li>
								<li><div><label>예약일</label> : <fmt:parseDate value="${i.reservation_date}" pattern="yyyyMMdd" var="reservationDate" /><fmt:formatDate value="${reservationDate}" pattern="yyyy-MM-dd"/></div></li>
								<li><div><label>이용시간</label> : ${i.use_time}</div></li>
								<!-- <li><div><label>공지사항 확인</label> : ${i.notice}</div></li> -->
								<c:if test="${i.member_yn eq 'N' || sessionScope.member.login}">
									<li><div><label>아이디</label> : ${i.member_id}</div></li>
								</c:if>
								<li><div><label>성명</label> : ${i.member_name}</div></li>
								<li><div><label>연락처</label> : ${i.member_phone}</div></li>
								<li><div><label>이메일</label> : ${i.member_email}</div></li>
								<c:if test="${i.reservation_type eq 'team'}">
									<li><div><label>신청인원</label> : ${i.application_people}</div></li>
								</c:if>
								<!-- <li><div><label>참고사항</label> : ${i.reference}</div></li> -->
								<li><div><label>신청일</label> : <fmt:formatDate value="${i.add_date}" pattern="yyyy-MM-dd"/></div>
							</ul>
						</div>
					</div>
					<div class="stat">
						<jsp:useBean id="today" class="java.util.Date" />
						<fmt:formatDate var="now" value="${today}" pattern="yyyyMMdd" /> 
						<c:choose>
						<c:when test="${i.reservation_date <= now}">
							<a href="javascript:void(0);" class="btn" style="cursor: default;">
							<i class="fa fa-pencil"></i><span>신청마감</span></a>
						</c:when>
						<c:when test="${i.cancel_user_yn eq 'Y'}">
							<a href="javascript:void(0);" class="btn btn3" style="cursor: default;">
							<i class="fa fa-times-circle"></i><span>취소완료</span></a>
						</c:when>
						<c:when test="${i.cancel_yn eq 'Y'}">
							<a href="javascript:void(0);" class="btn btn3" style="cursor: default;">
							<i class="fa fa-times-circle"><span>관리자취소</span></i></a>
						</c:when>
						<c:otherwise>
							<a href="#" class="btn btn5 cancel" keyValue1="${i.homepage_id}" keyValue2="${i.reservation_idx}">
							<i class="fa fa-times"></i><span>신청취소</span></a>
						</c:otherwise>
						</c:choose>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
</form:form>