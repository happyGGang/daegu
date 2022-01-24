<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
$(function() {

});
</script>
<h3 style="padding-left:30px;margin-top:0;">종목별 현황</h3>
<c:choose>
	<c:when test="${ing eq true}">
		<div id="cont_wrap">
			<div class="event_all">
				<c:forEach begin="0" end="${fn:length(marathonTypeList) -1}" var="i">
					<h4>${marathonTypeList[i].contest_type}</h4>
					<div class="event01 course0${i + 1}">
						<div class="bar_bg">
							<c:choose>
								<c:when test="${applicant_total_count > 0}">
									<span class="pink_bar" style="width:<fmt:formatNumber value="${(applicant_count[i] / applicant_total_count) * 100}" pattern="##.##"/>%">
										<fmt:formatNumber value="${(applicant_count[i] / applicant_total_count) * 100}" pattern="##.##"/>%
									</span>
								</c:when>
								<c:otherwise>
									<span class="pink_bar" style="width:0%">
										0%
									</span>
								</c:otherwise>
							</c:choose>
						</div>
						<em>${applicant_count[i]}명</em>
					</div>
				</c:forEach>
			</div>
		</div>
	</c:when>
	<c:otherwise>
		독서마라톤대회가 없습니다.
	</c:otherwise>
</c:choose>