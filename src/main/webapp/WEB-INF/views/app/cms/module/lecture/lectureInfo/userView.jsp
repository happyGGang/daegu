<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>
<script type="text/javascript">

/**
 * 수강신청 버튼 클릭
 * */
function lectureRequest(lecture_id) {
	var ajaxData = {
		'lecture_id' : lecture_id,
		'request_type' : '온라인'
	};

	if(confirm('수강신청 하시겠습니까?')) {
		$.ajax({
			url: '../../lectureRequest/save.do',
			data : ajaxData,
			method: 'POST',
			success: function(response) {
				if(response.valid) {
					alert(response.message);
					location.reload();
				} else {
					if ( response.message != null ) {
						alert(response.message);
					}
					else {
						for(var i =0 ; i < response.result.length ; i++) {
							alert(response.result[i].code);
							$('#'+response.result[i].field).focus();
							break;
						}
					}
				}
			},error: function(response) {
			}
		});
	}
}

function goIndex() {
	$('#lectureInfo').attr('action', 'index.do');
	$('#lectureInfo').submit();
}

</script>

<style>
	.tit {
		display: inline-block;
		margin-right: 20px;
	}

	.cotnt {
		display: inline-block;
	}

	.btn-inline {
		display: inline-block;
	}

	.lecture_tit {
		color: #2e9901;
	}

	.lecture_tit:hover {
		color: #0d75c4;
	}
</style>

<form:form modelAttribute="lectureInfo" method="GET" action="index.do">
	<input type="hidden" name="menu_idx" value="${param.menu_idx}" />
	<form:hidden path="viewPage"/>
	<form:hidden path="lecture_id"/>
	<form:hidden path="edu_school"/>
	<form:hidden path="searching_edu_status"/>
	<form:hidden path="searching_request_type"/>
	<form:hidden path="request_start_date"/>
	<form:hidden path="request_end_date"/>
	<form:hidden path="search_text"/>
	<form:hidden path="request_type" value="온라인"/>
</form:form>
<div id="apply">
	<h4 class="caption">강좌정보(강좌명, 교육기간, 교육시간, 접수기간, 교육대상, 접수방식, 모집인원, 접수현황, 교육장, 강사명, 담당자)</h4>
	<!-- 강좌정보 -->
	<div class="lec_list dis_table col2">
		<ul class="one">
			<li class="table">
				<p class="tit">강좌명</p>
				<p class="suj cotnt">${lectureInfo.lecture_title}</p>
			</li>
		</ul>
		<ul>
			<li class="table">
				<p class="cell th tit">교육기간</p>
				<div class="cell td cotnt">
					<span class="les_no">${lectureInfo.edu_start_date} ~ ${lectureInfo.edu_end_date}</span>
				</div>
			</li>
			<li class="table">
				<p class="cell th tit">교육시간</p>
				<div class="cell td cotnt">
					<span class="les_no">${lectureInfo.edu_start_time} ~ ${lectureInfo.edu_end_time}</span>
				</div>
			</li>
		</ul>
		<ul>
			<li class="table">
				<p class="cell th tit">접수기간</p>
				<div class="cell td cotnt">
					<span class="les_no cotnt">${lectureInfo.request_start_date} ~ ${lectureInfo.request_end_date}</span>
				</div>
			</li>
			<li class="table">
				<p class="cell th tit">교육대상</p>
				<div class="cell td cotnt">
					<c:set var="edu_target_string"></c:set>
					<c:forEach var="i" varStatus="status" items="${codeEduTargetList}">
						<c:if test="${fn:contains(lectureInfo.edu_target, i.code_id)}">
							<c:if test="${!empty edu_target_string}">
								<c:set var="edu_target_string">${edu_target_string},&nbsp;</c:set>
							</c:if>
							<c:set var="edu_target_string">${edu_target_string}${i.code_name}</c:set>
						</c:if>
					</c:forEach>
					${edu_target_string}
				</div>
			</li>
		</ul>
		<ul>
			<li class="table">
				<p class="cell th tit">접수방식</p>
				<div class="cell td cotnt">
					${lectureInfo.request_type}
				</div>
			</li>
			<li class="table">
				<p class="cell th tit">모집인원</p>
				<div class="cell td cotnt">
						<c:if test="${lectureInfo.request_type eq '선착순'}">
							<label class="hidden">현원</label><strong class="txt_color4">${lectureInfo.online_request_count + lectureInfo.offline_request_count}</strong>/
						</c:if>
							<label class="hidden">정원</label>${lectureInfo.online_person_count + lectureInfo.offline_person_count}</span>
				</div>
			</li>
		</ul>
		<ul>
			<li class="table">
				<p class="cell th tit">접수현황</p>
				<div class="cell td cotnt">
					<c:choose>
						<c:when test="${lectureInfo.request_type eq '선착순'}">
							온라인 <span class="les_no">(<label class="hidden">현원</label><strong class="txt_color4">${lectureInfo.online_request_count}</strong>/<label class="hidden">정원</label>${lectureInfo.online_person_count})</span>,
							오프라인 <span class="les_no">(<label class="hidden">현원</label><strong class="txt_color4">${lectureInfo.offline_request_count}</strong>/<label class="hidden">정원</label>${lectureInfo.offline_person_count})</span>,
							대기 <span class="les_no">(<label class="hidden">현원</label><strong class="txt_color4">${lectureInfo.wait_request_count}</strong>/<label class="hidden">정원</label>${lectureInfo.wait_person_count})</span>
						</c:when>
						<c:when test="${lectureInfo.request_type eq '추첨제'}">
							추첨대기 <span class="les_no">(<label class="hidden">현원</label><strong class="txt_color4">${lectureInfo.wait_request_count}</strong>/<label class="hidden">정원</label>${lectureInfo.wait_person_count})</span>
						</c:when>
					</c:choose>
				</div>
			</li>
			<li class="table">
				<p class="cell th tit">교육장소</p>
				<div class="cell td cotnt">
					<span class="txt_color1">${lectureInfo.edu_school}</span>
					<c:if test="${!empty lectureInfo.edu_second_school}">
						<span class="st2">${lectureInfo.edu_second_school}</span>
					</c:if>
					<c:if test="${!empty lectureInfo.edu_school_map}">
						<a href="${lectureInfo.edu_school_map}" class="map app_btn small new_win" target="_blank" title="새창열림">위치</a>
					</c:if>
				</div>
			</li>
		</ul>
		<ul>
			<li class="table">
				<p class="cell th tit">강사명</p>
				<div class="cell td cotnt">
					${lectureInfo.teacher_name}
					<c:if test="${!empty lectureInfo.teacher_tel}">
						<span class="les_no">(${lectureInfo.teacher_tel})</span>
					</c:if>
				</div>
			</li>
			<li class="table">
				<p class="cell th tit">담당자</p>
				<div class="cell td cotnt">
					${lectureInfo.supporter_name}
					<c:if test="${!empty lectureInfo.supporter_tel}">
						<span class="les_no">(${lectureInfo.supporter_tel})</span>
					</c:if>
				</div>
			</li>
		</ul>
	</div>
	<!--// 강좌정보 -->

	<div class="bott_box">
		<p class="tit">강좌상태</p>
		<p class="state_list cotnt">
			<c:choose>
				<c:when test="${lectureInfo.lecture_status1 eq '모집예정'}">
					<span class="lec_state state1">모집예정</span>
				</c:when>
				<c:when test="${lectureInfo.lecture_status1 eq '모집중'}">
					<c:if test="${lectureInfo.online_person_count <= lectureInfo.online_request_count and lectureInfo.wait_person_count <= lectureInfo.wait_request_count}">
						<span class="lec_state state3 tit">신청정원초과</span>
					</c:if>
					<c:if test="${lectureInfo.online_person_count > lectureInfo.online_request_count or lectureInfo.wait_person_count > lectureInfo.wait_request_count}">
						<span class="lec_state state3 tit">모집중</span>
					</c:if>
				</c:when>
				<c:when test="${lectureInfo.lecture_status1 eq '모집마감'}">
					<span class="lec_state state4">모집마감</span>
				</c:when>
			</c:choose>
			<c:choose>
				<c:when test="${lectureInfo.lecture_status2 eq '교육중'}">
					<span class="lec_state state3">교육중</span>
				</c:when>
				<c:when test="${lectureInfo.lecture_status2 eq '교육마감'}">
					<span class="lec_state state5">교육마감</span>
				</c:when>
			</c:choose>
		</p>
		<c:if test="${lectureInfo.lecture_status1 eq '모집중'}">
			<c:if test="${lectureInfo.online_person_count <= lectureInfo.online_request_count and lectureInfo.wait_person_count <= lectureInfo.wait_request_count}">
			</c:if>
			<c:if test="${lectureInfo.online_person_count > lectureInfo.online_request_count or lectureInfo.wait_person_count > lectureInfo.wait_request_count}">
				<div class="search btn-inline" style="display: inline-block; margin: 0; padding: 0;">
					<fieldset style="display: inline-block; margin: 0; padding: 0;">
						<button class="app_btn app_color3 check btn-inline" type="button" onclick="lectureRequest('${lectureInfo.lecture_id}');" style="margin:0;">수강신청</button>
					</fieldset>
				</div>
			</c:if>
			<%--<div id="request_layer" class="new_layer smlayer lay_middle" style="display:none;">
				<h4 class="layer_tit none">수강신청</h4>
				<button class="bt_close layerClose" title="창닫기" type="button" onclick="lectureRequestClose();">창닫기</button>

				<div class="con_body">
					<p class="h_tit">해당 강좌의 수강신청이 완료되었습니다.</p>
					<span class="con_ex">
				신청하신 강좌의 예약 진행상태는 [나의강좌] &gt; <span class="txt_red">예약내역</span> 에서 확인이 가능합니다.
				</span>
				</div>
				<div class="btn_wrap">
					<button type="button" class="layer_btn" onclick="location.href='/culture/main/myPage/myLectureRequest/index.do?menu_idx=7';">예약확인</button>
					<button type="button" class="layer_btn" onclick="lectureRequestClose();">닫기</button>
				</div>
			</div>--%>
		</c:if>
	</div>

	<h4 class="caption">교육내용</h4>
	<!-- 강좌정보 -->
	<div class="tbl_wrap tbl_view">
		<table class="tbl_basic tbl_all_td_left tbl_all_th_left">
			<caption><span>교육내용을 교육소개 및 강의내용, 첨부파일로 나타낸 표</span></caption>
			<colgroup>
				<col style="width:20%;">
				<col style="">
			</colgroup>
			<tbody>
			<tr>
				<th scope="row">교육소개 및 강의내용</th>
				<td>
					<div class="int_box textarea">${fn:replace(lectureInfo.lecture_content, crlf, '<br/>')}</div>
				</td>
			</tr>
			<c:if test="${!empty file}">
				<tr>
					<th scope="row">첨부파일</th>
					<td>
						<div class="int_box file">
							<span class="block"><a href="/cms/module/lecture/lectureInfo/download/${file.homepage_id}/${file.file_server_name}.do" class="ico_file" title="다운로드">${file.file_original_name}</a></span>
						</div>
					</td>
				</tr>
			</c:if>
			</tbody>
		</table>
	</div>

	<div class="bott_btn_box">
		<%--<div class="btn_left cotnt">
			<a href="javascript:void(0);" class="app_btn" onclick="goIndex();">목록</a>
		</div>--%>
		<c:if test="${lectureInfo.lecture_status1 eq '모집중'}">
			<c:if test="${lectureInfo.online_person_count <= lectureInfo.online_request_count and lectureInfo.wait_person_count <= lectureInfo.wait_request_count}">
				<span class="lec_state state3 tit">신청정원초과</span>
			</c:if>
			<c:if test="${lectureInfo.online_person_count > lectureInfo.online_request_count or lectureInfo.wait_person_count > lectureInfo.wait_request_count}">
				<div class="search btn-inline" style="display: inline-block; margin: 0; padding: 0;">
					<fieldset style="display: inline-block; margin: 0; padding: 0;">
						<button class="app_btn app_color3 check btn-inline" type="button" onclick="lectureRequest('${lectureInfolectureInfo.lecture_id}');" style="margin:0;">수강신청</button>
					</fieldset>
				</div>
			</c:if>
		</c:if>
	</div>

</div><!-- apply End -->


