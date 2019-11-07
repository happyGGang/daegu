<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript">
$(function() {
	if ('${fn:length(prtcNotice)}' == '0') {
	<%-- 약관없는 경우 --%>
		alert('약관을 불러오지 못했습니다. 다시 시도해 주세요.');
		location.href="/${homepage.context_path}/intro/join/modifyForm.do?menu_idx=${param.menu_idx}";
	}

	$('a#join-btn').on('click', function(e) {
		e.preventDefault();
		if ( $('input[name="agree_codes"][req="0001"]:checked').length == $('input[name="agree_codes"][req="0001"]').length ) {
			$('#memberAgreeForm').submit();
		}
		else {
			alert('약관 동의 하지 않았습니다.');
		}

	});

	$('#all-agree').change(function() {
		$('input:checkbox').prop('checked', $(this).prop('checked'));
	});
});
</script>

	<table class="joinNoline">
		<tbody>
			<tr>
				<td class="joinImg1" >
					<img src="/resources/common/img/mem_prcs02_on.png">
				</td>
				<td class="active joinText">
					이용약관동의
				</td>
				<td class="joinText">
					<img src="/resources/common/img/mem_prcs_arrow.png"/>
				</td>
				<td class="joinImg2">
					<img src="/resources/common/img/mem_prcs03.png">
				</td>
				<td class="joinText">
					아이디 선택
				</td>
				<td class="joinText">
					<img src="/resources/common/img/mem_prcs_arrow.png"/>
				</td>
				<td class="joinImg3">
					<img src="/resources/common/img/mem_prcs04.png">
				</td>
				<td class="joinText">
					본인확인 및 정보입력
				</td>
			</tr>
		</tbody>
	</table>

<div class="join-wrap" style="padding: 0">

	<div class="info">
		- 경상북도교육청 공공도서관 통합시스템 구축으로 회원정보가 통합 운영됩니다.<br/>
<!-- 		  &nbsp; 홈페이지에 로그인하여 통합회원으로 전환 후 이용하시기 바랍니다.<br/> -->
		- 회원서비스를 이용하기 위해서는 <b>아래의 이용약관 개인정보수집&middot;이용에 동의하셔야 합니다.</b><br/>
	</div>

	<h4>경상북도교육청 공공도서관 통합안내</h4>
	<p class="txte">경상북도교육청 도서관 통합정보시스템 구축으로 경상북도교육청 소속 27개 기관의 회원정보가 통합 운영됩니다. <br/>
	통합회원이 되시면 하나의 회원정보(ID/자료대출번호)로 홈페이지 서비스 및 자료대출 서비스 등을 이용할 수 있습니다.</p>
	<div class="Box">
		<ul class="lib-list">
			<c:forEach items="${libraryList.data}" var="i">
			<c:if test="${fn:indexOf(i.lib_name, '연수원') eq -1}">
			<li>${i.lib_name}</li>
			</c:if>
			</c:forEach>
		</ul>
	</div>

	<form:form id="memberAgreeForm" modelAttribute="newMember" action="integration2.do" method="post">
	<form:hidden path="editMode"/>
	<form:hidden path="before_url"/>
	<form:hidden path="ageType"/>
	<form:hidden path="menu_idx"/>

	<c:forEach items="${prtcNotice}" var="i" varStatus="status">
	<h4>${i.TITLE}</h4>
	<div class="Box" style="height:200px">
		<h1 style="font-size:20px; font-weight: bold">${i.TITLE}</h1><br/>
 		${i.CONTET}
	</div>
	<div class="agree_codes">
		<div class="checkbox">
			<c:if test="${fn:contains(i.REQ_CHECK, '1')}">
			<c:set value="0001" var="reqCheck" ></c:set>
			</c:if>
			<form:checkbox path="agree_codes" req="${reqCheck}" label="${i.TITLE}" value="${status.count}"/><br/>
		</div>
	</div>
	</c:forEach>

<!-- 	<h4>개인정보의 수집&middot;이용 동의</h4> -->
<!-- 	<div class="Box" style="height:200px"> -->
<%-- 		<h1 style="font-size:20px; font-weight: bold">${prtcNotice[1].TITLE}</h1><br/> --%>
<%-- 		${prtcNotice[1].CONTET}<br> --%>
<%-- 		<h1 style="font-size:20px; font-weight: bold">${prtcNotice[2].TITLE}</h1><br/> --%>
<%-- 		${prtcNotice[2].CONTET}<br> --%>
<%-- 		<h1 style="font-size:20px; font-weight: bold">${prtcNotice[3].TITLE}</h1><br/> --%>
<%-- 		${prtcNotice[3].CONTET}<br> --%>
<%-- 		<h1 style="font-size:20px; font-weight: bold">${prtcNotice[4].TITLE}</h1><br/> --%>
<%-- 		${prtcNotice[4].CONTET}<br> --%>
<!-- 	</div> -->
<!-- 	<div class="agree_codes"> -->
<!-- 		<div class="checkbox"> -->
<%-- 			<form:checkbox path="agree_codes" label="개인정보의 수집 이용 동의" value="${prtcNotice[1].NOTICE_NO}"/><br/> --%>
<!-- 		</div> -->
<!-- 	</div> -->

	</form:form>
	<div class="btn-wrap">
		<a href="#" id="join-btn" class="btn btn1">동의합니다.</a>
		<a href="/${homepage.context_path}/index.do" class="btn">동의하지 않습니다.</a>
	</div>

</div>