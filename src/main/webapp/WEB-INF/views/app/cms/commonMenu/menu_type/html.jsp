<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
		    	text: "미리보기",
				"class": 'btn btn3',
				click: function() {
					alert('미리보기');
				}
		    },{
				text: "저장",
				"class": 'btn btn1',
				click: function(){
					if(doAjaxPost($('#menuHtml'))) {
						$('#dialog_HTML').load('edit_html.do?homepage_id=${menuHtml.homepage_id}&menu_idx=${menuHtml.menu_idx}', function( response, status, xhr ) {
							$('div#dialog_HTML').dialog('open');
						});
					};
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

	$("#dialog_HTML").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 1000,
		height: 800
	});
	
	$('a#menu_html_add').on('click', function(e) {
		e.preventDefault();
		
		$.ajax({
			url : 'getMenuHtmlStrOne.do?homepage_id=${menuHtml.homepage_id}&menu_idx=${menuHtml.menu_idx}&html_idx=' + $(this).attr('keyValue'),
			async : true ,
			success : function(data) {
				$('textarea#html').val(data);							
			}
		});
	});
});

</script>
<form:form modelAttribute="menuHtml" action="save_html.do" method="POST" onsubmit="return false;">
<form:hidden path="homepage_id"/>
<form:hidden path="menu_idx"/>
<div class="textareaBox">
	<form:textarea path="html" cssStyle="width:100%;height:450px;"/>
</div>
<div class="table-scroll">
	<table class="">
		<thead>
			<tr class="center">
				<th width="50">순번</th>
				<th width="160">수정일</th>
				<th width="120">등록자정보</th>
				<th width="140">등록IP</th>
				<th>기능</th>
			</tr>
		</thead>
		<tbody style="height:185px">
		<c:if test="${fn:length(menuHtmlList) < 1}">
			<tr>
				<td colspan="5">데이터가 존재하지 않습니다.</td>
			</tr>
		</c:if>
		<c:forEach var="i" varStatus="status" items="${menuHtmlList}">
			<tr>
				<td width="50">
				<c:choose>
				<c:when test="${status.index eq 0}">
				사용중
				</c:when>
				<c:otherwise>
				${status.index}
				</c:otherwise>
				</c:choose>
				</td>
				<td width="160"><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM.dd HH:mm:ss"/></td>
				<td width="120">${i.add_id}</td>
				<td width="140">${i.add_ip}</td>
				<td> 
					<a href="" class="btn btn1" id="menu_html_add" keyValue="${i.html_idx}"><i class="fa fa-plus"></i><span>HTML 복사해오기</span></a>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</div>
</form:form>