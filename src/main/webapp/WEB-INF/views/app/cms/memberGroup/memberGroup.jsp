<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
var list = $('tbody#authGroupList tr');
$(document).ready(function() {
	//테이블 공통 (tr,th,td 처음과 끝 요소 클래스명 부여)
	$('table tr:first-child').addClass('first');
	$('table tr').each(function(){
		$(this).children('th:first-child,td:first-child').addClass('first');
		$(this).children('th:last-child,td:last-child').addClass('last');
	});
	
	<%--저장--%>
	$('a#saveAuthority').on('click', function(e){
		e.preventDefault();
		doAjaxPost($('form#memberGroup'));
	});

	$('a#dialog-modify').on('click', function(e){
		$('#dialog-2').load('edit_ajax.do?editMode=MODIFY&member_group_idx=${memberGroup.member_group_idx}&auth_id=' + $(this).attr('keyValue'), function( response, status, xhr ) {
			$('#dialog-2').dialog('open');
		});
		
		e.preventDefault();
	});
	
	$('a#auth_delete').on('click', function(e) {
		e.preventDefault();
		
		if(confirm('해당 권한을 삭제 하시겠습니까?')) {
			$.ajax({
				url : 'save.do?editMode=DELETE&member_group_idx=${memberGroup.member_group_idx}&auth_id=' + $(this).attr('keyValue'),
				async : true ,
				method : 'POST',
				success : function(data) {
					alert(data.message);
					$('#authLayer').load('auth.do?editMode=ADD&member_group_idx=${memberGroup.member_group_idx}');
				}
			});	
		}
	});
	
	<%--체크박스선택--%>
	$('input[name=relationList]').on('click', function() {
		<%-- 하위그룹 전체 선택 --%>
		var $myTr = $(this).parents('tr');
		var myLevel = parseInt($($myTr).data('level'));
		var currIdx = $(list).index($($myTr));
		var $nextTr = $($myTr).nextAll('[data-level='+myLevel+']:first');
		var nextIdx = $(list).index($($nextTr));
	
		for (var i=currIdx+1; i<nextIdx; i++) {
			var $el = $(list).get(i);
			if (parseInt($($el).data('level')) > myLevel) {
				$($el).find('input:checkbox').prop('checked', $(this).is(':checked'));
			}
		}
		<%-- 하위그룹 전체 선택 끝--%>
		
		<%-- 상위그룹 선택 시작 --%>
		var checkAll = true;
		
		var parentGroupidx = $(this).data('parentgroupidx');
		$('input[name=relationList][data-parentGroupIdx='+parentGroupidx+']').each(function() {
			if (!$(this).is(':checked')) {
				$('input:checkbox[value='+parentGroupidx+']').prop('checked', false);
				checkAll = false;
				return false;
			}
		});
		
		if (checkAll) {
			if (!$('input:checkbox[value='+parentGroupidx+']').is(':checked')) {
				$('input:checkbox[value='+parentGroupidx+']').prop('checked', true);
			}
		} else {
			var hasParent = false;
			var myParent = $('input:checkbox[value='+parentGroupidx+']');
			var parentGroupidxTmp = $(myParent).data('parentgroupidx');
			var myParentTmp = $('input:checkbox[value='+parentGroupidxTmp+']');
			var myParentTmpLength = $('input:checkbox[value='+parentGroupidxTmp+']').length;
			if (myParentTmpLength > 0) {
				hasParent = true;
				$(myParentTmp).prop('checked', false);
			}
			
			while (hasParent) {
				myParent = $('input:checkbox[value='+parentGroupidxTmp+']');
				parentGroupidxTmp = $(myParent).data('parentgroupidx');
				myParentTmp = $('input:checkbox[value='+parentGroupidxTmp+']');
				myParentTmpLength = $('input:checkbox[value='+parentGroupidxTmp+']').length;
				if (myParentTmpLength > 0) {
					hasParent = true;
					$(myParentTmp).prop('checked', false);
				} else {
					hasParent = false;
				}
			}
		}
		<%-- 상위그룹 선택 끝 --%>
	});
	
	
	<%--탭 선택 시작--%>
	$('div.tabmenu > ul > li > a').on('click', function(e) {
		selectedTab = $(this).data('tab');
		$('div.tabmenu > ul > li').removeClass('active');
		$(this).parent().addClass('active');
		
		$('div.table-wrap').toggle();
		$('a#saveAuthority').toggle();
// 		$('div#member-layer').load('memberList.do', serializeCustom($('form#smsSendForm')));
	});
	<%--탭 선택 끝--%>
	
	if (selectedTab == 'R') {
		$('a#tabLi2').click();
	}
	
	

	<%-- 권한그룹 신규등록  --%>
	$('a#editGroup_add').on('click', function(e) {
		e.preventDefault(); 
		//열려있는 다이얼로그를 삭제한다.(중복방지)
		//$('.dialog-common').remove();
		<c:choose>
		<c:when test="${memberGroup.admin_group_yn eq 'Y' or memberGroup.user_group_yn eq 'Y' or memberGroup.guest_group_yn eq 'Y'}">
		alert('기본 그룹에는 하위그룹을 생성할 수 없습니다. 사이트명을 클릭 후 하위그룹 생성이 가능합니다.');
		</c:when>
		<c:otherwise>
		$('#dialog-1').load('edit_ajax.do?editMode=ADD&parent_member_group_idx=${memberGroup.member_group_idx}', function( response, status, xhr ) {
			try {
				$('#dialog-1').attr('title', '권한그룹 등록');
				$('#dialog-1').dialog('open');
			} catch (e) {
			}
		});
		</c:otherwise>
		</c:choose>
	});
	
	<%-- 권한그룹 수정 --%>
	$('a#editGroup_modify').on('click', function(e) {
		<c:choose>
		<c:when test="${memberGroup.default_group_yn eq 'Y'}">
		alert('기본그룹은 수정할 수 없습니다.');
		</c:when>
		<c:otherwise>
		if(beforeSelected_node.id == null) {
			alert('수정할 권한그룹을 선택하세요.');			
		} else{
			if(beforeSelected_node.id == 'ROOT') {
				alert('최상위 그룹은 수정할 수 없습니다.');
			} else {
				$('#dialog-1').load('edit_ajax.do?editMode=MODIFY&member_group_idx=${memberGroup.member_group_idx}', function( response, status, xhr ) {
					$('#dialog-1').attr('title', '권한그룹 수정');
					$('#dialog-1').dialog('open');
				});
			}
		}
		</c:otherwise>
		</c:choose>
		
		
		e.preventDefault(); 
	});
	
	<%-- 권한그룹 삭제 --%>
	$('a#editGroup_delete').on('click', function(e) {
		<c:choose>
		<c:when test="${memberGroup.default_group_yn eq 'Y'}">
		alert('기본그룹은 삭제할 수 없습니다.');
		</c:when>
		<c:otherwise>
		if(beforeSelected_node.id == null) {
			alert('삭제할 권한그룹을 선택하세요.');			
		} else{
			if(beforeSelected_node.id == 'ROOT') {
				alert('권한그룹 모음은 삭제할 수 없습니다.');
			} else {
				if(confirm('삭제 하시겠습니까?')) {
					$.ajax({
						url : 'save.do?editMode=DELETE&member_group_idx=${memberGroup.member_group_idx}',
						async : true ,
						method : 'POST',
						success : function(data) {
							alert(data.message);
							if(data.valid) {
								location.reload();
							}
						}
					});
				}	
			}
		}
		</c:otherwise>
		</c:choose>
		
		
			
		
		e.preventDefault(); 
	});
});
</script>

<style>
.tabmenu li { width:auto; font-size: 13px;}
</style>

<div id="editDisable" class="disableBox">
	<%-- disable 상태로 변경 --%>
	<c:if test="${memberGroup.editMode eq 'FIRST'}">
	<div class="mask"></div>
	</c:if>
	<div class="infodesk" style="padding-top: 0px;">
		<div style="float:left;">
			<div class="tabmenu tab1" style="padding:0px;">
				<ul>
					<li class="active"><a href="#" keyValue="table1" id="tabLi1" data-tab="D">기본정보</a></li>
					<li class=""><a href="#" keyValue="table2" id="tabLi2" data-tab="R">그룹관계설정</a></li>
				</ul>
			</div>
		</div>
		<div class="button">
			<a href="#" class="btn btn5" id="saveAuthority" style="display: none;"><i class="fa fa-floppy-o" aria-hidden="true"></i></i><span>저장</span></a>
		</div>
	</div>
	<form:form modelAttribute="memberGroup" method="POST" action="saveRelation.do">
	<form:hidden path="member_group_idx"/>
	<div class="table-wrap" id="table1" title="기본정보">
		<table class="border-all">
			<colgroup>
				<col width="120"/>
				<col/>
				<col width="120"/>
				<col/>
				<col width="120"/>
				<col/>
			</colgroup>
			<thead>
				<tr>
					<th colspan="2">그룹 정보</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th>상위그룹명</th>
					<td id="auth_group_name_left">${parentMemberGroup.member_group_name eq null ? (memberGroup.member_group_idx eq 0 ? '':'CMS') : parentMemberGroup.member_group_name}</td>
				</tr>
				<tr>
					<th>그룹명</th>
					<td id="auth_group_name_left">${memberGroup.member_group_name eq null ? 'CMS' : memberGroup.member_group_name}</td>
				</tr>
				<tr>
					<th>설명</th>
					<td id="remark_left">${memberGroup.remark eq null ? 'CMS' : memberGroup.remark}</td>
				</tr>
			</tbody>
		</table>
		<div class="button" style="float: right;">
		<c:if test="${memberGroup.admin_group_yn eq 'N' and memberGroup.user_group_yn eq 'N' and memberGroup.guest_group_yn eq 'N'}">
			<a href="" class="btn btn5" id="editGroup_add"><i class="fa fa-plus"></i><span>그룹 신규등록</span></a>
		</c:if>
		<c:if test="${memberGroup.member_group_idx eq 0}">
			<a href="" class="btn btn5" id="editGroup_add"><i class="fa fa-plus"></i><span>그룹 신규등록</span></a>
		</c:if>
		
		
		<c:if test="${memberGroup.member_group_idx > 0 and memberGroup.default_group_yn ne 'Y'}">
			<a href="" class="btn btn1" id="editGroup_modify"><i class="fa fa-pencil"></i><span>수정</span></a>
			<a href="" class="btn" id="editGroup_delete"><i class="fa fa-minus"></i><span>삭제</span></a>
		</c:if>
		</div>
	</div>
	<div class="table-wrap" id="table2" title="그룹관계설정" style="display: none;">
		<div class="table-scroll">
			<table class="type1">
				<colgroup>
					<col width="30%"/>
					<col/>
				</colgroup>
				<thead>
					<tr>
						<th><input type="checkbox"> 그룹명</th>
						<th>설명</th>
						<th></th>
					</tr>
				</thead>
				<tbody id="authGroupList">
					<c:if test="${fn:length(memberGroupList) < 1}">
					<tr style="height:100%">
						<td style="background:#f8fafb;">데이터가 존재하지 않습니다.</td>
					</tr>
					</c:if>
					<c:forEach var="i" varStatus="status" items="${memberGroupList}">
					<c:set var="_self" value="${i.member_group_idx eq memberGroup.member_group_idx }"></c:set>
					<c:if test="${i.member_group_idx eq memberGroup.member_group_idx }">
					<c:set var="_myLevel" value="${i.member_group_depth}"></c:set>
					</c:if>
					</c:forEach>
					<c:forEach var="i" varStatus="status" items="${memberGroupList}" begin="1">
					<tr data-level="${i.member_group_depth}" data-parentGroupIdx="${i.parent_member_group_idx}">
						<c:set var="isSite" value="${i.parent_member_group_idx eq 0 ? 'th' : 'td'}"></c:set>
						
						<${isSite}>
							<span style="padding-left: ${(i.member_group_depth-1)*15}px;">
								<c:choose>
								<c:when test="${!(i.parent_member_group_idx < 0 or _self or status.first or (status.count == 2) or (i.member_group_depth <= _myLevel))}">
								<form:checkbox 
									path="relationList" 
									data-level="${i.member_group_depth}" 
									data-parentGroupIdx="${i.parent_member_group_idx}" 
									value="${i.member_group_idx}" 
									label="${i.member_group_name}" 
									cssStyle="margin-right:5px;"/> 
								</c:when>
								<c:otherwise>
								<span style="padding-left: 15px;">${i.member_group_name}</span>
								</c:otherwise>
								</c:choose>
								
							</span>
						</${isSite}>
						<${isSite}>${i.remark}</${isSite}>
						<${isSite}>
							<c:if test="${isSite eq 'td'}">
							</c:if>
						</${isSite}>
					</tr>
					</c:forEach>
				
				</tbody>
			</table>
		</div>
	</div>
	</form:form>
	<div class="alert">
<!-- 		<ul> -->
<!-- 			<li>여러개 나오는 설명 문구를 출력합니다.</li> -->
<!-- 			<li>목록을 선택하시면 상세정보를 볼 수 있습니다.</li> -->
<!-- 		</ul> -->
	</div>
</div>	
<div id="dialog-1" class="dialog-common" title="권한그룹">
</div>