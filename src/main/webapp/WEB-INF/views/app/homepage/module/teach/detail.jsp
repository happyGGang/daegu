<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
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
											+ '&apply_status='
											+ $this.attr('apply_status')
											+ '&menu_idx=${teach.menu_idx}');

							e.preventDefault();
						});

		$('a#back-btn').on('click', function(e) {
			e.preventDefault();
			history.back();
		});
		
		
	});

</script>


<div class="teach_wrap">
	<div class="teach_top">
		<h3>${teach.teach_name}</h3>
	</div>

	<div class="auto-scroll teach_detail">
		<table class="tstyle nohead" id="teach_table" summary="강의 상세내용입니다.">
			<caption>강의 상세내용입니다.</caption>
			<colgroup>
				<col width="20%"/>
				<col width="30%"/>
				<col width="20%"/>
				<col width="30%"/>
			</colgroup>
			<tbody>
				<c:if test="${not empty teach.image_real_file_name}">
				<tr>
					<th class="center" colspan="4">
						<img src="/data/teach/${homepage.homepage_id}/img/${teach.image_real_file_name}" style="width: 100%;" > 
					</th>
				</tr>
				</c:if>
				<tr>
					<th class="center">강의 분류</th>
					<td colspan="3">${teach.group_name} ${teach.category_name}</td>
				</tr>
				<tr>
					<th class="center">강의 설명</th>
					<td colspan="3">${teach.teach_desc}</td>
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
						<c:if test="${teach.real_file_name ne null and teach.real_file_name ne '' }">
							<a style="color: #00f" href="download/${teach.homepage_id}/${teach.group_idx}/${teach.category_idx}/${teach.teach_idx}.do">
							<i class="fa fa-floppy-o"></i> ${teach.plan_file_name}</a>
						</c:if>
					</td>
				</tr>
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

<div class="sbtn">
	<a id="back-btn" href="" class="btn"><i class="fa fa-reorder"></i><span>목록으로</span></a>
</div>

</div>
