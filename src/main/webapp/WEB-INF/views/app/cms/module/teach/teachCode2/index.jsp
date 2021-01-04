<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
		var teach_code = $('select#cate1').val();
		$.get('getSubcategories.do?homepage_id=${category.homepage_id}&teach_code=' + teach_code, function(data) {
			var cate2 = $('select#cate2').empty();
			$(data.data).sort(function(a, b) {
				return parseInt(a.display_seq) > parseInt(b.display_seq);
			}).each(function(i) {
				cate2.append($('<option>', { value: this.teach_code, text: this.code_name }));
			});
		});
	});

	$('a#up_cate').on('click', function(e) {
		e.preventDefault();

		var idx = fm.cate1.options.selectedIndex;

		if(idx < 0) {
			alert("1차 분류를 선택하세요.");
			return;
		}

		moveOption(idx, -1, fm.cate1.options);
	});

	$('a#down_cate').on('click', function(e) {
		e.preventDefault();

		var idx = fm.cate1.options.selectedIndex;

		if(idx < 0) {
			alert("1차 분류를 선택하세요.");
			return;
		}

		moveOption(idx, 1, fm.cate1.options);
	});

	$('a#save_list').on('click', function(e) {
		e.preventDefault();

		if(confirm("1차 분류의 표시순서를 저장하시겠습니까?")) {
			saveList(fm.cate1.options);
		}
	});

	$('a#add_cate').on('click', function(e) {
		e.preventDefault();
		$('input#editMode').val('ADD');
		$('input#code_name').val('');
		$('input#depth').val('1');
		$('#depth_text').text('1');
		$('#parent_name').text('최상위 분류');
		openAddDialog(addOption('select#cate1'));
	});

	$('a#modify_cate').on('click', function(e) {
		e.preventDefault();
		if(fm.cate1.options.selectedIndex < 0) {
			alert("수정할 1차 분류를 선택하세요.");
			return;
		}
		$('input#editMode').val('MODIFY');
		$('input#teach_code').val($('select#cate1').val());
		$('input#code_name').val($('select#cate1 option:selected').text());
		$('input#depth').val('1');
		$('#depth_text').text('1');
		$('#parent_name').text('최상위 분류');
		openModifyDialog(modifyOption('select#cate1'), deleteOption('select#cate1'));
	});

	$('a#up_cate2').on('click', function(e) {
		e.preventDefault();

		var idx = fm.cate2.options.selectedIndex;

		if(idx < 0) {
			alert("2차 분류를 선택하세요.");
			return;
		}

		moveOption(idx, -1, fm.cate2.options);
	});

	$('a#down_cate2').on('click', function(e) {
		e.preventDefault();

		var idx = fm.cate2.options.selectedIndex;

		if(idx < 0) {
			alert("2차 분류를 선택하세요.");
			return;
		}

		moveOption(idx, 1, fm.cate2.options);
	});

	$('a#save_list2').on('click', function(e) {
		e.preventDefault();

		if(fm.cate1.options.selectedIndex < 0) {
			alert("1차 분류를 선택하세요.");
			return;
		}

		if(confirm("2차 분류의 표시순서를 저장하시겠습니까?")) {
			saveList(fm.cate2.options);
		}
	});

	$('a#add_cate2').on('click', function(e) {
		e.preventDefault();

		if(fm.cate1.options.selectedIndex < 0) {
			alert("하위 분류를 추가할 1차 분류를 선택하세요.");
			return;
		}

		$('input#editMode').val('ADD');
		$('input#parent_id').val($('select#cate1').val());
		$('input#depth').val('2');
		$('#parent_name').text($('select#cate1 option:selected').text());
		$('#depth_text').text('2');
		$('input#code_name').val('');
		openAddDialog(addOption('select#cate2'));
	});

	$('a#modify_cate2').on('click', function(e) {
		e.preventDefault();

		if(fm.cate2.options.selectedIndex < 0) {
			alert("수정할 2차 분류를 선택하세요.");
			return;
		}
		$('input#editMode').val('MODIFY');
		$('input#parent_id').val($('select#cate1').val());
		$('input#teach_code').val($('select#cate2').val());
		$('input#code_name').val($('select#cate2 option:selected').text());
		$('input#depth').val('2');
		$('#parent_name').text($('select#cate1 option:selected').text());
		$('#depth_text').text('2');
		openModifyDialog(modifyOption('select#cate2'), deleteOption('select#cate2'));
	});

	$('select#selectLib').on('change', function() {
		location.href = 'index.do?homepage_id='+$(this).val();
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
		data_list.push({ teach_code: options[i].value, display_seq: (i + 1) });
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
		$('<option>', { value: cate.teach_code, text: cate.code_name }).appendTo(select);
	}
}

function modifyOption(select) {
	return function(data) {
		var cate = data.data;
		$(select + ' option:selected').val(cate.teach_code);
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

<div style="margin-left: 100px; height: 650px; text-align: center;">
<form name="fm" method="post" action="#">
<input type="hidden" name="_csrf" value="${_csrf.token}">
<input type="hidden" name="data_list">
	<div style="text-align: left;">
		<c:choose>
			<c:when test="${fn:length(subHomepageList) > 0 and asideHomepageId ne 'h50' and asideHomepageId ne 'h51' and asideHomepageId ne 'h37'}">
				도서관 :
				<select id="selectLib">
					<c:forEach items="${subHomepageList}" var="i" varStatus="status">
						<option value="${i.homepage_id}" ${category.homepage_id eq i.homepage_id ? 'selected' : ''}>${i.homepage_name}</option>
					</c:forEach>
				</select>
			</c:when>

			<c:when test="${asideHomepageId eq 'h50'}">
				도서관 :
				<select id="selectLib">
					<option value="h50" ${category.homepage_id eq 'h50' ? 'selected' : ''}>범어</option>
					<option value="h54" ${category.homepage_id eq 'h54' ? 'selected' : ''}>책숲길</option>
					<option value="h55" ${category.homepage_id eq 'h55' ? 'selected' : ''}>물망이</option>
				</select>
			</c:when>


			<c:when test="${asideHomepageId eq 'h51'}">
				도서관 :
			<select id="selectLib">
					<option value="h51" ${category.homepage_id eq 'h51' ? 'selected' : ''}>용학</option>
					<option value="h56" ${category.homepage_id eq 'h56' ? 'selected' : ''}>파동</option>
					<option value="h57" ${category.homepage_id eq 'h57' ? 'selected' : ''}>무학숲</option>
			</select>
			</c:when>

			<c:when test="${asideHomepageId eq 'h37'}">
				도서관 :
			<select id="selectLib">
					<option value="h72" ${category.homepage_id eq 'h72' ? 'selected' : ''}>도원</option>
					<option value="h67" ${category.homepage_id eq 'h67' ? 'selected' : ''}>성서</option>
					<option value="h68" ${category.homepage_id eq 'h68' ? 'selected' : ''}>본리</option>
					<option value="h69" ${category.homepage_id eq 'h69' ? 'selected' : ''}>달서가족문화</option>
					<option value="h66" ${category.homepage_id eq 'h66' ? 'selected' : ''}>달서어린이</option>
					<option value="h70" ${category.homepage_id eq 'h70' ? 'selected' : ''}>달서영어</option>
					<option value="h41" ${category.homepage_id eq 'h41' ? 'selected' : ''}>독서문화진흥</option>
			</select>
			</c:when>

		</c:choose>
	</div>


	<div class="leftBox" style="width: 350px;">
		<div class="contentsBox">
			<div class="categoryEdit ">
				<p class="title" style="text-align: center;">1차 분류</p>
				<select id="cate1" name="cate1" size=2 style="width: 100%; height: 540px;">
					<c:forEach var="i" varStatus="status" items="${categoryList}">
					<option value="${i.teach_code}">${i.code_name}</option>
					</c:forEach>
				</select>
			</div>
		</div>
		<div class="arrayArea" style="margin-top: 10px;">
		<c:if test="${authC or authU}">
			<a class="btn i01" id="up_cate"><span>위로</span></a>
			<a class="btn i02" id="down_cate"><span>아래</span></a>
<!-- 			<a class="btn" id="save_list"><span>저장</span></a> -->
			<a class="btn" id="add_cate"><span>추가</span></a>
			<a class="btn" id="modify_cate"><span>수정</span></a>
		</c:if>
		</div>
	</div>

	<div class="rightBox" style="width: 350px; margin-left: 50px;">
		<div class="categoryEdit">
			<p class="title" style="text-align: center;">2차 분류</p>
			<select id="cate2" name="cate2" size=2 style="width: 100%; height: 540px;"></select>
		</div>
		<div class="arrayArea" style="margin-top: 10px;">
		<c:if test="${authC or authU}">
			<a class="btn i01" id="up_cate2"><span>위로</span></a>
			<a class="btn i02" id="down_cate2"><span>아래</span></a>
			<a class="btn" id="add_cate2"><span>추가</span></a>
			<a class="btn" id="modify_cate2"><span>수정</span></a>
 			<a class="btn" id="save_list2"><span>저장</span></a>
		</c:if>
		</div>
	</div>
</form>
</div>

<div id="edit_cate" style="display: block;">
<form:form modelAttribute="category" action="save.do" method="post" onsubmit="return false;">
<form:hidden path="editMode"/>
<form:hidden path="parent_id"/>
<form:hidden path="teach_code"/>
<form:hidden path="code_type"/>
<form:hidden path="depth"/>
<form:hidden path="homepage_id"/>


<table class="tableTy02">
	<colgroup>
		<col width="30%">
		<col width="70%">
	</colgroup>
	<tbody>
		<tr>
			<th>상위분류</th>
			<td><span id="parent_name">최상위 분류</span></td>
		</tr>
		<tr>
			<th>분류명</th>
			<td>
				<form:input path="code_name" cssStyle="width: 150px;"/>
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
