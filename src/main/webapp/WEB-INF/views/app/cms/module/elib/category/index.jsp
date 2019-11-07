<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<style>
	div.leftBox {float: left;}
	div.rightBox {float: left;}
</style>
<script>
var edit_cate_dialog;

$(document).ready(function() {
	edit_cate_dialog = $('div#edit_cate').dialog({ //모달창 기본 스크립트 선언
		autoOpen: false,
		resizable: false,
		modal: true, 
	    open: function(){
	        $('.ui-widget-overlay').addClass('custom-overlay');
	    },
	    close: function(){
	        $('.ui-widget-overlay').removeClass('custom-overlay');
	    }
	});
	
	$('select#cate1').on('change', function(e) {
		var cate_id = $('select#cate1').val();
		$.get('getSubcategories.do?cate_id=' + cate_id, function(data) {
			var cate2 = $('select#cate2').empty();
			$(data.data).sort(function(a, b) {
				return parseInt(a.display_seq) > parseInt(b.display_seq);
			}).each(function(i) {
				cate2.append($('<option>', { value: this.cate_id, text: this.cate_name }));
			});
		});
	});
	
	$('a#up_cate').on('click', function(e) {
		e.preventDefault();
		
		var idx = fm.cate1.options.selectedIndex;
		
		if(idx < 0) {
			alert("1차 카테고리를 선택하세요.");
			return;
		}
		
		moveOption(idx, -1, fm.cate1.options);
	});
	
	$('a#down_cate').on('click', function(e) {
		e.preventDefault();
		
		var idx = fm.cate1.options.selectedIndex;
		
		if(idx < 0) {
			alert("1차 카테고리를 선택하세요.");
			return;
		}
		
		moveOption(idx, 1, fm.cate1.options);
	});
	
	$('a#save_list').on('click', function(e) {
		e.preventDefault();
		
		if(confirm("1차 카테고리의 표시순서를 저장하시겠습니까?")) {
			saveList(fm.cate1.options);
		}
	});
	
	$('a#add_cate').on('click', function(e) {
		e.preventDefault();
		$('input#editMode').val('ADD');
		$('input#cate_name').val('');
		$('input#depth').val('1');
		$('#depth_text').text('1');
		$('#parent_name').text('최상위 카테고리');
		openAddDialog(addOption('select#cate1'));
	});
	
	$('a#modify_cate').on('click', function(e) {
		e.preventDefault();
		if(fm.cate1.options.selectedIndex < 0) {
			alert("수정할 1차 카테고리를 선택하세요.");
			return;
		}
		$('input#editMode').val('MODIFY');
		$('input#cate_id').val($('select#cate1').val());
		$('input#cate_name').val($('select#cate1 option:selected').text());
		$('input#depth').val('1');
		$('#depth_text').text('1');
		$('#parent_name').text('최상위 카테고리');
		openModifyDialog(modifyOption('select#cate1'), deleteOption('select#cate1'));
	});
	
	$('a#up_cate2').on('click', function(e) {
		e.preventDefault();
		
		var idx = fm.cate2.options.selectedIndex;
		
		if(idx < 0) {
			alert("2차 카테고리를 선택하세요.");
			return;
		}
		
		moveOption(idx, -1, fm.cate2.options);
	});
	
	$('a#down_cate2').on('click', function(e) {
		e.preventDefault();
		
		var idx = fm.cate2.options.selectedIndex;
		
		if(idx < 0) {
			alert("2차 카테고리를 선택하세요.");
			return;
		}
		
		moveOption(idx, 1, fm.cate2.options);
	});
	
	$('a#save_list2').on('click', function(e) {
		e.preventDefault();
		
		if(confirm("2차 카테고리의 표시순서를 저장하시겠습니까?")) {
			saveList(fm.cate2.options);
		}
	});
	
	$('a#add_cate2').on('click', function(e) {
		e.preventDefault();

		if(fm.cate1.options.selectedIndex < 0) {
			alert("하위 카테고리를 추가할 1차 카테고리를 선택하세요.");
			return;
		}
		
		$('input#editMode').val('ADD');
		$('input#parent_id').val($('select#cate1').val());
		$('input#depth').val('2');
		$('#parent_name').text($('select#cate1 option:selected').text());
		$('#depth_text').text('2');
		$('input#cate_name').val('');
		openAddDialog(addOption('select#cate2'));
	});
	
	$('a#modify_cate2').on('click', function(e) {
		e.preventDefault();
		
		if(fm.cate2.options.selectedIndex < 0) {
			alert("수정할 2차 카테고리를 선택하세요.");
			return;
		}
		$('input#editMode').val('MODIFY');
		$('input#parent_id').val($('select#cate1').val());
		$('input#cate_id').val($('select#cate2').val());
		$('input#cate_name').val($('select#cate2 option:selected').text());
		$('input#depth').val('2');
		$('#parent_name').text($('select#cate1 option:selected').text());
		$('#depth_text').text('2');
		openModifyDialog(modifyOption('select#cate2'), deleteOption('select#cate2'));
	});
	
});

function moveOption(i, n, options) {
	if(n < 0 && i == 0) return;
	if(n > 0 && i >= options.length-1) return;
	
	var opt1 = options[i];
	var opt2 = options[i+n];
	
	var text = opt1.text;
	var value = opt1.value;
	
	opt1.text  = opt2.text;
	opt1.value = opt2.value;
	opt2.text = text;
	opt2.value = value;
	
	options.selectedIndex = i+n;
}

function saveList(options) {
	var data_list = [];
	for(var i = 0; i < options.length; i++) {
		data_list.push({ cate_id: options[i].value, display_seq: (i + 1) });
	}
	
	$.ajax({
	    url: 'saveList.do',
	    type: "POST", 
	    contentType: "application/json; charset=utf-8",
	    data: JSON.stringify(data_list),
	    async: false,
	    cache: false,
	    processData: false,
	    success: function(data) {
	    	alert(data.message);
			if(data.valid) {
				location.reload();
			}
	    }
	});
}

function openAddDialog(success) {
	edit_cate_dialog.dialog('option', 'buttons',
		[
			{
				text: "저장",
				"class": 'btn btn1',
				click: function(){
					var result = doAjaxPostResponse($('form#category'));
					if(result.valid) {
						success(result);
						$(this).dialog('close');
					};
				}
			},
			{
				text: "취소",
				"class": 'btn',
				click: function(){
					$(this).dialog('close');
				}
			}
		]
	).dialog('open');
}

function openModifyDialog(success, deleteSuccess) {
	edit_cate_dialog.dialog('option', 'buttons',
		[
			{
				text: "삭제",
				"class": 'btn btn1',
				click: function(){
					if(confirm('삭제하시겠습니까?')) {
						$('input#editMode').val('DELETE');
						var result = doAjaxPostResponse($('form#category'));
						if(result.valid && typeof(deleteSuccess) !== undefined) {
							deleteSuccess(result);
							$(this).dialog('close');
						};
					}
				}
			},
			{
				text: "저장",
				"class": 'btn btn1',
				click: function(){
					var result = doAjaxPostResponse($('form#category'));
					if(result.valid) {
						success(result);
						$(this).dialog('close');
					};
				}
			},
			{
				text: "취소",
				"class": 'btn',
				click: function(){
					$(this).dialog('close');
				}
			}
		]
	).dialog('open');
}

function addOption(select) {
	return function(data) {
		var cate = data.data;
		$('<option>', { value: cate.cate_id, text: cate.cate_name }).appendTo(select);
	}
}

function modifyOption(select) {
	return function(data) {
		var cate = data.data;
		$(select + ' option:selected').val(cate.cate_id);
		$(select + ' option:selected').text(cate.cate_name);
	}
}

function deleteOption(select) {
	return function(data) {
		$(select + ' option:selected').remove();
	}
}

function doAjaxPostResponse(form, ajaxBody) {
	jQuery.ajaxSettings.traditional = true;
	var formData = serializeObject(form);
	var result;
	
    $.ajax({
        type: "POST",
        url: form.attr('action'),
        async: false,
        data: formData,
        dataType:'json',
        success: function(response) {
        	response = eval(response);
        	result = response;
            if(response.valid) {            	
                 if(response.message != null && response.message.replace(/\s/g,'').length!=0) {
                	 alert(response.message);
                 }
                 if(response.reload) {
                	 location.reload();
                 }
                 if(response.url != null && response.url.replace(/\s/g,'').length!=0) {
                	 /**
                	  * ajaxBody 값이 존재한다면 ajax , 아니라면 form 을 이용하여 화면이동한다.
                	  */
                	 if(ajaxBody != null && ajaxBody.replace(/\s/g,'').length!=0) {
                		 doAjaxLoad(ajaxBody, response.url, response.data);
                	 } else {
                		 doGetLoad(response.url, response.data);
                	 }
                 }
			} else {
				if(response.message != null && response.message.replace(/\s/g,'').length!=0) {
					alert(response.message);
                } else {
                	for(var i =0 ; i < response.result.length ; i++) {
    					alert(response.result[i].code);
    					$('#'+response.result[i].field).focus();
    					$('#'+response.result[i].field, $(form)).css('border-color', 'red');
                		$('#'+response.result[i].field, $(form)).on('change', function() {
                			$(this).css('border-color', '');
                		});
    					break;
    				}
                }
				
				if(response.url != null && response.url.replace(/\s/g,'').length!=0) {
					if(ajaxBody != null && ajaxBody.replace(/\s/g,'').length!=0) {
						doAjaxLoad(ajaxBody, response.url, response.data);
					} else {
						doGetLoad(response.url, response.data);
               	 	}
				}
			}
         },
         error: function(jqXHR, textStatus, errorThrown) {
             alert('[' + textStatus + ']관리자에게 문의하세요. : ' + errorThrown);
         }
    });
    
    return result;
}
</script>

<div style="margin-left: 100px; height: 600px; text-align: center;">
<form name="fm" method="post" action="#">
<input type="hidden" name="_csrf" value="${_csrf.token}">
<input type="hidden" name="data_list">

	<div class="leftBox" style="width: 350px;">
		<div class="contentsBox">
			<div class="categoryEdit ">
				<p class="title" style="text-align: center;">1차 카테고리</p>
				<select id="cate1" name="cate1" size=2 style="width: 100%; height: 540px;">
					<c:forEach var="i" varStatus="status" items="${categoryList}">
					<option value="${i.cate_id}">${i.cate_name}</option>
					</c:forEach>
				</select>
			</div>
		</div>
		<div class="arrayArea" style="margin-top: 10px;">
		<c:if test="${authC or authU}">
			<a class="btn i01" id="up_cate"><span>위로</span></a>
			<a class="btn i02" id="down_cate"><span>아래</span></a>
			<a class="btn" id="save_list"><span>저장</span></a>
			<a class="btn" id="add_cate"><span>추가</span></a>
			<a class="btn" id="modify_cate"><span>수정</span></a>
		</c:if>
		</div>
	</div>

	<div class="rightBox" style="width: 350px; margin-left: 50px; <c:if test="${category.type == 'ADO'}"> display: none;</c:if>">
		<div class="categoryEdit">
			<p class="title" style="text-align: center;">2차 카테고리</p>
			<select id="cate2" name="cate2" size=2 style="width: 100%; height: 540px;"></select>
		</div>
		<div class="arrayArea" style="margin-top: 10px;">
		<c:if test="${authC or authU}">
			<a class="btn i01" id="up_cate2"><span>위로</span></a>
			<a class="btn i02" id="down_cate2"><span>아래</span></a>
			<a class="btn" id="save_list2"><span>저장</span></a>
			<a class="btn" id="add_cate2"><span>추가</span></a>
			<a class="btn" id="modify_cate2"><span>수정</span></a>
		</c:if>
		</div>
	</div>
</form>
</div>

<div id="edit_cate" style="display: none;">
<form:form modelAttribute="category" action="save.do" method="post" onsubmit="return false;">
<form:hidden path="editMode"/>
<form:hidden path="parent_id"/>
<form:hidden path="cate_id"/>
<form:hidden path="type"/>
<form:hidden path="depth"/>

<table class="tableTy02">
	<colgroup>
		<col width="30%">
		<col width="70%">
	</colgroup>
	<tbody>
		<tr>
			<th>상위카테고리</th>
			<td><span id="parent_name">최상위 카테고리</span></td>
		</tr>
		<tr>
			<th>카테고리명</th>
			<td>
				<form:input path="cate_name" cssStyle="width: 150px;"/>
			</td>
		</tr>
		<tr>
			<th>Depth</th>
			<td><span id="depth_text">1</span></td>
		</tr>
	</tbody>
</table>
</form:form>
</div>
