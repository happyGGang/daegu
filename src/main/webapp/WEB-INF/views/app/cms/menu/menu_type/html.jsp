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
		    	text: "파일 업로드",
				"class": 'btn btn3',
				click: function() {
					showFooter();
					$('div#dialog_fileupload').dialog('open');
				}
		    },
		    {
		    	text: "미리보기",
				"class": 'btn btn3',
				click: function() {
					var params = {
						homepage_id: '${menuHtml.homepage_id}',
						menu_idx: '${menuHtml.menu_idx}',
						html: $('textarea#html').val()
					};
					$.post('save_temp_html.do', params).done(function(data) {
						if(data.valid == false) {
							alert(data.message);
						} else {
							var previewWindow = window.open("/${homepage.context_path}/html.do?menu_idx=${menuHtml.menu_idx}&temp_yn=Y", "_blank");
						}
					});
				}
		    },
		    {
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
	
	var instances = $('div#dialog_fileupload').dialog('instance') || [];
	if(instances.length == 0) {
		$('div#dialog_fileupload').dialog({
			width: 380,
			height: 160,
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
					"class": 'btn btn1',
					click: function(){
						upload_tempfile($(this));
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
	}

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
	
	load_tempfile_table('${menuHtml.homepage_id}', '${menuHtml.menu_idx}');
	
	$('a#show_menu_html_footer').on('click', toggleFooter);
	$('a#close_menu_html_footer').on('click', toggleFooter);
});

function showFooter() {
	var html = $('textarea#html');
	var menu_html_footer = $('div#menu_html_footer');
	var show_html_menu_footer = $('a#show_menu_html_footer');
	var close_html_menu_footer = $('a#close_menu_html_footer');

	html.css('height', 425);
	menu_html_footer.css('display', '');
	show_html_menu_footer.css('display', 'none');
	close_html_menu_footer.css('display', '');
}

function toggleFooter() {
	var html = $('textarea#html');
	var menu_html_footer = $('div#menu_html_footer');
	var show_html_menu_footer = $('a#show_menu_html_footer');
	var close_html_menu_footer = $('a#close_menu_html_footer');
	var display = menu_html_footer.css('display');
	
	if(display == 'none') {
		html.css('height', 425);
		menu_html_footer.css('display', '');
		show_html_menu_footer.css('display', 'none');
		close_html_menu_footer.css('display', '');
	} else {
		html.css('height', 625);
		menu_html_footer.css('display', 'none');
		show_html_menu_footer.css('display', '');
		close_html_menu_footer.css('display', 'none');
	}
	
	return false;
}

function load_tempfile_table(homepage_id, menu_idx) {
	$('div#tempfile_table').load('get_temp_files.do?homepage_id=' + homepage_id + '&menu_idx=' + menu_idx);
}

function upload_tempfile(dialog) {
	if($('input#tempfile').val() == '') {
		alert('파일을 선택해주세요.');
		return;
	}
	
	var option = {
		url: 'add_temp_file.do',
		type: "POST",
		data: { homepage_id: '${menuHtml.homepage_id}', menu_idx: '${menuHtml.menu_idx}' },
		dataType: 'json',
		success: function(data) {
			if(data.isValid == false) {
				alert('오류가 발생했습니다. 다시 시도해주세요.');
			} else {
				load_tempfile_table(data.homepage_id, data.menu_idx);
				dialog.dialog('destroy');
			}
		},
		error: function(jqXHR, textStatus, errorThrown) {
             alert('[' + textStatus + ']관리자에게 문의하세요. : ' + errorThrown);
        }
	};
	$('form#fileUploadForm').ajaxSubmit(option);
	$('input#tempfile').val('');
}
</script>
<form:form modelAttribute="menuHtml" action="save_html.do" method="POST" onsubmit="return false;">
<form:hidden path="homepage_id"/>
<form:hidden path="menu_idx"/>
<div class="textareaBox">
	<form:textarea path="html" cssStyle="width:100%;height:625px;"/>
</div>

<div style="text-align: center; margin-bottom: 12px;">
<a href="#" id="show_menu_html_footer">업로드 파일, 히스토리 보기 ▲</a>
<a href="#" id="close_menu_html_footer" style="display: none;">업로드 파일, 히스토리 닫기 ▼</a>
</div>

<div id="menu_html_footer" style="display: none;">
<div id="tempfile_table">
</div>
<br/>
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
</div>

<div id="dialog_fileupload" class="injected" style="display: none;">
	<form id="fileUploadForm" action="add_temp_file.do" method="POST">
	<input type="hidden" name="_csrf" value="${_csrf.token}">
		경로: <input type="file" id="tempfile" name="menu_temp_file" style="width: 300px;">
	</form>
</div>
