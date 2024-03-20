<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" type="text/css" href="/resources/common/css/join/join.css"/>

<script type="text/javascript">
$(function() {
	$('td.yearSelect a.next').on('click', function(e) {
		e.preventDefault();
		$('input#ageType').val($(this).attr('val'));
		$('form#newMember').submit();
	});

});
</script>

<form:form modelAttribute="newMember" action="step2.do" method="post">
<form:hidden path="ageType"/>
<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
</form:form>

<table class="joinNoline">
	<tbody>
		<tr>
			<td class="joinImg1 center active">
				<div class="en">STEP 01</div>
				<div class="ko">회원유형</div>
			</td>

			<td class="joinImg2 center">
				<div class="en">STEP 02</div>
				<div class="ko">이용약관동의</div>
			</td>

			<td class="joinImg3 center">
				<div class="en">STEP 03</div>
				<div class="ko">본인확인</div>
			</td>

			<td class="joinImg4 center">
				<div class="en">STEP 04</div>
				<div class="ko">정보입력</div>
			</td>
		</tr>
		<tr>
			<td class="joinLine center active">
				<div style="width:27px;border-radius:33px;background:#fab001;margin:0 auto">&nbsp;</div>
			</td>

			<td class="joinLine center">
				<div style="width:27px;border-radius:33px;background:#000;margin:0 auto">&nbsp;</div>
			</td>

			<td class="joinLine center">
				<div style="width:27px;border-radius:33px;background:#000;margin:0 auto">&nbsp;</div>
			</td>

			<td class="joinLine center">
				<div style="width:27px;border-radius:33px;background:#000;margin:0 auto">&nbsp;</div>
			</td>
		</tr>
	</tbody>
</table>


<div class="join-wrap" style="padding:0">

	<div class="info">
		<ul class="con2">
		<li>다음의 가입 방법 중 하나를 선택하세요.</li>
		<li>회원유형에 따라 절차가 다르며 실제정보와 차이가 있을 경우 인증이 되지 않을 수 있습니다.</li>
		</ul>
	</div>

	<div style="clear: both;">
	<table class="center joinSelect">
		<colgroup>
			<col width="50%"/>
			<col width="50%"/>
		</colgroup>
		<tr>
			<td class="yearSelect">
				<div class="yearSelectAlign">
					<div class="joinImages">
						<img src="/resources/common/img/mem_adult.jpg" alt="14세이상" class="joinAdult">
					</div>
					<div class="joinBtnTxt">
						<div class="joinText1"><c:if test="${context_path ne 'gukbo'}">만</c:if> 14세 이상</div>
						<div class="joinText2">가입자의 본인확인(휴대폰인증/아이핀인증) 절차가 필요합니다.</div>
						<div><a href="#" class="year_a next btn btn01" val="more"><c:choose><c:when test="${param.status eq 'intergration'}">반입하기</c:when><c:otherwise>회원가입</c:otherwise></c:choose></a></div>
					</div>
				</div>
			</td>
			<td class="yearSelect">
				<div class="yearSelectAlign">
					<div class="joinImages">
						<img src="/resources/common/img/mem_child.jpg" alt="14세미만" class="joinChild">
					</div>
					<div class="joinBtnTxt">
						<div class="joinText1"><c:if test="${context_path ne 'gukbo'}">만</c:if> 14세 미만</div>
						<div class="joinText2">법정대리인과 가입자의 본인확인 절차가 필요합니다.</div>
						<div><a href="#" class="year_b next btn btn01" val="under"><c:choose><c:when test="${param.status eq 'intergration'}">반입하기</c:when><c:otherwise>회원가입</c:otherwise></c:choose></a></div>
					</div>
				</div>
			</td>
		</tr>
	</table>
	</div>

</div>

<div style="clear:both"></div>

