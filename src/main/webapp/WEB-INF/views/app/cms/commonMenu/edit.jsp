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
	
	//HTML 등록/수정 dialog
	$('a#modal_HTML').on('click', function(event) {
		$('#dialog_HTML').load('edit_html.do?menu_idx=${menu.menu_idx}', function( response, status, xhr ) {
			$('div#dialog_HTML').dialog('open');
		});
		
		event.preventDefault();
	});
	
	//게시판 등록/수정 dialog
	$('a#modal_BOARD').on('click', function(event) {
		$('#dialog_BOARD').load('edit_board.do?menu_idx=${menu.menu_idx}', function( response, status, xhr ) {
			$('div#dialog_BOARD').dialog('open');
		});
		
		event.preventDefault();
	});
	
	$('a#save').on('click', function(e) {
		//if(confirm('저장 하시겠습니까?')) {
			jQuery.ajaxSettings.traditional = true;
			var option = {
				url : "/cms/commonMenu/save.do",
				type : "POST",
				data : $("#menuEdit").serialize(),
				success: function(response) {
					 if(response.valid) {
		                 if(response.message != null && response.message.replace(/\s/g,'').length!=0) {
							/* alert(response.message);
							location.reload(); */
		                 }
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
		         },
		         error: function(jqXHR, textStatus, errorThrown) {
		             alert('[' + textStatus + ']관리자에게 문의하세요. : ' + errorThrown);
		         }
			};
			$("#menuEdit").ajaxSubmit(option);
		//}
		
		e.preventDefault();
	});
	
});
</script>
<div id="editDisable" class="disableBox">
	<%-- disable 상태로 변경 --%>
	<c:if test="${menu.editMode eq 'FIRST'}">
	<div class="mask"></div>
	</c:if>
	<div class="set-info">
		<strong>메뉴 상세정보</strong>
	</div>
	<form:form id="menuEdit" modelAttribute="menu" action="save.do" method="post" onsubmit="return false;" enctype="multipart/form-data">
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
				<th>메뉴 경로</th>
				<td>
				<c:choose>
					<c:when test="${menu.parent_menu_idx eq 0}">
					최상위 > <span class="menuName"></span>
					</c:when>
					<c:otherwise>
					최상위 > ${parentMenu.menu_full_path_name} > <span class="menuName"></span>
					</c:otherwise>
				</c:choose>
				</td>
			</tr>
			<tr>
				<th>메뉴 ID</th>
				<td>
					<c:choose>
					<c:when test="${menu.editMode eq 'MODIFY'}">${menu.menu_idx}</c:when>
					<c:otherwise>
					<p class="info">자동으로 메뉴 ID가 등록됩니다. </p>
					</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<tr class="group first">
				<th>메뉴명</th>
				<td><form:input path="menu_name" cssClass="text menuName" cssStyle="font-size:14px;font-weight:800;" maxlength=""/></td>
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
				<th>출력 순서</th>
				<td>
					<form:input path="print_seq" cssStyle="width:30px;" cssClass="text spinner"/>
				</td>
			</tr>
			<tr>
				<th>메뉴 유형</th>
				<td>
					<div class="form-group menuTypeBox">
						<div class="radio">
							<form:radiobutton id="menu_type_NONE" path="menu_type" value="NONE"/>
							<label for="menu_type_NONE">기능 없음</label>
						</div>
					</div>
				</td>
			</tr>
		</tbody>
	</table>
	</form:form>
	<c:if test="${menu.editMode eq 'MODIFY'}">
	<div class="button">
		<div class="left">
			<a href="/${homepage.context_path}/html.do?menu_idx=${menu.menu_idx}" class="btn btn3" target="_blank"><i class="fa fa-eye"></i><span>미리보기</span></a>
		</div>
		<div class="right">
			마지막 수정일 : 2016-09-02
		</div>
	</div>
	</c:if>
	
	<br/><br/>
	
	<!-- 메뉴 트리 클릭하기 전에 보여줄 영역 여기부터 -->
	<div class="set-info">
		<strong>메뉴 설정 안내</strong>
		<ul>
			<li>드래그 앤 드롭으로 메뉴 순서를 변경할 수 있습니다.</li>
			<li>메뉴별 상세설정 변경은 메뉴명을 클릭하여 오른쪽 화면에서 변경할 수 있습니다.</li>
			<li><span style="color:#2e9901;!important">메뉴를 편집한 후에 저장하기 버튼을 클릭해야 변경된 내용이 반영됩니다.</span></li>
		</ul>
	</div>
	
	<c:if test="${member.admin}">
		<div class="txt-center">
			<a href="" class="btn">취소</a>
			<a href="" class="btn btn1" id="save">저장하기</a>
		</div>
	</c:if>
	<!-- 메뉴 트리 클릭하기 전에 보여줄 영역 여기까지 -->
	
	
</div>

