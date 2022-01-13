<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
$(function() {
	<c:forEach begin="1" end="5" var="i"> 
		$('div.number').append('<em class="spot${i}"><fmt:formatNumber value="${(marathonApplicant.page_count / 5) * i}" pattern="####km"/></em>');
	</c:forEach>
	
	$('a.pink').on('click', function(e) {
		e.preventDefault();
		$('#dialog-1').load('myRecord.do?homepage_id=${marathonApplicant.homepage_id}&contest_idx=' + $(this).attr('keyValue') + '&contest_type_idx=' + $(this).attr('keyValue2') + '&applicant_idx=' + $(this).attr('keyValue3'), function(response, status, xhr) {
			$('#dialog-1').dialog('open');
		});
	});
});
	
</script>
<style>
	.con_btn {display: inline-block;padding: 5px 15px;font-weight: bold;font-size: 14px;line-height: normal;text-align: center;cursor: pointer;}
	.con_btn.pink {color: #fff;background: #ee005e;border: 1px solid #ee005e;}
	a, a:link {text-decoration: none;}
	.mara_check {position: relative;margin: 0 40px;}
	.mara_check .user {top: 0;margin-left: -24px;z-index: 9;}
	.mara_check .finish {position: absolute;top: 20px;right: 0;margin-right: -30px;}
	.mara_check .user, .mara_check .finish {position: absolute;}
	.mara_check .mara_course {padding-top: 135px;position: relative;background: url(/resources/board/img/mara_course.gif) no-repeat 20px 71px;}
	.mara_check .mara_course .bar_bg {position: relative;height: 20px;background: #c8c8c8;}
	.mara_check .number {position: relative;}
	.mara_check .number .spot1 {left: 20%;}
	.mara_check .number .spot2 {left: 40%;}
	.mara_check .number .spot3 {left: 60%;}
	.mara_check .number .spot4 {left: 80%;}
	.mara_check .number .spot5 {left: 100%;}
	.mara_check .number em {position: absolute;top: 5px;font-size: 17px;font-style: normal;font-family: 'sans-serif';font-weight: 500;color: #222;margin-left: -18px;letter-spacing: 0;}
	.mara_check .mara_course .bar_bg span.pink_bar {position: absolute; top: 0;left: 0;height: 20px;background: #ee005e;}
</style>
<h3 style="margin-top:0;">내 마라톤일지 확인</h3>
<c:choose>
	<c:when test="${ing eq true}">
		<form:form modelAttribute="marathonApplicant" method="post" action="index.do">
		<form:hidden path="contest_idx"/>
		<form:hidden path="contest_type_idx"/>
		<form:hidden path="applicant_idx"/>
		<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
			<table class="type2">
				<colgroup>
					<col width="15%"/>
					<col width="35%"/>
					<col width="15%"/>
					<col width="*"/>
				</colgroup>
				<tbody>
					<tr>
						<th style="border-top:1px solid #5e6062;">참가자명</th>
						<td style="border-top:1px solid #5e6062;">${marathonApplicant.member_name}</td>
						<th style="border-top:1px solid #5e6062;">참가종목</th>
						<td>${marathonApplicant.contest_type} (${marathonApplicant.page_count})쪽
					</tr>
					<tr>
						<th>개인누적현황</th>
						<td><strong>${marathonApplicant.read_page_count_total}</strong>쪽</td>
						<th>독서이력확인</th>
						<td><a href="" class="con_btn pink" keyValue="${marathonApplicant.contest_idx}" keyValue2="${marathonApplicant.contest_type_idx}" keyValue3="${marathonApplicant.applicant_idx}">독서이력</a></td>
					</tr>
				</tbody>
			</table>
			<br><br>
			<div class="mara_check">
				<c:choose>
					<c:when test="${(marathonApplicant.read_page_count_total / marathonApplicant.page_count) < 1}">
						<div class="user" style="left: <fmt:formatNumber value="${(marathonApplicant.read_page_count_total / marathonApplicant.page_count) * 100}" pattern="##.##"/>%;">
							<img src="/resources/board/img/bookman02.png" alt="독서마라토너">
						</div>
					</c:when>
					<c:otherwise>
						<div class="user" style="left: 100%;">
							<img src="/resources/board/img/bookman02.png" alt="독서마라토너">
						</div>
					</c:otherwise>
				</c:choose>
				<div class="finish">
					<img src="/resources/board/img/finish.gif" alt="finish">
				</div>
				<div class="mara_course">
					<div class="bar_bg">
						<c:choose>
							<c:when test="${(marathonApplicant.read_page_count_total / marathonApplicant.page_count) < 1}">
								<span class="pink_bar" style="width:<fmt:formatNumber value="${(marathonApplicant.read_page_count_total / marathonApplicant.page_count) * 100}" pattern="##.##"/>%;"></span>
							</c:when>
							<c:otherwise>
								<span class="pink_bar" style="width:100%;"></span>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<div class="number">
				</div>
			</div>
		</form:form>
	</c:when>
	<c:otherwise>
		독서마라톤대회가 없습니다.
	</c:otherwise>
</c:choose>

<div id="dialog-1" class="dialog-common" title="독서마라톤 신청자정보 - 프로필 1"></div>