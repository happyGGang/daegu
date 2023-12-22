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
	
	<%-- 1차 카테고리 선택 --%>
	$('select#cate1').on('change', function(e) {
		var cate_id = $('select#cate1').val();
		$.get('getMidCategoryList.do?large_code=' + cate_id, function(data) {
			var cate2 = $('select#cate2').empty();
			var cate3 = $('select#cate3').empty();
			$(data).sort(function(a, b) {
				return parseInt(a.print_seq) > parseInt(b.print_seq);
			}).each(function(i) {
				cate2.append($('<option>', { value: this.mid_code, text: this.code_name }));
			});
		});
	});
	
	<%-- 2차 카테고리 선택 --%>
	$('select#cate2').on('change', function(e) {
		var large_code = $('select#cate1').val();
		var mid_code = $('select#cate2').val();
		$.get('getSmallCategoryList.do?large_code=' + large_code + '&mid_code=' + mid_code, function(data) {
			var cate3 = $('select#cate3').empty();
			$(data).sort(function(a, b) {
				return parseInt(a.print_seq) > parseInt(b.print_seq);
			}).each(function(i) {
				cate3.append($('<option>', { value: this.small_code, text: this.code_name }));
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
	
	
	<%-- 1차 카테고리 순서저장 --%>
	$('a#save_list').on('click', function(e) {
		e.preventDefault();
		
		if(confirm("1차 카테고리의 표시순서를 저장하시겠습니까?")) {
			saveList(fm.cate1.options, '1');
		}
	});
	
	<%-- 1차 카테고리 등록 --%>
	$('a#add_code1').on('click', function(e) {
		e.preventDefault();
		$('input#editMode').val('ADD');
		$('input#code_name').val('');
		$('#parent_name').text('최상위 카테고리');
		$('input#large_code').val('0');
		$('input[name=tempCode]').show();
		$('input[name=tempCode]').val('');
		$('span#tempCode').html('');
		openAddDialog(addOption('select#cate1', '1'));
	});
	
	<%-- 2차 카테고리 등록 --%>
	$('a#add_code2').on('click', function(e) {
		e.preventDefault();
		$('input#editMode').val('ADD');
		$('input#code_name').val('');
		$('input#large_code').val($('select#cate1 option:selected').val());
		if ($('input#large_code').val() == '') {
			alert('1차 카테고리를 선택해 주세요.');
			return false;
		}
		$('input#mid_code').val('0');
		$('#parent_name').text($('select#cate1 option:selected').text());
		$('input[name=tempCode]').show();
		$('input[name=tempCode]').val('');
		$('span#tempCode').html('');
		openAddDialog(addOption('select#cate2', '2'));
	});
	
	<%-- 3차 카테고리 등록 --%>
	$('a#add_code3').on('click', function(e) {
		e.preventDefault();
		$('input#editMode').val('ADD');
		$('input#code_name').val('');
		$('input#large_code').val($('select#cate1 option:selected').val());
		$('input#mid_code').val($('select#cate2 option:selected').val());
		if( $('input#large_code').val() == '' ) {
			alert('1차 카테고리를 선택해 주세요.');
			return false;
		}
		if( $('input#mid_code').val() == '' ) {
			alert('2차 카테고리를 선택해 주세요.');
			return false;
		}
		$('input#small_code').val('0');
		$('#parent_name').text($('select#cate2 option:selected').text());
		$('input[name=tempCode]').show();
		$('input[name=tempCode]').val('');
		$('span#tempCode').html('');
		openAddDialog(addOption('select#cate3', '3'));
	});
	
	<%-- 1차 카테고리 수정 --%>
	$('a#modify_code1').on('click', function(e) {
		e.preventDefault();
		if(fm.cate1.options.selectedIndex < 0) {
			alert("선택된 분류코드가 없습니다.");
			return;
		}
		$('input#editMode').val('MODIFY');
		$('input#large_code').val($('select#cate1').val());
		$('input#mid_code').val('--');
		$('input#small_code').val('--');
		$('span#tempCode').html($('select#cate1').val());
		$('input[name=tempCode]').hide();
		$('input#code_name').val($('select#cate1 option:selected').text());
		$('#parent_name').text('최상위 분류');
		openModifyDialog(modifyOption('select#cate1'), deleteOption('select#cate1'));
	});
	
	<%-- 2차 카테고리 수정 --%>
	$('a#modify_code2').on('click', function(e) {
		e.preventDefault();
		if(fm.cate2.options.selectedIndex < 0) {
			alert("선택된 분류코드가 없습니다.");
			return;
		}
		$('input#editMode').val('MODIFY');
		$('input#large_code').val($('select#cate1').val());
		$('input#mid_code').val($('select#cate2').val());
		$('input#small_code').val('--');
		$('span#tempCode').html($('select#cate2').val());
		$('input[name=tempCode]').hide();
		$('input#code_name').val($('select#cate2 option:selected').text());
		$('#parent_name').text($('select#cate1 option:selected').text());
		openModifyDialog(modifyOption('select#cate2'), deleteOption('select#cate2'));
	});
	
	<%-- 3차 카테고리 수정 --%>
	$('a#modify_code3').on('click', function(e) {
		e.preventDefault();
		if(fm.cate3.options.selectedIndex < 0) {
			alert("선택된 분류코드가 없습니다.");
			return;
		}
		$('input#editMode').val('MODIFY');
		$('input#large_code').val($('select#cate1').val());
		$('input#mid_code').val($('select#cate2').val());
		$('input#small_code').val($('select#cate3').val());
		$('span#tempCode').html($('select#cate3').val());
		$('input[name=tempCode]').hide();
		$('input#code_name').val($('select#cate3 option:selected').text());
		$('#parent_name').text($('select#cate2 option:selected').text());
		openModifyDialog(modifyOption('select#cate3'), deleteOption('select#cate3'));
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
			alert("3차 카테고리를 선택하세요.");
			return;
		}
		
		moveOption(idx, 1, fm.cate2.options);
	});
	
	$('a#up_cate3').on('click', function(e) {
		e.preventDefault();
		
		var idx = fm.cate3.options.selectedIndex;
		
		if(idx < 0) {
			alert("3차 카테고리를 선택하세요.");
			return;
		}
		
		moveOption(idx, -1, fm.cate3.options);
	});
	
	$('a#down_cate3').on('click', function(e) {
		e.preventDefault();
		
		var idx = fm.cate3.options.selectedIndex;
		
		if(idx < 0) {
			alert("3차 카테고리를 선택하세요.");
			return;
		}
		
		moveOption(idx, 1, fm.cate3.options);
	});
	
	<%-- 2차 카테고리 순서저장 --%>
	$('a#save_list2').on('click', function(e) {
		e.preventDefault();
		
		if(confirm("2차 카테고리의 표시순서를 저장하시겠습니까?")) {
			saveList(fm.cate2.options, '2');
		}
	});
	
	<%-- 1차 카테고리 순서저장 --%>
	$('a#save_list3').on('click', function(e) {
		e.preventDefault();
		
		if(confirm("3차 카테고리의 표시순서를 저장하시겠습니까?")) {
			saveList(fm.cate3.options, '3');
		}
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

function saveList(options, n) {
	var data_list = [];
	for(var i = 0; i < options.length; i++) {
		if (n == '1') {
			data_list.push({ large_code: options[i].value, mid_code : '--', small_code : '--', print_seq: (i + 1) });
		} else if (n == '2') {
			var large_code = $('select#cate1').val();
			data_list.push({ large_code: large_code, mid_code : options[i].value, small_code : '--', print_seq: (i + 1) });
		} else if (n == '3') {
			var large_code = $('select#cate1').val();
			var mid_code = $('select#cate2').val();
			data_list.push({ large_code: large_code, mid_code : mid_code, small_code : options[i].value, print_seq: (i + 1) });
		}
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
// 				location.reload();
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
					var result = doAjaxPostResponse($('form#archiveCategory'));
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
						var result = doAjaxPostResponse($('form#archiveCategory'));
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
					var result = doAjaxPostResponse($('form#archiveCategory'));
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

function addOption(select, div) {
	return function(data) {
		var cate = data.data;
		if (div == '1') {
			$('<option>', { value: cate.large_code, text: cate.code_name }).appendTo(select);
		} else if (div == '2') {
			$('<option>', { value: cate.mid_code, text: cate.code_name }).appendTo(select);
		} else if (div == '3') {
			$('<option>', { value: cate.small_code, text: cate.code_name }).appendTo(select);
		}
	}
}

function modifyOption(select) {
	return function(data) {
		var cate = data.data;
		$(select + ' option:selected').text(cate.code_name);
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

	<div class="leftBox" style="width: 390px;">
		<div class="contentsBox">
			<div class="categoryEdit ">
				<p class="title" style="text-align: center;">1차 카테고리</p>
				<select id="cate1" name="cate1" size=2 style="width: 100%; height: 540px;">
					<c:forEach var="i" varStatus="status" items="${largeCodeList}">
					<option value="${i.large_code}">${i.code_name}</option>
					</c:forEach>
				</select>
			</div>
		</div>
		<div class="arrayArea" style="margin-top: 10px;">
			<a class="btn i01" id="up_cate"><span><i class="fa fa-arrow-up" aria-hidden="true"></i>위로</span></a>
			<a class="btn i02" id="down_cate"><span><i class="fa fa-arrow-down" aria-hidden="true"></i>아래</span></a>
			<a class="btn" id="save_list"><span><i class="fa fa-floppy-o" aria-hidden="true"></i>저장</span></a>
			<a class="btn" id="add_code1"><span><i class="fa fa-plus" aria-hidden="true"></i>추가</span></a>
			<a class="btn" id="modify_code1"><span><i class="fa fa-pencil-square-o" aria-hidden="true"></i>수정</span></a>
		</div>
	</div>

	<div class="rightBox" style="width: 390px; margin-left: 50px;">
		<div class="categoryEdit">
			<p class="title" style="text-align: center;">2차 카테고리</p>
			<select id="cate2" name="cate2" size=2 style="width: 100%; height: 540px;"></select>
		</div>
		<div class="arrayArea" style="margin-top: 10px;">
			<a class="btn i01" id="up_cate2"><span><i class="fa fa-arrow-up" aria-hidden="true"></i>위로</span></a>
			<a class="btn i02" id="down_cate2"><span><i class="fa fa-arrow-down" aria-hidden="true"></i>아래</span></a>
			<a class="btn" id="save_list2"><span><i class="fa fa-floppy-o" aria-hidden="true"></i>저장</span></a>
			<a class="btn" id="add_code2"><span><i class="fa fa-plus" aria-hidden="true"></i>추가</span></a>
			<a class="btn" id="modify_code2"><span><i class="fa fa-pencil-square-o" aria-hidden="true"></i>수정</span></a>
		</div>
	</div>

	<div class="rightBox" style="width: 390px; margin-left: 50px;">
		<div class="categoryEdit">
			<p class="title" style="text-align: center;">3차 카테고리</p>
			<select id="cate3" name="cate3" size=2 style="width: 100%; height: 540px;"></select>
		</div>
		<div class="arrayArea" style="margin-top: 10px;">
			<a class="btn i01" id="up_cate3"><span><i class="fa fa-arrow-up" aria-hidden="true"></i>위로</span></a>
			<a class="btn i02" id="down_cate3"><span><i class="fa fa-arrow-down" aria-hidden="true"></i>아래</span></a>
			<a class="btn" id="save_list3"><span><i class="fa fa-floppy-o" aria-hidden="true"></i>저장</span></a>
			<a class="btn" id="add_code3"><span><i class="fa fa-plus" aria-hidden="true"></i>추가</span></a>
			<a class="btn" id="modify_code3"><span><i class="fa fa-pencil-square-o" aria-hidden="true"></i>수정</span></a>
		</div>
	</div>
</form>
</div>

<div id="edit_cate" style="display: none;">
<form:form modelAttribute="archiveCategory" action="save.do" method="post" onsubmit="return false;">
<form:hidden path="editMode"/>
<form:hidden path="large_code"/>
<form:hidden path="mid_code"/>
<form:hidden path="small_code"/>

<table class="tableTy02">
	<colgroup>
		<col width="30%">
		<col width="70%">
	</colgroup>
	<tbody>
		<tr>
			<th>상위<br>카테고리</th>
			<td><span id="parent_name">최상위 카테고리</span></td>
		</tr>
		<tr>
			<th>카테고리 코드</th>
			<td>
				<input name="tempCode" style="width: 150px;">
				<span id="tempCode"></span>
			</td>
		</tr>
		<tr>
			<th>카테고리명</th>
			<td>
				<form:input path="code_name" cssStyle="width: 150px;"/>
			</td>
		</tr>
	</tbody>
</table>
</form:form>
</div>
