<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
$(function() {

});
</script>
<style>
	.doc-body h3{padding-left:0px;}
	#cont_wrap{padding:20px 0 60px;font-size:15px;font-weight:bold;font-family:'NotoKrR';line-height:160%;letter-spacing:-0.02em;}
	.event_all{width:100%;}
	.event_all > h3{margin-bottom: -16px;}
	h3.tit{padding-top:20px;background:url(/resources/board/img/h3_bar.png) no-repeat 0 0;font-weight:bold;font-family:'NotoKrM';font-size:23px;color:#222;line-height:1.2;letter-spacing:-0.05em;}
	.event_all .event01{position:relative;padding-top:20px;margin-bottom:50px;}
	.event_all .event01.course01{background:url(/resources/board/img/mara_event01.gif) no-repeat 30% 0;}
	.event_all .event01.course02{background:url(/resources/board/img/mara_event02.gif) no-repeat 51% 0;}
	.event_all .event01.course03{background:url(/resources/board/img/mara_event03.gif) no-repeat 10% 0;}
	.event_all .event01.course04{background:url(/resources/board/img/mara_event02.gif) no-repeat 80% 0;margin-bottom:0;}
	.event_all .event01 .bar_bg{position:relative;margin-right:70px;height:20px;background:#c8c8c8;}
	.event_all .event01 .bar_bg .pink_bar{position: absolute;top: 0;left: 0;height: 20px;font-family:'Roboto';font-size:15px;font-weight:bold;color:#fff;line-height:20px;text-align:right;padding-right:5px;background: #ee005e;}
	.event_all .event01 em{position:absolute;right:0;top:20px;font-size: 17px;font-family: 'Roboto','NotoKrB';font-weight: bold;color:#222;letter-spacing: 0;font-style: normal;}
</style>
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