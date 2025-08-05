<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
$(function(){
	//테이블 공통 (tr,th,td 처음과 끝 요소 클래스명 부여)
	$('table tr:first-child').addClass('first');
	$('table tr').each(function(){
		$(this).children('th:first-child,td:first-child').addClass('first');
		$(this).children('th:last-child,td:last-child').addClass('last');
	});

	$('a#addCode').on('click', function(e) {
		e.preventDefault();
		
		$('#dialog-2').load('editCode.do?editMode=ADD&homepage_id=${code.homepage_id}&group_id=${code.group_id}', function( response, status, xhr ) {
			try {
				$('#dialog-2').dialog('open');
			} catch (e) {
			}
		});
	});

	$('a#dialog-modify').on('click', function(e) {
		e.preventDefault();
		
		$('#dialog-2').load('editCode.do?editMode=MODIFY&homepage_id=${code.homepage_id}&group_id=${code.group_id}&code_id=' + $(this).attr('keyValue'), function( response, status, xhr ) {
			try {$('#dialog-2').dialog('open');} catch (e) {} 
		});
	});
	
	$('a#code_delete').on('click', function(e) {
		e.preventDefault();
		
		if(confirm('해당 코드를 삭제 하시겠습니까?')) {
			$.ajax({
				url : 'save.do?editMode=DELETE&homepage_id=${code.homepage_id}&group_id=${code.group_id}&code_id=' + $(this).attr('keyValue'),
				async : true ,
				method : 'POST',
				success : function(data) {
					alert(data.message);
					$('#codeLayer').load('code.do?editMode=ADD&homepage_id=${code.homepage_id}&group_id=${code.group_id}');
				}
			});	
		}
	});
});
</script>
<div id="editDisable" class="disableBox">
	<%-- disable 상태로 변경 --%>
	<c:if test="${code.editMode eq 'FIRST'}">
	<div class="mask"></div>
	</c:if>
	<div class="table-action-wrapper">
        <div class="center">
            <p class="total-count">총 ${fn:length(codeList)}건</p>
        </div>

			<c:if test="${authC}">
                <a href="" class="icon-btn navy" id="addCode" >
                    <img src="/resources/cms/img/main/plus.svg" alt="">
                    <div>추가</div>
                </a>
			</c:if>

	</div>
            <table class="custom-table">
				<thead>
					<tr>
						<th>코드ID</th>
						<th>코드명</th>
						<th>정렬순서</th>
						<th>설명</th>
						<th>사용여부</th>
						<th>기능</th>
					</tr>
				</thead>
				<tbody>
				<form:form id="codeIndex" modelAttribute="code" method="POST">
					<c:if test="${fn:length(codeList) < 1}">
					<tr style="height:100%">
						<td colspan="6" style="background:#f8fafb">데이터가 존재하지 않습니다.</td>
					</tr>
					</c:if>
					<c:forEach var="i" varStatus="status" items="${codeList}">
					<tr>
						<td>${i.code_id}</td>
						<td>${i.code_name}</td>
						<td>${i.print_seq}</td>
						<td>${i.remark}</td>
						<td>${i.use_yn}</td>
						<td>
							<c:if test="${authU}">
								<a href="" class="btn" id="dialog-modify" keyValue="${i.code_id}">수정</a>
							</c:if>
							<c:if test="${authD}">
								<a href="" class="btn" id="code_delete" keyValue="${i.code_id}">삭제</a>
							</c:if>
						</td>
					</tr>
					</c:forEach>
				</form:form>
				</tbody>
			</table>

	<div id="dialog-2" class="dialog-common" title="코드정보">
	</div>
</div>	