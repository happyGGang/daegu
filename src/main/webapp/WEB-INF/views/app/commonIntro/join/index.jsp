<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript">
$(function() {
	$('td.yearSelect > a.next').on('click', function(e) {
		e.preventDefault();
		$('input#ageType').val($(this).attr('val'));
		$('form#newMember').submit();
	});

	<c:if test="${member.langMode eq 'eng'}">
	$('div.doc-title > h3').text('Membership');
	</c:if>
	
	$('div#changeLanguage a').on('click', function(e) {
		e.preventDefault();
		var id = $(this).attr('id');
		location.href = window.location.pathname + '?menu_idx='+$('input#menu_idx').val() + '&langMode=' + id;
	});
	
	
	$('.year_a').mouseenter(function(){
		$('.joinAdult').attr("src","/resources/common/img/mem_adult_on.png");
	});
	$('.year_a').mouseleave(function(){
		$('.joinAdult').attr("src","/resources/common/img/mem_adult.png");
	});
	$('.year_b').mouseenter(function(){
		$('.joinChild').attr("src","/resources/common/img/mem_child_on.png");
	});
	$('.year_b').mouseleave(function(){
		$('.joinChild').attr("src","/resources/common/img/mem_child.png");
	});


	
	
});
</script>

<c:set var="engMode" value="${member.langMode eq 'eng'}"></c:set>
<c:if test="${engMode}">
</c:if>

	<p class="blind">
		<c:if test="${engMode}">Join Process</c:if>	
		<c:if test="${!engMode}">회원가입 단계</c:if>	
	</p>
	<table class="joinNoline">
		<tbody>
			<tr>
				<td class="joinImg1" >
					<img src="/resources/common/img/mem_prcs01_on.png" alt="">
				</td>
				<td class="active joinText">
					<c:if test="${engMode}">Check<br/> member<br/> type</c:if>	
					<c:if test="${!engMode}"><span>회원유형확인</span></c:if>
				</td>
				<td class="joinText">
					<img src="/resources/common/img/mem_prcs_arrow.png" alt=""/>
				</td>
				<td class="joinImg2">
					<img src="/resources/common/img/mem_prcs02.png" alt="">
				</td>
				<td class="joinText">
					<c:if test="${engMode}">Consent to <br/>users<br/> agreement</c:if>	
					<c:if test="${!engMode}">이용약관동의</c:if>
				</td>
				<td class="joinText">
					<img src="/resources/common/img/mem_prcs_arrow.png" alt=""/>
				</td>
				<td class="joinImg3">
					<img src="/resources/common/img/mem_prcs03.png" alt="">
				</td>
				<td class="joinText">
					<c:if test="${engMode}">Identification</c:if>	
					<c:if test="${!engMode}">본인확인</c:if>
				</td>
				<td class="joinText">
					<img src="/resources/common/img/mem_prcs_arrow.png" alt=""/>
				</td>
				<td class="joinImg4">
					<img src="/resources/common/img/mem_prcs04.png" alt="">
				</td>
				<td class="joinText">
					<c:if test="${engMode}">Information<br/> input</c:if>	
					<c:if test="${!engMode}">정보입력</c:if>
				</td>
			</tr>
		</tbody>
	</table>


<div class="join-wrap" style="padding: 0">

	<div class="info" style="float: left;">
		<ul class="con2">
		<c:if test="${engMode}">
		<li>Please select the type of member you belong to</li>
		<li>The process differs depending to the type of member and,<br/> if it differs from actual information, authentication may not be available</li>
		</c:if>	
		<c:if test="${!engMode}">
		<li>자신이 해당하는 회원의 종류를 선택해 주시기 바랍니다.</li>
		<li>회원유형에 따라 절차가 다르고. 실제정보와 차이가 있을 경우 인증이되지 않을 수 있습니다.</li>
		</c:if>
		</ul>
	</div>
	
	<div id="changeLanguage" style="float:right; text-align: right; margin-bottom: 20px; margin-top: 57px;">
		<a href="#" id="kor" class="btn korea <c:if test="${!engMode}">btn1</c:if>">한국어</a>
		<a href="#" id="eng" class="btn english <c:if test="${engMode}">btn1</c:if>">ENGLISH</a>
	</div>
	
	<div style="clear: both;">
	<table class="center joinSelect">
		<colgroup>
			<col width="50%"/>
			<col width="50%"/>
		</colgroup>
		<tr>
			<td class="yearSelect">
				<a href="#" class="year_a next" val="more" title="만 14세 이상의 일반회원,General members of Aged 14 and over ">
					<c:if test="${engMode}">
						<span class="joinText1">Aged 14 and over</span><br/><span class="joinText2">General members</span><br/>
					</c:if>
					<c:if test="${!engMode}">
						<span class="joinText1">만 14세 이상</span><br/><span class="joinText2">일반회원</span><br/>
					</c:if>
					<img src="/resources/common/img/mem_adult.png" class="joinAdult" alt="">
				</a>
			</td>
			<td class="yearSelect">
				<a href="#" class="year_b next" val="under" title="만 14세 미만의 어린이 또는 학생회원, Children or Student member of Aged 14 and under">
					<c:if test="${engMode}">
						<span class="joinText1">Aged 14 and under</span><br/><span class="joinText2">Children, and Student member</span><br/>
					</c:if>
					<c:if test="${!engMode}">
						<span class="joinText1">만 14세 미만</span><br/><span class="joinText2">어린이, 학생회원</span><br/>
					</c:if>
					<img src="/resources/common/img/mem_child.png" class="joinChild" alt="">
				</a>
			</td>
		</tr>
	</table>
	</div>
	
</div>
	
<%-- <form:form modelAttribute="newMember" action="https://www.gbelib.kr/${homepage.context_path}/intro/join/step2.do" method="post"> --%>
<form:form modelAttribute="newMember" action="step2.do" method="post">
<form:hidden path="ageType"/>
<form:hidden path="before_url"/>
<form:hidden path="menu_idx"/>
<form:hidden path="langMode"/>

</form:form>
	
<div style="clear:both">
<br/>
</div>
