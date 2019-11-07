<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript">
$(function() {
	<%-- if ('${fn:length(prtcNotice)}' == '0') {
	약관없는 경우
		alert('약관을 불러오지 못했습니다. 다시 시도해 주세요.');
		location.href="index.do"; 
	} --%>
	
	$('a#join-btn').on('click', function(e) {
		e.preventDefault();
		if ( $('input[name="agree_codes"][req="0001"]:checked').length == $('input[name="agree_codes"][req="0001"]').length ) {
			doAjaxPost($('#memberAgreeForm'));	
		}
		else {
			alert('약관 동의 하지 않았습니다.');
		}
		
	});
	
	$('div.content').addClass('wide');
	
});
</script>
	<div class="join-wrap " style="padding: 0">

	<div class="info">
		- 경상북도교육청 공공도서관 통합시스템 구축으로 회원정보가 통합 운영됩니다.<br/>
		  &nbsp; 홈페이지에 로그인하여 통합회원으로 전환 후 이용하시기 바랍니다.<br/>
		- 회원서비스를 이용하기 위해서는 <b>아래의 이용약관 개인정보수집&middot;이용에 동의하셔야 합니다.</b><br/> 
	</div>
	
	<h4>경상북도교육청 공공도서관 통합안내</h4>
	<p class="txte">경상북도교육청 도서관 통합정보시스템 구축으로 경상북도교육청 소속 29개 기관의 회원정보가 통합 운영됩니다. <br/> 
	통합회원이 되시면 하나의 회원정보(ID/자료대출번호)로 홈페이지 서비스 및 자료대출 서비스 등을 이용할 수 있습니다.</p>
	<div class="Box">
		<ul class="lib-list">
			<c:forEach items="${libraryList.data}" var="i">
			<li>${i.lib_name}</li>
			</c:forEach>
		</ul>
	</div>
	
	<form:form id="memberAgreeForm" modelAttribute="member" action="saveAgree.do">
	<form:hidden path="editMode"/>
	<form:hidden path="before_url"/>
	<form:hidden path="ageType"/>
	<form:hidden path="menu_idx"/>
	<form:hidden path="member_id"/>
	<form:hidden path="loca"/>
	
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
	</div>
</div>
