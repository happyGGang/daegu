<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tag" uri="/WEB-INF/config/tld/cmsTag.tld" %>
<link rel="stylesheet" type="text/css" 	href="/resources/common/css/culture-list.css" />
<script type="text/javascript" src="/resources/common/netFunnel/netfunnel.js"></script>
<script type="text/javascript" src="/resources/common/netFunnel/test_skin.js"></script>
<script type="text/javascript">
$(function(){
	$('a.detail-btn').on('click', function(e) {
		var formData = 'menu_idx='+$('#menu_idx').val()+'&homepage_id='+$('#homepage_id_1').val()+'&group_idx='+$(this).attr('keyValue1')+'&category_idx='+$(this).attr('keyValue2')+'&teach_idx='+$(this).attr('keyValue3')+'&large_category_idx='+$(this).attr('keyValue4')
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
		e.preventDefault();
		$('#viewPage').val(1);
		doGetLoad('index.do', serializeCustom($('form#teach')));

	});

	<c:if test="${fn:length(subHomepageList) > 0 or
		(homepage.context_path eq 'beomeo' and teach.searchCate1 eq '17') or
		(homepage.context_path eq 'yonghak' and teach.searchCate1 eq '17') or
		(homepage.context_path eq 'dalseolib' and teach.searchCate1 eq '16') or
		(homepage.context_path eq 'dalseolib' and teach.searchCate1 eq '17') or
		(homepage.context_path eq 'dalseolib' and teach.searchCate1 eq '29')}">
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
	
	$('select#select_status').on('change', function() {
		var v = $(this).val();
		
		if(v == '') {
			$('tbody#teach_list tr').show();
			return false;
		}
		
		v = v.split(',');
		$('tbody#teach_list tr').hide();
		
		for(var i = 0; i < v.length; i++) {
			$('tr.status_' + v[i]).show();
		}
	});
	$('select#sortType').on('change',function(){
		$('#teach #search_text').val('');
		$('#teach #viewPage').val(1);
		doGetLoad('index.do', serializeCustom($('form#teach')));
	});
	$('select#sortField').on('change',function(){
		$('#teach #search_text').val('');
		$('#teach #viewPage').val(1);
		doGetLoad('index.do', serializeCustom($('form#teach')));
	});

});

</script>
<link rel="stylesheet" href="/resources/common/css/teach.css" />
<form

<form:form modelAttribute="teach" action="/${homepage.context_path}/module/teach/student/save.do" method="POST" onsubmit="return false">
<%-- 	<form:hidden path="group_idx"/> --%>
	<form:hidden path="teach_idx"/>
	<form:hidden path="menu_idx"/>
<%-- 	<form:hidden path="category_idx"/> --%>
	<form:hidden path="searchCate1"/>
	<form:hidden id="homepage_id_1" path="homepage_id"/>
<%-- 	<input type="hidden" name="_csrf" value="${CSRF_TOKEN}"/> --%>

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

		<c:when test="${homepage.context_path eq 'dalseolib' and teach.searchCate1 eq '29'}">
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

	<c:if test="${homepage.context_path eq 'bukbu'}">
		<h3>유의사항</h3>
		<ul class="con">
			<li>수강신청시 수강생 정보에는 실제 수업에 참석 하는 사람의 정보를 입력해 주시기 바랍니다. 수강생 정보로 출석부를 작성합니다.</li>
			<li>수강신청 뒤 강의계획서는 도서관 홈페이지 휴관일 및 행사 달력에서 강좌를 선택하여 확인할 수 있습니다.</li>
			<li>첫강좌 무단 불참시 수강제한될 수 있으며, 취소시 대기자 연락을 위해 전화부탁드립니다.</li>
			<li>도서관 주차장이 협소하오니 강의수강시 대중교통을 이용해 주시기 바랍니다.</li>
		</ul>
	</c:if>

	<!-- 범어 > 글로벌문화행사 -->
	<c:if test="${homepage.context_path eq 'beomeo'}">
		<c:choose>
			<c:when test="${param.searchCate1 eq '23'}">
				<div class="roomicon">
					<div class="inner icowrap">
						<span class="ico ico4"></span> <strong>글로벌프로그램 운영 안내</strong>
						<p class="basic_btn">
							<a href="https://library.daegu.go.kr/beomeo/module/teach/index.do?menu_idx=98&searchCate1=16" class="btn_go"> <span>강연신청 바로가기</span> </a>
						</p>
					</div>
				</div>
				<ul class="con">
					<li>글로벌 유스 아카데미(Global Youth Academy)
						<ul class="con2">
							<li>중·고등학생들을 대상으로 다양한 분야의 외국인 교수 및 주제분야 전문가를 초청하여 진행하는 영어강연 프로그램</li>
						</ul>
					</li>
					<li>국제 리더 초청 강연회
						<ul class="con2">
							<li>세계적으로 활동을 펼치고 있는 각 분야의 명사를 초청하여 경험담을 공유하는 프로그램</li>
						</ul>
					</li>
					<li>국제 부모교육 특강
						<ul class="con2">
							<li>국제적 교육방법 및 외국어 ·미래 교육 분야의 전문가에게 듣는 최신 트렌드 및 미래 방향성 강연</li>
						</ul>
					</li>
					<li>유명대학 재학생의 해외대학 진학기(탐방 등)
						<ul class="con2">
							<li>해외 유명대학 재학생들의 진학 성공담 및 관련 정보공유, 실시간 질의응답 프로그램</li>
						</ul>
					</li>
					<li>내 방에서 떠나는 세계여행
						<ul class="con2">
							<li>세계 유명 도시의 역사·문화 등을 만날 수 있는 온라인 실시간 탐방 프로그램</li>
						</ul>
					</li>
					<li>국제인증교육과정(IB)프로그램
						<ul class="con2">
							<li>IB분야의 전문가의 PYP(초등), MYP(중등), DP(고등) 및 IB관련 최신동향 강연</li>
						</ul>
					</li>
					<li>원어민 선생님과 함께하는 범어 어학당
						<ul class="con2">
							<li>유아·성인 대상의 연령별 맞춤형 원어민 영어강좌</li>
						</ul>
					</li>
					<li>영어 독서캠프
						<ul class="con2">
							<li>원어민 선생님과 원서를 활용한 영어 독서캠프</li>
						</ul>
					</li>
					<li>국제 문화교류 프로그램(버디버디)
						<ul class="con2">
							<li>외국인-한국인 매칭 후, 함께 언어·문화를 교류하며 한국문화를 탐방하는 프로그램</li>
						</ul>
					</li>
				</ul>
			</c:when>
			<c:otherwise>
			</c:otherwise>
		</c:choose>
	</c:if>

	<c:choose>
	<c:when test="${homepage.context_path eq 'donggu' || homepage.context_path eq 'seogulib' || homepage.context_path eq 'namdm' ||  homepage.context_path eq 'namic' ||  homepage.context_path eq 'namic' || homepage.context_path eq 'bukgs' || homepage.context_path eq 'bukdh' || homepage.context_path eq 'buktj' || homepage.context_path eq 'beomeo' || homepage.context_path eq 'yonghak' || homepage.context_path eq 'gosan' || homepage.context_path eq 'dalseolib' || homepage.context_path eq 'dalseonglib' || homepage.context_path eq 'junggu' || homepage.context_path eq 'dmsl'}">

	</c:when>
	<c:when test="${homepage.context_path eq 'with' || homepage.context_path eq 'dotory' || homepage.context_path eq 'dongil' ||  homepage.context_path eq 'vision' ||  homepage.context_path eq 'saebut' || homepage.context_path eq 'art' || homepage.context_path eq 'yeonam' || homepage.context_path eq 'daegubraillelibrary' || homepage.context_path eq 'wasabi' || homepage.context_path eq 'handle'}">

	</c:when>
	<c:otherwise>
	<div class="tabmenu tab1">
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
			<div style="margin-bottom:10px;">
				<div class="srch_name_box">
					<form:select path="search_type" cssClass="selectmenu new_select_box">
						<form:option value="teach_name">
						<c:choose>
							<c:when test="${param.searchCate1 eq '16'}">행사명</c:when>
							<c:when test="${param.searchCate1 eq '17'}">강좌명</c:when>
							<c:when test="${param.searchCate1 eq '18'}">강좌명</c:when>
							<c:otherwise>강좌명</c:otherwise>
						</c:choose>
						</form:option>
					</form:select>
					<p class="m_br"></p>
					<form:input path="search_text" cssClass="text new_text01"/>
				</div>
				<div class="srch_category_box">
					<p style="height:2px;"></p>
					<span>접수상태 :</span>
					<select id="select_status" class="new_select_box">
						<option class="all" label="선택" />
						<option value="0" label="수강신청" />
						<option value="1" label="대기자신청" />
						<option value="2,10" label="신청완료" />
						<option value="3" label="대기자신청완료" />
						<option value="4" label="접수마감" />
						<option value="5" label="정원마감" />
						<option value="6" label="신청대기" />
						<option value="9" label="수강종료" />
					</select>
					<p class="m_br"></p>
					<span>중분류 :
						<form:select path="group_idx" cssClass="new_select_box">
							<form:option class="all" value="0" label="전체" />
							<form:options itemValue="group_idx" itemLabel="group_name" items="${categoryGroupList}"/>
						</form:select>
					</span>
					<p class="m_br"></p>
					<span class="ml10">소분류 :
						<form:select path="category_idx" cssClass="new_select_box">
							<form:option class="all" value="0" label="전체" />
							<c:forEach items="${categoryList}" var="i">
								<form:option class="group_${i.group_idx}" value="${i.category_idx}">${i.category_name}</form:option>
							</c:forEach>
						</form:select>
					</span>
					<p class="m_br"></p>
					<a href="#" class="btn btn1" id="search_btn"><i class="fa fa-search"></i><span>검색</span></a>
				</div>

				<div class="srch_category_box" >
					<span class="ml10"> 정렬 기준 :
					<form:select path="sortField" cssClass="new_select_box">
						<form:option value="">전체</form:option>
						<form:option value="start_join_date">접수시작일</form:option>
						<form:option value="end_join_date">접수종료일</form:option>
					</form:select>
						<p class="m_br"></p>
					<form:select path="sortType" cssClass="new_select_box">
						<form:option value="">정렬기준</form:option>
						<form:option value="ASC">오름차순</form:option>
						<form:option value="DESC">내림차순</form:option>
					</form:select>
					</span>
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

<c:if test="${homepage.context_path eq 'namdm' || homepage.context_path eq 'namic'}">
	<p style="color:#ff0000;font-weight:bold;text-align:center;font-size:17px;padding-top:10px;">
		※ 무단 결석 시에는 추후 프로그램 신청이 제한될 수 있습니다.
	</p>
</c:if>

<div style="text-align: right; margin-bottom: 10px; ">
	<a href="anonyApplyCheck.do?homepage_id=${fn:escapeXml(teach.homepage_id)}&menu_idx=${fn:escapeXml(param.menu_idx)}" class="btn btn1" style="font-size:14px;">비회원 신청확인</a>
</div>

<c:if test="${homepage.context_path eq 'junggu'}">
	<c:if test="${param.menu_idx eq '32'}">
		<c:if test="${param.homepage_id eq 'h74' || param.homepage_id eq '' || param.homepage_id eq null }">
			<c:if test="${param.searchCate1 eq '17'}">
				<p style="color:#ff0000;font-weight:bold;text-align:left;margin-left:10px;margin-bottom:30px;font-size:18px;">
					※ “직전분기 수강이력 없는 신청자 우선 수강” 기준이 적용됩니다.<br />
					<span style="color:#000;">따라서 수강신청 시 확인되는 순위는 접수 순서이며,<br />신청기간이 종료된 후 7일 이내 최종 확정 여부를 개별 문자로 안내드릴 예정이오니 양해 부탁드립니다.</span>
				</p>
			</c:if>
		</c:if>
	</c:if>
</c:if>

<!-- <c:if test="${homepage.context_path eq 'dalseolib'}">
	<p style="color:#ff0000;font-weight:bold;font-size:16px;">
		* 단계적 일상회복 1차 개편에 따라 도서관 백신패스 의무화되었습니다.<br />
		<p style="color:#555;font-size:14px;font-weight:normal;margin:5px 0 20px 10px;">
		- 접종완료자 및 완치자(6개월 이내), PCR 음성확인자(48시간 이내)<br />
		- 18세 이하인 자('22년부터는 11세 이하)(등본확인필요)<br />
		- 접종불가자(진단서 및 증명서 필요)
		</p>
	</p>
</c:if> -->

<c:if test="${homepage.context_path eq 'dalseolib'}">
	<c:if test="${param.menu_idx eq '32'}">
		<c:if test="${param.homepage_id eq 'h66'}">
			<p style="margin:20px 0;font-size:15px;">
				겨울학기 &lt;스토리텔링&성인동화구연&gt;, &lt;생각이 크는 어린이 인문학&gt;은 강사포기로 인하여 휴강하여 접수가 되지 않습니다.<br />많은 양해바랍니다.
			</p>
		</c:if>
	</c:if>
</c:if>

<div class="op_wrap">
	<div class="smain">
		<table class="list01 rwd-table" summary="문화행사신청 게시물. 본 데이터표는 8컬럼, 10로우로 구성되어 있습니다. 각 로우는 번호, 분류,  제목,   등록자, 등록일, 조회로 구성되어 있습니다." cellspacing="0" cellpadding="0" border="0">
			<caption>문화행사신청 목록 페이지</caption>
			<!-- <colgroup>
			<col />
			<col width="15%" />
			<col width="25%"/>
			<col width="20%" />
			<col width="10%" />
			</colgroup> -->
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
			<tbody id="teach_list">
					
					<c:forEach items="${teachList}" var="i">
					<tr class="status_${i.teach_status}">
						<td data-th="제목" class="title left" style="padding-left:5px;">
							<dl>
								<dd><span class="ca ty2">${i.group_name}</span></dd>
								<dt class="title">
									<a href="#" title="강좌 상세정보 보기" class="detail-btn" keyValue1="${i.group_idx}" keyValue2="${i.category_idx}" keyValue3="${i.teach_idx}" keyValue4="${i.large_category_idx}">
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
								<span>(대기자 <span ${i.teach_backup_join_count > 0 and (i.teach_backup_join_count eq i.teach_backup_count)? 'style="color:red;"' : 'style="color:#e55832"'}>${i.teach_backup_join_count}</span> / ${i.teach_backup_count})
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
								<c:if test="${i.teach_backup_count > 0}"><span>, ( <strong>대기자</strong> ${i.teach_backup_count}명 )</span></c:if>
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
								<span>(대기자 <span ${i.teach_backup_join_count > 0 and (i.teach_backup_join_count eq i.teach_backup_count)? 'style="color:red;"' : 'style="color:#e55832"'}>${i.teach_backup_join_count}</span> / ${i.teach_backup_count})
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
						<td data-th="<c:choose><c:when test="${param.searchCate1 eq '16'}">행사기간</c:when><c:when test="${param.searchCate1 eq '17'}">강좌기간</c:when><c:when test="${param.searchCate1 eq '18'}">강좌기간</c:when><c:otherwise>강좌기간</c:otherwise></c:choose>">
							<span>${i.start_date} <c:if test="${i.start_date ne i.end_date}">~ ${i.end_date}</c:if></span>
							<br class=''/>
							<span>
							(
							<c:choose>
								<c:when test="${i.teach_day_yn eq 'Y'}">${i.teach_day_txt}</c:when>
								<c:otherwise>
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
								</c:otherwise>
							</c:choose>
							)
							</span>
							<br/>
							<span class="">${i.start_time} ~ ${i.end_time}</span>
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
											<a href="" class="btn btn1 add" keyValue1="${i.homepage_id}" keyValue2="${i.group_idx}" keyValue3="${i.category_idx}" keyValue4="${i.teach_idx}" keyValue5="${i.large_category_idx}" apply_status="2">
											<i class="fa fa-pencil-square-o"></i><span>대기자신청</span></a>
										</c:when>
										<c:when test="${i.teach_status eq '2' or i.teach_status eq '10'}">
											<a href="/${homepage.context_path}/module/teach/applyList.do?menu_idx=${myTeachListMenuIdx}" class="btn btn2">
											<i class="fa fa-circle-o"></i><span>신청완료</span></a>
										</c:when>
										<c:when test="${i.teach_status eq '3'}">
											<a href="/${homepage.context_path}/module/teach/applyList.do?menu_idx=${myTeachListMenuIdx}" class="btn btn2">
											<i class="fa fa-circle-o"></i><span>대기자<br />신청완료</span></a>
										</c:when>
										<c:when test="${i.teach_status eq '9'}">
											<a href="javascript:void(0);" class="btn btn6" style="cursor: default;">
											<i class="fa fa-pencil"></i><span>수강종료</span></a>
										</c:when>
										<c:when test="${i.teach_status eq '4'}">
											<a href="javascript:void(0);" class="btn btn8" style="cursor: default;">
											<i class="fa fa-user"></i><span>접수마감</span></a>
										</c:when>
										<c:when test="${i.teach_status eq '5'}">
											<a href="javascript:void(0);" class="btn btn8" style="cursor: default;">
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