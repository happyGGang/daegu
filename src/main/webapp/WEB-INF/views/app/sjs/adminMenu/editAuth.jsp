<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
$(function() {
	$('.dialog-common').dialog({ //모달창 기본 스크립트 선언
		autoOpen: false,
		resizable: true,
		modal: true, 
	    open: function() {
	        $('.ui-widget-overlay').addClass('custom-overlay');
	    },
	    close: function() {
	        $('.ui-widget-overlay').removeClass('custom-overlay');
	    },
		buttons: [
		    {
		    	text: "저장",
				"class": 'btn btn3',
				click: function() {
					saveAuth();
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
	
	$("#dialog_editAuth").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 600,
		height: 800
	});
	
	<%-- 권한 추가 버튼 클릭 --%>
	$('a#add_auth').on('click', function(e) {
		e.preventDefault();
		
		$('select#group_list option:selected').each( function() {
			var target_idx = this.value;
			$('select#menu_auth_group_list').find('option').each(function() {
				if(target_idx == this.value) {
					$(this).removeAttr('style')
				}
			});
			$(this).attr('style', 'display:none');
		});
	});
	
	<%-- 권한 삭제 버튼 클릭 --%>
	$('a#del_auth').on('click', function(e) {
		e.preventDefault();
		
		$('select#menu_auth_group_list option:selected').each( function() {
			var target_idx = this.value;
			$('select#group_list').find('option').each(function() {
				if(target_idx == this.value) {
					$(this).removeAttr('style')
				}
			});
			$(this).attr('style', 'display:none');
		});
	});
	
	<%-- 권한 저장 --%>
	function saveAuth() {
		if (confirm("저장하시겠습니까?")) {
			$('select#menu_auth_group_list option').each( function() {
				if ($(this).attr('style') == null) {
					$(this).clone().appendTo('select#sel_group');
				}
	        });
			
			$('select#sel_group > option').attr('selected', 'selected');
			
			jQuery.ajaxSettings.traditional = true;
			var option = {
				url : 'saveAuth.do',
				type : "POST",
				data : $("form#authForm").serialize(),
				success: function(response) {
					 if(response.valid) {
		                 if(response.message != null && response.message.replace(/\s/g,'').length!=0) {
							alert(response.message);
							$('#dialog_editAuth').remove();
							$('div#editLayer').load('edit.do?' + $('form#form_1').serialize());	
		                 }
					} else {
		                for(var i =0 ; i < response.result.length ; i++) {
							alert(response.result[i].code);
							break;
						}
					}
		         },
		         error: function(jqXHR, textStatus, errorThrown) {
		             alert('[' + textStatus + ']관리자에게 문의하세요. : ' + errorThrown);
		         }
			};
			$('form#authForm').ajaxSubmit(option);
		}
	}
});	
</script>

<form:form id="authForm" modelAttribute="adminMenuAuthGroup" action="saveAuth.do" method="post"> 
<form:hidden path="menu_idx"/>
<div class="column-edit menu-group">
	<h3 class="center">CMS 메뉴접근 권한관리</h3>
	<div class="column ban">
		<div class="areaL">
			<h4>미소속 그룹</h4>
			<select id="group_list" size="33" multiple="multiple">
				<c:forEach var="i" varStatus="status_i" items="${groupListAll}">
					<c:set var="isUse" value="0"/>
					<c:forEach	var="j" varStatus="status_j" items="${adminMenuAuthGroupList}">
						<c:if test="${i.grp_seqno eq j.grp_seqno}">
							<c:set var="isUse" value="1" />
						</c:if>
					</c:forEach>
					<option value="${i.grp_seqno}" label="${i.grp_name }" ${isUse eq '1'? 'style="display:none"' : '' }>
				</c:forEach>
			</select>
		</div>
		<div class="areaC">
			<!-- <h4>버튼</h4> -->
			<div class="btn-box txt-center">
				<a href="" id="add_auth" class="btn btn1"><span>추가</span><i class="fa fa-arrow-right"></i></a>
				<a href="" id="del_auth" class="btn btn5"><i class="fa fa-arrow-left"></i><span>삭제</span></a>
			</div>
		</div>
		<div class="areaR">
			<h4>소속 그룹</h4>
			<select id="menu_auth_group_list" size="33" multiple="multiple">
				<c:forEach var="i" varStatus="status_i" items="${groupListAll}">
					<c:set var="isUse" value="1"/>
					<c:forEach	var="j" varStatus="status_j" items="${adminMenuAuthGroupList}">
						<c:if test="${i.grp_seqno eq j.grp_seqno}">
							<c:set var="isUse" value="0" />
						</c:if>
					</c:forEach>
					<option value="${i.grp_seqno}" label="${i.grp_name }" ${isUse eq '1'? 'style="display:none"' : '' }>
				</c:forEach>
			</select>
			
			<select id="sel_group" name="menu_auth_group_arr" multiple="multiple" style="display:none"></select>
		</div>
	</div>
</div>
</form:form>