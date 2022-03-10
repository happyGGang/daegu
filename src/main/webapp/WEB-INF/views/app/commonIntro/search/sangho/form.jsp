<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" type="text/css" href="/resources/book/search/css/default.css"/>
<script type="text/javascript">
$(function() {

	$('#save-btn').on('click', function(e) {
		e.preventDefault();
		if (!confirm('상호대차신청을 하시겠습니까?')) {
			return false;
		}

		if ($('select#uselibcode').val() == '') {
			alert('제공받을 도서관을 선택하세요.');
			$('select#uselibcode').focus();
			return false;
		}

		if (doAjaxPost($('form#librarySearch'))) {
			location.href='index.do?menu_idx=${sanghoMenuIdx}';
		}
	});
	
	$('#cancel-btn').on('click', function(e) {
		e.preventDefault();
		history.go(-1);
	});

	$('select#uselibcode option').each(function() {
		if ($(this).val() != '' && $(this).val() == '${detail.LIB_CODE}') {
			$(this).remove();
		}
	});

});
</script>

<!-- contents-title-->
<div id="contents-title">
	<h2>상호대차 신청을 위한 선택사항<span style="font-weight:300">을 확인하세요.</span></h2>
</div>
<!-- /contents-title-->

<form:form modelAttribute="librarySearch" action="../sanghoSave.do" method="post" onsubmit="return false;">
<form:hidden path="editMode"/>
<form:hidden path="isbn" />
<form:hidden path="regNo" />
<form:hidden path="booktype" />
<form:hidden path="manageCode" />
	<input type="hidden" name="libCode" value="${detail.LIB_CODE}">

<div class="delibery_info">
	<h3>상호대차 정보 입력</h3>
	<div class="" style="padding:10px 0;font-size:120%">(<span style="color:red;font-weight:bold;">*</span>) 항목은 필수 입력값입니다.</div>
	<table class="editTbl">
		<colgroup>
	       <col width="28%" />
	       <col width="*"/>
       	</colgroup>
       	<tbody>
			 <tr>
			 	<th>신청인</th>
			 	<td>
			 		${sessionScope.member.member_name}
			 	</td>
			 </tr>
			 <tr>
			 	<th>제공도서관</th>
			 	<td>
			 		${detail.LIB_NAME}
			 	</td>
			 </tr>
			 <tr>
			 	<th>이용도서관(<span style="color: red;">*</span>)</th>
			 	<td>
<!-- 도서관 선택 분기처리 시작 -->
					<c:choose>
					<c:when test="${homepage.context_path eq 'bukgs' || homepage.context_path eq 'bukdh' || homepage.context_path eq 'buktj'}">
			 		<form:select path="uselibcode">
			 			<form:option value="" label="-- 선택 --" />
						<form:option value="127009">구수산도서관</form:option>
						<form:option value="127084">대현도서관</form:option>
						<form:option value="127088">태전도서관</form:option>
						<!-- <form:option value="727033">태전1동 작은도서관</form:option> -->
						<form:option value="727038">산격1동 작은도서관</form:option>
						<!-- <form:option value="727040">북구영어작은도서관</form:option> -->
						<form:option value="727054">침산1동 작은도서관</form:option>
						<form:option value="727055">노원동 작은도서관</form:option>
						<form:option value="727088">서변동작은도서관</form:option>
						<form:option value="727098">노원행복도서관</form:option>
						<form:option value="727102">한강공원부키도서관</form:option>
					</form:select>
					</c:when>
					<c:when test="${homepage.context_path eq 'beomeo' || homepage.context_path eq 'yonghak' || homepage.context_path eq 'gosan'}">
			 		<form:select path="uselibcode">
			 			<form:option value="" label="-- 선택 --" />
						<form:option value="127072">범어도서관</form:option>
						<form:option value="127013">용학도서관</form:option>
						<form:option value="127085">고산도서관</form:option>
						<form:option value="127019">파동도서관</form:option>
						<form:option value="127096">무학숲도서관</form:option>
						<form:option value="127017">책숲길도서관</form:option>
						<form:option value="127018">물망이도서관</form:option>
						<form:option value="127021">사월역도서관</form:option>
					</form:select>
					</c:when>
					<c:when test="${homepage.context_path eq 'junggu'}">
			 		<form:select path="uselibcode">
			 			<form:option value="" label="-- 선택 --" />
						<form:option value="127016">남산4동작은도서관</form:option>
						<form:option value="127056">동인 느티나무 도서관</form:option>
						<form:option value="127070">중구영어도서관</form:option>
						<form:option value="327009">중구청교양정보실</form:option>
						<form:option value="727025">대신동작은도서관</form:option>
						<form:option value="727083">삼덕마루 작은도서관</form:option>
						<form:option value="727107">대봉2동작은도서관</form:option>
					</form:select>
					</c:when>
					<c:when test="${homepage.context_path eq 'dalseolib'}">
			 		<form:select path="uselibcode">
			 			<form:option value="" label="-- 선택 --" />
						<form:option value="127005">성서도서관</form:option>
						<form:option value="127002">달서어린이도서관</form:option>
						<form:option value="127001">도원도서관</form:option>
						<form:option value="127012">본리도서관</form:option>
						<form:option value="127093">달서가족문화도서관</form:option>
						<form:option value="127099">달서영어도서관</form:option>
						<form:option value="127066">이곡2동공립작은도서관</form:option>
						<form:option value="127006">용산1동작은도서관</form:option>
						<form:option value="127007">장기동작은도서관</form:option>
						<!-- <form:option value="127008">죽전동공립작은도서관</form:option> -->
						<form:option value="327002">달서아트센터 도서관</form:option>
						<form:option value="327003">행정정보문고센터</form:option>
						<form:option value="727036">학산작은도서관</form:option>
					</form:select>
					</c:when>
					<c:when test="${homepage.context_path eq 'donggu'}">
					<form:select path="uselibcode">
						<form:option value="127049">안심도서관</form:option>
						<form:option value="127087">신천도서관</form:option>
						<form:option value="727061">신암2동 작은도서관</form:option>
						<form:option value="727062">신암3동 작은도서관</form:option>
						<form:option value="727071">신암5동 작은도서관</form:option>
						<form:option value="127029">신천3동 작은도서관</form:option>
						<form:option value="727064">효목1동 작은도서관</form:option>
						<form:option value="127048">효목2동 작은도서관</form:option>
						<form:option value="127030">도평동 작은도서관</form:option>
						<form:option value="727065">불로어울림 작은도서관</form:option>
						<form:option value="727066">지저동 작은도서관</form:option>
						<form:option value="727067">동촌역사 작은도서관</form:option>
						<form:option value="727069">해안동 작은도서관</form:option>
						<form:option value="127031">반야월역사 작은도서관</form:option>
						<!-- <form:option value="727070">동구청 작은도서관</form:option> -->
						<form:option value="727073">늘푸른 도서관</form:option>
						<!-- 초록우산작은도서관 잠정 운영중단으로 인한 주석처리  -->
						<%-- <form:option value="727072">초록우산도서관</form:option> --%>
						<form:option value="727074">행복도서관</form:option>
						<form:option value="727068">방촌동 작은도서관</form:option>
						<!-- <form:option value="727076">율하5주민도서관</form:option> -->
					</form:select>
					</c:when>
					<c:otherwise>
					</c:otherwise>
					</c:choose>
			 	</td>
			 </tr>
			 <tr>
			 	<th>도서명</th>
			 	<td>
			 		${detail.TITLE_INFO}
			 	</td>
			 </tr>
			 <tr>
			 	<th>등록번호</th>
			 	<td>
			 		${detail.REG_NO}
			 	</td>
			 </tr>
			 <c:if test="${not empty detail.APPENDIX_INFO}">
			 <tr>
			 	<th>부록대출</th>
			 	<td>
<%-- 			 		<form:checkbox path="appendixregnolist" value="y" label="(해당 도서에 부록이 있을 시 부록도 같이 대출하겠습니다.)"/> --%>
			 		<c:forEach items="${detail.APPENDIX_LIST}" var="i" varStatus="status">
						<c:if test="${i.KBILL_APPENDIX_LILL_YN eq 'O'}">
							<c:set var="media_desc" value=""></c:set>
							<c:forEach items="${detail.APPENDIX_INFO}" var="j">
								<c:if test="${empty j.value}">
									<c:set var="media_desc" value="${j.DESCRIPTION}"></c:set>
								</c:if>
								<c:if test="${not empty j.value and j.value eq i.MEDIA_CODE and j.key eq 'DESCRIPTION'}">
									<c:set var="media_desc" value="${j.value}"></c:set>
								</c:if>
							</c:forEach>
							<form:checkbox path="appendixregnolist" label="${media_desc }" value="${i.REG_NO}"/>
						</c:if>
						<c:if test="${i.KBILL_APPENDIX_LILL_YN ne 'O'}">
						부록대출불가
						</c:if>
					</c:forEach>
			 	</td>
			 </tr>
			 </c:if>
       	</tbody>
	</table>

	<div class="btnArea" style="text-align: center; padding-top: 25px;">
		<a href="#" id="cancel-btn" class="btn btn02">취소</a>
		<a href="#" id="save-btn" class="btn btn1">신청</a>
	</div>
</div>
</form:form>
