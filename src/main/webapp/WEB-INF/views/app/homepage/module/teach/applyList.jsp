<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tag" uri="/WEB-INF/config/tld/cmsTag.tld" %>
<script type="text/javascript">
$(function(){
	$('a.detail-btn').on('click', function(e) {
		if('${homepage.homepage_id}' == 'h32') {
			var param = 'homepage_id='+$(this).attr('keyValue');
			param += '&group_idx='+$(this).attr('keyValue1');
			param += '&category_idx='+$(this).attr('keyValue2');
			param += '&teach_idx='+$(this).attr('keyValue3');
			param += '&menu_idx='+$(this).attr('keyValue5');

			doGetLoad('/'+$(this).attr('keyValue4')+'/module/teach/detail.do', param);
		} else {
			$('#teach #group_idx').val($(this).attr('keyValue1'));
			$('#teach #category_idx').val($(this).attr('keyValue2'));
			$('#teach #teach_idx').val($(this).attr('keyValue3'));
			doGetLoad('/${homepage.context_path}/module/teach/detail.do', serializeCustom($('form#teach')));
		}
		e.preventDefault();
	});
	
	$('a.cancel').on('click', function(e) {
		e.preventDefault();
		if (confirm("해당 강좌 신청을 취소하시겠습니까? 취소후 해당 강좌에 대해 재신청 가능합니다.")) {
			$('input#homepage_id').val($(this).attr('keyValue1'));
			$('input#group_idx').val($(this).attr('keyValue2'));
			$('input#category_idx').val($(this).attr('keyValue3'));
			$('input#teach_idx').val($(this).attr('keyValue4'));
			if('${homepage.homepage_id}' == 'h32') {
				$('input#editMode').val('CANCEL_ALL');
			} else {
				$('input#editMode').val('CANCEL');
			}
			
			doAjaxPost($('form#teach'));
		}
	});
	
	$('a.dialog-certificate').on('click', function(e) { 
		$('#dialog-1').load('student/certificate.do?homepage_id=' + $(this).attr('keyValue1') + '&group_idx=' + $(this).attr('keyValue2') + '&category_idx=' + $(this).attr('keyValue3') + '&teach_idx=' + $(this).attr('keyValue4') + '&student_idx=' + $(this).attr('keyValue5'), function( response, status, xhr ) {
			var divToPrint = $('div#dialog-1').clone();
			divToPrint = divToPrint.show()[0];
		    newWin= window.open("");
		    newWin.document.write(divToPrint.outerHTML);
		    newWin.print();
		    newWin.close();
		});
		
		e.preventDefault();
	});
	
	$('a.excel-btn').on('click', function(e) {
		e.preventDefault();
		$('#excelDownForm #excel_type').val('HOPE');
		$('#excelDownForm').submit();
	});
	
	$('input#searchDateFrom').datepicker({
		maxDate: $('input#searchDateTo').val(), 
		onClose: function(selectedDate){
			$('input#searchDateTo').datepicker('option', 'minDate', selectedDate);
		}
	});
	$('input#searchDateTo').datepicker({
		minDate: $('input#searchDateFrom').val(), 
		onClose: function(selectedDate){
			$('input#searchDateFrom').datepicker('option', 'maxDate', selectedDate);
		}
	});
	
	$('a#search-btn').on('click', function(e) {
		e.preventDefault();
		doGetLoad('applyList.do', $('form#teach').serialize());
	});
});
</script>

<c:if test="${fn:length(teachList) > 0}">
	<div style="text-align: right">
		<form:form id="excelDownForm" modelAttribute="teach" action="/${homepage.context_path}/module/teach/excelDownload.do" method="get">
			<form:hidden path="homepage_id"/>
			<form:hidden path="group_idx"/>
			<form:hidden path="category_idx"/>
			<form:hidden path="teach_idx"/>
			<form:hidden path="member_key"/>
			<form:hidden path="menu_idx"/>
		</form:form>
	</div>
</c:if>

<form:form modelAttribute="teach" action="/${homepage.context_path}/module/teach/student/save.do" method="POST">
	<form:hidden path="homepage_id" />
	<form:hidden path="group_idx"/>
	<form:hidden path="category_idx"/>
	<form:hidden path="teach_idx"/>
	<form:hidden path="editMode"/>
	<form:hidden path="menu_idx"/>

<div id="libraryList" class="bbs-notice" style="margin-top:10px;margin-bottom:20px;" >
조회 기간:<form:input path="searchDateFrom" cssClass="text ui-calendar"/><label for="searchDateFrom" class="blind">시작일</label> ~ 
		<form:input path="searchDateTo" cssClass="text ui-calendar"/><label for="searchDateTo"  class="blind">종료일</label>
		<a href="#" id="search-btn" class="btn btn1">조회</a>
		<c:if test="${fn:length(teachList) > 0}">
		<a class="btn btn2 excel-btn"><i class="fa fa-file-excel-o"></i>엑셀 저장</a>
		</c:if>
		<br/>
<form:radiobutton path="searchStatus" value="Y" label="신청내역 : " cssStyle="vertical-align:middle"/>
<form:select path="status" cssClass="selectmenu" cssStyle="width:60px;">
			<form:option value="" label="전체"></form:option>
			<form:options items="${statusCode}" itemLabel="code_name" itemValue="code_id"/>
		</form:select>&nbsp;&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;&nbsp;
<form:radiobutton path="searchStatus" value="N" label="수료내역" cssStyle="vertical-align:middle"/>
</div>
<c:if test="${fn:length(teachList) <1 }">
	<div class="nodata" style="text-align: center;">
		<i class="fa fa-frown-o"></i>신청 내역이 없습니다.
	</div>
</c:if>
<div class="op_wrap">
	<div class="smain">
		
		<c:forEach items="${teachList}" var="i">
			<div class="item">
				<div class="op_title category">
					<c:choose>
						<c:when test="${homepage.homepage_id eq 'h32'}">
							<span class="ca ${i.context_path}">${i.homepage_alias}</span>
							<span class="ca ty2">${i.group_name} ${i.category_name}</span>
							<a href="#" class="name detail-btn" keyValue="${i.homepage_id}" keyValue1="${i.group_idx}" keyValue2="${i.category_idx}" keyValue3="${i.teach_idx}" keyValue4="${i.context_path}" keyValue5="${i.menu_idx}">${i.teach_name}</a>
						</c:when>
						<c:otherwise>
							<span class="ca ty2">${i.group_name} ${i.category_name}</span>
							<a href="" class="name detail-btn" keyValue1="${i.group_idx}" keyValue2="${i.category_idx}" keyValue3="${i.teach_idx}">${i.teach_name}</a>
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
							<li><div><label>강사명</label> : ${i.teacher_name}</div></li>
							<li><div><label>강좌설명</label> : ${i.teach_desc}</div></li>
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
									<span ${i.teach_join_count > 0 and (i.teach_join_count eq i.teach_limit_count)? 'style="color:red;"' : 'style="color:orange"'}>${i.teach_join_count}</span> / ${i.teach_limit_count}
								</span>
								<c:if test="${i.teach_offline_count > 0}">
									<span>
										오프라인 :
										<span ${i.teach_off_join_count > 0 and (i.teach_off_join_count eq i.teach_offline_count)? 'style="color:red;"' : 'style="color:orange"'}>${i.teach_off_join_count}</span> / ${i.teach_offline_count}
									</span>
								</c:if>
								<c:if test="${i.teach_backup_count > 0}">
									<span>
										(
										후보자 :
										<span ${i.teach_backup_join_count > 0 and (i.teach_backup_join_count eq i.teach_backup_count)? 'style="color:red;"' : 'style="color:orange"'}>${i.teach_backup_join_count}</span> / ${i.teach_backup_count}
										)
									</span>
								</c:if>
							</div></li>
							<li><div><label>모집대상</label> : ${i.teach_target}</div></li>
							<c:if test="${i.cancle_use_yn eq 'Y'}">
							<li><div><label>취소기간</label> : ${i.start_cancle_date} ${i.start_cancle_time} ~ ${i.end_cancle_date} ${i.end_cancle_time}</div></li>
							</c:if>
							<c:if test="${i.limit_hak_yn eq 'Y'}">
							<li><div><label>학년제한</label> : ${i.limit_hak_str} ~ ${i.limit_hak2_str}</div></li>
							</c:if>
							<li>
								<div>
									<label>수강생</label> : ${i.student_name} ( ${i.student_sex eq 'M' ? '남' : '여'} )
									<c:if test="${i.teach_status eq '3'and i.wait_num != 0}">
									<span>현재 대기번호 ${i.wait_num}번 입니다.</span>
									</c:if>
								</div>
							</li>
							<li><div><label>신청일시</label> : ${i.add_date}</div></li>
						</ul>
					</div>
				</div>
				<div class="stat">
					<c:choose>
						<c:when test="${i.teach_status eq '2'}">
<!-- 							<a href="javascript:void(0);" class="btn btn2" style="cursor: default;"> -->
<!-- 							<i class="fa fa-circle-o"></i><span>신청완료</span></a> -->
							<a href="" class="btn btn5 cancel" keyValue1="${i.homepage_id}" keyValue2="${i.group_idx}" keyValue3="${i.category_idx}" keyValue4="${i.teach_idx}">
							<i class="fa fa-times"></i><span>신청취소</span></a>
						</c:when>
						<c:when test="${i.teach_status eq '3'}">
<!-- 							<a href="javascript:void(0);" class="btn btn3" style="cursor: default;"> -->
<!-- 							<i class="fa fa-sign-in"></i><span>대기자</span></a> -->
							<a href="" class="btn btn5 cancel" keyValue1="${i.homepage_id}" keyValue2="${i.group_idx}" keyValue3="${i.category_idx}" keyValue4="${i.teach_idx}">
							<i class="fa fa-times"></i><span>대기자 신청취소</span></a>
						</c:when>
						<c:when test="${i.teach_status eq '4'}">
							<a href="javascript:void(0);" class="btn" style="cursor: default;">
							<i class="fa fa-pencil"></i><span>접수마감</span></a>
						</c:when>
						<c:when test="${i.teach_status eq '9'}">
							<a href="javascript:void(0);" class="btn" style="cursor: default;">
							<i class="fa fa-pencil"></i><span>수강종료</span></a>
						</c:when>
						<c:when test="${i.teach_status eq '5'}">
							<a href="javascript:void(0);" class="btn" style="cursor: default;">
							<i class="fa fa-user"></i><span>정원마감</span></a>
						</c:when>
						<c:when test="${i.teach_status eq '7' }">
							<a href="javascript:void(0);" class="btn btn3" style="cursor: default;">
							<i class="fa fa-times-circle"></i><span>취소완료</span></a>
						</c:when>
						<c:when test="${i.teach_status eq '8' }">
							<a href="javascript:void(0);" class="btn btn3" style="cursor: default;">
							<i class="fa fa-times-circle"></i><span>관리자취소</span></a>
						</c:when>
						<c:when test="${i.teach_status eq '10'}">
							<a href="javascript:void(0);" class="btn btn5" style="cursor: default;">
							<i class="fa fa-times-circle"></i><span>취소불가</span></a>
						</c:when>
					</c:choose>
				</div>
			</div>
		</c:forEach>
	</div>
</div>
</form:form>
<div id="dialog-1" class="dialog-common" title="수료증" hidden="hidden">
</div>