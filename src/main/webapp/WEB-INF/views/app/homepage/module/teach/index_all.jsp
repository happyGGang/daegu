<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tag" uri="/WEB-INF/config/tld/cmsTag.tld" %>
<script type="text/javascript">
$(function(){
	$('a.detail-btn').on('click', function(e) {

		var param = 'homepage_id='+$(this).attr('keyValue');
		param += '&group_idx='+$(this).attr('keyValue1');
		param += '&category_idx='+$(this).attr('keyValue2');
		param += '&teach_idx='+$(this).attr('keyValue3');
		param += '&menu_idx='+$(this).attr('keyValue5');

		doGetLoad('/'+$(this).attr('keyValue4')+'/module/teach/detail.do', param);
		e.preventDefault();
	});

	$('a.add').on('click', function(e) {
		var $this = $(this);
		doGetLoad('/'+$this.attr('keyValue5')+'/module/teach/student/edit.do',
				'editMode=ADD&homepage_id='+$this.attr('keyValue1')+'&group_idx='+$this.attr('keyValue2')+'&category_idx='+$this.attr('keyValue3')
				+'&teach_idx='+$this.attr('keyValue4')+ '&apply_status='+ $this.attr('apply_status')+'&menu_idx='+$this.attr('keyValue6')+'&large_category_idx='+$this.attr('keyValue7')) ;

		e.preventDefault();
	});

	$('a.cancel').on('click', function(e) {
		e.preventDefault();

		if (confirm("취소하시면 해당강의에 재신청이 불가합니다.\n프로그램 신청을 취소하시겠습니까?")) {
			$('input#homepage_id').val($(this).attr('keyValue1'));
			$('input#category_idx').val($(this).attr('keyValue2'));
			$('input#teach_idx').val($(this).attr('keyValue3'));
			$('input#editMode').val('CANCEL');

			doAjaxPost($('form#teach'));
		}
	});

	$('a.teachBook-btn').on('click', function(e) {
		e.preventDefault();
		var $this = $(this);
		doGetLoad('/${homepage.context_path}/module/teachBook/index.do','menu_idx='+$('#menu_idx').val()+'&homepage_id='+$this.attr('keyValue1')+'&group_idx='+$this.attr('keyValue2')+'&category_idx='+$this.attr('keyValue3')+'&teach_idx='+$this.attr('keyValue4'))
	});

	$('a#search-btn').on('click', function(e) {
		e.preventDefault();
		$('#viewPage').attr('value', '1');
		doGetLoad('index.do', $('form#teach').serialize());
	});

	$('input#start_date').datepicker({
		maxDate: $('input#end_date').val(),
		onClose: function(selectedDate){
			$('input#end_date').datepicker('option', 'minDate', selectedDate);
		}
	});
	$('input#end_date').datepicker({
		minDate: $('input#start_date').val(),
		onClose: function(selectedDate){
			$('input#start_date').datepicker('option', 'maxDate', selectedDate);
		}
	});

	$('input#start_join_date').datepicker({
		maxDate: $('input#end_join_date').val(),
		onClose: function(selectedDate){
			$('input#end_join_date').datepicker('option', 'minDate', selectedDate);
		}
	});
	$('input#end_join_date').datepicker({
		minDate: $('input#start_join_date').val(),
		onClose: function(selectedDate){
			$('input#start_join_date').datepicker('option', 'maxDate', selectedDate);
		}
	});

	$('select#homepage_id').on('change', function() {
// 		$('select#group_idx').val('0');
// 		$('select#category_idx').val('0');
// 		$('select#group_idx option:not(.ALL)').remove();
// 		$('select#category_idx option:not(.ALL)').remove();
/* 		$('select#group_idx').select2({minimumResultsForSearch: Infinity});
		$('select#category_idx').select2({minimumResultsForSearch: Infinity}); */

// 		$.get('getGroupList.do?homepage_id='+$('select#homepage_id option:selected').val()+'&large_category_idx='+$('select#large_category_idx').val(), function(response) {
// 			if ( response.resultMsg != null ) {
// 				alert(response.resultMsg);
// 			}
// 			else {
// 				if( response.data != null){
// 					for (var i=0; i<response.data.length; i++) {
// 						$('select#group_idx').append('<option value="'+response.data[i].group_idx+'">'+response.data[i].group_name+'</option>');
// 					}
// 				}
// 			}
// 		});
	});
	$('select#large_category_idx').on('change', function() {
		$('select#group_idx').val('0');
		$('select#category_idx').val('0');
		$('select#group_idx option:not(.ALL)').remove();
		$('select#category_idx option:not(.ALL)').remove();
/* 		$('select#group_idx').select2({minimumResultsForSearch: Infinity});
		$('select#category_idx').select2({minimumResultsForSearch: Infinity}); */
		$.get('getGroupList.do?homepage_id='+$('select#homepage_id option:selected').val()+'&large_category_idx='+$(this).val(), function(response) {
			if ( response.resultMsg != null ) {
				alert(response.resultMsg);
			}
			else {
				if( response.data != null){
					for (var i=0; i<response.data.length; i++) {
						$('select#group_idx').append('<option value="'+response.data[i].group_idx+'">'+response.data[i].group_name+'</option>');
					}
				}
			}
		});
	});
	$('select#group_idx').on('change', function() {
		$('select#category_idx').val('0');
		$('select#category_idx option:not(.ALL)').remove();
/* 		$('select#category_idx').select2({minimumResultsForSearch: Infinity}); */
		$.get('getCategoryList.do?homepage_id='+$('select#homepage_id option:selected').val()+'&group_idx='+$('select#group_idx option:selected').val(), function(response) {
			if ( response.resultMsg != null ) {
				alert(response.resultMsg);
			}
			else {
				if( response.data != null){
					for (var i=0; i<response.data.length; i++) {
						$('select#category_idx').append('<option value="'+response.data[i].category_idx+'">'+response.data[i].category_name+'</option>');
					}
				}
			}
		});
	});

	$('div#board_paging a').on('click', function(e) {
		$('#viewPage').attr('value', $(this).attr('keyValue'));
		var param = serializeCustom($('form#teach'));
		doGetLoad('index.do', param);
		e.preventDefault();
	});
});
</script>
<form:form modelAttribute="teach" action="/${homepage.context_path}/module/teach/student/save.do" method="POST">
	<form:hidden path="teach_idx"/>
	<form:hidden path="editMode"/>
	<form:hidden path="menu_idx"/>

	<div id="libraryList" class="bbs-notice" style="margin-top:10px;margin-bottom:20px;">
		<ul>
			<li style="padding-bottom: 5px;">
				<c:if test="${teach.editMode eq 'ALL'}">
				도&nbsp;&nbsp;서&nbsp;&nbsp;관 :
				<form:select path="homepage_id"  cssClass="selectmenu" cssStyle="width: 250px;" title="도서관 선택">
					<form:option value="" label="전체" />
					<c:forEach var="i" varStatus="status" items="${homepageList}">
					<c:if test="${i.homepage_id ne 'h32' and i.homepage_id ne 'h31' and i.homepage_id ne 'h30' and i.homepage_id ne 'h33' and i.homepage_id ne 'h34' and i.homepage_id ne 'c0' and i.homepage_id ne 'c1'}">
					<form:option value="${i.homepage_id}" label="${i.homepage_name}" />
					</c:if>
					</c:forEach>
				</form:select>
				</c:if>
			</li>
			<li style="padding-bottom: 5px;">
				접수기간 : <form:input path="start_join_date" title="접수시작일, 입력예시 2020-01-01" cssClass="text ui-calendar"/><label for="start_join_date" class="blind">접수시작일</label> ~
						<form:input path="end_join_date" title="접수종료일, 입력예시 2020-12-31" cssClass="text ui-calendar" /><label for="end_join_date" class="blind">접수종료일</label>
			</li>
			<li style="padding-bottom: 5px;">
				강좌기간 : <form:input path="start_date" title="강의시작일, 입력예시 2020-01-01" cssClass="text ui-calendar"/><label for="start_date" class="blind">강의시작일</label> ~
						<form:input path="end_date" title="강의종료일, 입력예시 2020-12-31" cssClass="text ui-calendar" /><label for="end_date" class="blind">강의종료일</label>
			</li>
			<li style="padding-bottom: 5px;">
				상&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;태 :
				<form:select path="status" cssClass="selectmenu" cssStyle="width: 100px" title="상태값 선택">
					<form:option value="" label="전체"></form:option>
					<form:option value="6" label="신청대기"></form:option>
					<form:option value="0" label="신청가능"></form:option>
					<form:option value="1" label="대기자신청"></form:option>
					<form:option value="2" label="신청완료"></form:option>
					<form:option value="4" label="접수마감"></form:option>
					<form:option value="5" label="정원마감"></form:option>
				</form:select>
			</li>
			<li>
				강&nbsp;&nbsp;좌&nbsp;&nbsp;명 : <form:input path="search_text" title="강좌명 입력" cssClass="text" cssStyle="width: 200px; background:#fff;" /><label for="search_text" class="blind">강좌명</label>
				<a href="#" id="search-btn" class="btn btn1" title="조회" >조회</a>
			</li>
		</ul>
		<%--<form:select path="rowCount" cssClass="selectmenu" cssStyle="width:110px;">
		<c:forEach var="i" begin="10" end="50" step="10">
			<form:option value="${i}">${i}개씩 보기</form:option>
		</c:forEach>
		</form:select> --%>
	</div>


<c:if test="${fn:length(teachList) <1 }">
	<div class="nodata">
			<i class="fa fa-frown-o"></i>
		<p>등록된 프로그램이 없습니다.</p>
	</div>
</c:if>
<div class="op_wrap">
	<div class="smain">
		<c:forEach items="${teachList}" var="i">
			<div class="item" id="${i.homepage_id}_${i.group_idx}_${i.category_idx}_${i.teach_idx}">
				<div class="op_title category">
					<span class="ca ${i.context_path}">${i.homepage_alias}</span><span class="ca ty2">${i.group_name} ${i.category_name}</span>
					<c:choose>
						<c:when test="${i.context_path eq 'junggu'}">
							<a href="#" class="name detail-btn" keyValue="${i.homepage_id}" keyValue1="${i.group_idx}" keyValue2="${i.category_idx}" keyValue3="${i.teach_idx}" keyValue4="${i.context_path}" keyValue5="32">${i.teach_name}</a>
						</c:when>
						<c:otherwise>
							<a href="#" class="name detail-btn" keyValue="${i.homepage_id}" keyValue1="${i.group_idx}" keyValue2="${i.category_idx}" keyValue3="${i.teach_idx}" keyValue4="${i.context_path}" keyValue5="${i.menu_idx}">${i.teach_name}</a>
						</c:otherwise>
					</c:choose>

				</div>
				<div class="box">
					<div class="box2">
						<ul class="con2">
							<li class="first"><div><label>접수기간 </label> : ${i.start_join_date} ${i.start_join_time} ~ ${i.end_join_date} ${i.end_join_time}</div></li>
							<li><div><label>장소</label> : ${i.teach_stage}</div></li>
							<li><div><label>강좌일</label> : ${i.start_date} <c:if test="${i.start_date ne i.end_date}">~ ${i.end_date}</c:if> (
															<c:forEach var="j" varStatus="status_j" items="${i.teach_day_arr}">
																<c:choose>
																	<c:when test="${j eq '1'}">일</c:when>
																	<c:when test="${j eq '2'}">월</c:when>
																	<c:when test="${j eq '3'}">화</c:when>
																	<c:when test="${j eq '4'}">수</c:when>
																	<c:when test="${j eq '5'}">목</c:when>
																	<c:when test="${j eq '6'}">금</c:when>
																	<c:when test="${j eq '7'}">토</c:when>
																</c:choose>
																<c:if test="${!status_j.last}">
																	,
																</c:if>
															</c:forEach>
														) ${i.start_time} ~ ${i.end_time}
							</div></li>
							<c:if test="${not empty i.teacher_name}">
							<li><div><label>강사명</label> : ${i.teacher_name}</div></li>
							</c:if>
<%-- 							<c:if test="${not empty i.server_file_name}"> --%>
<!-- 							<li><div> -->
<!-- 								<label>강의계획서</label> : -->
<!-- 								<span class="important td1"> -->
<%-- 									<c:if test="${i.server_file_name ne null and i.server_file_name ne '' }"> --%>
<%-- 										<a style="color:#00f" href="download/${i.homepage_id}/${i.group_idx}/${i.category_idx}/${i.teach_idx}.do"><i class="fa fa-floppy-o"></i> ${i.org_file_name}</a> --%>
<%-- 									</c:if> --%>
<!-- 								</span> -->
<!-- 							</div></li> -->
<%-- 							</c:if> --%>

							<%-- <li><div><label>강좌설명</label> : ${i.teach_desc}</div></li> --%>
							<li><div class="status">
								<label>모집인원</label> :
								<span><strong>온라인</strong> ${i.teach_limit_count}명 </span>
								<c:if test="${i.teach_offline_count > 0}"><span>, <strong>오프라인</strong> ${i.teach_offline_count}명</span></c:if>
								<c:if test="${i.teach_backup_count > 0}"><span>, ( <strong>후보자</strong> ${i.teach_backup_count}명 )</span></c:if>
							</div></li>
							<li><div class="status">
								<label>접수현황</label> :
								<span>
									온라인 :
									<span ${i.teach_join_count > 0 and (i.teach_join_count eq i.teach_limit_count)? 'style="color:red;"' : 'style="color:#e55832"'}>${i.teach_join_count}</span> / ${i.teach_limit_count}
								</span>
								<c:if test="${i.teach_offline_count > 0}">
									<span>
										오프라인 :
										<span ${i.teach_off_join_count > 0 and (i.teach_off_join_count eq i.teach_offline_count)? 'style="color:red;"' : 'style="color:#e55832"'}>${i.teach_off_join_count}</span> / ${i.teach_offline_count}
									</span>
								</c:if>
								<c:if test="${i.teach_backup_count > 0}">
									<span>
										(
										후보자 :
										<span ${i.teach_backup_join_count > 0 and (i.teach_backup_join_count eq i.teach_backup_count)? 'style="color:red;"' : 'style="color:#e55832"'}>${i.teach_backup_join_count}</span> / ${i.teach_backup_count}
										)
									</span>
								</c:if>
							</div></li>
							<li><div><label>모집대상</label> : ${i.teach_target}</div></li>
							<c:if test="${i.limit_hak_yn eq 'Y'}">
							<li><div><label>학년제한</label> : ${i.limit_hak}</div></li>
							</c:if>
						</ul>
					</div>
				</div>
				<div class="stat">
							<c:set var="menu_idx" value="${i.menu_idx}"></c:set>
							<c:if test="${i.context_path eq 'junggu'}">
								<c:set var="menu_idx" value="32"></c:set>
							</c:if>
							<c:choose>
								<c:when test="${i.teach_status eq '0'}">
									<a href="#" class="btn btn1 add" keyValue1="${i.homepage_id}" keyValue2="${i.group_idx}" keyValue3="${i.category_idx}" keyValue4="${i.teach_idx}" keyValue5="${i.context_path}" keyValue6="${menu_idx}" keyValue7="${i.large_category_idx}" apply_status="1">
									<i class="fa fa-pencil-square-o"></i><span>수강신청 </span></a>
								</c:when>
								<c:when test="${i.teach_status eq '1'}">
									<a href="#" class="btn btn1 add" keyValue1="${i.homepage_id}" keyValue2="${i.group_idx}" keyValue3="${i.category_idx}" keyValue4="${i.teach_idx}" keyValue5="${i.context_path}" keyValue6="${menu_idx}" keyValue7="${i.large_category_idx}" apply_status="2">
									<i class="fa fa-pencil-square-o"></i><span>대기자신청</span></a>
								</c:when>
								<c:when test="${i.teach_status eq '2'}">
									<a href="javascript:void(0);" class="btn btn2" style="cursor: default;">
									<i class="fa fa-circle-o"></i><span>신청완료</span></a>
								</c:when>
								<c:when test="${i.teach_status eq '3'}">
									<a href="/${homepage.context_path}/module/teach/applyList.do?menu_idx=${myTeachListMenuIdx}&editMode=ALL" class="btn btn2">
									<i class="fa fa-circle-o"></i><span>대기자 신청완료</span></a>
								</c:when>
								<c:when test="${i.teach_status eq '9'}">
									<a href="javascript:void(0);" class="btn" style="cursor: default;">
									<i class="fa fa-pencil"></i><span>수강종료</span></a>
								</c:when>
								<c:when test="${i.teach_status eq '4'}">
									<a href="javascript:void(0);" class="btn" style="cursor: default;">
									<i class="fa fa-pencil"></i><span>접수마감</span></a>
								</c:when>
								<c:when test="${i.teach_status eq '5'}">
									<a href="javascript:void(0);" class="btn" style="cursor: default;">
									<i class="fa fa-user"></i><span>정원마감</span></a>
								</c:when>
								<c:when test="${i.teach_status eq '6'}">
									<a href="javascript:void(0);" class="btn btn4" style="cursor: default;">
									<i class="fa fa-clock-o"></i><span>신청대기</span></a>
								</c:when>
								<%-- <c:when test="${i.teach_status eq '7' }">
									<a href="javascript:void(0);" class="btn btn3" style="cursor: default;">
									<i class="fa fa-times-circle"></i><span>신청불가(취소)</span></a>
								</c:when> --%>
							</c:choose>
				</div>
			</div>
		</c:forEach>
	</div>
</div>
<form:hidden path="viewPage"/>
<div id="board_paging" class="dataTables_paginate">
<c:if test="${paging.firstPageNum > 0}">
	<a href="#" class="paginate_button previous" title="처음" keyValue="${paging.firstPageNum}">처음</a>
</c:if>
<c:if test="${paging.prevPageNum > 0}">
	<a href="#" class="paginate_button previous" title="이전" keyValue="${paging.prevPageNum}">이전</a>
</c:if>
	<span>
<c:forEach var="i" varStatus="status" begin="${paging.startPageNum}" end="${paging.endPageNum}">
<c:choose>
<c:when test="${i eq paging.viewPage}">
	<a href="#" class="paginate_button current" title="${i}페이지, 현재페이지" keyValue="${i}">${i}</a>
</c:when>
<c:otherwise>
	<a href="#" class="paginate_button" title="${i}페이지" keyValue="${i}">${i}</a>
</c:otherwise>
</c:choose>
</c:forEach>
<c:if test="${paging.nextPageNum > 0}">
	<a href="#" class="paginate_button next" title="다음" keyValue="${paging.nextPageNum}">다음</a>
</c:if>
<c:if test="${paging.totalPageCount ne paging.lastPageNum}">
	<a href="#" class="paginate_button next" title="맨끝" keyValue="${paging.totalPageCount}">맨끝</a>
</c:if>
	</span>
</div>

</form:form>
<div id="dialog-1" class="dialog-common" title="수강생 정보">
</div>