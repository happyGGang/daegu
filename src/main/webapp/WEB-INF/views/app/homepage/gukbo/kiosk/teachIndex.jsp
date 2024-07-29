<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<tiles:insertAttribute name="header" />

<script type="text/javascript">
$(function(){
	$('a.detail-btn').on('click', function(e) {
		var formData = '&homepage_id='+$('#homepage_id_1').val()+'&group_idx='+$(this).attr('keyValue1')+'&category_idx='+$(this).attr('keyValue2')+'&teach_idx='+$(this).attr('keyValue3')+'&large_category_idx='+$(this).attr('keyValue4')
			+'&searchCate1='+$('#searchCate1').val();
		doGetLoad('/${homepage.context_path}/kiosk/teachDetail.do', formData);
		e.preventDefault();
	});
});
</script>
<form:form modelAttribute="teach" action="/${homepage.context_path}/kiosk/module/teach/student/kioskSave.do" method="POST" onsubmit="return false">
<form:hidden path="teach_idx"/>
<form:hidden path="searchCate1"/>
<form:hidden id="homepage_id_1" path="homepage_id"/>
	<div id="wrap">
		<div class="culture-wrap">
			<div class="header">
				<h1>문화강좌</h1>
				<p>Cultural Lecture</p>
			</div>
			<div class="contents">
				<div class="overflow-y culture-inner-box">
					<c:forEach items="${teachList}" var="i">
						<div class="culture-list">
							<a href="javascript:void(0);" class="detail-btn" keyValue1="${i.group_idx}" keyValue2="${i.category_idx}" keyValue3="${i.teach_idx}" keyValue4="${i.large_category_idx}">
							<div class="outer">
								<div class="inner">
									<div class="cul-status">
										<c:choose>
											<c:when test="${i.teach_status eq '0'}">
												<span class="status_${i.teach_status}">수강신청</span>
											</c:when>
											<c:when test="${i.teach_status eq '1'}">
												<span class="status_${i.teach_status}">대기자신청</span>
											</c:when>
											<c:when test="${i.teach_status eq '2' or i.teach_status eq '10'}">
												<span class="status_${i.teach_status}">신청완료</span>
											</c:when>
											<c:when test="${i.teach_status eq '3'}">
												<span class="status_${i.teach_status}">대기자<br/>신청완료</span>
											</c:when>
											<c:when test="${i.teach_status eq '4'}">
												<span class="status_${i.teach_status}">접수마감</span>
											</c:when>
											<c:when test="${i.teach_status eq '5'}">
												<span class="status_${i.teach_status}">정원마감</span>
											</c:when>
											<c:when test="${i.teach_status eq '6'}">
												<span class="status_${i.teach_status}">신청대기</span>
											</c:when>
											<c:when test="${i.teach_status eq '9'}">
												<span class="status_${i.teach_status}">수강종료</span>
											</c:when>
										</c:choose>
									</div>
									<div class="cul-info">
										<ul>
											<li>${i.teach_name}</li>
											<li><span class="">강의기간&nbsp;&nbsp;</span>${i.start_time} ~ ${i.end_time}</li>
											<li><span class="">강의대상&nbsp;&nbsp;</span>${i.teach_target}</li>
										</ul>
									</div>
									<div class="cul-cnt">
										<ul>
											<li><p class="cul-cnt-tit">온라인접수</p><p class="cul-cnt-state"><span class="">${i.teach_join_count}</span> / ${i.teach_limit_count}</p></li>
											<li><p class="cul-cnt-tit">후보자접수</p><c:if test="${i.teach_backup_count > 0}"><p class="cul-cnt-state"><span class="">${i.teach_backup_join_count}</span> / ${i.teach_backup_count}</p></c:if><c:if test="${i.teach_backup_count < 1}"><p class="cul-cnt-state"><span class="">0</span> / 0</p></c:if></li>
										</ul>
									</div>
								</div>
							</div>
							</a>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
		<jsp:include page="/WEB-INF/views/app/homepage/gukbo/kiosk/menuNavigation.jsp" flush="false" />
	</div>
</form:form>

<tiles:insertAttribute name="footer" />