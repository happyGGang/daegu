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
	$('a#save').on('click', function(e){
		e.preventDefault();
		doAjaxPost($('form#memberGroupAuth'));
	});
	
	
	<%--체크박스선택--%>
	$('input.checkAll').on('click', function() {
		var $myTr = $(this).parents('tr');
		$($myTr).find('input:checkbox').prop('checked', $(this).is(':checked'));
	});
	<%-- 체크박스 선택 끝 --%>
	
	$('input#masterCheck').on('click', function() {
		$('input:checkbox:visible').not(':disabled').prop('checked', $(this).is(':checked'));
	});
	
	<%--구분값 변경(CMS, SITE)--%>
	$('select#moduleType').on('change', function() {
		$('#authLayer').load('memberGroupAuth.do?editMode=ADD&member_group_idx=${memberGroupAuth.member_group_idx}&moduleType='+$(this).val());
// 		doAjaxLoad('div#ajaxLoadBody', '/cms/authConfig/memberGroupAuth.do', serializeCustom($('form#authConfig')));
	});
	
	<%--모듈권한설정--%>
	$('a.setModuleAuth').on('click', function(e) {
		e.preventDefault();
		var param = 'menu_idx='+$(this).data('menu-idx');
		param += '&module_idx='+$(this).data('module-idx');
		param += '&moduleType='+$('select#moduleType option:selected').val();
		param += '&member_group_idx='+$('input#member_group_idx').val();
		
		$('#dialog-1').load('editAuthGroupModule_ajax.do?'+param, function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
	});
	
	$('input#masterCheckR, input#masterCheckU, input#masterCheckC, input#masterCheckD').on('click', function() {
		$('input.'+$(this).attr('id')).prop('checked', $(this).is(':checked'));
	});
	
});
</script>
<style>
.width200{width: 200px;}
</style>
<form:form modelAttribute="memberGroupAuth" method="POST" action="save.do">
<form:hidden path="member_group_idx"/>
<form:hidden path="homepage_id"/>
<div id="editDisable" class="disableBox">
	<%-- disable 상태로 변경 --%>
	<c:if test="${memberGroupAuth.editMode eq 'FIRST'}">
	<div class="mask"></div>
	</c:if>
	<div class="infodesk">
		구분 : <form:select path="moduleType" cssClass="selectmenu">
			<form:option value="CMS" label="관리자페이지" />
			<form:option value="SITE" label="이용자페이지" />
		</form:select>
		<div class="button">
			
			<a href="#" class="btn btn5" id="save"><i class="fa fa-floppy-o" aria-hidden="true"></i></i><span>저장</span></a>
			
		</div>
	</div>
	
	
	<div class="table-wrap">
		<div class="table-scroll">
			<table class="type1">
				<colgroup>
					<col width="200"/>
					<col width="200"/>
					<col/>
					<col/>
					<col/>
					<col/>
					<col/>
					<col/>
				</colgroup>
				<thead>
					<tr>
						<th class="width200">메뉴명</th>
						<th class="width200">모듈명</th>
						<th><input type="checkbox" id="masterCheck"/>전체</th>
						<th><input type="checkbox" id="masterCheckR"/><label for="masterCheckR">조회</label></th>
						<th><input type="checkbox" id="masterCheckC"/><label for="masterCheckC">등록</label></th>
						<th><input type="checkbox" id="masterCheckU"/><label for="masterCheckU">수정</label></th>
						<th><input type="checkbox" id="masterCheckD"/><label for="masterCheckD">삭제</label></th>
						<th>모듈권한설정</th>
					</tr>
				</thead>
				<tbody id="authGroupList">
					<c:if test="${fn:length(menuList) < 1}">
					<tr style="height:100%">
						<td style="background:#f8fafb;">데이터가 존재하지 않습니다.</td>
					</tr>
					</c:if>
					<c:forEach var="i" varStatus="status" items="${menuList}" begin="1">
					<tr>
						<th class="width200"><span style="padding-left: ${(i.menu_level-2)*16}px;">${i.menu_name}</span></th>
						<th class="width200"><span>${i.moduleName}</span></th>
						<c:choose>
							<c:when test="${not empty i.moduleName}">
						<td>
							<input type="checkbox" class="checkAll" id="checkAll_${status.index}">
							<label for="checkAll_${status.index}">전체</label>
						</td>
						<td>
							<form:checkbox path="authCodeList" id="checkR_${status.index}" value="${i.menu_idx}_${i.module_idx}_R" class="masterCheckR"/>
							<label for="checkR_${status.index}">조회</label>
						</td>
						<td>
							<c:choose>
								<c:when test="${fn:contains(i.moduleName, 'K.API')}">
								</c:when>
								<c:when test="${fn:contains(i.moduleName, 'HTML')}">
								</c:when>
								<c:when test="${fn:contains(i.moduleName, 'NONE')}">
								</c:when>
								<c:when test="${fn:contains(i.moduleName, '링크')}">
								</c:when>
								<c:otherwise>
									<form:checkbox path="authCodeList" id="checkC_${status.index}" value="${i.menu_idx}_${i.module_idx}_C" class="masterCheckC"/>
									<label for="checkC_${status.index}">등록</label>
								</c:otherwise>
							</c:choose>
						</td>
						<td>
							<c:choose>
								<c:when test="${fn:contains(i.moduleName, 'K.API')}">
								</c:when>
								<c:when test="${fn:contains(i.moduleName, 'HTML')}">
								</c:when>
								<c:when test="${fn:contains(i.moduleName, 'NONE')}">
								</c:when>
								<c:when test="${fn:contains(i.moduleName, '링크')}">
								</c:when>
								<c:otherwise>
									<form:checkbox path="authCodeList" id="checkU_${status.index}" value="${i.menu_idx}_${i.module_idx}_U" class="masterCheckU"/>
									<label for="checkU_${status.index}">수정</label>
								</c:otherwise>
							</c:choose>
						</td>
						<td>
							<c:choose>
								<c:when test="${fn:contains(i.moduleName, 'K.API')}">
								</c:when>
								<c:when test="${fn:contains(i.moduleName, 'HTML')}">
								</c:when>
								<c:when test="${fn:contains(i.moduleName, 'NONE')}">
								</c:when>
								<c:when test="${fn:contains(i.moduleName, '링크')}">
								</c:when>
								<c:otherwise>
									<form:checkbox path="authCodeList" id="checkD_${status.index}" value="${i.menu_idx}_${i.module_idx}_D" class="masterCheckD"/>
									<label for="checkD_${status.index}">삭제</label>
								</c:otherwise>
							</c:choose>
						</td>
						<td>
							<c:if test="${not empty i.auth_group_id and (authC or authU or authD)}">
							<a href="#" class="btn btn4 setModuleAuth" data-module-idx="${i.module_idx}" data-menu-idx="${i.menu_idx}">모듈권한설정</a>
							</c:if>
						</td>
							</c:when>
							<c:otherwise>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
							</c:otherwise>
						</c:choose>
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
<div id="dialog-1" class="dialog-common" title="모듈권한정보">
</div>