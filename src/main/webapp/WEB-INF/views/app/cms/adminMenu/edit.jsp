<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tag" uri="/WEB-INF/config/tld/customTag.tld" %>
<script src="${getContextPath}/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>
<script type="text/javascript">
$(function() {
	//input change (메뉴명 입력 시 메뉴 경로에 자동으로 출력 됨)
	$.event.special.inputchange = {
	    setup: function(){
	        var self = this, val;
	        $.data(this, 'timer', window.setInterval(function(){
	            val = self.value;
	            if($.data(self, 'cache') != val){
	                $.data(self, 'cache', val);
	                $(self).trigger('inputchange');
	            }
	        }, 20));
	    },
	    teardown: function(){
	        window.clearInterval($.data(this,'timer'));
	    }, 
	    add: function(){
	        $.data(this, 'cache', this.value);
	    }
	};
	var txt = $('input.menuName').val();
	$('span.menuName').text(txt);
	$('input.menuName').on('inputchange',function(){
		var txt = $(this).val();
		$('span.menuName').text(txt);
	});
	
	$('input#print_seq').spinner({
		min: 0,
		max: 2500,
		step: 1,
		start: 1000
	});
	
	//메뉴 유형 선택 시 추가 옵션 (cont2.jsp)
	$('.menuType').each(function(i){
		var i = i+1;
		$(this).attr('id','menuType'+i);
	});
	$('.menuTypeBox .radio input').each(function(i){
		var i = i+1;
		$(this).on('click',function(){
			$('.menuType').hide();
			$('#menuType'+i).show();
		});
		if($(this).prop('checked')){
			$('.menuType').hide();
			$('#menuType'+i).show();
		}
	});
	$('.selectmenu').select2({
		//셀렉트 메뉴에 검색 기능 사용 안함
		minimumResultsForSearch: Infinity
	});
	$('.selectmenu-search').select2({
		//셀렉트 메뉴에 검색 기능 사용 함
	});
	
	$('a#save').on('click', function(e) {
		if(confirm('저장 하시겠습니까?')) {
			jQuery.ajaxSettings.traditional = true;
			var option = {
				url : 'save.do',
				type : "POST",
				data : $("#menuEdit").serialize(),
				success: function(response) {
					 if(response.valid) {
		                 if(response.message != null && response.message.replace(/\s/g,'').length!=0) {
							alert(response.message);
							location.reload();
		                 }
					} else {
		                for(var i =0 ; i < response.result.length ; i++) {
							alert(response.result[i].code);
							$('#'+response.result[i].field).focus();
							break;
						}
					}
		         },
		         error: function(jqXHR, textStatus, errorThrown) {
		             alert('[' + textStatus + ']관리자에게 문의하세요. : ' + errorThrown);
		         }
			};
			$('#menuEdit').ajaxSubmit(option);
		}
		
		e.preventDefault();
	});
	
	$('a#modal_editAuth').on('click', function(e) {
		$('div#dialog_editAuth').load('editAuth.do?menu_idx='+$('input#menu_idx').val(), function( response, status, xhr ) {
			$('div#dialog_editAuth').dialog('open');
		});
		
		e.preventDefault();
	});
	
	<c:if test="${adminMenu.editMode eq 'MODIFY'}">
	if ('${adminMenu.menu_type}' == 'module') {
		$('tr#menuTypeContainer').hide();
		$('tr#menuTypeModule').show();
	}
	</c:if>
	
	$('select#menu_type').on('change', function() {
		if ($(this).val() == 'module') {
			$('tr#menuTypeContainer').hide();
			$('tr#menuTypeModule').show();			
		} else {
			$('tr#menuTypeContainer').show();
			$('tr#menuTypeModule').hide();			
		}
	});
});
</script>
<div id="editDisable" class="disableBox">
	<%-- disable 상태로 변경 --%>
	<c:if test="${adminMenu.editMode eq 'FIRST'}">
	<div class="mask"></div>
	</c:if>
	<div class="set-info">
		<strong>메뉴 상세정보</strong>
	</div>
	<form:form id="menuEdit" modelAttribute="adminMenu" action="save.do" method="post" onsubmit="return false;">
	<form:hidden path="menu_idx" />
	<form:hidden path="manage_idx" />
	<form:hidden path="parent_menu_idx" />
	<form:hidden path="group_idx" />
	<form:hidden path="editMode" />
	<table class="type3">
		<colgroup>
			<col width="120"/>
			<col width="*"/>
		</colgroup>
		<tbody>
			<tr>
				<th>메뉴 경로sfsdfsdf</th>
				<td>
				<c:choose>
					<c:when test="${adminMenu.parent_menu_idx eq 0}">
					최상위 > <span class="menuName"></span>
					</c:when>
					<c:otherwise>
					최상위 > ${parentAdminMenu.menu_full_path_name} > <span class="menuName"></span>
					</c:otherwise>
				</c:choose>
				</td>
			</tr>
			<tr>
				<th>메뉴 ID</th>
				<td>
					<c:choose>
					<c:when test="${adminMenu.editMode eq 'MODIFY'}">${adminMenu.menu_idx}</c:when>
					<c:otherwise>
					<p class="info">자동으로 메뉴 ID가 등록됩니다. </p>
					</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<tr class="group first">
				<th>메뉴명</th>
				<td><form:input path="menu_name" cssClass="text menuName" cssStyle="font-size:14px;font-weight:800;" maxlength="20"/></td>
			</tr>
			<tr>
				<th>메뉴명 표시</th>
				<td>
					<div class="checkbox">
						<input type="checkbox" id="check_0" checked="checked"/>
						<label for="check_0">사용함</label>
						<p class="info">체크 해제 시 홈페이지에서 콘텐츠 상단의 메뉴명이 출력되지 않습니다.</p>
					</div>
				</td>
			</tr>
			<tr class="group">
				<th>메뉴 노출</th>
				<td>
					<form:select path="view_yn" cssClass="selectmenu">
						<form:option value="Y">YES</form:option>
						<form:option value="N">NO</form:option>
					</form:select>
					<p class="info">NO 선택 시 홈페이지 메뉴 목록에서 출력되지 않습니다.(URL로 직접 접근은 가능합니다.)</p>
				</td>
			</tr>
			<tr class="group last">
				<th>사용 여부</th>
				<td>
					<form:select path="use_yn" cssClass="selectmenu">
						<form:option value="Y">YES</form:option>
						<form:option value="N">NO</form:option>
					</form:select>
					<p class="info">NO 선택 시 메뉴에 접근이 불가능합니다.</p>
				</td>
			</tr>
			<tr>
				<th>최고관리자 전용</th>
				<td>
					<form:select path="admin_access_yn" cssClass="selectmenu">
						<form:option value="Y">YES</form:option>
						<form:option value="N">NO</form:option>
					</form:select>
				</td>
			</tr>
			<tr>
				<th>출력 순서</th>
				<td>
					<form:input path="print_seq" cssStyle="width:30px;" cssClass="text spinner"/>
				</td>
			</tr>
			<tr>
				<th>메뉴 유형</th>
				<td>
					<form:select path="menu_type" cssClass="selectmenu">
						<form:option value="container">내부링크</form:option>
						<form:option value="module">모듈</form:option>
<%-- 						<form:option value="_blank">외부링크</form:option> --%>
					</form:select>
					<p class="info">외부 링크의 경우 새창으로 연결됩니다.</p>
				</td>
			</tr>
			<tr id="menuTypeContainer">
				<th>링크 주소</th>
				<td>
					<form:input path="menu_url" cssClass="text" cssStyle="width:90%" maxlength="200"/>
					<p class="info">예) /cms/homepage/index.do</p>
				</td>
			</tr>
			<tr id="menuTypeModule" style="display: none;">
				<th>모듈선택</th>
				<td>
					<form:select path="module_idx" cssClass="selectmenu-search" items="${moduleList}" itemLabel="module_name" cssStyle="width:90%" itemValue="module_idx">
					</form:select>
				</td>
			</tr>
			<tr style="display: none;">
				<th>폴더 아이콘</th>
				<td>
					<form:radiobutton path="css_type" value="fa-desktop" label="일반형"/>&nbsp;
					<form:radiobutton path="css_type" value="fa-folder-open" label="폴더형"/>&nbsp;
					<form:radiobutton path="css_type" value="fa-bar-chart" label="통계형"/>
				</td>
			</tr>
			<tr>
				<th>메뉴설명</th>
				<td><form:input path="menu_desc" cssClass="text" cssStyle="width:90%;" maxlength="200"/></td>
			</tr>
			<tr style="display: none;">
				<th>메뉴 접근 권한</th>
				<td>
					<div class="permissionBox">
						<c:set var="group_id" value="" />
						<table>
						<c:forEach var="i" varStatus="status" items="${authList}">
						<c:if test="${group_id ne i.auth_group_id}">
						<c:if test="${!status.first}">
								</td>
							</tr>
						</c:if>
						<c:set var="group_id" value="${i.auth_group_id}" />
							<tr>
								<th style="width:70px">${i.auth_group_name}</th>
								<td>
						</c:if> 
									<tag:menuAuthCheckbox name="auth_id_array" auth_id_array="${menuAuthArray}" value="${i.auth_id}" id="auth_${status.index}"/>
									<label for="auth_${status.index}" style="cursor:pointer;">${i.auth_name}</label>&nbsp;&nbsp;
						<c:if test="${status.last}">
								</td>
							</tr>
						</c:if>
						</c:forEach>
						</table>
					</div>
				</td>
			</tr>
		</tbody>
	</table>
	</form:form>
	<br/><br/>
	<div class="set-info">
		<strong>메뉴 설정 안내</strong>
		<ul>
			<li>메뉴 권한은 수정시에만 반영이 됩니다. 신규메뉴일 경우 생성후 권한 설정 하시기 바랍니다.</li>
			<li>메뉴별 상세설정 변경은 메뉴명을 클릭하여 오른쪽 화면에서 변경할 수 있습니다.</li>
			<li><span style="color:#2e9901;!important">메뉴를 편집한 후에 저장하기 버튼을 클릭해야 변경된 내용이 반영됩니다.</span></li>
		</ul>
	</div>
	
	<div class="txt-center">
		<c:if test="${member.admin}">
			<a href="" class="btn">취소</a>
			<a href="" class="btn btn1" id="save">저장하기</a>
		</c:if>
	</div>
	
	<div id="dialog_editAuth" class="dialog-common" title="그룹관리">
	</div>
	
</div>