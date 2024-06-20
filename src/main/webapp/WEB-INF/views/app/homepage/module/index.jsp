<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tag" uri="/WEB-INF/config/tld/cmsTag.tld" %>
<link rel="stylesheet" type="text/css" 	href="/resources/common/css/culture-list.css" />
<script type="text/javascript">
$(function(){
	$('a.detail-btn').on('click', function(e) {
		var formData = 'menu_idx='+$('#menu_idx').val()+'&homepage_id='+$('#homepage_id_1').val()+'&group_idx='+$(this).attr('keyValue1')+'&category_idx='+$(this).attr('keyValue2')+'&teach_idx='+$(this).attr('keyValue3')
			+'&searchCate1='+$('#searchCate1').val();
		doGetLoad('/${homepage.context_path}/module/teach/detail.do', formData);
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
		$('#teach select#group_idx option.all').prop('selected', true);
		$('#teach select#category_idx option.all').prop('selected', true);
		var $form = $('form#teach');
		var formData = serializeCustom($form);
		doGetLoad(url, formData);
	});

	$('a.toggle-btn').on('click', function(e) {
		var a = $(this).attr('keyValue3');
		$('div#'+a).toggle();

		e.preventDefault();
	});
	
	$('a#search_btn').on('click', function(e) {
		$('#viewPage').val(1);
		var hid = $(this).data('hid');
		$('input#homepage_id_1').val(hid);
		doGetLoad('index.do', serializeCustom($('form#teach')));

		e.preventDefault();
	});

	<c:if test="${fn:length(subHomepageList) > 0 or
		(homepage.context_path eq 'beomeo' and teach.searchCate1 eq '17') or
		(homepage.context_path eq 'yonghak' and teach.searchCate1 eq '17') or
		(homepage.context_path eq 'dalseolib' and teach.searchCate1 eq '16') or
		(homepage.context_path eq 'dalseolib' and teach.searchCate1 eq '17')}">
	var a = '${fn:escapeXml(param.homepage_id)}';
	if (a == '') {
		a = '${fn:escapeXml(teach.homepage_id)}';
	}
	$('div.tab_menu a[data-hid="'+a+'"]').parent().addClass('active');

	$('div.tab_menu a').on('click', function(e) {
		e.preventDefault();
		var hid = $(this).data('hid');
		$('input#homepage_id_1').val(hid);
		doGetLoad('index.do', 'menu_idx='+$('#menu_idx').val()+'&searchCate1='+$('#searchCate1').val()+'&homepage_id='+$('#homepage_id_1').val());
	});
	</c:if>
	
	$('input#search_text').keydown(function(key) {
		if (key.keyCode == 13) {
			$('a#search_btn').click();
		}
	});
	
	$('select#group_idx').on('change', function() {
		$('#taech select#category_idx option.all').prop('selected', true);
		$('#teach #search_text').val('');
		$('#teach #viewPage').val(1);
		doGetLoad('index.do', serializeCustom($('form#teach')));
	});

	$('select#category_idx').on('change', function() {
		$('#teach #search_text').val('');
		$('#teach #viewPage').val(1);
		doGetLoad('index.do', serializeCustom($('form#teach')));
	});
});
</script>
<style>
	.list01 td .btn{width:100px;padding:5px 8px;}
</style>

<form:form modelAttribute="teach" action="/${homepage.context_path}/module/teach/student/save.do" method="POST" onsubmit="return false">
<%-- 	<form:hidden path="group_idx"/> --%>
	<form:hidden path="teach_idx"/>
	<form:hidden path="menu_idx"/>
<%-- 	<form:hidden path="category_idx"/> --%>
	<form:hidden path="large_category_idx"/>
	<form:hidden path="searchCate1"/>
	<form:hidden id="homepage_id_1" path="homepage_id"/>

	<c:if test="${fn:length(subHomepageList) > 0 and homepage.context_path ne 'beomeo' and homepage.context_path ne 'yonghak' and homepage.context_path ne 'dalseolib'}">
		<div class="tab_menu on">
			<ul class="no${fn:length(subHomepageList)}">
				<c:forEach items="${subHomepageList}" var="i" varStatus="status">
					<li><a href="#tabCon${status.index}" data-hid="${i.homepage_id}">${i.homepage_alias}</a></li>
				</c:forEach>
			</ul>
		</div>
	</c:if>

	<c:choose>

		<c:when test="${homepage.context_path eq 'beomeo' and teach.searchCate1 eq '17'}">
			<div class="tab_menu on">
				<ul class="no3">
					<li><a href="#tabCon0" data-hid="h50">범어</a></li>
					<li><a href="#tabCon1" data-hid="h54">책숲길</a></li>
					<li><a href="#tabCon2" data-hid="h55">물망이</a></li>
				</ul>
			</div>
		</c:when>

		<c:when test="${homepage.context_path eq 'yonghak' and teach.searchCate1 eq '17'}">
			<div class="tab_menu on">
				<ul class="no3">
					<li><a href="#tabCon0" data-hid="h51">용학</a></li>
					<li><a href="#tabCon1" data-hid="h56">파동</a></li>
					<li><a href="#tabCon2" data-hid="h57">무학숲</a></li>
				</ul>
			</div>
		</c:when>

		<c:when test="${homepage.context_path eq 'dalseolib' and teach.searchCate1 eq '16'}">
			<div class="tab_menu on">
				<ul class="no7">
					<li><a href="#tabCon0" data-hid="h72">도원</a></li>
					<li><a href="#tabCon1" data-hid="h67">성서</a></li>
					<li><a href="#tabCon2" data-hid="h68">본리</a></li>
					<li><a href="#tabCon3" data-hid="h69">달서가족문화</a></li>
					<li><a href="#tabCon4" data-hid="h66">달서어린이</a></li>
					<li><a href="#tabCon5" data-hid="h70">달서영어</a></li>
					<li><a href="#tabCon6" data-hid="h41">독서문화진흥</a></li>
				</ul>
			</div>
		</c:when>

		<c:when test="${homepage.context_path eq 'dalseolib' and teach.searchCate1 eq '17'}">
			<div class="tab_menu on">
				<ul class="no6">
					<li><a href="#tabCon0" data-hid="h72">도원</a></li>
					<li><a href="#tabCon1" data-hid="h67">성서</a></li>
					<li><a href="#tabCon2" data-hid="h68">본리</a></li>
					<li><a href="#tabCon3" data-hid="h69">달서가족문화</a></li>
					<li><a href="#tabCon4" data-hid="h66">달서어린이</a></li>
					<li><a href="#tabCon5" data-hid="h70">달서영어</a></li>
				</ul>
			</div>
		</c:when>



	</c:choose>

	<c:choose>
	<c:when test="${homepage.context_path eq 'donggu' || homepage.context_path eq 'seogulib' || homepage.context_path eq 'namdm' ||  homepage.context_path eq 'namic' ||  homepage.context_path eq 'namic' || homepage.context_path eq 'bukgs' || homepage.context_path eq 'bukdh' || homepage.context_path eq 'buktj' || homepage.context_path eq 'beomeo' || homepage.context_path eq 'yonghak' || homepage.context_path eq 'gosan' || homepage.context_path eq 'dalseolib' || homepage.context_path eq 'dalseonglib' || homepage.context_path eq 'junggu' || homepage.context_path eq 'dmsl'}">

	</c:when>
	<c:otherwise>
	<div class="tabmenu tab1" style="margin-top:30px;">
		<ul>
			<li class="${empty teach.searchCate1 ? 'active':''}"><a href="" keyValue=""style="font-size: 14px;">전체</a></li>
			<c:forEach items="${teachLargeCategoryList}" var="i" varStatus="status">
			<li class="${teach.searchCate1 eq i.teach_code ? 'active':''}"><a href="" keyValue="${i.teach_code}" style="font-size: 14px;">${i.code_name}</a></li>
			</c:forEach>
		</ul>
	</div>
	</c:otherwise>
	</c:choose>

	<div class="search new_search_box">
		<fieldset>
			<div style="text-align:center;margin-bottom:10px;">
				<div class="fl_left_box">
					<form:select path="search_type" cssClass="selectmenu new_select_box">
						<form:option value="teach_name"><c:choose>
						<c:when test="${param.searchCate1 eq '16'}">행사명</c:when>
						<c:when test="${param.searchCate1 eq '17'}">강좌명</c:when>
						<c:when test="${param.searchCate1 eq '18'}">강좌명</c:when>
						<c:otherwise>강좌명</c:otherwise></c:choose>
						</form:option>
					</form:select>
					<form:input path="search_text" cssClass="text new_text01"/>
				</div>
				<div class="srch_category_box">
					<p style="height:2px;"></p>
					<span>중분류 :
						<form:select path="group_idx" cssClass="new_select_box">
							<form:option class="all" value="0" label="전체" />
							<form:options itemValue="group_idx" itemLabel="group_name" items="${categoryGroupList}"/>
						</form:select>
					</span>
					<span style="margin-left:10px;">소분류 :
						<form:select path="category_idx" cssClass="new_select_box">
							<form:option class="all" value="0" label="전체" />
							<c:forEach items="${categoryList}" var="i">
								<form:option class="group_${i.group_idx}" value="${i.category_idx}">${i.category_name}</form:option>
							</c:forEach>
						</form:select>
					</span>
					<a href="#" class="btn btn1" id="search_btn"><i class="fa fa-search"></i><span>검색</span></a>
				</div>
			</div>
			<div class="srch_day_box">
				<c:forEach var="i" begin="1" end="7">
					<input type="checkbox" id="teach_day${i}" name="teach_day" value="${i}" ${fn:contains(teach.teach_day, i) ? 'checked="checked"' : ''} style="width: 13px;">
					<label for="teach_day${i}" style="background:none;padding-right:5px;">
						<c:if test="${i eq 1}">일</c:if>
						<c:if test="${i eq 2}">월</c:if>
						<c:if test="${i eq 3}">화</c:if>
						<c:if test="${i eq 4}">수</c:if>
						<c:if test="${i eq 5}">목</c:if>
						<c:if test="${i eq 6}">금</c:if>
						<c:if test="${i eq 7}">토</c:if>
					</label>
				</c:forEach>
			</div>
		</fieldset>
	</div>

</form:form>

${html.html}

<div style="text-align: right; margin-bottom: 10px; ">
	<a href="anonyApplyCheck.do?homepage_id=${fn:escapeXml(teach.homepage_id)}&menu_idx=${fn:escapeXml(param.menu_idx)}" class="btn btn1" style="font-size:14px;">비회원 신청확인</a>
</div>

<div class="op_wrap">
	<div class="smain">
		<table class="list01 rwd-table" summary="문화행사신청 게시물. 본 데이터표는 8컬럼, 10로우로 구성되어 있습니다. 각 로우는 번호, 분류,  제목,   등록자, 등록일, 조회로 구성되어 있습니다." cellspacing="0" cellpadding="0" border="0">
			<caption>문화행사신청 목록 페이지</caption>
			<colgroup>
			<col />
			<col width="15%" />
			<col width="25%"/>
			<col width="20%" />
			<col width="10%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col" class="center"><c:choose><c:when test="${param.searchCate1 eq '16'}">행사명</c:when><c:when test="${param.searchCate1 eq '17'}">강좌명</c:when><c:when test="${param.searchCate1 eq '18'}">강좌명</c:when><c:otherwise>강좌명</c:otherwise></c:choose></th>
					<th scope="col" class="center">접수인원</th>
					<th scope="col" class="center"><c:choose><c:when test="${param.searchCate1 eq '16'}">행사기간</c:when><c:when test="${param.searchCate1 eq '17'}">강좌기간</c:when><c:when test="${param.searchCate1 eq '18'}">강좌기간</c:when><c:otherwise>강좌기간</c:otherwise></c:choose></th>
					<th scope="col" class="center">접수기간</th>
					<th scope="col" class="center">접수상태</th>
				</tr>
			</thead>

			<c:choose>
			<c:when test="${fn:length(teachList) < 1 }">
			<tbody>
					<tr>
						<td colspan="5" style="text-align:center;">
<p>등록된 프로그램이 없습니다.</p>
						</td>
					</tr>
			</tbody>
			</c:when>

			<c:otherwise>
			<tbody>
					
					<c:forEach items="${teachList}" var="i">
					<tr>
						<td data-th="제목" class="title left" style="padding-left:5px;">
							<dl>
								<dd><span class="ca ty2">${i.group_name}</span></dd>
								<dt class="title">
									<a href="#" title="강좌 상세정보 보기" class="detail-btn" keyValue1="${i.group_idx}" keyValue2="${i.category_idx}" keyValue3="${i.teach_idx}">
										${i.teach_name}
									</a>
								</dt>
								<!-- <dd class="con">장소 : ${i.teach_stage}</dd> -->
								<dd class="con">대상 : ${i.teach_target}</dd>
								<dd class="con mobile-view">
								<span>온라인
									<span ${i.teach_join_count > 0 and (i.teach_join_count eq i.teach_limit_count)? 'style="color:red;"' : 'style="color:#e55832"'}>${i.teach_join_count}</span> / ${i.teach_limit_count}<br/>
								</span>
								<c:if test="${i.teach_offline_count > 0}">
								<span>오프라인
									<span ${i.teach_off_join_count > 0 and (i.teach_off_join_count eq i.teach_offline_count)? 'style="color:red;"' : 'style="color:#e55832"'}>${i.teach_off_join_count}</span> / ${i.teach_offline_count}<br/>
								</span>
								</c:if>
								<c:if test="${i.teach_backup_count > 0}">
								<span>(후보자 <span ${i.teach_backup_join_count > 0 and (i.teach_backup_join_count eq i.teach_backup_count)? 'style="color:red;"' : 'style="color:#e55832"'}>${i.teach_backup_join_count}</span> / ${i.teach_backup_count})
								</span>
								</c:if>
								</dd>
								<c:if test="${i.server_file_name ne null and i.server_file_name ne '' }">
								<!-- <dd class="con">강의계획서 : <a style="color:#00f" href="download/${i.homepage_id}/${i.group_idx}/${i.category_idx}/${i.teach_idx}.do"><i class="fa fa-floppy-o"></i> <%--${i.plan_file_name}--%></a>
								</dd> -->
								</c:if>
							</dl>
						</td>
						<td data-th="정원 및 신청현황" class="visit">
								<!--
								<span><strong>온라인</strong> ${i.teach_limit_count}명 </span>
								<c:if test="${i.teach_offline_count > 0}"><span>, <strong>오프라인</strong> ${i.teach_offline_count}명</span></c:if>
								<c:if test="${i.teach_backup_count > 0}"><span>, ( <strong>후보자</strong> ${i.teach_backup_count}명 )</span></c:if>
								<br/>
								-->
								<span>온라인
									<span ${i.teach_join_count > 0 and (i.teach_join_count eq i.teach_limit_count)? 'style="color:red;"' : 'style="color:#e55832"'}>${i.teach_join_count}</span> / ${i.teach_limit_count}<br/>
								</span>
								<c:if test="${i.teach_offline_count > 0}">
								<span>오프라인
									<span ${i.teach_off_join_count > 0 and (i.teach_off_join_count eq i.teach_offline_count)? 'style="color:red;"' : 'style="color:#e55832"'}>${i.teach_off_join_count}</span> / ${i.teach_offline_count}<br/>
								</span>
								</c:if>
								<c:if test="${i.teach_backup_count > 0}">
								<span>(후보자 <span ${i.teach_backup_join_count > 0 and (i.teach_backup_join_count eq i.teach_backup_count)? 'style="color:red;"' : 'style="color:#e55832"'}>${i.teach_backup_join_count}</span> / ${i.teach_backup_count})
								</span>
								</c:if>
								<!--
								<span style="color:red;padding:0;">12</span> / 12</span><br/>
								<span>
									(
									대기자 :
									<span style="color:orange">1</span> / 5
									)
								</span>
								-->
						</td>
						<td data-th="<c:choose><c:when test="${param.searchCate1 eq '16'}">행사기간</c:when><c:when test="${param.searchCate1 eq '17'}">강좌기간</c:when><c:when test="${param.searchCate1 eq '18'}">강좌기간</c:when><c:otherwise>강좌기간</c:otherwise></c:choose>"><span>${i.start_date} <c:if test="${i.start_date ne i.end_date}">~ ${i.end_date}</c:if></span> <br class=''/><span>(
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
																<c:if test="${!status_j.last}">,</c:if>
															</c:forEach>
														)</span><br/><span class="">${i.start_time} ~ ${i.end_time}</span>
						</td>
						<td data-th="접수기간">
							<span class="">${i.start_join_date}&nbsp;${i.start_join_time}&nbsp;&nbsp;~ <br/>${i.end_join_date}&nbsp;${i.end_join_time}</span>
						</td>
						<td data-th="접수상태">
							<c:choose>
								<c:when test="${member.login and (member.loginType eq 'HOMEPAGE') and (not empty i.member_key and i.member_key eq member.seq_no)}">
									<a class="btn btn3 teachBook-btn" keyValue1="${i.homepage_id}" keyValue2="${i.group_idx}" keyValue3="${i.category_idx}" keyValue4="${i.teach_idx}"keyValue5="${i.large_category_idx}" >출석부</a>
								</c:when>
								<c:otherwise>
									<c:choose>
										<c:when test="${i.teach_status eq '0'}">
											<a href="" class="btn btn5 add" keyValue1="${i.homepage_id}" keyValue2="${i.group_idx}" keyValue3="${i.category_idx}" keyValue4="${i.teach_idx}" keyValue5="${i.large_category_idx}" apply_status="1">
											<i class="fa fa-pencil-square-o"></i><span>수강신청 </span></a>
										</c:when>
										<c:when test="${i.teach_status eq '1'}">
											<a href="" class="btn btn2 add" keyValue1="${i.homepage_id}" keyValue2="${i.group_idx}" keyValue3="${i.category_idx}" keyValue4="${i.teach_idx}" keyValue5="${i.large_category_idx}" apply_status="2">
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
											<a href="javascript:void(0);" class="btn" style="cursor: default;border:1px solid #ddd !important;">
											<i class="fa fa-pencil"></i><span>수강종료</span></a>
										</c:when>
										<c:when test="${i.teach_status eq '4'}">
											<a href="javascript:void(0);" class="btn btn6" style="cursor: default;">
											<i class="fa fa-user"></i><span>접수마감</span></a>
										</c:when>
										<c:when test="${i.teach_status eq '5'}">
											<a href="javascript:void(0);" class="btn btn6" style="cursor: default;">
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
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
					</c:forEach>
			</tbody>

			</c:otherwise>
			</c:choose>
		</table>
	</div>
</div>

<div id="dialog-1" class="dialog-common" title="수강생 정보">
</div>