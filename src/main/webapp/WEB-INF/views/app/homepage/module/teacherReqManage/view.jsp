<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>
<script type="text/javascript">
$(function () {
	$('#modify-btn').on('click', function(e) {
		e.preventDefault();

		if(confirm('내용을 수정하게 되면 승인을 다시 받아야 합니다. 진행하시겠습니까?')) {
			doGetLoad('edit.do', 'editMode=MODIFY&teacher_idx=' + $('#teacher_idx').val() + '&menu_idx=${fn:escapeXml(param.menu_idx)}');
		}
	});
	
	$('#back-btn').on('click', function() {
		history.back();
	});
	
	json2inputs('#teacher_education', '학력을 불러오는 도중에 오류가 발생했습니다.');
	json2inputs('#teacher_experience', '경력사항을 불러오는 도중에 오류가 발생했습니다.');
	json2inputs('#teacher_certifications', '자격 및 면허를 불러오는 도중에 오류가 발생했습니다.');
	
	try {
		var json_teacher_open_files = JSON.parse($('#teacher_open_files').val());
		for(var i=0; i < json_teacher_open_files.length; ++i) {
			var file = json_teacher_open_files[i];
			$('#td_teacher_open_files').append('<a href="/cms/module/teacherReqManage/download2/${teacher.homepage_id}/${teacher.teacher_idx}/' + file.file_hash + '.do"><i class="fa fa-floppy-o"></i> ' + file.file_name + '.' + file.file_extension + '</a><br>');
		}
	} catch(e) {
		
	}
});

function isEmpty(value){ 
	if( value == "" || value == null || value == undefined || ( value != null && typeof value == "object" && !Object.keys(value).length ) ){ 
		return true 
	}else{ 
		return false 
	} 
};

function inputs2json(prefix) {
	var assoc = {};
	$('input[id^="'+prefix+'"]').each(function(i) {
		var id = $(this).attr('id');
		var val = $(this).val();
		if(id != 'prefix') {
			var type = $(this).prop('type');
			if(type == 'checkbox' || type == 'radio') {
				if($(this).prop('checked') == true) {
					assoc[id] = val;
				}
			} else {
				assoc[id] = val;
			}
		}
	});
	
	return JSON.stringify(assoc);
}

function json2inputs(selector, msg) {
	var json = $(selector).val();
	if(!!json) {
		var assoc = '';
		try {
			assoc = JSON.parse(json);
		} catch(e) {
			alert(msg);
			return;
		}
		for (var id in assoc) {
			var input = $('#'+id);
			var text = assoc[id] == '' ? '-' : assoc[id];
			input.val(text);
			input.text(text);
			if(assoc[id] != '' && (input.prop('type') == 'checkbox' || input.prop('type') == 'radio')) {
				input.prop('checked', true);
			}
		}
	}
}

function onlyNumber(event){
    event = event || window.event;
    var keyID = (event.which) ? event.which : event.keyCode;
    if ( (keyID >= 48 && keyID <= 57) || (keyID >= 96 && keyID <= 105) || keyID == 8 || keyID == 9 || keyID == 46 || keyID == 37 || keyID == 39 ) 
        return;
    else
        return false;
}
 
function removeChar(event) {
    event = event || window.event;
    var keyID = (event.which) ? event.which : event.keyCode;
    if ( keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
        return;
    else
        event.target.value = event.target.value.replace(/[^0-9]/g, "");
}
</script>
<form:form id="teacherForm" modelAttribute="teacher" method="post" action="save.do" onsubmit="return false;">
	<form:hidden path="homepage_id"/>
	<form:hidden path="teacher_idx"/>
	<form:hidden path="teacher_id" value="${memberInfo.member_id}"/>
	<form:hidden path="member_key" value="${memberInfo.seq_no}"/>
	<form:hidden path="editMode"/>
	<form:hidden path="teacher_education"/>
	<form:hidden path="teacher_experience"/>
	<form:hidden path="teacher_certifications"/>
	<form:hidden path="teacher_open_files"/>
	<form:hidden path="teacher_zipcode"/>
	<form:hidden path="teacher_address"/>
	<form:hidden path="menu_idx"/>
	<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
	<table class="type2">
		<colgroup>
	       <col width="130" />
	       <col width="*"/>
       	</colgroup>
       	<tbody>
			<tr>
	         	<th>마지막 수정일시</th>
	         	<td>${teacher.mod_date}</td>
        	</tr>
			<tr>
	         	<th>승인여부</th>
	         	<td>${teacher.confirm_yn}</td>
        	</tr>
			<tr>
	         	<th>기관명</th>
	         	<td>${teacher.homepage_name}</td>
        	</tr>
			<tr>
	         	<th>이름(<span style="color: red; font-weight: bold;">*</span>)</th>
	         	<td>${teacher.teacher_name}</td>
        	</tr>
			<tr>
	         	<th>생년월일(<span style="color: red; font-weight: bold;">*</span>)</th>
	         	<td>${teacher.teacher_birth}</td>
        	</tr>
        	<tr>
	         	<th>성별(<span style="color: red; font-weight: bold;">*</span>)</th>
	         	<td>${teacher.teacher_sex}</td>
	        </tr>
	        <tr> 
				<th>휴대전화번호(<span style="color: red; font-weight: bold;">*</span>)</th>
				<td>${teacher.teacher_phone}</td>
			</tr>
			<tr>
	         	<th>주소(<span style="color: red; font-weight: bold;">*</span>)</th>			
	         	<td>
	         		<c:set var="full_adder" value="${teacher.teacher_zipcode} ${teacher.teacher_address}"/>
	         		${full_adder}
	         	</td>
        	</tr>
        	<tr> 
				<th>이메일</th>
				<td>${teacher.teacher_email}</td>
			</tr>
			<tr> 
				<th>전화번호</th>
				<td>${teacher.teacher_cell_phone}</td>
			</tr>
        	<tr>
	         	<th>과목구분(<span style="color: red; font-weight: bold;">*</span>)</th>
	         	<td>${teacher.subject_cd_name}</td>
	        </tr>
        	<tr>
	         	<th>과목명(<span style="color: red; font-weight: bold;">*</span>)</th>			
	         	<td>${teacher.teacher_subject_name}</td>
        	</tr>
			<tr>
	         	<th>강의가능지역(<span style="color: red; font-weight: bold;">*</span>)</th>
	         	<td>${teacher.teacher_location_code_name}</td>
	        </tr>
			<tr>
	         	<th>학력(<span style="color: red; font-weight: bold;">*</span>)</th>			
	         	<td>
					<table class="type2 education">
						<colgroup>
							<col width="100" />
							<col width="100" />
							<col width="100" />
							<col width="100" />
							<col width="*"/>
						</colgroup>
						<thead>
							<tr>
								<th></th>
								<th>학교명</th>
								<th>수료(졸업)일</th>
								<th>학과</th>
								<th>학적사항</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>고등학교</td>
								<td><span id="t_edu00">-</span></td>
								<td><span id="t_edu01">-</span></td>
								<td><span id="t_edu02">-</span></td>
								<td>
									<input type="checkbox" id="t_edu03" value="Y"><label for="t_edu03">검정고시</label>
								</td>
							</tr>
							<tr>
								<td>대학교</td>
								<td><span id="t_edu10">-</span></td>
								<td><span id="t_edu11">-</span></td>
								<td><span id="t_edu12">-</span></td>
								<td class="t_edu1">
									<input type="radio" id="t_edu13" name="t_edu13" value="Y"><label for="t_edu13">졸업</label> &nbsp;
									<input type="radio" id="t_edu14" name="t_edu13" value="Y"><label for="t_edu14">졸업예정</label> &nbsp; <br/>
									<input type="radio" id="t_edu15" name="t_edu13" value="Y"><label for="t_edu15">수료</label>
								</td>
							</tr>
							<tr>
								<td>대학원</td>
								<td><span id="t_edu20">-</span></td>
								<td><span id="t_edu21">-</span></td>
								<td><span id="t_edu22">-</span></td>
								<td class="t_edu2">
									<input type="radio" id="t_edu23" name="t_edu23" value="Y"><label for="t_edu23">졸업</label> &nbsp;
									<input type="radio" id="t_edu24" name="t_edu23" value="Y"><label for="t_edu24">졸업예정</label> &nbsp;<br/>
									<input type="radio" id="t_edu25" name="t_edu23" value="Y"><label for="t_edu25">수료</label>
								</td>
							</tr>
							<tr>
								<td>기타</td>
								<td><span id="t_edu30">-</span></td>
								<td><span id="t_edu31">-</span></td>
								<td><span id="t_edu32">-</span></td>
								<td><span id="t_edu33">-</span></td>
							</tr>
						</tbody>
					</table>
	         	</td>
        	</tr>
        	<tr>
	         	<th>자격·면허·수상</th>
	         	<td>
					<table class="type2">
						<colgroup>
							<col width="200" />
							<col width="*" />
							<col width="100" />
						</colgroup>
						<thead>
							<tr>
								<th>취득년월일</th>
								<th>자격·면허·수상 내역</th>
								<th>시행처</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td><span id="t_cer00">-</span></td>
								<td><span id="t_cer01">-</span></td>
								<td><span id="t_cer02">-</span></td>
							</tr>
							<tr>
								<td><span id="t_cer10">-</span></td>
								<td><span id="t_cer11">-</span></td>
								<td><span id="t_cer12">-</span></td>
							</tr>
							<tr>
								<td><span id="t_cer20">-</span></td>
								<td><span id="t_cer21">-</span></td>
								<td><span id="t_cer22">-</span></td>
							</tr>
							<tr>
								<td><span id="t_cer30">-</span></td>
								<td><span id="t_cer31">-</span></td>
								<td><span id="t_cer32">-</span></td>
							</tr>
						</tbody>
					</table>
	         	</td>
        	</tr>
			<tr>
	         	<th>강의경력</th>
	         	<td>
					<table class="type2">
						<colgroup>
							<col width="350" />
							<col width="100" />
							<col width="100" />
							<col width="*"/>
						</colgroup>
						<thead>
							<tr>
								<th>근무기간</th>
								<th>근무처</th>
								<th>직위</th>
								<th>주요업무</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td><span id="t_exp00">-</span></td>
								<td><span id="t_exp02">-</span></td>
								<td><span id="t_exp03">-</span></td>
								<td><span id="t_exp04">-</span></td>
							</tr>
							<tr>
								<td><span id="t_exp10">-</span></td>
								<td><span id="t_exp12">-</span></td>
								<td><span id="t_exp13">-</span></td>
								<td><span id="t_exp14">-</span></td>
							</tr>
							<tr>
								<td><span id="t_exp20">-</span></td>
								<td><span id="t_exp22">-</span></td>
								<td><span id="t_exp23">-</span></td>
								<td><span id="t_exp24">-</span></td>
							</tr>
							<tr>
								<td><span id="t_exp30">-</span></td>
								<td><span id="t_exp32">-</span></td>
								<td><span id="t_exp33">-</span></td>
								<td><span id="t_exp34">-</span></td>
							</tr>
						</tbody>
					</table>
	         	</td>
        	</tr>
        	<c:if test="${not empty teacher.teacher_open_files}">
        	<tr>
        	 	<th>현재 첨부파일<br/>강의계획서(<span style="color: red; font-weight: bold;">*</span>)</th>
	         	<td id="td_teacher_open_files"></td>
        	</tr>
        	</c:if>
		</tbody>
	</table>
</form:form>
<br/>
<div class="button bbs-btn center">
	<button id="modify-btn" class="btn btn5" title="수정요청" >수정요청</button>
	<button id="back-btn" class="btn" title="뒤로가기"><i class="fa fa-reorder"></i><span>뒤로가기</span></button>
</div>
