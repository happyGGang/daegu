<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<% pageContext.setAttribute("crlf", "\r\n"); %>
<% pageContext.setAttribute("lf", "\n"); %>
<script src="/resources/cms/js/malsup.jquery.form.min.js"
	type="text/javascript"></script>
<script type="text/javascript">
	$(function() {
		$('a.add')
				.on(
						'click',
						function(e) {
							var $this = $(this);
							doGetLoad(
									'/${homepage.context_path}/module/teach/student/edit.do',
									'editMode=ADD&homepage_id='
											+ $this.attr('keyValue1')
											+ '&group_idx='
											+ $this.attr('keyValue2')
											+ '&category_idx='
											+ $this.attr('keyValue3')
											+ '&teach_idx='
											+ $this.attr('keyValue4')
											+ '&large_category_idx='
											+ $this.attr('keyValue5')
											+ '&apply_status='
											+ $this.attr('apply_status')
											+ '&menu_idx=${teach.menu_idx}');

							e.preventDefault();
						});

		$('a#back-btn').on('click', function(e) {
			e.preventDefault();
			//location.href = 'index.do?menu_idx=${fn:escapeXml(param.menu_idx)}';
 			location.href = 'index.do?menu_idx=${fn:escapeXml(param.menu_idx)}&searchCate1=${fn:escapeXml(param.searchCate1)}&homepage_id=${fn:escapeXml(param.homepage_id)}';
		});


	});

</script>

<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
<div class="teach_wrap">
	<div class="teach_top">
		<h3>${teach.teach_name}</h3>
	</div>

	<div class="teach_detail">
		<table class="tstyle nohead2" id="teach_table" summary="강의 상세내용입니다.">
			<caption>강의 상세내용입니다.</caption>
			<colgroup>
				<col width="20%"/>
				<col width="30%"/>
				<col width="20%"/>
				<col width="30%"/>
			</colgroup>
			<tbody>
				<c:if test="${not empty teach.image_server_file_name}">
				<tr>
					<th class="center" colspan="4">
						<img src="/data/teach/${teach.homepage_id}/img/${teach.image_server_file_name}" style="width: 100%;" >
					</th>
				</tr>
				</c:if>
				<tr>
					<th class="center">강의 분류</th>
					<td colspan="3">${teach.group_name} ${teach.category_name}</td>
				</tr>
				<tr>
					<th class="center">강의 설명</th>
					<c:set var="desc" value="${fn:replace(teach.teach_desc, crlf, '<br/>')}"></c:set>
					<c:set var="desc" value="${fn:replace(desc, lf, '<br/>')}"></c:set>
					<td colspan="3">${desc}</td>
				</tr>




				<tr class="mAllpx">
					<th class="center">강의장소</th>
					<td>${teach.teach_stage}</td>
					<th class="center">강사명</th>
					<td>${teach.teacher_name}</td>
				</tr>
				<tr class="mAllpx">
					<th class="center">준비물 및 재료비</th>
					<td>${teach.teach_etc}</td>
					<th class="center">강의대상</th>
					<td>${teach.teach_target}</td>
				</tr>


				<tr class="m330px">
					<th class="center">강의장소</th>
					<td colspan="3">${teach.teach_stage}</td>
				</tr>
				<tr class="m330px">
					<th class="center">강사명</th>
					<td colspan="3">${teach.teacher_name}</td>
				</tr>
				<tr class="m330px">
					<th class="center">준비물 및 재료비</th>
					<td colspan="3">${teach.teach_etc}</td>
				</tr>
				<tr class="m330px">
					<th class="center">강의대상</th>
					<td colspan="3">${teach.teach_target}</td>
				</tr>





				<c:if test="${teach.limit_hak_yn eq 'Y'}">
				<tr>
					<th class="center">학년제한</th>
					<td colspan="3">${teach.limit_hak_str} ~ ${teach.limit_hak2_str}</td>
				</tr>
				</c:if>
				<tr>
					<th class="center">강의계획서</th>
					<td colspan="3">
						<c:if test="${teach.server_file_name ne null and teach.server_file_name ne '' }">
							<a style="color: #00f" href="download/${teach.homepage_id}/${teach.group_idx}/${teach.category_idx}/${teach.teach_idx}.do">
							<i class="fa fa-floppy-o"></i> ${teach.org_file_name}</a>
						</c:if>
					</td>
				</tr>
				<tr>
					<th class="center">첨부파일</th>
					<td colspan="3">
						<c:if test="${teach.attach_server_file_name ne null and teach.attach_server_file_name ne ''}">
							<a style="color: #00f" href="download/${teach.homepage_id}/${teach.group_idx}/${teach.category_idx}/${teach.teach_idx}.do?file_type=attach">
							<i class="fa fa-floppy-o"></i> ${teach.attach_org_file_name}</a>
						</c:if>
					</td>
				</tr>
				<c:if test="${not empty teach.link_url}">
				<tr>
					<th class="center">하이퍼링크</th>
					<td colspan="3"><a href="${teach.link_url}" target="_blank" title="link">${teach.link_url}</a></td>
				</tr>
				</c:if>
				<tr>
					<th class="center">접수기간</th>
					<td colspan="3">${teach.start_join_date} ${teach.start_join_time} ~ ${teach.end_join_date} ${teach.end_join_time}</td>
				</tr>
				<tr>
					<th class="center">강의기간(*)</th>
					<td colspan="3">${teach.start_date} ~ ${teach.end_date}</td>
				</tr>



				<tr class="mAllpx">
					<th class="center">강의시간</th>
					<td>${teach.start_time } ~ ${teach.end_time }</td>
					<th class="center">강의요일</th>
					<td>
					<c:choose>
						<c:when test="${teach.teach_day_yn eq 'Y'}">${teach.teach_day_txt}</c:when>
						<c:otherwise>
						<c:forEach var="i" varStatus="stats_j" items="${teach.teach_day_arr}">
						<c:choose>
							<c:when test="${i eq '1'}">일</c:when>
							<c:when test="${i eq '2'}">월</c:when>
							<c:when test="${i eq '3'}">화</c:when>
							<c:when test="${i eq '4'}">수</c:when>
							<c:when test="${i eq '5'}">목</c:when>
							<c:when test="${i eq '6'}">금</c:when>
							<c:when test="${i eq '7'}">토</c:when>
						</c:choose>
						<c:if test="${!stats_j.last}">
							,
						</c:if>
						</c:forEach>
						</c:otherwise>
					</c:choose>
					</td>
				</tr>


				<tr class="m330px";>
					<th class="center">강의시간</th>
					<td colspan="3">${teach.start_time } ~ ${teach.end_time }</td>
				</tr>
				<tr class="m330px";>
					<th class="center">강의요일</th>
					<td colspan="3">
						<c:forEach var="i" varStatus="stats_j" items="${teach.teach_day_arr}">
							<c:choose>
								<c:when test="${i eq '1'}">일</c:when>
								<c:when test="${i eq '2'}">월</c:when>
								<c:when test="${i eq '3'}">화</c:when>
								<c:when test="${i eq '4'}">수</c:when>
								<c:when test="${i eq '5'}">목</c:when>
								<c:when test="${i eq '6'}">금</c:when>
								<c:when test="${i eq '7'}">토</c:when>
							</c:choose>
							<c:if test="${!stats_j.last}">
								,
							</c:if>
						</c:forEach>
					</td>
				</tr>





				<tr>
					<th class="center">현재 참여 / 모집</th>
					<td colspan="3">${teach.teach_join_count} 명 / ${teach.teach_limit_count} 명</td>
				</tr>
				<c:if test="${teach.teach_offline_count ne 0}">
				<tr>
					<th class="center">현재 오프라인 / 오프라인</th>
					<td colspan="3">${teach.teach_off_join_count} 명 / ${teach.teach_offline_count} 명</td>
				</tr>
				</c:if>
				<c:if test="${teach.teach_backup_count ne 0}">
				<tr>
					<th class="center">현재 대기자 / 대기자</th>
					<td colspan="3">${teach.teach_backup_join_count}명 / ${teach.teach_backup_count} 명</td>
				</tr>
				</c:if>
				<c:if test="${fn:length(teach.holidays) > 0}">
				<tr>
					<th class="center">휴강일</th>
					<td colspan="3">
						<c:forEach items="${teach.holidays}" var="i" varStatus="status">
						<c:if test="${!status.first}">, </c:if>
						${i}
						</c:forEach>
					</td>
				</tr>
				</c:if>
			</tbody>
		</table>
	</div>


	<c:choose>
		<c:when test="${homepage.context_path eq 'with'}">
			<div class="sbtn">
				<a id="back-btn" href="" class="btn"><i class="fa fa-reorder"></i><span>목록으로</span></a>
			</div>
		</c:when>
		<c:otherwise>
			<div class="sbtn">
				<c:choose>
					<c:when test="${teach.teach_status eq '0'}">
						<a href="" class="btn btn1 add" keyValue1="${teach.homepage_id}" keyValue2="${teach.group_idx}" keyValue3="${teach.category_idx}" keyValue4="${teach.teach_idx}" keyValue5="${teach.large_category_idx}" apply_status="1">
						<i class="fa fa-pencil-square-o"></i><span>수강신청 </span></a>
					</c:when>
					<c:when test="${teach.teach_status eq '1'}">
						<a href="" class="btn btn1 add" keyValue1="${teach.homepage_id}" keyValue2="${teach.group_idx}" keyValue3="${teach.category_idx}" keyValue4="${teach.teach_idx}" keyValue5="${teach.large_category_idx}" apply_status="2">
						<i class="fa fa-pencil-square-o"></i><span>대기자신청</span></a>
					</c:when>
					<c:when test="${teach.teach_status eq '2' or i.teach_status eq '10'}">
						<a href="/${homepage.context_path}/module/teach/applyList.do?menu_idx=${myTeachListMenuIdx}" class="btn btn2">
						<i class="fa fa-circle-o"></i><span>신청완료</span></a>
					</c:when>
					<c:when test="${teach.teach_status eq '3'}">
						<a href="/${homepage.context_path}/module/teach/applyList.do?menu_idx=${myTeachListMenuIdx}" class="btn btn2">
						<i class="fa fa-circle-o"></i><span>대기자 신청완료</span></a>
					</c:when>
					<c:when test="${teach.teach_status eq '9'}">
						<a href="javascript:void(0);" class="btn" style="cursor: default;">
						<i class="fa fa-pencil"></i><span>수강종료</span></a>
					</c:when>
					<c:when test="${teach.teach_status eq '4'}">
						<a href="javascript:void(0);" class="btn" style="cursor: default;">
						<span>접수마감</span></a>
					</c:when>
					<c:when test="${teach.teach_status eq '5'}">
						<a href="javascript:void(0);" class="btn" style="cursor: default;">
						<i class="fa fa-user"></i><span>정원마감</span></a>
					</c:when>
					<c:when test="${teach.teach_status eq '6'}">
						<a href="javascript:void(0);" class="btn btn4" style="cursor: default;">
						<i class="fa fa-clock-o"></i><span>신청대기</span></a>
					</c:when>
					<%-- <c:when test="${teach.teach_status eq '7' }">
						<a href="javascript:void(0);" class="btn btn3" style="cursor: default;">
						<i class="fa fa-times-circle"></i><span>신청불가(취소)</span></a>
					</c:when> --%>
				</c:choose>
				<a id="back-btn" href="" class="btn"><i class="fa fa-reorder"></i><span>목록으로</span></a>
			</div>
		</c:otherwise>
	</c:choose>


</div>
