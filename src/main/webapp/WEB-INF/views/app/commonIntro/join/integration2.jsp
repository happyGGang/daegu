<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
	table.integration2Table tbody th, table.integration2Table tbody td {text-align: center;padding:6px 0px!important;}
</style>
<script type="text/javascript">
$(function() {
	
	$('a.btn').on('click', function(e) {
		e.preventDefault();
		
		var id = $(this).attr('id');
		if (id == 'join-btn') {
			
			if ($('input[name=integrationId]:checked').length < 1) {
				alert('통합 할 하나의 아이디를 선택해주세요.');
				return false;
			}
			
			if (confirm('대출이력, 희망도서신청 내역 등의 정보가 선택한 아이디로 통합되며\n나머지 아이디는 삭제 됩니다.\n\n진행 하시겠습니까?')) {
				$('input#unAgreeFlag').val('0001');
				$('form#newMember').submit();
			}
		} else {
			location.href="/${homepage.context_path}/index.do";
// 			if (confirm('통합회원으로 전환하지 않을 경우 소속 도서관 이외의 도서관에서 자료대출이 불가하며 통합 전자도서관 서비스를 이용하실 수 없습니다.\n\n추후 회원정보수정 메뉴를 통해 통합회원으로 전환이 가능합니다.\n\n그대로 진행 하시겠습니까?')) {
// 				$('input#unAgreeFlag').val('0002');
// 				$('form#newMember').submit();
// 			}
		}
		
	});
	
	$('input[name=integrationId]').on('click', function(e) {
		var tbody = $(this).parents('tbody');
		$(tbody).find('td').css('background-color', '#FFF');
		$(tbody).find('td').css('font-weight', '');
		$(tbody).find('td').css('color', '#666');
		var tr = $(this).parents('tr');
		$(tr).find('td').css('background-color', '#E6FFFF');
		$(tr).find('td').css('font-weight', 'BOLD');
		$(tr).find('td').css('color', '#000');
		$('input#integrationSeqNo').val($(this).attr('seqno'));
	});
	
});
</script>

	<table class="joinNoline">
		<tbody>
			<tr>
				<td class="joinImg1" >
					<img src="/resources/common/img/mem_prcs02.png">
				</td>
				<td class="joinText">
					이용약관동의
				</td>
				<td class="joinText">
					<img src="/resources/common/img/mem_prcs_arrow.png"/>
				</td>
				<td class="joinImg2">
					<img src="/resources/common/img/mem_prcs03_on.png">
				</td>
				<td class="active joinText">
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
		- 경상북도교육청 도서관 통합정보시스템 구축으로 통합 운영됩니다.<br/>
		- 통합회원 서비스를 이용하기 위해서는 하나의 회원 ID를 선택해야 합니다.<br/>
		- <u>선택한 회원ID로 대출이력 등의 정보가 통합되며 나머지는 삭제됩니다.</u><br/>
		- 통합회원이 되면 하나의 회원정보(회원ID/대출자번호)로 홈페이지 및 도서관 서비스를 이용할 수 있습니다.<br/>
		- 또한, 경상북도교육청 소속 도서관에서 자료대출이 가능하며 통합 전자도서관 이용이 가능합니다.<br/>
		- 통합회원 전환은 24시간 이내에 적용됩니다.<br/>
	</div>
	
<!-- 	<h4>경상북도교육청 공공도서관 통합 규정</h4> -->
<!-- 	<p class="txte">경상북도교육청 도서관 통합정보시스템 구축으로 경상북도교육청 소속 28개 기관의 회원정보가 통합 운영됩니다. <br/>  -->
<!-- 	통합회원이 되시면 하나의 회원정보(ID/자료대출번호)로 홈페이지 서비스 및 자료대출 서비스 등을 이용할 수 있습니다.<br /> -->
	
<!-- 	</p> -->
	
	<div class="Box" style="display: none;">
		<ul class="lib-list">
			<c:forEach items="${libraryList.data}" var="i">
			<c:choose>
				<c:when test="${fn:indexOf(i.lib_name, '연수원') > -1}">
			<li>경상북도교육연수원</li>
				</c:when>
				<c:otherwise>
			<li>${i.lib_name}</li>
				</c:otherwise>
			</c:choose>
			</c:forEach>
		</ul>
	</div>
	
	<form:form modelAttribute="newMember" action="integration3.do" method="post">
	<form:hidden path="editMode"/>
	<form:hidden path="before_url"/>
	<form:hidden path="ageType"/>
	<form:hidden path="menu_idx"/>
	<form:hidden path="unAgreeFlag"/>
	<form:hidden path="integrationIdList"/>
	<form:hidden path="integrationSeqNo"/>
	<form:hidden path="integrationSeqNoList"/>
	
	<h4>아이디 선택</h4>
	<table class="integration2Table">
		<colgroup>
			<col width="6%">
			<col width="15%">
			<col width="18%">
			<col width="13%">
			<col width="9%">
			<col width="12%">
			<col width="16%">
			<col width="21%">
		</colgroup>
		<thead>
		<tr>
			<th class="center">선택</th>
			<th class="center">소속도서관</th>
			<th class="center">대출회원번호</th>
			<th class="center">웹아이디</th>
			<th class="center">성명</th>
			<th class="center">생년월일</th>
			<th class="center">휴대전화번호</th>
			<th class="center">가입일</th>
		</tr>
		</thead>
		<tbody>
			<c:forEach items="${dupList}" var="i" varStatus="status">
			<tr>
				<c:choose>
				<c:when test="${multiId and fn:contains(i.USER_ID, '*')}">
				<td class="center"><form:radiobutton path="integrationId" value="${i.USER_ID}" disabled="true" title="준회원 아이디는 선택하실 수 없습니다." alt="준회원 아이디는 선택하실 수 없습니다."/></td>
				</c:when>
				<c:otherwise>
				<td class="center"><form:radiobutton path="integrationId" value="${i.USER_ID}" seqno="${i.SEQ_NO}" /></td>
				</c:otherwise>
				</c:choose>
				<td style="font-size: 12px;">${i.LOCA_NAME}</td>
				<td>${i.USER_ID}</td>
				<td>${i.WEB_ID}</td>
				<td>${i.USER_NAME}</td>
				<td>${i.BIRTHD}</td>
				<td>${i.MOBILE_NO }</td>
				<td>${i.INSERT_DATE}</td>
			</tr>
			</c:forEach>		
		</tbody>
	</table>
	
	</form:form>
	<div class="btn-wrap">
		<a href="#" id="join-btn" class="btn btn1">확인</a>
		<a href="#" id="" class="btn">취소</a>
	</div>
	
</div>