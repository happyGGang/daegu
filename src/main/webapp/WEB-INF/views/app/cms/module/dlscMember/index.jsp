<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
$(function(){
	//모달창 링크 버튼
	$('button#search_btn').on('click', function(e) {
		$('#viewPage').val(1);
		doGetLoad('index.do', serializeCustom($('#dlscMember')));
	});

	$('select#rowCount, select#sortField, select#sortType').on('change', function() {
		$('button#search_btn').click();
	});

	$('button#dlsCheck').on('click', function(e) {
		e.preventDefault();
		$('input#reading_id').val($('input#dlsId').val());
		$('input#reading_pw').val($('input#dlsPw').val());

		var wWidth = 360;
 		var wHight = 360;
 		var wX = (window.screen.width - wWidth) / 2;
 		var wY = (window.screen.height - wHight) / 2;

		var dlsWindow = window.open('', "dlsWindow", "directories=no,toolbar=no,resizeable=yes,left="+wX+",top="+(wY-200)+",width="+wWidth+",height="+wHight);
		$('form#dlsCheckForm').submit();
		dlsWindow.focus();
	});
});
</script>
<form id="dlsCheckForm" method="post" target="dlsWindow" action="https://reading.gyo6.net/r/reading/search/ebookView_kb_ck.jsp">
	<input type="hidden" name="reading_pw" id="reading_pw" >
	<input type="hidden" name="reading_id" id="reading_id" >
	<input type="hidden" name="return_url" value="http://www.gbelib.kr/cms/dlscMember/checkDlsTest.do">
</form>
<form:form modelAttribute="dlscMember" action="index.do" onsubmit="return false;">
<form:hidden path="editMode"/>
<div id="editDisable" class="disableBox">
	<div class="infodesk">
		검색 결과 : ${paging.totalDataCount}건
		<form:select path="rowCount" class="selectmenu" style="width:120px;">
			<form:option value="10">10개씩 보기</form:option>
			<form:option value="20">20개씩 보기</form:option>
			<form:option value="30">30개씩 보기</form:option>
			<form:option value="50">50개씩 보기</form:option>
			<form:option value="100">100개씩 보기</form:option>
		</form:select>
		정렬 :
		<form:select path="sortField" class="selectmenu" style="width:100px;">
			<form:option value="add_date" label="등록일"></form:option>
			<form:option value="user_name" label="성명"></form:option>
			<form:option value="lib_id" label="회원번호"></form:option>
		</form:select>
		<form:select path="sortType" class="selectmenu" style="width:100px;">
			<form:option value="DESC">내림차순</form:option>
			<form:option value="ASC">오름차순</form:option>
		</form:select>
		<div style="float: right;">
			DLSC ID & PW 확인 -
			아이디 : <input id="dlsId">
			패스워드 : <input id="dlsPw">
			<button id="dlsCheck"><i class="fa fa-search"></i><span>검색</span></button>
		</div>
	</div>
	<table class="type1 center">
		<thead>
			<tr>
				<th width="50">순번</th>
				<th width="200">회원번호</th>
				<th width="100">성명</th>
				<th width="100">웹아이디</th>
				<th width="100">DLSC아이디</th>
				<th width="100">등록일</th>
			</tr>
		</thead>
		<tbody>
		<c:if test="${fn:length(dlscMemberList) < 1}">
			<tr style="height:100%">
				<td colspan="6" style="background:#f8fafb;">데이터가 존재하지 않습니다.</td>
			</tr>
		</c:if>
		<c:forEach var="i" varStatus="status" items="${dlscMemberList}">
			<tr>
				<td width="50">${paging.listRowNum - status.index}</td>
				<td width="200">${i.lib_id}</td>
				<td class="left" width="100">${i.user_name}</td>
				<td class="left" width="100">${i.web_id}</td>
				<td class="left" width="100">${i.dls_id}</td>
				<td width="100"><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM.dd"/></td>
			</tr>
		</c:forEach>
		</tbody>
	</table>

	<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
		<jsp:param name="formId" value="#dlscMember"/>
	</jsp:include>

	<div class="search txt-center" style="margin-top:25px;"><!-- 하단 정렬 시 margin-top 입력 -->
		<fieldset>
			<form:select path="search_type" cssClass="selectmenu">
				<form:option value="dls_id">회원번호</form:option>
				<form:option value="user_name">성명</form:option>
				<form:option value="web_id">웹아이디</form:option>
			</form:select>
			<form:input path="search_text" cssClass="text" cssStyle="width:200px;"/>
			<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
		</fieldset>
	</div>
</div>
</form:form>
<div id="dialog-1" class="dialog-common" title="DLS 계정 확인">
</div>