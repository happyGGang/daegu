<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script>
$(function() {
	$('.dialog-common').dialog({ //모달창 기본 스크립트 선언
		autoOpen: false,
		resizable: false,
		modal: true,
	    open: function(){
	        $('.ui-widget-overlay').addClass('custom-overlay');
	    },
	    close: function(){
	        $('.ui-widget-overlay').removeClass('custom-overlay');
	    },
		buttons: [
			{
				text: "저장",
				"class": 'btn btn1',
				click: function() {
					if(doAjaxPost($('#member'))) {
						$(this).dialog('destroy');
						location.reload();
					}
				}
			},{
				text: "취소",
				"class": 'btn',
				click: function() {
					$(this).dialog('destroy');
				}
			}
		]
	});

	$("#dialog-1").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 700,
		height: 800
	});

	if ( '${member.auth_id_list}' != '' ) {
		var arr = '${member.auth_id_list}'.split(',');
		$.each(arr, function(i, v) {
			$( 'option#auth_' + v ).prop('selected', true);
		});
	}

	$('a#linkMemberSearch').on('click', function(e) {
		$.get('getLinkMember.do?member_id='+$('#member input#member_id:visible').val(), function(response) {
			console.log(response);
			if( response.data.length > 0){

				$('#member #link_member_yn').val('Y');
				$('#member #member_name').val(response.data[0]["NAME"]);
				$('#member #member_pw').val('111111');

				if(response.data[0]["HANDPHONE"] != null){
					var phone = response.data[0]["HANDPHONE"].split("\-");
					$('#member #cell_phone1').val(phone[0]);
					$('#member #cell_phone2').val(phone[1]);
					$('#member #cell_phone3').val(phone[2]);
				}

				if(response.data[0]["E_MAIL"] != null){
					var email = response.data[0]["E_MAIL"].split("\@");
					$('#member #email1').val(email[0]);
					$('#member #email2').val(email[1]);
				}

			} else {
				alert('검색한 사용자 없습니다.');
			}
		});
		e.preventDefault();
	});

	$('#member_id:visible').on('change', function(e) {
		if($('#member #link_member_yn').val() == 'Y'){
			$('#member #link_member_yn').val('N');
			$('#member #member_name').val('');
			$('#member #member_pw').val('');
			$('#member #cell_phone1').val('');
			$('#member #cell_phone2').val('');
			$('#member #cell_phone3').val('');
			$('#member #email1').val('');
			$('#member #email2').val('');
		}
		e.preventDefault();
	});



});

</script>
<form:form modelAttribute="member" action="save.do" method="post" onsubmit="return false;">
	<form:hidden path="editMode"/>
	<form:hidden path="link_member_yn" value="N"/>
<c:if test="${!member.admin or (member.editMode eq 'MODIFY')}">
	<form:hidden path="member_id"/>
</c:if>
<table class="type2">
	<colgroup>
		<col width="130"/>
		<col width="*"/>
	</colgroup>
	<tbody>
		<tr>
			<th>사용자ID</th>
			<td>
				<c:choose>
					<c:when test="${member.editMode eq 'ADD'}">
						<form:input path="member_id" cssStyle="width:178px;" cssClass="text" maxlength="20"/>
					</c:when>
					<c:otherwise>
						${member.member_id}
					</c:otherwise>
				</c:choose>
			</td>
		</tr>
		<tr>
			<th>사용자명</th>
			<td>
				<form:input path="member_name" cssClass="text" maxlength="20"/>
			</td>
		</tr>
		<tr>
			<th>비밀번호</th>
			<td>
				<form:password path="member_pw" cssStyle="width:178px;" cssClass="text" maxlength="20"/>
			</td>
		</tr>
		<tr>
			<th>전화번호</th>
			<td>
				<form:select path="phone1" cssClass="selectmenu">
					<form:options items="${phoneCode}" itemLabel="code_name" itemValue="code_id"/>
				</form:select> -
				<form:input path="phone2" cssStyle="width:40px;" cssClass="text" maxlength="4"/> -
				<form:input path="phone3" cssStyle="width:40px;" cssClass="text" maxlength="4"/>
			</td>
		</tr>
		<tr>
			<th>휴대전화번호</th>
			<td>
				<form:select path="cell_phone1" cssClass="selectmenu">
					<form:options items="${cellPhoneCode}" itemLabel="code_name" itemValue="code_id"/>
				</form:select> -
				<form:input path="cell_phone2" cssStyle="width:40px;" cssClass="text" maxlength="4"/> -
				<form:input path="cell_phone3" cssStyle="width:40px;" cssClass="text" maxlength="4"/>
			</td>
		</tr>
		<tr>
			<th>이메일</th>
			<td>
				<form:input path="email1" cssStyle="width:100px;" cssClass="text" maxlength="20"/> @
				<form:input path="email2" cssStyle="width:100px;" cssClass="text" maxlength="20"/>
			</td>
		</tr>
		<tr style="display: none;">
			<th>등록일</th>
			<td>
				<fmt:formatDate value="${member.add_date}" pattern="yyyy-MM-dd HH:mm" />
			</td>
		</tr>
		<tr style="display: none;">
			<th>비밀번호 변경일</th>
			<td>
				<fmt:formatDate value="${member.pw_change_date}" pattern="yyyy-MM-dd HH:mm" />
			</td>
		</tr>
		<tr style="display: none;">
			<th>마지막 로그인</th>
			<td>
				<fmt:formatDate value="${member.last_login}" pattern="yyyy-MM-dd HH:mm" />
			</td>
		</tr>
	</tbody>
</table>
<c:if test="${member.editMode eq 'ADD'}">
<table class="type2">
	<colgroup>
		<col width="30"/>
		<col width="*"/>
		<col width="180"/>
	</colgroup>
	<thead>
		<th colspan="3">권한</th>
	</thead>
	<tbody id="groupList">
		<c:forEach items="${getMemberGroupList}" var="i" varStatus="status" begin="1">
		<c:if test="${i.user_group_yn ne 'Y' and i.guest_group_yn ne 'Y' }">
		<tr>
			<c:set var="isSite" value="${i.site_id ne 'CMS' and i.parent_member_group_idx eq 0 ? 'th' : 'td'}"></c:set>
			<c:set var="_isSite" value="${i.site_id ne 'CMS' and i.parent_member_group_idx eq 0}"></c:set>
			<${isSite}><c:if test="${!_isSite}"><form:checkbox id="checkAll${status.index}" path="authGroupIdxList" value="${i.member_group_idx}"/></c:if></${isSite}>
			<${isSite} style="text-align: left;"><label for="checkAll${status.index}" style="padding-left:${(i.member_group_depth-1)*15}px;">${i.member_group_name}</label></${isSite}>
			<${isSite} style="text-align: left;"><label for="checkAll${status.index}">${i.remark}</label></${isSite}>
		</tr>
		</c:if>
		</c:forEach>
	</tbody>
</table>
</c:if>
</form:form>