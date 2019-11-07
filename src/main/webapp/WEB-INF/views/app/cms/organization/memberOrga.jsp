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

	$('a#addMember').on('click', function(e) {
		e.preventDefault();
		if ( $('#homepage_id_1').val() == '' ) {
			alert('홈페이지정보가 없습니다.');
			return;
		}
		
		if ( '${memberOrga.orga_idx}' == 0 ) {
			alert('조직을 선택해주세요.');
			return;
		}
		
		$('#dialog-2').load('editMemberOrga.do?editMode=ADD&homepage_id=${memberOrga.homepage_id}&orga_idx=${memberOrga.orga_idx}', function( response, status, xhr ) {
			$('#dialog-2').dialog('open');
		});
		
	});
	
	$('a.delete-btn').on('click', function(e) {
		e.preventDefault();
		$('#deleteForm #member_id').val($(this).attr('keyValue'));
		
		if ( doAjaxPost($('#deleteForm')) ) {
			$('#memberLayer').load('memberOrga.do?homepage_id=${memberOrga.homepage_id}&orga_idx=${memberOrga.orga_idx}');
		}
	});
	
});
</script>
<form:form id="deleteForm" modelAttribute="memberOrga" action="saveMemberOrga.do">
	<form:hidden path="editMode" value="DELETE"/>
	<form:hidden path="homepage_id"/>
	<form:hidden path="orga_idx"/>
	<form:hidden path="member_id"/>
</form:form>
<div id="editDisable" class="disableBox">
	<%-- disable 상태로 변경 --%>
	<c:if test="${orga.editMode eq 'FIRST'}">
	<div class="mask"></div>
	</c:if>
	<div class="infodesk">
		검색 결과 : ${fn:length(memberList)}건
		<div class="button">
			<c:if test="${member.auth_id <= 200}">
				<a href="" class="btn btn5" id="addMember"><i class="fa fa-plus"></i><span>추가</span></a>
			</c:if>
		</div>
	</div>
	<div class="table-wrap">
		<div class="table-scroll">
			<table class="type1 center">
				<thead>
					<tr>
						<th width="100">사용자ID</th>
						<th width="100">사용자명</th>
						<th width="100">전화번호</th>
						<th width="100">휴대전화번호</th>
						<th width="200">이메일</th>
						<th width="">기능</th>
					</tr>
				</thead>
				<tbody>
					<form:form id="authIndex" modelAttribute="auth" method="POST">
						<c:if test="${fn:length(memberList) < 1}">
							<tr style="height:100%">
								<td style="background:#f8fafb;">데이터가 존재하지 않습니다.</td>
							</tr>
						</c:if>
						<c:forEach var="i" varStatus="status" items="${memberList}">
							<tr>
								<td width="100">${i.member_id}</td>
								<td width="100">${i.member_name}</td>
								<td width="100">${i.phone}</td>
								<td width="100">${i.cell_phone}</td>
								<td width="200">${i.email}</td>
								<td width="">
									<c:if test="${member.auth_id <= 200}">
										<a href="" class="btn delete-btn" keyValue="${i.member_id}">삭제</a>
									</c:if>
								</td>
							</tr>
						</c:forEach>
				</form:form>
				</tbody>
			</table>
		</div>
	</div>
	<div class="alert">
		<ul>
			<li>여러개 나오는 설명 문구를 출력합니다.</li>
			<li>목록을 선택하시면 상세정보를 볼 수 있습니다.</li>
		</ul>
	</div>
	<div id="dialog-2" class="dialog-common" title="사용자리스트">
	</div>
</div>	