<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tag" uri="/WEB-INF/config/tld/cmsTag.tld" %>
<script type="text/javascript">
$(function(){
	$('a.detail-btn').on('click', function(e) {
		$('#teach #group_idx').val($(this).attr('keyValue1'));
		$('#teach #category_idx').val($(this).attr('keyValue2'));
		$('#teach #teach_idx').val($(this).attr('keyValue3'));
		doGetLoad('/${homepage.context_path}/module/teach/detail.do', serializeCustom($('form#teach')));
		e.preventDefault();
	});

	$('a.add').on('click', function(e) {
		var $this = $(this);
		doGetLoad('/${homepage.context_path}/module/teach/student/edit.do',
				'editMode=ADD&homepage_id='+$this.attr('keyValue1')+'&group_idx='+$this.attr('keyValue2')+'&category_idx='+$this.attr('keyValue3')
				+'&teach_idx='+$this.attr('keyValue4')+'&large_category_idx='+$this.attr('keyValue5')+ '&apply_status='+ $this.attr('apply_status')+'&menu_idx='+$('input#menu_idx').val());

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
		doGetLoad('/${homepage.context_path}/module/teachBook/index.do','menu_idx='+$('#menu_idx').val()+'&homepage_id='+$this.attr('keyValue1')+'&group_idx='+$this.attr('keyValue2')+'&category_idx='+$this.attr('keyValue3')+'&teach_idx='+$this.attr('keyValue4')+'&large_category_idx='+$this.attr('keyValue5'));
	});

	$('select#category_idx').change(function() {

		doGetLoad('/${homepage.context_path}/module/teach/index.do','menu_idx='+$('#menu_idx').val()+'&group_idx='+$('#group_idx').val()+'&category_idx='+$('#category_idx').val()+'&large_category_idx='+$('#large_category_idx').val());
	});

	$('div.tabmenu a').on('click', function(e) {
		e.preventDefault();
		var url = 'index.do';
		$('input#searchCate1').attr('value', $(this).attr('keyValue'));
		var $form = $('form#teach');
		var formData = serializeCustom($form);
		doGetLoad(url, formData);
	});

	$('a.toggle-btn').on('click', function(e) {
		var a = $(this).attr('keyValue3');
		$('div#'+a).toggle();

		e.preventDefault();
	});

});
</script>
<form:form modelAttribute="teach" action="/${homepage.context_path}/module/teach/student/save.do" method="POST">
	<form:hidden path="group_idx"/>
	<form:hidden path="teach_idx"/>
	<form:hidden path="menu_idx"/>
	<form:hidden path="category_idx"/>
	<form:hidden path="large_category_idx"/>
	<form:hidden path="searchCate1"/>

	<div class="tabmenu tab1">
		<ul>
			<li class="${empty teach.searchCate1 ? 'active':''}"><a href="" keyValue=""style="font-size: 13px;">전체</a></li>
			<c:forEach items="${teachLargeCategoryList}" var="i" varStatus="status">
			<li class="${teach.searchCate1 eq i.teach_code ? 'active':''}"><a href="" keyValue="${i.teach_code}" style="font-size: 13px;">${i.code_name}</a></li>
			</c:forEach>
		</ul>
	</div>

	<div style="text-align: right; margin-bottom: 20px; ">
		<a href="anonyApplyCheck.do?menu_idx=${fn:escapeXml(param.menu_idx)}" class="btn btn1">비회원 신청확인</a>
	</div>

</form:form>
<c:if test="${fn:length(teachList) <1 }">
	<div class="nodata">
			<i class="fa fa-frown-o"></i>
		<p>등록된 프로그램이 없습니다.</p>
	</div>
</c:if>
<div class="op_wrap">
	<div class="smain">
		<c:forEach items="${teachList}" var="i">
			<div class="item">
				<div class="op_title category">
					<span class="ca ty2">${i.group_name} ${i.category_name}</span>
					<c:if test="${fn:length(i.teach_name) > 20}">
										</c:if>
					<a href="" class="name toggle-btn" keyValue1="${i.group_idx}" keyValue2="${i.category_idx}" keyValue3="${i.teach_idx}">
						${i.teach_name}
					</a>

					<a href="" class="name toggle-btn btn btn6" style="float:right; text-align:center; width:85px; font-size: 13px;" keyValue1="${i.group_idx}" keyValue2="${i.category_idx}" keyValue3="${i.teach_idx}">
						<i class="fa fa-search"></i>상세보기
					</a>
					<span style="float: right;font-size:14px;padding-top:8px;margin-right:5px;letter-spacing:-1px;">
					<c:if test="${fn:length(i.teach_target) > 0}">
						<b>대상 : </b> ${i.teach_target} <span>｜</span>
					</c:if>
					<b>접수현황 : </b><span ${i.teach_join_count > 0 and (i.teach_join_count eq i.teach_limit_count)? 'style="color:red;padding:0; vertical-align:baseline;"' : 'style="color:orange; padding:0; vertical-align:baseline;"'}>${i.teach_join_count}</span> / ${i.teach_limit_count}
					<c:if test="${i.teach_backup_count > 0}">
						<span>｜</span> <b>대기현황 : </b>
						<span ${i.teach_backup_join_count > 0 and (i.teach_backup_join_count eq i.teach_backup_count)? 'style="color:red;"' : 'style="color:#e55832"'}>${i.teach_backup_join_count}</span> / ${i.teach_backup_count}
					</c:if>
					</span>
				</div>
				<div class="sk-box" id="${i.teach_idx}" style="display: none;">
				<div class="box">
					<div class="box2">
						<ul class="con2">
							<li class="first"><div><label>접수기간 </label> : ${i.start_join_date}&nbsp;&nbsp;${i.start_join_time}&nbsp;&nbsp;&nbsp;~ &nbsp;&nbsp;&nbsp;${i.end_join_date}&nbsp;&nbsp;${i.end_join_time}</div></li>
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
							<li><div>
				        		<label>강의계획서</label> :
					         	<span class="important td1">
					         		<c:if test="${i.server_file_name ne null and i.server_file_name ne '' }">
					         			<a style="color:#00f" href="download/${i.homepage_id}/${i.group_idx}/${i.category_idx}/${i.teach_idx}.do"><i class="fa fa-floppy-o"></i> ${i.org_file_name}</a>
					         		</c:if>
				         		</span>
					        </div></li>

							<%-- <li><div><label>강좌설명</label> : ${i.teach_desc}</div></li> --%>
							<li><div class="status">
								<label>모집인원</label> :
								<span><strong>온라인</strong> ${i.teach_limit_count}명 </span>
								<c:if test="${i.teach_offline_count > 0}"><span>, <strong>오프라인</strong> ${i.teach_offline_count}명</span></c:if>
								<c:if test="${i.teach_backup_count > 0}"><span>, ( <strong>대기인원</strong> ${i.teach_backup_count}명 )</span></c:if>
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
										대기현황 :
										<span ${i.teach_backup_join_count > 0 and (i.teach_backup_join_count eq i.teach_backup_count)? 'style="color:red;"' : 'style="color:#e55832"'}>${i.teach_backup_join_count}</span> / ${i.teach_backup_count}
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
									<label>상세내용</label> :
									<a href="#" title="강좌 상세정보 보기" class="detail-btn btn" keyValue1="${i.group_idx}" keyValue2="${i.category_idx}" keyValue3="${i.teach_idx}">강좌 상세정보 보기</a>
								</div>
							</li>
						</ul>
					</div>
				</div>
				<div class="stat">
					<c:choose>
						<c:when test="${i.teach_status eq '0'}">
							<a href="" class="btn btn1 add" keyValue1="${i.homepage_id}" keyValue2="${i.group_idx}" keyValue3="${i.category_idx}" keyValue4="${i.teach_idx}" keyValue5="${i.large_category_idx}" apply_status="1">
							<i class="fa fa-pencil-square-o"></i><span>수강신청 </span></a>
						</c:when>
						<c:when test="${i.teach_status eq '1'}">
							<a href="" class="btn btn1 add" keyValue1="${i.homepage_id}" keyValue2="${i.group_idx}" keyValue3="${i.category_idx}" keyValue4="${i.teach_idx}" keyValue5="${i.large_category_idx}" apply_status="2">
							<i class="fa fa-pencil-square-o"></i><span>대기자신청</span></a>
						</c:when>
						<c:when test="${i.teach_status eq '2' or i.teach_status eq '10'}">
							<a href="/${homepage.context_path}/module/teach/applyList.do?menu_idx=${myTeachListMenuIdx}" class="btn btn2">
							<i class="fa fa-circle-o"></i><span>신청완료</span></a>
						</c:when>
						<c:when test="${i.teach_status eq '3'}">
							<a href="/${homepage.context_path}/module/teach/applyList.do?menu_idx=${myTeachListMenuIdx}" class="btn btn2">
							<i class="fa fa-circle-o"></i><span>대기자 신청완료</span></a>
						</c:when>
						<c:when test="${i.teach_status eq '9'}">
							<a href="javascript:void(0);" class="btn" style="cursor: default;">
							<i class="fa fa-pencil"></i><span>수강종료</span></a>
						</c:when>
						<c:when test="${i.teach_status eq '4'}">
							<a href="javascript:void(0);" class="btn" style="cursor: default;">
							<span>접수마감</span></a>
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
			</div>
		</c:forEach>
	</div>
</div>

<div id="dialog-1" class="dialog-common" title="수강생 정보">
</div>