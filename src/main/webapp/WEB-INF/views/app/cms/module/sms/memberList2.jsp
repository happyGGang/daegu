<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" type="text/css" href="/resources/cms/smsSend/css/sms2.css"/>
<script src="${getContextPath}/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>
<input type="hidden" id="forDuple" />
<div class="listBox">
	<div class="sendList">
		<!-- 보내는번호 / 받는 번호 -->
		<dl class="sendNum" style="display: none;">
			<dt>&middot; 보내는 번호</dt>
			<dd>
				<c:if test="${authUser.mobileNo eq null}">
				<input name="rtn_mobileno" type="text" size="11" maxlength="12" value="01000000000" class="disable" />
				</c:if>
				<c:if test="${authUser.mobileNo ne null}">
				<input name="rtn_mobileno" type="text" size="11" maxlength="12" value="${authUser.mobileNo}" class="disable" />
				</c:if>
			</dd>
		</dl>
		<dl class="getNum">
			<dt>&middot; 받는 번호</dt>
			<dd>
				<input id="rcv_mobileno_temp" name="" type="text" size="11" maxlength="15" value="" />
			</dd>
		</dl>
		<p class="btn_putNum"><a href="#" id="addTelpcs" class="btn"><i class="fa fa-plus"></i>추가</a>
		
		</p>
		
		<!--// 보내는번호 / 받는 번호 -->
		
		<!-- 전송목록 -->
		<div class="list">
			<table border="0" sumary="문자전송을 할 사람의 이름과 전화번호를 확인할 수 있으며 불필요한 번호는 삭제할 수 있습니다."> 
				<caption class="blind"">문자 전송 목록</caption>
				<colgroup>
					<col width="30px" />
					<col width="65px" />
					<col />
				</colgroup>
				<thead>
					<tr>
						<th scope="col"><input type="checkbox" id="sendListCheck"/></th>
						<th scope="col">이름</th>
						<th scope="col">전화번호</th>
					</tr>
				</thead>
				<tbody id="sendList">
				</tbody>
			</table>
		</div>
		
		<div class="openText" style="display: none;">
			<p>
				<span style="width:80px;">수신번호</span>
				<span style="width:150px;">이름</span>
			</p>
			<textarea id="asdf"></textarea>
			<p class="btn_complete">
				<a href="#" id="closeEditList">
					<img src="${getContextPath}/resources/cms/smsSend/img/btn_complete.gif" alt="편집완료" />
				</a>
			</p>
		</div>
		
		<p class="delBtn">
			<a href="#" class="button" id="chooseDelete">선택삭제</a>
			<a href="#" class="button" id="allDelete">전체삭제</a>
			<a href="#" class="button" id="editList">목록편집</a>
		</p>
		<form id="addressForm" method="post" onsubmit="return false;" style="text-align: center; padding-top: 5px; width:123%; margin-left:-21px;">
		<input type="hidden" name="_csrf" value="${_csrf.token}">
		<input type="file" id="uploadFile" name="uploadFile" style="width: 35%; border: 1px #4554ff solid;">
		<a href="#" class="btn" id="excelUpload">엑셀등록</a>
		<a href="/cms/module/addressBook/excelDownloadSample.do" class="btn btn2" id="excel_down"><i class="fa fa-arrow-down" aria-hidden="true"></i><span>엑셀양식</span></a>
		</form>
		
		<!--// 전송목록 -->
	</div>
	
	<!-- 이동 버튼 -->
	<ul class="moveBtn">
		<li><a href="#" id="arrowLeft"><i class="fa fa-arrow-left" aria-hidden="true"></i></a></li>
	</ul>
	<!--// 이동 버튼 -->
		
	<!-- 주소록 및 그룹 -->
	<div class="addressList">
		<div class="group">
			<h4>&middot; 그룹</h4>
			<div class="list">
				<ul id="contactGroup">
					<c:forEach var="i" varStatus="status" items="${addressBookGroupList}">
						<li <c:if test="${status.index eq 0}">class="on"</c:if>><span><a href="#" seq="${i.address_book_idx}">${i.address_book_name}</a></span></li>
					</c:forEach>
				</ul>
			</div>
		</div>
		<div class="address">
			<h4>&middot; 주소록</h4>
			<div class="list">
				<table border="0" sumary="문자전송을 할 사람의 이름과 전화번호를 확인할 수 있으며 불필요한 번호는 삭제할 수 있습니다."> 
					<caption class="blind">문자 전송 목록</caption>
					<colgroup>
						<col width="30px" />
						<col width="65px" />
						<col />
					</colgroup>
					<thead>
						<tr>
							<th scope="col"><input type="checkbox" id="contactListCheck"/></th>
							<th scope="col">이름</th>
							<th scope="col">전화번호</th>
						</tr>
					</thead>
					<tbody id="contactList">
						<c:forEach var="i" varStatus="status" items="${crcontactList}">
						<tr id="${i.telpcs}" nm="${i.name}">
							<td><input type="checkbox" class="checkOne" seq="${i.seq}"/></td>
							<td class="nickname">${i.name}</td>
							<td>
								<span>${i.telpcs}</span>
							</td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<!--// 주소록 및 그룹 -->
</div>
<!-- <div id="receiveList" style="float: left; width: 45% ">
	<input type="text" class="text" maxlength="11" size="12">
	<a href="" class="btn btn5" id="address_add"><i class="fa fa-plus"></i><span>추가</span></a>
	<a href="" class="btn btn2" id="address_add"><i class="fa fa-minus"></i><span>선택제거</span></a>
	<textarea rows="20" cols="20"></textarea>
</div>
<div class="table-wrap" style="margin-right: 20px; width: 50%; float: right;">
	<div class="table-scroll">
		<div id="module_table" style="display:block;">
			<table id="table1" class="type1 center">
				<thead>
					<tr>
						<th style="width:10px;"><input type="checkbox" id="checkAll" class="checkAll" name="checkbox"/></th>
						<th style="width:65px;">이름</th>
						<th style="width:100px;">전화번호</th>
						<th style="width:100px;">수신여부</th>
						<th style="width:200px;">기타</th>
					</tr>
				</thead>
				<tbody style="height:360px">
				</tbody>
			</table>
		</div>
	</div>
</div>

-->

<script type="text/javascript">
var editingList = false;
$(function() {	
	<%--그룹선택--%>
	$('ul#contactGroup li').on('click', function(e) {
		$('ul#contactGroup li').removeClass('on');
		$(this).addClass('on');
		var seq = $(this).find('a').attr('seq');
		//ajax 주소록 불러오기
		var data;
		$.ajax({
			url: 'getItemList.do',
			type: 'get',
			data: {'address_book_idx' : seq},
			success: function(data) {
				$('tbody#contactList tr').remove();
				var html = '';
				for (var i = 0; i < data.length; i++) {
					html += '<tr id="'+ data[i]['address_cell_phone'] +'" nm="' + data[i]['address_name'] + '">';
					var disabled = '';
					if (data[i]['address_cell_phone'] == null) {
						var disabled = 'disabled="disabled"';
					}
					html += '<td><input type="checkbox" '+disabled+' value="'+data[i]['address_cell_phone']+'"></td>';
					html += '<td class="nickname">'+ data[i]['address_name'] +'</td>';
					html += '<td><span>'+ data[i]['address_cell_phone'] +'</span>';
					html += '</tr>';			
				}
				$('tbody#contactList').append(html);
				
			},
			error: function() {
				alert('!!');
			}
		});
	});
	
	<%--번호추가--%>
	$('a#addTelpcs').on('click', function(e) {
		e.preventDefault();
		if ($('input#rcv_mobileno_temp').val() == '') {
			alert('전화번호를 입력해주세요.'); $('input#rcv_mobileno_temp').focus(); return false;
		}
		var pattern = /^01[\d]{1}-?[\d]{3,4}-?[\d]{4}$/;
		if (!pattern.test($('input#rcv_mobileno_temp').val())) {
			alert('전화번호형식이 올바르지 않습니다.'); $('input#rcv_mobileno_temp').focus(); return false;
		}
		duple = false;
		$('tbody#sendList tr').each(function(i, el) {
			if ($(el).attr('id') == $('input#rcv_mobileno_temp').val()) {
				alert('이미 추가된 번호입니다.'); duple = true; return false;
			}
		});
		if (duple) {
			return false;	
		}
		var html = '';
		html += '<tr id="'+ $('input#rcv_mobileno_temp').val() +'" nm="">';
		html += '<td><input type="checkbox" class="checkOne" value="'+$('input#rcv_mobileno_temp').val()+'"></td>';
		html += '<td class="nickname"></td>';
		html += '<td><span>'+$('input#rcv_mobileno_temp').val()+'</span>';
		html += '<span><a href="#" class="delTelpcs"><i class="fa fa-times-circle" aria-hidden="true"></i></a></span>';
		html += '</tr>';
		$('tbody#sendList').append(html);
		$('input#forDuple').val($('input#forDuple').val() + $('input#rcv_mobileno_temp').val());
		deletePcs();
		$('input#rcv_mobileno_temp').val('');
		$('input#rcv_mobileno_temp').focus();
	});
	$('input#rcv_mobileno_temp').on('keyup', function(e) {
		e.preventDefault();
		if (e.keyCode != '13') {
			return false;
		}
		if ($('input#rcv_mobileno_temp').val() == '') {
			alert('전화번호를 입력해주세요.'); $('input#rcv_mobileno_temp').focus(); return false;
		}
		var pattern = /^01[\d]{1}-?[\d]{3,4}-?[\d]{4}$/;
		if (!pattern.test($('input#rcv_mobileno_temp').val())) {
			alert('전화번호형식이 올바르지 않습니다.'); $('input#rcv_mobileno_temp').focus(); return false;
		}
		duple = false;
		$('tbody#sendList tr').each(function(i, el) {
			if ($(el).attr('id') == $('input#rcv_mobileno_temp').val()) {
				alert('이미 추가된 번호입니다.'); duple = true; return false;
			}
		});
		if (duple) {
			return false;	
		}
		var html = '';
		html += '<tr id="'+ $('input#rcv_mobileno_temp').val() +'" nm="">';
		html += '<td><input type="checkbox" class="checkOne" value="'+$('input#rcv_mobileno_temp').val()+'"></td>';
		html += '<td class="nickname"></td>';
		html += '<td><span>'+$('input#rcv_mobileno_temp').val()+'</span>';
		html += '<span><a href="#" class="delTelpcs"><i class="fa fa-times-circle" aria-hidden="true"></i></a></span>';
		html += '</tr>';
		$('tbody#sendList').append(html);
		$('input#forDuple').val($('input#forDuple').val() + $('input#rcv_mobileno_temp').val());
		deletePcs();
		$('input#rcv_mobileno_temp').val('');
		$('input#rcv_mobileno_temp').focus();
	});
	
	<%--선택삭제--%>
	$('a#chooseDelete').on('click', function(e) {
		e.preventDefault();
		if ($('tbody#sendList input[type=checkbox]:checked').length < 1) {
			alert('선택된 번호가 없습니다.'); return false;
		}
		$('tbody#sendList input[type=checkbox]:checked').each(function(i) {
			var num = $(this).parents('tr').attr('id');
			var duple = $('input#forDuple').val(); 
			var idx = duple.indexOf(num);
			if (idx > -1 && idx == 0) {
				duple = duple.replace(num, '');
			} else {
				duple = duple.replace(num+',', '');
			}
			$('input#forDuple').val(duple);
		});
		$('tbody#sendList input[type=checkbox]:checked').parents('tr').remove();
	});
	
	<%--전체삭제--%>
	$('a#allDelete').on('click', function(e) {
		e.preventDefault();
		$('tbody#sendList tr').remove();
		$('input#rcv_mobileno').val('');
		$('input#rcv_name_ar').val('');
		$('input#forDuple').val('');
	});
	
	<%--전송목록 전체선택--%>
	$('input#sendListCheck').on('click', function(e) {
		if ($(this).is(':checked')) {
			$('tbody#sendList input[type=checkbox]').prop('checked', true);
		} else { 
			$('tbody#sendList input[type=checkbox]').prop('checked', false);
		}
	});
	
	<%--주소록 전체선택--%>
	$('input#contactListCheck').on('click', function(e) {
		if ($(this).is(':checked')) {
			$('tbody#contactList input[type=checkbox]').not(':disabled').prop('checked', true);
		} else {
			$('tbody#contactList input[type=checkbox]').not(':disabled').prop('checked', false);
		}
// 		$('input#rcv_mobileno').val('');
// 		$('input#rcv_name_ar').val('');
	});
	
	<%--화살표버튼 제외--%>
	$('a#arrowRight').on('click', function(e) {
		e.preventDefault();
		$('a#chooseDelete').click();
	});

	<%--화살표버튼 추가--%>
	$('a#arrowLeft').on('click', function(e) {
		e.preventDefault();
		if ($('tbody#contactList input[type=checkbox]:checked').length < 1) {
			alert('선택된 번호가 없습니다.\n\n우측 주소록에서 전송하실 번호를 선택해주세요.'); return false;
		}
		var data = $('tbody#contactList input[type=checkbox]:checked').parents('tr').clone().toArray();
		var originalLength = $(data).length;
		data = $.grep(data, function(el) {
			return $('input#forDuple').val().indexOf($(el).attr('id')) == -1;
		});
		var pattern = /^01[\d]{1}-?[\d]{3,4}-?[\d]{4}$/;
		data = $.grep(data, function(el) {
			return pattern.test($(el).attr('id').replace( /(^\s*)|(\s*$)/g, "" ));
		});
		if ($(data).length == 0) {
			alert('중복된 번호는 추가할 수 없습니다.'); return false;
		} else if ($(data).length != originalLength) {
			alert('중복번호를 제외한 나머지 번호만 추가되었습니다.');
		}
		$(data).each(function(i, el) {
			$('input#forDuple').val($('input#forDuple').val() + $(this).attr('id'));
			$(this).find('input[type=checkbox]').prop('checked', false);
			$(this).find('input[type=checkbox]').addClass('checkOne');
			$(this).find('td:last').append('<span><a href="#" class="delTelpcs"><i class="fa fa-times-circle" aria-hidden="true"></i></a></span>');
		});
		
		$('tbody#sendList').append(data); 
		deletePcs();
		
	});
	
	<%--목록편집열기--%>
	$('a#editList').on('click', function(e) {
		e.preventDefault();
		editingList = true;
		$('textarea#asdf').val('');
		$('a#editList').hide();
		$('a#closeEditList').show();
		if ($('tbody#sendList tr').length > 0) {
			var rcv_mobileno = '';
			$('tbody#sendList tr').each(function(i, el) {
				rcv_mobileno += $(el).attr('id');
				if ($(el).attr('nm') != '') {
					rcv_mobileno += ' '+$(el).attr('nm');
				}
				rcv_mobileno += '\n';
			});
			$('textarea#asdf').val(rcv_mobileno);
		}
		$('div.openText').show();
		$('textarea#asdf').focus();
	});
	
	<%--목록편집완료--%>
	$('a#closeEditList').on('click', function(e) {
		e.preventDefault();
		editingList = false;
		$('a#editList').show();
		$('a#closeEditList').hide();
		if ($('textarea#asdf').val() != '') {
			var pattern = /^01[\d]{1}-?[\d]{3,4}-?[\d]{4}$/;
			var rcv_mobile = $('textarea#asdf').val().replace(/-/g,'');
			var lines = rcv_mobile.split('\n');
			var rcv_mobileno = '';
			var rcv_mobilenm = '';
			for (var i = 0; i < lines.length; i++) {
				var temp = lines[i].replace(/\s/g,',');
				temp = temp.split(',');
				temp = $.grep(temp, function(n) {
					return n == '';
				}, true);
				if (pattern.test(temp[0])) {
					if (temp[1] == undefined) {
						temp[1] = '';
					}
					if (i == 0) {
						rcv_mobileno += temp[0];
						rcv_mobilenm += temp[1];
					} else {
						rcv_mobileno += ','+temp[0];
						rcv_mobilenm += ','+temp[1];
					}
				}
			}
			rcv_mobileno = rcv_mobileno.split(',');
			rcv_mobilenm = rcv_mobilenm.split(',');
			if (rcv_mobileno.length > 0 && rcv_mobileno[0] != '') {
				var html = '';
				$('tbody#sendList tr').remove();
				for (var i = 0; i < rcv_mobileno.length; i++) {
					html += '<tr id="'+ rcv_mobileno[i] +'" nm="' + rcv_mobilenm[i] + '">';
					html += '<td><input type="checkbox" class="checkOne" value="'+rcv_mobileno[i]+'"></td>';
					html += '<td class="nickname">' + rcv_mobilenm[i] + '</td>';
					html += '<td><span>'+ rcv_mobileno[i] +'</span>';
					html += '<span><a href="#" class="delTelpcs"><i class="fa fa-times-circle" aria-hidden="true"></i></a></span>';
					html += '</tr>';
				}
				$('tbody#sendList').append(html);
				deletePcs();
			}
		} else {
			$('input#rcv_mobileno').val('');
			$('input#rcv_name_ar').val('');
			$('input#forDuple').val('');
		}
		$('textarea#asdf').val('');
		$('div.openText').hide();
	});
	
	$('a#excelUpload').on('click', function(e) {
		e.preventDefault();
		if ($('input#uploadFile').val() == '') {
			alert('업로드할 파일을 선택해주세요.');
			return false;
		}
		var option = {
				url : 'excelView.do',
				type : 'post',										
				data : $('#addressForm').serialize(),	
				success: function(response) {
					response = eval(response);
					if(response.valid) {
						var html = '';
						var data = response.data;
						for (var i = 0; i < data.length; i++) {
							var phone = data[i]['address_cell_phone'];
							var name = data[i]['address_name'];
							html += '<tr id="'+ phone +'" nm="' + name + '">';
							html += '<td><input type="checkbox" class="checkOne" value="'+phone+'"></td>';
							html += '<td class="nickname">' + name + '</td>';
							html += '<td><span>'+ phone +'</span>';
							html += '<span><a href="#" class="delTelpcs"><i class="fa fa-times-circle" aria-hidden="true"></i></a></span>';
							html += '</tr>';
						}
						$('tbody#sendList').append(html);
						deletePcs();
					} else {
						alert(response.result[0].code);
					}
		        },
				error: function(jqXHR, textStatus, errorThrown) {
		            alert('[' + textStatus + ']관리자에게 문의하세요. : ' + errorThrown);
		        }
		};
		$('#addressForm').ajaxSubmit(option);
	});
	
});

function deletePcs(){
	<%--번호삭제--%>
	$('a.delTelpcs').on('click', function(e) {
		e.preventDefault();
		var parents = $(this).parents('tr');
		var num = $(this).parents('tr').attr('id');
		var duple = $('input#forDuple').val(); 
		var idx = duple.indexOf(num);
		if (idx > -1 && idx == 0) {
			duple = duple.replace(num, '');
		} else {
			duple = duple.replace(num+',', '');
		}
		$('input#forDuple').val(duple);
		parents.remove();
	});
}
</script>
<script>
$('div#loading2, img#loading_img2').hide();
</script>