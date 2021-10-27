<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>
<script type="text/javascript">

	$(function() {

		// 등록 버튼
		$('a#dialog-add').on('click', function(e){
			e.preventDefault();
			let search_course_id = $('#search_course_id').val();
			$('#dialog-1').load('edit.do?editMode=ADD&search_course_id='+search_course_id, function( response, status, xhr ) {
				$('#dialog-1').dialog('open');
			});
		});

		// 수정 버튼
		$('a.modify_btn').on('click', function(e){
			e.preventDefault();
			let request_id = $(this).data('key');
			$('#dialog-2').load('edit.do?editMode=UPDATE&request_id='+request_id, function( response, status, xhr ) {
				$('#dialog-2').dialog('open');
			});
		});

		// 문자 전송 다이얼로그
		$('a#sendMessage').on('click', function(e){
			e.preventDefault();

			let sendList = [];
			$("input[name=check_select]:checked").each(function() {
				sendList.push($(this).val());
			});

			$('#dialog-3').load('message.do?sendList='+sendList.toString(), function( response, status, xhr ) {
				$('#dialog-3').dialog('open');
			});
		});

		// 검색 버튼
		$('button.search_btn').on('click', function(e){
			e.preventDefault();
			$('#viewPage').val(1);
			doGetLoad('index.do', serializeCustom($('form#lectureRequest')));
		});

		// 보이는 개수 변경
		$('select#rowCount').on('change', function() {
			$('#viewPage').val(1);
			doGetLoad('index.do', $('form#lectureRequest').serialize());
		});

		// 과정선택 select 변경
		$('select#search_course_id').on('change', function() {
			$('#viewPage').val(1);
			doGetLoad('index.do', $('form#lectureRequest').serialize());
		});

		// 강좌선택 select 변경
		$('select#search_lecture_id').on('change', function() {
			$('#viewPage').val(1);
			doGetLoad('index.do', $('form#lectureRequest').serialize());
		});

		// 접수방법 select 변경
		$('select#search_request_type').on('change', function() {
			$('#viewPage').val(1);
			doGetLoad('index.do', $('form#lectureRequest').serialize());
		});

		// 취소여부 select 변경
		$('select#search_request_status').on('change', function() {
			$('#viewPage').val(1);
			doGetLoad('index.do', $('form#lectureRequest').serialize());
		});

		// 과정 select 변경
		/*$('select#search_course_id').on('change', function() {
			let course_id = $(this).val();
			$.ajax({
				type:"post",
				url:`/cms/module/lecture/lectureRequest/lectureInfoList.do`,
				data: JSON.stringify({"course_id":course_id}),
				contentType:"application/json; charset=utf-8",
				dataType:"json",
			}).done(res=>{
				let lectureInfos = res.data;
				let lectureInfoList = JSON.parse(lectureInfos);
				$('#search_lecture_id').empty();
				$('#select2-search_lecture_id-container').val("");
				$('#select2-search_lecture_id-container').text("전체");
				$('#search_lecture_id').append(selectItem('', '전체'));
				lectureInfoList.forEach(lectureInfo => {
					$('#search_lecture_id').append(selectItem(lectureInfo.lecture_id, lectureInfo.lecture_title));
				})
			}).fail(error=>{
				alert(error);
			})
		});*/

		// 삭제 버튼
		$('a.delete_btn').on('click', function(e) {
			e.preventDefault();
			if (confirm('정말로 취소하시겠습니까?')) {
				$('form#lectureRequest').attr('action', 'delete.do');
				$('#request_id').val($(this).data('key'));
				$('#editMode').val('DELETE');

				jQuery.ajaxSettings.traditional = true;
				var formData = serializeObject($('form#lectureRequest'));

				$.ajax({
					type : 'POST',
					dataType : 'json',
					url : $('form#lectureRequest').attr('action'),
					async : false,
					data : formData,
					success : function(response) {
						if (response.valid) {
							if (response.message != null && response.message.replace(/\s/g, '').length != 0) {
								alert(response.message);
							} else {
								alert("진행중 오류가 발생하였습니다.\n관리자에게 문의하세요.");
							}
						} else {
							if (response.message != null && response.message.replace(/\s/g, '').length != 0) {
								alert(response.message);
							} else {
								for (var i = 0; i < response.result.length; i++) {
									alert(response.result[i].code);
									$('#' + response.result[i].field).focus();
									break;
								}
							}
						}
					},
					error : function(jqXHR, textStatus, errorThrown) {
						alert('[' + textStatus + ']관리자에게 문의하세요. : ' + errorThrown);
					}
				});

				location.reload();
			}
		});

		// 신청자명 클릭
		$('a.view_btn').on('click', function(e){
			e.preventDefault();
			$('#request_id').val($(this).data('key'));
			doGetLoad('view.do', serializeCustom($('form#lectureRequest')));
		});

		// csv 다운로드
		$('a#csvDownload').on('click', function(e) {
			e.preventDefault();
			if(!confirm("현재 보여지고 있는 목록만 CSV로 저장됩니다.\n" +
					"전체 결과를 저장하고싶으시면 검색결과를 '전체 보기'로 변경 후 다시 시도하십시오.\n\n" +
					"계속 진행하시겠습니까?")) return;
			$('#lectureRequest').attr('action', 'csvDownload.do').submit();
		});

		// 엑셀 다운로드
		$('a#excelDownload').on('click', function(e) {
			e.preventDefault();
			if(!confirm("현재 보여지고 있는 목록만 엑셀로 저장됩니다.\n" +
					"전체 결과를 저장하고싶으시면 검색결과를 '전체 보기'로 변경 후 다시 시도하십시오.\n\n" +
					"계속 진행하시겠습니까?")) return;
			$('#lectureRequest').attr('action', 'excelDownload.do').submit();
		});

		// 제일위에 체크박스 선택
		$('#check-all').on('change', function() {
			if ($(this).is(":checked")) {
				$("input[name='check_select']").prop("checked", true);
			} else {
				$("input[name='check_select']").prop("checked", false);
			}
		});

	});

	/**
	 * select option item
	 * */
	function selectItem(lecture_id, lecture_title) {
		let item = `<option value="`+lecture_id+`">`+lecture_title+`</option>`
		return item;
	}

	// 검색 초기화
	function searchReset() {
		$('#viewPage').val(1);
		$('#search_course_id').val("");
		$('#search_lecture_id').val("");
		$('#search_request_type').val("");
		$('#search_cancel_yn').val("N");
		$('#search_type').val("request_name");
		$('#search_text').val("");
		doGetLoad('index.do', serializeCustom($('form#lectureRequest')));
	}

</script>

<style>
	.search {
		padding: 0;

	}
	.search-row {
		border-bottom: #DDDDDD solid 1px;
		padding: 10px;
	}
	.search-row-bottom {
		border-bottom: none;
		padding: 10px;
	}
	.search-item {
		display: inline;
	}
	.search-title {
		display: inline-block;
		text-align: center;
		width: 10%;
	}
	.search-text-box {
		display: inline;
		margin-left: 50px;
	}
</style>

<form:form modelAttribute="lectureRequest">
	<form:hidden path="homepage_id"/>
	<form:hidden path="request_id"/>
	<form:hidden path="editMode"/>
	<form:hidden path="lecture_id"/>
	<form:hidden path="request_type"/>

	<div class="infodesk">

		<div class="search">
			<fieldset>
				<div class="search-row">
					<div class="search-title">과정선택</div>
					<div class="search-item">
						<form:select path="search_course_id" cssClass="selectmenu" cssStyle="width: 80%">
							<c:forEach var="i" varStatus="status" items="${courseInfoList}">
								<form:option value="${i.course_id}">${i.use_yn eq "N" ? '(미사용) ' : ''}${i.course_title}</form:option>
							</c:forEach>
						</form:select>
					</div>
				</div>
				<div class="search-row">
					<div class="search-title">강좌선택</div>
					<div class="search-item">
						<form:select path="search_lecture_id" cssClass="selectmenu" cssStyle="width: 80%">
							<form:option value="">전체</form:option>
							<c:forEach var="i" varStatus="status" items="${lectureInfoList}">
								<form:option value="${i.lecture_id}">${i.lecture_title}</form:option>
							</c:forEach>
						</form:select>
					</div>
				</div>
				<div class="search-row-bottom">
					<div class="search-title">접수방법</div>
					<div class="search-item">
						<form:select path="search_request_type" cssClass="selectmenu">
							<form:option value="">전체</form:option>
							<form:option value="온라인">온라인</form:option>
							<form:option value="오프라인">오프라인</form:option>
						</form:select>
					</div>
					<div class="search-title">예약상태</div>
					<div class="search-item">
						<form:select path="search_request_status" cssClass="selectmenu">
							<form:option value="예약완료">예약완료</form:option>
							<form:option value="예약대기">예약대기</form:option>
							<form:option value="추첨대기">추첨대기</form:option>
							<form:option value="예약취소">예약취소</form:option>
							<form:option value="예약불참">예약불참</form:option>
						</form:select>
					</div>
					<div class="search-text-box">
						<form:select path="search_type" cssClass="selectmenu">
							<form:option value="request_name">신청자명</form:option>
							<form:option value="phone_number">휴대전화</form:option>
						</form:select>
						<form:input path="search_text" cssClass="text" cssStyle="width:200px;"/>
						<button class="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
						<button type="button" id="reset_btn" onclick="searchReset()"><i class="fa fa-search"></i><span>초기화</span></button>
					</div>
				</div>
			</fieldset>
		</div>

		검색 결과 : 총 ${paging.totalDataCount}건

		<form:select path="rowCount" cssClass="selectmenu">
			<form:option value="10">10개씩보기</form:option>
			<form:option value="20">20개씩보기</form:option>
			<form:option value="30">30개씩보기</form:option>
			<form:option value="50">50개씩보기</form:option>
			<form:option value="100">100개씩보기</form:option>
			<form:option value="${paging.totalDataCount}">전체 보기</form:option>
		</form:select>

		<div class="button">
			<a href="#" id="sendMessage" class="btn btn4"><i class="fa fa-mail-forward"></i><span>선택 문자전송</span></a>
			<a href="#" id="excelDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>엑셀저장</span></a>
			<a href="#" id="csvDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>CSV저장</span></a>
			<a href="#" class="btn btn5 left" id="dialog-add"><i class="fa fa-plus"></i><span>오프라인 등록</span></a>
		</div>
	</div>
	<div>
		<table class="type1 center">
			<colgroup>
				<col width="5%" /> <%--체크박스--%>
				<col width="5%" />  <%--순번--%>
				<col width="10%" /> <%--신청자 id--%>
				<col width="10%" /> <%--신청자이름--%>
				<col width="10%" /> <%--생년월일--%>
				<col width="15%" /> <%--휴대전화 / 이메일--%>
				<col width="15%" /> <%--신청강좌--%>
				<col width=7%" /> <%--예약상태--%>
				<col width="7%" /> <%--접수방법--%>
				<col width="8%" /> <%--등록일--%>
				<col width="" /> <%--관리--%>
			</colgroup>
			<thead>
				<tr>
					<th><input type="checkbox" id="check-all"></th>
					<th>순번</th>
					<th>신청자ID</th>
					<th>신청자이름</th>
					<th>생년월일(성별)</th>
					<th>휴대전화 /<br> 이메일</th>
					<th>신청강좌</th>
					<th>예약상태</th>
					<th>접수방법</th>
					<th>등록일</th>
					<th>관리</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="i" varStatus="status" items="${lectureRequestList}">
				<tr>
					<td><form:checkbox path="check_select" value="${i.request_id}"/></td>
					<td>${i.reverse_rownum}</td>
					<td><a href="#" class="view_btn" data-key="${i.request_id}">${i.add_id}</a></td>
					<td><a href="#" class="view_btn" data-key="${i.request_id}">${i.request_name}</a></td>
					<td>${i.birthday}(${i.gender eq '0' ? '남' : '여'})</td>
					<td>${i.phone_number} /<br>${!empty i.email ? i.email : '등록된이메일없음'}</td>
					<td>${i.lecture_title}</td>
					<td>${i.request_status}</td>
					<td>${i.request_type}</td>
					<fmt:formatDate var="formatRegDate" value="${i.add_date}" pattern="yyyy-MM-dd"/>
					<td>${formatRegDate}</td>
					<td>
						<c:if test="${i.request_status ne '예약취소' and i.request_status ne '예약불참'}">
							<a href="#" class="btn modify_btn" data-key="${i.request_id}">신청수정</a>
							<a href="#" class="btn delete_btn" data-key="${i.request_id}">신청취소</a>
						</c:if>
					</td>
				</tr>
				</c:forEach>
				<c:if test="${fn:length(lectureRequestList) < 1}">
					<tr>
						<td colspan="11">등록된 신청이 없습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>

		<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
			<jsp:param name="formId" value="#lectureRequest"/>
		</jsp:include>
	</div>

</form:form>

<div id="dialog-1" class="dialog-common" title="수강 신청"></div>
<div id="dialog-2" class="dialog-common" title="수강 신청 수정"></div>
<div id="dialog-3" class="dialog-common" title="문자 전송"></div>
