<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tag" uri="/WEB-INF/config/tld/cmsTag.tld" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>

<script type="text/javascript">

	// 강좌명 클릭
	function clkTitle(id) {
		$('#lecture_id').val(id);
		doGetLoad('view.do', serializeCustom($('form#lectureInfo')));
	}

	// 신청 취소
	function clkCancel(id) {

		var ajaxData = {
			'request_id' : id,
			'request_type' : '온라인',
			'editMode' : 'DELETE'
		};

		if(confirm('정말 신청을 취소 하시겠습니까?')) {
			$.ajax({
				url: 'delete.do',
				data : ajaxData,
				method: 'POST',
				success: function(response) {
					if(response.valid) {
						alert(response.message);
						location.reload();
					} else {
						if ( response.message != null ) {
							alert(response.message);
						}
						else {
							for(var i =0 ; i < response.result.length ; i++) {
								alert(response.result[i].code);
								$('#'+response.result[i].field).focus();
								break;
							}
						}
					}
				},error: function(response) {
					alert(response.message);
				}
			});
		}
	}

	// 목록으로버튼클릭
	function clkGoIndex(){
		doGetLoad('index.do', serializeCustom($('form#lectureInfo')));
	}

</script>


<h1 style="font-size: 30px;">마이페이지 신청 강좌 목록</h1>
<br>
<h3>현재 로그인 아이디 : ${sessionId}</h3>
<br>
<form:form modelAttribute="lectureInfo" method="GET" action="index.do">
<form:hidden path="lecture_id"/>

	<a href="#" onclick="clkGoIndex()">강좌목록으로</a>

	<div>
		<table class="type1 center">
			<colgroup>
				<col width="10%" />  <%--순번--%>
				<col width="40%" /> <%--강좌명--%>
				<col width="20%" /> <%--강좌명--%>
				<col width="15%" /> <%--교육상태--%>
				<col width="15%" /> <%--예약상태--%>
			</colgroup>
			<thead>
			<tr>
				<th>순번</th>
				<th>강좌명</th>
				<th>신청일</th>
				<th>교육상태</th>
				<th>예약상태</th>
			</tr>
			</thead>
			<tbody>
			<c:forEach var="i" varStatus="status" items="${lectureInfoList}">
				<tr>
					<td>${i.reverse_rownum}</td>
					<td><a href="#" id="${i.lecture_id}" onclick="clkTitle(this.id)">${i.lecture_title}</a></td>
					<fmt:formatDate var="formatRegDate" value="${i.request_add_date}" pattern="yyyy-MM-dd hh:mm"/>
					<td>${formatRegDate}</td>
					<td>${i.lecture_status2}</td>
					<td>
						${i.request_status}
						<c:if test="${i.lecture_status1 eq '모집중' or i.lecture_status1 eq '정원마감'}">
							<a href="#" class="btn delete_btn" id="${i.request_id}" onclick="clkCancel(this.id)">신청취소</a>
						</c:if>
					</td>
				</tr>
			</c:forEach>
			<c:if test="${fn:length(lectureInfoList) < 1}">
				<tr>
					<td colspan="3">신청된 강좌가 없습니다.</td>
				</tr>
			</c:if>
			</tbody>
		</table>

		<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
			<jsp:param name="formId" value="#lectureInfo"/>
		</jsp:include>
	</div>

</form:forgit