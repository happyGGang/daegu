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

	<p class="blind">
		회원가입 단계
	</p>
	<table class="joinNoline">
		<tbody>
			<tr>
				<td class="joinImg1" >
					<img src="/resources/common/img/mem_prcs01_on.png" alt="">
				</td>
				<td class="active joinText">
					<span>회원유형확인</span>
				</td>
				<td class="joinText">
					<img src="/resources/common/img/mem_prcs_arrow.png" alt=""/>
				</td>
				<td class="joinImg2">
					<img src="/resources/common/img/mem_prcs02.png" alt="">
				</td>
				<td class="joinText">
					이용약관동의
				</td>
				<td class="joinText">
					<img src="/resources/common/img/mem_prcs_arrow.png" alt=""/>
				</td>
				<td class="joinImg3">
					<img src="/resources/common/img/mem_prcs03.png" alt="">
				</td>
				<td class="joinText">
					본인확인
				</td>
				<td class="joinText">
					<img src="/resources/common/img/mem_prcs_arrow.png" alt=""/>
				</td>
				<td class="joinImg4">
					<img src="/resources/common/img/mem_prcs04.png" alt="">
				</td>
				<td class="joinText">
					정보입력
				</td>
			</tr>
		</tbody>
	</table>


<div class="join-wrap" style="padding: 0">

	<div class="info" style="float: left;">
		<ul class="con2">
		<li>자신이 해당하는 회원의 종류를 선택해 주시기 바랍니다.</li>
		<li>회원유형에 따라 절차가 다르고, 실제 정보와 차이가 있을 경우 인증이 되지 않을 수 있습니다.</li>
		</ul>
	</div>

	<div>
		<table class="center joinSelect">
			<colgroup>
				<col width="50%"/>
				<col width="50%"/>
			</colgroup>
			<tr>
				<td class="yearSelect">
					<a href="#" class="year_a next" val="more" title="만 14세 이상의 일반회원,General members of Aged 14 and over ">
						<span class="joinText1"><c:if test="${homepage.context_path ne 'gukbo'}">만</c:if> 14세 이상</span><br/><span class="joinText2">일반회원</span><br/>
						<img src="/resources/common/img/mem_adult.png" class="joinAdult" alt="">
					</a>
				</td>
				<td class="yearSelect">
					<a href="#" class="year_b next" val="under" title="만 14세 미만의 어린이 또는 학생회원, Children or Student member of Aged 14 and under">
						<span class="joinText1"><c:if test="${homepage.context_path ne 'gukbo'}">만</c:if> 14세 미만</span><br/><span class="joinText2">어린이, 학생회원</span><br/>
						<img src="/resources/common/img/mem_child.png" class="joinChild" alt="">
					</a>
				</td>
			</tr>
		</table>
	</div>

</div>

<form:form modelAttribute="newMember" action="step2.do" method="post">
<form:hidden path="ageType"/>
<form:hidden path="menu_idx"/>
<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
</form:form>

<div style="clear:both">
<br/>
</div>
