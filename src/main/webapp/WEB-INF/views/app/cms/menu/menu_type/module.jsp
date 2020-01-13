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
				text: "취소",
				"class": 'btn',
				click: function() {
					$(this).dialog('destroy');
				}
			}
		]
	});

	$("#dialog_MODULE").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 1000,
		height: 800
	});

	$('a#moduleUse').on('click', function(e) {
		$('input#manage_idx').val($(this).attr('keyValue'));
		$('td#edit_moduleIdx').html($(this).attr('keyValue'));
		$('td#edit_moduleName').html($(this).attr('moduleName'));
		$('td#edit_moduleLink').html($(this).attr('moduleLink'));
		if ($('input.menuName').val() == '') {
			$('input.menuName').html($(this).attr('moduleName'));
		}

		if ( $(this).attr('keyValue') == '25' ) {
			$('tr.moduleHtml').show();
		}
		else {
			$('tr.moduleHtml').hide();
		}

		$("#dialog_MODULE").dialog('destroy');
		e.preventDefault();
	});
});
</script>
<div style="width:100%;">
	<table class="type2 menuType-data">
		<colgroup>
			<col width="100"/>
			<col width="250"/>
			<col width="*"/>
			<col width="80"/>
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>모듈명</th>
				<th>모듈설명</th>
				<th>기능</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="i" varStatus="status" items="${moduleMngtList}">
			<tr>
				<td>${i.module_idx}</td>
				<td>${i.module_name}</td>
				<td>${i.remark}</td>
				<td>
					<a href="" class="btn" id="moduleUse" keyValue="${i.module_idx}" moduleName="${i.module_name}" moduleLink="${i.link_url}">사용</a>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</div>

