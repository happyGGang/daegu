<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" type="text/css" href="/resources/book/search/css/default.css"/>
<script src="/resources/cms/js/vk/vk_popup.js?vk_skin=flat_gray&vk_layout=ZW Shona"></script>
<script type="text/javascript">
var authorViewPage = 1;
var authorTotalCnt = '${fn:escapeXml(result.totalCnt)}';
var publisherViewPage = 1;
var publisherTotalCnt = '${fn:escapeXml(result.totalCnt)}';
var formCodeViewPage = 1;
var formCodeTotalCnt = '${fn:escapeXml(result.totalCnt)}';
var yearViewPage = 1;
var yearTotalCnt = '${fn:escapeXml(result.totalCnt)}';

$(function() {
	var ua = window.navigator.userAgent;
	var msie = ua.indexOf("MSIE ");

	if (msie > 0 || !!navigator.userAgent.match(/Trident.*rv\:11\./))  // If Internet Explorer, return version number
	{
// 	    alert(parseInt(ua.substring(msie + 5, ua.indexOf(".", msie))));
	}
	else  // If another browser, return 0
	{
		$('div#printMsg').hide();
		$('div#btn_print_div').hide();
	}

	$('#do-search').on('click', function(e) {
		if ($('#librarySearch input#search_text').val() == '') {
			alert('검색어를 입력해주세요');
			$('#librarySearch input#search_text').focus();
			return false;
		}
		if (!$('input#sub_search1').is(':checked')) {
			$('form#librarySearch input#allBookListStr').val('');
		}
		$('input#search_type2').val($('select#search_type option:selected').val());
		$('#librarySearch').submit();
// 		$('#search_type').val('SEARCH');
// 		$('#librarySearch').submit();
		//doGetLoad('search.do', serializeCustom($('#librarySearch')));
	});

// 	$('a.doSearchType').on('click', function(e) {
// 		$('#viewPage').val(1);
// 		$('#search_type').val($(this).attr('keyValue'));
// 		loadIndex();
// 		e.preventDefault();
// 	});

	$('a.doSearchYear').on('click', function(e) {
		$('#search_type2').val($(this).attr('keyValue1'));
		$('#search_year').val($(this).attr('keyValue2'));
		loadIndex();
		e.preventDefault();
	});

// 	$('a.doSearchLibrary').on('click', function(e) {
// 		$('div#libraryList input:checkbox').prop('checked', false);
// 		$('div#libraryList input#lib_'+$(this).attr('keyValue2')).prop('checked', true);
// 		$('#search_type').val($(this).attr('keyValue1'));
// 		$('#search_library').val($(this).attr('keyValue2'));
// 		loadIndex();
// 		e.preventDefault();
// 	});

	$('a.doSearchFormCode').on('click', function(e) {
		$('#search_type2').val($(this).attr('keyValue1'));
		$('#search_form_code').val($(this).attr('keyValue2'));
		loadIndex();
		e.preventDefault();
	});

	$('a.doSearchWriter').on('click', function(e) {
		$('#search_type2').val($(this).attr('keyValue1'));
		$('#search_athor').val($(this).attr('keyValue2'));
		loadIndex();
		e.preventDefault();
	});

	$('a.doSearchPublisher').on('click', function(e) {
		$('#search_type2').val($(this).attr('keyValue1'));
		$('#search_publisher').val($(this).attr('keyValue2'));
		loadIndex();
		e.preventDefault();
	});

// 	$('a.doSearchPform').on('click', function(e) {
// 		$('#search_type').val($(this).attr('keyValue1'));
// 		$('#search_form_code').val($(this).attr('keyValue2'));
// 		loadIndex();
// 		e.preventDefault();
// 	});

	$('#vk-popup').on('click', function(e) {
		PopupVirtualKeyboard.toggle('search_text','vk');
	});

	$('#checkAll').change(function(e) {
		$('div#libraryList input:checkbox').prop('checked', $(this).prop('checked'));
	});

	$('#checkAllBook').change(function(e) {
		$('input.checkBook').prop('checked', $(this).prop('checked'));
	});

	$('li.li-group a.bi').on('click', function() {
		$(this).parent('li').toggleClass('active');
	});

	$('a#addMyLib').on('click', function(e) {
		e.preventDefault();
		var len = $('input.checkBook:checked').length;
		if (len < 1) {
			alert('선택된 책이 없습니다.');
			return false;
		}
		//TODO
		alert('준비중입니다');
		//내 보관함 이동.
	});

	// No 'Access-Control-Allow-Origin' header is present on the requested resource. Origin 'http://localhost:81' is therefore not allowed access.
	// API 서버에서 추가 작업이 필요함.
	/* function AutoFill(){
		$.ajax({
	        type:'GET',
	        url:'${fn:escapeXml(liboneApiUrl)}',
	        data:'cmd=GETAUTOFILL&searchKeyword=어린',
	        success:function(response){
	            console.log(response);
	        },
	        error:function(e){
	            alert(e.responseText);
	        }
	    });
	} */

// 	$('#librarySearch #search_text').on('keyup',function(e){
// 		 switch (e.keyCode) {
//         case 8:  // Backspace
//         case 9:  // Tab
//         case 13: // Enter
//         case 37: // Left
//         case 38: // Up
//         case 39: // Right
//         case 40: // Down
//         break;

//         default:
//        	 $.ajax({
//     	        type:'GET',
//     	        async:true,
//     	        url:'autoFill.do',
//     	        data:'searchKeyword='+encodeURIComponent($(this).val()),
//     	        success:function(response){
//     	        	var autofillArr = response.autofillArr;
//     	        	var autoFillStr = [];
//     	        	$.each(autofillArr, function(i, v) {
//     	        		autoFillStr.push('<a class="autoText">' + v.word + '</a>');
//     	        	});
//     	            $('#autoFill').html(autoFillStr.join(','));
//     	            $('a.autoText').on('click', function(e) {
//     	            	e.preventDefault();
//     	            	$('#librarySearch #search_text').val($(this).text());
//     	            	$('#librarySearch #do-search').click();
//     	            });
//     	        },
//     	        error:function(e){
//     	        }
//     	    });
//     	}
// 	});
	$('a.showSlide').on('click', function(e) {
		e.preventDefault();
		var bci = $(this).parents('div.bif').next('div.bci');
		var toggleState = $(bci).is(':hidden');
		if (toggleState) {
			$(bci).load('index_detail.do?vLoca='+$(this).attr('vLoca')+'&vCtrl='+$(this).attr('vCtrl'), function() {
				$(bci).slideToggle();
			});
		} else {
			$(bci).slideToggle();
		}
	});

	$('a.goDetail').on('click', function(e) {
		e.preventDefault();
		<c:if test="${librarySearch.booktype eq 'BOOK'}">
		$('input#isbn').val($(this).attr('isbn'));
		$('input#manageCode').val($(this).attr('manageCode'));
		$('input#regNo').val($(this).attr('regNo'));

		var formData = serializeParameter(['regNo', 'isbn', 'manageCode']);
		formData += '&booktype=' + $('input[type=radio][name=booktype]:checked').val();
		doGetLoad('detail.do', formData);
		</c:if>

		<c:if test="${librarySearch.booktype eq 'NONBOOK'}">
		alert('비도서자료는 상세보기를 하실 수 없습니다.');
		return false;
		</c:if>
	});

	if ($('input#viewPage').val() != '1') {
		jQuery.ajaxSettings.traditional = true;
		var param = serializeObject($('#librarySearch'));
		var param2 = serializeObject($('#searchTableForm'));
		loadIndex('table');
	}

	function loadIndex() {
		jQuery.ajaxSettings.traditional = true;
		$('input#viewPage').val('1');
		var isSubSearch = $('input#sub_search1').is(':checked');
		$('input#sub_search1').prop('checked', false);
		var param = serializeObject($('#librarySearch'));
		var param2 = serializeObject($('#searchTableForm'));
		$('div#search-results').load('table.do', $.extend(true, param, param2));
		if (isSubSearch) {
			$('input#sub_search1').prop('checked', true);
		}
		$('body').scrollTop(0);
	}

	$('div#hotTrend').load('hotTrend.do');

	$('#btn_print').on('click', function(e) {
		e.preventDefault();
		var checkList = $('#librarySearch input[name="print_param"]:checked').clone();

		if ( checkList.length < 1 ) {
			alert("인쇄할 도서를 선택해주요.");
			return false;
		}


		$('#printForm').append(checkList);
		var param = $('#printForm').serialize();

		jQuery.post('print.do',param,function(arg) {
			$("#print_iframe").contents().find("body").html(arg);
			frames["print_iframe"].focus();

			IEPageSetupX.header="";
			IEPageSetupX.footer="";
			IEPageSetupX.leftMargin=0;
			IEPageSetupX.rightMargin=1.5;
			IEPageSetupX.Orientation = 1.0;
	        IEPageSetupX.PrintBackground = false;
	        IEPageSetupX.topMargin=0.0;
	        IEPageSetupX.bottomMargin=1.0;
			//IEPageSetupX.Clear=true;
			IEPageSetupX.Print(false);//설정

			var loadingImg = '';

	        loadingImg += "<div id='loadingImg' style='position:relative; left:15%; top:0%; display:none; z-index:10000;'>";
	        loadingImg += " <font color='#FF0033' size='5' ><strong>선택한 내용을 인쇄처리중입니다.  잠시만 기다려주세요.</strong></font>";
	        loadingImg += "</div>";

	        $("#print_div").html(loadingImg);
	        //로딩중 이미지 표시
	        $('#loadingImg').show().delay(3000).fadeOut();
	        $('#printForm input:checkbox').remove();
	        $('#librarySearch input[name="print_param"]').prop('checked', false);
		});
	});

        if ('${fn:escapeXml(param.search_type)}'=='') {
                $('select#search_type').val('L_TITLEAUTHOR');
        }

	$('a#sort-btn').on('click', function(e) {
		$('#do-search').click();
	});
});
</script>
<form:form modelAttribute="librarySearch" id="detailForm" action="detail.do" method="post">
	<form:hidden path="menu_idx"/>
	<form:hidden path="vLoca"/>
	<form:hidden path="vCtrl"/>
	<form:hidden path="vImg"/>
	<form:hidden path="isbn"/>
	<form:hidden path="tid"/>
	<form:hidden path="regNo"/>
	<form:hidden path="manageCode"/>
</form:form>

<form:form modelAttribute="librarySearch" action="index.do" method="POST">
	<form:hidden path="allBookListStr" value="${fn:escapeXml(result.allBookListStr)}"/>
	<form:hidden path="search_type2"/>
	<form:hidden path="search_library"/>
	<form:hidden path="search_form_code"/>
	<form:hidden path="search_kdc"/>
	<form:hidden path="search_year"/>
	<form:hidden path="search_athor"/>
	<form:hidden path="search_publisher"/>
	<form:hidden path="menu_idx"/>
	<form:hidden path="viewPage"/>
	<div class="search-wrap">
	<div class="booktype-box">
		<form:radiobutton path="booktype" label="도서" value="BOOK" checked="checked"/>
		<form:radiobutton path="booktype" label="비도서" value="NONBOOK" cssStyle="margin-left:28px;"/>
		</div>
		<div id="libraryList" class="bbs-notice" style="margin-bottom:15px;" >
			<div>
				<form:checkbox id="checkAll" path="libraryCodes" label="전체" value="ALL"  />
			</div>
			<div>
				<ul>
					<c:forEach items="${homepageList}" var="i">
						<li>
							<c:choose>
								<c:when test="${fn:indexOf(librarySearch.libraryCodes, i.homepage_code)!= -1 or fn:indexOf(librarySearch.libraryCodes, 'ALL') != -1}">
									<form:checkbox searched="true" path="libraryCodes" label="${i.homepage_name}" value="lib_${i.homepage_code}" checked="checked"/>
								</c:when>
								<c:otherwise>
									<form:checkbox id="lib_${i.homepage_code}" path="libraryCodes" label="${i.homepage_name}" value="lib_${i.homepage_code}" />
								</c:otherwise>
							</c:choose>
						</li>
					</c:forEach>
				</ul>
			</div>
		</div>

		<c:if test="${librarySearch.search_text ne null and librarySearch.search_text ne ''}">
		<div>
			<form:checkbox path="sub_search" label="검색결과 내 재검색"/>
		</div>
		</c:if>

		<div class="search-form">

			<div class="box">

			<div class="box1">
				<form:select path="search_type" class="selectmenu" cssStyle="width:100%;margin-top:2px;font-size:105%;padding-left:3px;">
					<form:option value="L_TITLE">서명</form:option>
					<form:option value="L_AUTHOR">저자</form:option>
					<form:option value="L_PUBLISHER">발행자</form:option>
					<form:option value="L_KEYWORD">키워드</form:option>
				</form:select>
			</div>
				<span><img src="/resources/book/search/img/line.jpg" style="padding-top: 5px;"></span>
				<div class="b1">
					<form:input htmlEscape="true" path="search_text" type="text" class="text2" placeholder="검색어를 입력하세요." onfocus="PopupVirtualKeyboard.attachInput(this)" cssStyle="ime-mode:active;"/>
				</div>
				<div class="b2">
					<button id="do-search"><i class="fa fa-search"></i><span class="blind">검색</span></button>
				</div>
			</div>
			<br/>
			<div id="autoFill">
			</div>
			<p style="height:auto">
			  <a id="vk-popup" class="btn" style="line-height:140%">
			    <i class="fa fa-keyboard-o" style="font-size:19px;color:#777"></i><span>외국어입력기</span>
			  </a>
			</p>
		</div>
		<br/>
		<div id="libraryList" class="bbs-notice" style="margin-bottom:20px; display: none;" >
			<div>
			<form:checkbox id="checkAll" path="libraryCodes" label="전체" value="ALL" />
			</div>
			<div>
				<ul>
					<c:forEach items="${libraryList.data}" var="i">
						<li style="display: inline-block; margin-right: 5px;">
						<c:choose>
							<c:when test="${i.lib_manage_code eq '00000001'}">
								<form:checkbox id="lib_${i.lib_manage_code}" searched="true" path="libraryCodes" label="${fn:escapeXml(i.lib_name)}" value="${fn:escapeXml(i.lib_manage_code)}" checked="checked"/>
							</c:when>
							<c:when test="${fn:indexOf(librarySearch.libraryCodes, i.lib_manage_code)!= -1 or fn:indexOf(librarySearch.libraryCodes, 'ALL') != -1}">
								<form:checkbox id="lib_${fn:escapeXml(i.lib_manage_code)}" searched="true" path="libraryCodes" label="${fn:escapeXml(i.lib_name)}" value="${fn:escapeXml(i.lib_manage_code)}" checked="checked"/>
							</c:when>
							<c:otherwise>
								<form:checkbox id="lib_${fn:escapeXml(i.lib_manage_code)}" path="libraryCodes" label="${fn:escapeXml(i.lib_name)}" value="${fn:escapeXml(i.lib_manage_code)}" />
							</c:otherwise>
						</c:choose>
						</li>
					</c:forEach>
				</ul>
			</div>
		</div>
		<div class="search-info" >
			<c:if test="${result.code eq '0000'}">
				검색결과 '<b class="og"><i>${fn:escapeXml(librarySearch.search_text)}</i></b>'에 대한 <b>${fn:escapeXml(librarySearch.viewPage)}</b>/${fn:escapeXml(result.totalPage)}페이지, 총 <b>${fn:escapeXml(result.totalCnt)}</b>건
			</c:if>
		</div>
		<c:set var="showSmain" value="${not empty librarySearch.search_text}"></c:set>
		<c:if test="${fn:length(result.data) < 1 and showSmain}">
		<p style="text-align: center;">
			<b>찾으시는 자료가 없습니다. </b>
		</p>
		</c:if>
		<div class="smain">
			<div class="box"<c:if test="${!showSmain}">style="display: none;"</c:if>>
				<div class="ws-toolbar">
					<div class="checkbox">
						<input type="hidden" name="" value="on"/>
						<input id="checkAllBook" name="" type="checkbox" value="Y"/>
						<label for="checkAllBook">전체</label>
					</div>

					<div class="control">
						<form:select path="sortField" cssClass="selectmenu" cssStyle="width: 90px;">
							<form:option value="NONE" label="정렬없음"></form:option>
							<form:option value="TITLE" label="서명"></form:option>
							<form:option value="AUTHOR" label="저자"></form:option>
							<form:option value="PUBLISHER" label="출판사"></form:option>
							<form:option value="PUB_YEAR" label="발행년도"></form:option>
							<form:option value="SHELF_DATE" label="배가일"></form:option>
						</form:select>
						<form:select path="sortType" cssClass="selectmenu" cssStyle="width: 90px;">
							<form:option value="ASC" label="오름차순"></form:option>
							<form:option value="DESC" label="내림차순"></form:option>
						</form:select>
						<form:select path="rowCount" cssClass="selectmenu" cssStyle="width:70px;">
							<form:option value="10" label="10건"></form:option>
							<form:option value="20" label="20건"></form:option>
							<form:option value="30" label="30건"></form:option>
							<form:option value="40" label="40건"></form:option>
							<form:option value="50" label="50건"></form:option>
							<form:option value="100" label="100건"></form:option>
						</form:select>
					</div>
				</div>
				<div id="search-results" class="search-results">
					<c:if test="${empty librarySearch.search_text}">
					<div id="loadingLoanBest" style="text-align: center; padding-top: 105px; display: none;" >
						<img id="loading_img" alt="loading" src="/resources/common/img/viewLoading.gif" />
						<br/><br/>
						대출 순위 불러오는 중
					</div>
					</c:if>
					<c:forEach items="${bookSearch}" var="i">
						<div class="row">
							<p class="admin"><input name="print_param" type="checkbox" class="checkBook" value="${i.ST_CODE}_${i.MANAGE_CODE}"/></p>
							<div class="thumb">
								<c:choose>
									<c:when test="${i.IMAGE eq '' or fn:contains(i.IMAGE, 'noimg')}">
										<a href="#" vLoca="${i.LIB_CODE}" vCtrl="${i.rec_key}" vImg="${i.IMAGE}" isbn="${i.ST_CODE}" tid="${i.tid}" regNo="${i.REG_NO}" manageCode="${i.MANAGE_CODE}" class="goDetail noImg">
											<img src="/resources/common/img/noImg.gif" alt="noImage"/>
											<span>등록된 이미지가<br/>없습니다.</span>
										</a>
									</c:when>
									<c:otherwise>
										<a href="#" vLoca="${i.LIB_CODE}" vCtrl="${i.rec_key}" vImg="${i.IMAGE}" isbn="${i.ST_CODE}" tid="${i.tid}" manageCode="${i.MANAGE_CODE}" regNo="${i.REG_NO}" class="goDetail">
											<img src="${i.IMAGE}" alt="${i.TITLE_INFO }"/>
										</a>
									</c:otherwise>
								</c:choose>

								<c:if test="${sessionScope.member.login && sessionScope.member.member_class eq '0'}"> <!--로그인이면서 (0 : 정회원, 1 : 비회원, 2 : 준회원) MA : 북구 , MB 중앙-->
<%-- 									<c:if test="${(i.MANAGE_CODE eq 'MA' and i.MEDIA_CODE eq 'PR' and --%>
<%-- 									 (sessionScope.member.user_class_code eq '105' || --%>
<%-- 									 sessionScope.member.user_class_code eq '106' || sessionScope.member.user_class_code eq '107' || --%>
<%-- 									 sessionScope.member.user_class_code eq '108' || sessionScope.member.user_class_code eq '109' || --%>
<%-- 									 sessionScope.member.user_class_code eq '110' || sessionScope.member.user_class_code eq '111') ) --%>
<%-- 									 or --%>
<%-- 									 (i.MANAGE_CODE eq 'MB' and (i.MEDIA_CODE eq 'PR' or i.MEDIA_CODE eq 'PD') and --%>
<%-- 									 (sessionScope.member.user_class_code eq '201' || --%>
<%-- 									 sessionScope.member.user_class_code eq '202' || sessionScope.member.user_class_code eq '203' || --%>
<%-- 									 sessionScope.member.user_class_code eq '204' || sessionScope.member.user_class_code eq '205' || --%>
<%-- 									 sessionScope.member.user_class_code eq '206')) --%>
<%-- 									 }"> --%>
									<c:if test="${
									 (
									 (i.MANAGE_CODE eq 'MA' and i.MEDIA_CODE eq 'PR') or
									 (i.MANAGE_CODE eq 'MB' and (i.MEDIA_CODE eq 'PR' or i.MEDIA_CODE eq 'PD')) or
									 (i.MANAGE_CODE eq 'MD' and i.MEDIA_CODE eq 'PR')
									 )
									 and
									 (sessionScope.member.user_class_code eq '105' ||
									 sessionScope.member.user_class_code eq '106' || sessionScope.member.user_class_code eq '107' ||
									 sessionScope.member.user_class_code eq '108' || sessionScope.member.user_class_code eq '109' ||
									 sessionScope.member.user_class_code eq '110' || sessionScope.member.user_class_code eq '111' ||
									 sessionScope.member.user_class_code eq '201' ||
									 sessionScope.member.user_class_code eq '202' || sessionScope.member.user_class_code eq '203' ||
									 sessionScope.member.user_class_code eq '204' || sessionScope.member.user_class_code eq '205' ||
									 sessionScope.member.user_class_code eq '206' ||
									 sessionScope.member.user_class_code eq '301' ||
									 sessionScope.member.user_class_code eq '302' ||
									 sessionScope.member.user_class_code eq '303')
									 }">
										<c:choose>
											<c:when test="${i.LIB_CODE eq '123007' and (i.USE_LIMIT_CODE eq 'CD' or i.USE_LIMIT_CODE eq 'IZ')}">
											</c:when>
											<c:when test="${i.LIB_CODE eq '123005' and (i.USE_LIMIT_CODE eq 'CD' or i.USE_LIMIT_CODE eq 'IZ')}">
											</c:when>
											<c:when test="${fn:indexOf(i.CALL_NO, 'R') > -1}">
											</c:when>
											<c:when test="${i.RESERVATION_CNT ne '0'}">
											</c:when>
											<c:otherwise>
											<c:if test="${fn:length(i.RETURN_PLAN_DATE) > 1 }">
											</c:if>
											<c:if test="${fn:length(i.RETURN_PLAN_DATE) < 1 }">
											<a href="#" style="font-size: 15px; margin: 5px 2px 0 0; width:103px;" class="btn btn2 addBasket" data-basket="${i.TITLE_INFO}//${i.AUTHOR}//${i.PUBLISHER}//${i.PUB_YEAR}//${i.LIB_NAME}//${i.SHELF_LOC_NAME}//${i.MAT_CODE}//${i.ST_CODE}//${i.BOOK_SIZE}//${i.PRICE}//${i.BOOK_KEY}//${librarySearch.booktype eq 'BOOK' ? 'MO' : 'NB'}//${i.MANAGE_CODE}" ><i class="fa fa-archive"></i><span>택배대출<br/>보관함 추가</span></a>
											</c:if>
											</c:otherwise>
										</c:choose>
									</c:if>
								</c:if>
								<c:if test="${sessionScope.member.member_id eq 'whale1'}">
									<a href="#" style="font-size: 15px; margin: 5px 2px 0 0; width:103px;" class="btn btn2 addBasket" data-basket="${i.TITLE_INFO}//${i.AUTHOR}//${i.PUBLISHER}//${i.PUB_YEAR}//${i.LIB_NAME}//${i.SHELF_LOC_NAME}//${i.MAT_CODE}//${i.ST_CODE}//${i.BOOK_SIZE}//${i.PRICE}//${i.BOOK_KEY}//${librarySearch.booktype eq 'BOOK' ? 'MO' : 'NB'}//${i.MANAGE_CODE}" ><i class="fa fa-archive"></i><span>택배대출<br/>보관함 추가</span></a>
								</c:if>
							</div>
							<div class="box">
								<div class="item">
									<div class="bif">
										<c:set var="replaceStr" value="<span style='color:#ffa651'>${librarySearch.search_text}</span>"/>
										<a href="#" vLoca="${i.LIB_CODE}" vCtrl="${i.rec_key}" vImg="${i.IMAGE}" isbn="${i.ST_CODE}" tid="${i.tid}" regNo="${i.REG_NO}" manageCode="${i.MANAGE_CODE}" class="name goDetail">${fn:replace(i.TITLE_INFO , librarySearch.search_text, replaceStr)}</a>
										<p><font style="color:#91b015">저자명</font> : ${fn:replace(i.AUTHOR , librarySearch.search_text, replaceStr)}</p>
										<p><font style="color:#91b015">발행자</font> : ${fn:replace(i.PUBLISHER, librarySearch.search_text, replaceStr)}, ${i.PUB_YEAR}</p>
										<p><font style="color:#91b015">소장처</font> : ${i.LIB_NAME} / ${i.SHELF_LOC_NAME}</p>
										<p><font style="color:#91b015">청구기호</font> : ${i.CALL_NO}</p>
										<p><font style="color:#91b015">등록번호</font> : ${i.REG_NO}</p>
										<c:if test="${i.APPENDIX_TOTAL_CNT > 0}">
										<p><font style="color:#91b015">부록여부</font> : 부록있음
											<c:if test="${not empty i.APPENDIX_INFO}">
												<c:forEach items="${i.APPENDIX_INFO}" var="appendix_info">
													(${appendix_info.DESCRIPTION})
												</c:forEach>
											</c:if>
										</p>
										</c:if>
										<!--
										<div class="stat">
											<a href="#" class="showSlide" vLoca="${i.LIB_CODE}" ><span>이용가능여부</span><i class="fa fa-sort-down"></i></a>
										</div>
										-->

										<!--
										<p><font style="color:#91b015">대출가능여부</font> :
												<c:choose>
													<c:when test="${i.RESERVATION_CNT > 1}">
															<c:if test="${fn:length(i.RETURN_PLAN_DATE) > 1 }">
															대출불가
															</c:if>
															<c:if test="${fn:length(i.RETURN_PLAN_DATE) < 1 }">
															대출가능
															</c:if>
													</c:when>
													<c:otherwise>
															<c:if test="${fn:length(i.RETURN_PLAN_DATE) > 1 }">
															대출불가
															</c:if>
															<c:if test="${fn:length(i.RETURN_PLAN_DATE) < 1 }">
															대출가능
															</c:if>
													</c:otherwise>
												</c:choose>
										/ <font style="color:#91b015">반납예정일</font> :
												<c:if test="${fn:length(i.RETURN_PLAN_DATE) < 1 }">
													-
												</c:if>
												<c:if test="${fn:length(i.RETURN_PLAN_DATE) > 1 }">
													${i.RETURN_PLAN_DATE}
												</c:if>
										</p>
										<p><font style="color:#91b015">예약가능여부</font> :
										<c:choose>
											<c:when test="${i.RESERVATION_CNT eq i.RESERVATION_NUMBER}">
												예약불가(${i.RESERVATION_CNT}/${i.RESERVATION_NUMBER})
											</c:when>
											<c:otherwise>
												<c:if test="${i.RESERVATION_STATUS eq '1'}">
													<c:if test="${i.MEDIA_CODE eq 'PR'}">
													<a class="btn resve-req og" bookkey="${i.BOOK_KEY}" booktype="BO">예약가능</a> (${i.RESERVATION_CNT}/${i.RESERVATION_NUMBER})
													</c:if>
												</c:if>
												<c:if test="${i.RESERVATION_STATUS eq '0'}">
													예약불가(${i.RESERVATION_CNT}/${i.RESERVATION_NUMBER})
												</c:if>
											</c:otherwise>
										</c:choose>
										</p>
										-->
										<c:if test="${librarySearch.booktype eq 'NONBOOK'}">
										<p><font style="color:#91b015">자료실명</font> : ${i.SHELF_LOC_NAME}</p>
										<p><font style="color:#91b015">줄거리</font> : ${i.NONBOOK_SUMMARY}</p>
										</c:if>
										<table summary="도서 상태 및 등록 정보" style="text-align:center;margin-top:7px">
										<caption>도서 상태 및 등록 정보</caption>
										<colgroup>
											<col width="25%">
											<col width="25%">
											<col width="25%">
											<col width="25%">
										</colgroup>
										<thead>
											<tr>
												<th>대출가능여부</th>
												<th>반납예정일</th>
												<th>상호대차</th>
												<th>예약가능여부</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td>
													<c:choose>
														<c:when test="${i.LIB_CODE eq '123010' and (i.USE_LIMIT_CODE eq 'CD' or i.USE_LIMIT_CODE eq 'IZ')}">
															<!-- 연수 대출불가설정 -->
															대출불가(대출제한자료)
														</c:when>
														<c:when test="${i.LIB_CODE eq '123007' and (i.USE_LIMIT_CODE eq 'CD' or i.USE_LIMIT_CODE eq 'IZ')}">
															<!-- 화도진 대출불가설정 -->
															대출불가(대출제한자료)
														</c:when>
														<c:when test="${i.LIB_CODE eq '123009' and (i.USE_LIMIT_CODE eq 'CD' or i.USE_LIMIT_CODE eq 'IZ')}">
															<!-- 계양 대출불가설정 -->
															대출불가(대출제한자료)
														</c:when>
														<c:when test="${fn:indexOf(i.CALL_NO, 'R') > -1}">
															<!-- 청구기호 R이 포함되면 대출불가 -->

															<c:choose>
																<c:when test="${fn:indexOf(i.CALL_NO, 'TR') > -1}">
																	<font style="color:#91b015">대출가능<c:if test="${i.BOOK_STATUS eq '1'}">(비치중)</c:if></font>
																</c:when>
																<c:otherwise>
																	대출불가
																</c:otherwise>
															</c:choose>

														</c:when>
														<c:when test="${i.RESERVATION_CNT ne '0'}">
															대출불가(예약자료)
														</c:when>
														<c:otherwise>
																<c:if test="${fn:length(i.RETURN_PLAN_DATE) > 1 }">
																	대출불가<c:if test="${i.BOOK_STATUS eq '0'}">(대출중)</c:if>
																</c:if>
																<c:if test="${fn:length(i.RETURN_PLAN_DATE) < 1 }">
																	<c:choose>
																		<c:when test="${i.WORKING_STATUS eq 'BOL112N' or i.WORKING_STATUS eq 'SEL212N'}">
																			<font style="color:#91b015">대출가능<c:if test="${i.BOOK_STATUS eq '1'}">(비치중)</c:if></font>
																		</c:when>
																		<c:otherwise>
																			대출불가<c:if test="${i.BOOK_STATUS eq '0'}">(대출중)</c:if>
																		</c:otherwise>
																	</c:choose>
																</c:if>
														</c:otherwise>
													</c:choose>
												</td>
												<td>
													<c:if test="${fn:length(i.RETURN_PLAN_DATE) < 1 }">
														-
													</c:if>
													<c:if test="${fn:length(i.RETURN_PLAN_DATE) > 1 }">
														${i.RETURN_PLAN_DATE}
													</c:if>
												</td>
												<td>
															<c:choose>
																<c:when test="${i.MANAGE_CODE eq 'MJ'}">
																</c:when>
																<c:otherwise>
																	<c:choose>
																		<c:when test="${param.booktype eq 'BOOK'}">
																			<c:choose>
																				<c:when test="${i.WORKING_STATUS eq 'BOL112N'}">
																					<c:choose>
																						<c:when test="${i.RESERVATION_CNT eq '0'}">
																							<c:choose>
																								<c:when test="${i.SHELF_LOC_CODE eq 'G000' || i.SHELF_LOC_CODE eq 'G002' || i.SHELF_LOC_CODE eq 'G003' || i.SHELF_LOC_CODE eq 'G006' || i.SHELF_LOC_CODE eq 'G007' || i.SHELF_LOC_CODE eq 'G008' || i.SHELF_LOC_CODE eq 'G009' || i.SHELF_LOC_CODE eq 'G011' || i.SHELF_LOC_CODE eq 'G012' || i.SHELF_LOC_CODE eq 'G022' || i.SHELF_LOC_CODE eq 'G024' || i.SHELF_LOC_CODE eq 'G025' || i.SHELF_LOC_CODE eq 'G026' || i.SHELF_LOC_CODE eq 'G027' || i.SHELF_LOC_CODE eq 'G028' || i.SHELF_LOC_CODE eq 'G029' || i.SHELF_LOC_CODE eq 'G030' || i.SHELF_LOC_CODE eq 'G032' || i.SHELF_LOC_CODE eq 'G033' || i.SHELF_LOC_CODE eq 'G049' || i.SHELF_LOC_CODE eq 'G097' || i.SHELF_LOC_CODE eq 'G098' || i.SHELF_LOC_CODE eq 'G099' || i.SHELF_LOC_CODE eq 'G999' || i.SHELF_LOC_CODE eq 'G050' || i.SHELF_LOC_CODE eq 'G100' || i.SHELF_LOC_CODE eq 'C008'}">

																								</c:when>
																								<c:otherwise>
																									<a href="#sangho" class="sangho btn" isbn="${i.ST_CODE}" manageCode="${i.MANAGE_CODE}" regNo="${i.REG_NO}">상호대차신청</a>
																								</c:otherwise>
																							</c:choose>
																						</c:when>
																						<c:otherwise>

																						</c:otherwise>
																					</c:choose>
																				</c:when>
																				<c:otherwise>
																				</c:otherwise>
																			</c:choose>
																		</c:when>
																		<c:otherwise>
																		</c:otherwise>
																	</c:choose>
																</c:otherwise>
															</c:choose>

												</td>
												<td class="og">
												<c:choose>
													<c:when test="${i.LIB_CODE eq '123010' and (i.USE_LIMIT_CODE eq 'CD' or i.USE_LIMIT_CODE eq 'IZ')}">
														<!-- 연수 예약불가설정 -->
														예약불가
													</c:when>
													<c:when test="${i.LIB_CODE eq '123007' and (i.USE_LIMIT_CODE eq 'CD' or i.USE_LIMIT_CODE eq 'IZ')}">
														<!-- 화도진 예약불가설정 -->
														예약불가
													</c:when>
													<c:when test="${fn:indexOf(i.CALL_NO, 'R') > -1}">
														<!-- 청구기호 R이 포함되면 대출불가 -->
														예약불가
													</c:when>
													<c:when test="${param.booktype eq 'NONBOOK'
															and (i.LIB_CODE ne '123010' and i.MEIDA_CODE ne 'PD')
															and (i.LIB_CODE ne '123006' and i.MEIDA_CODE ne 'PD')
															and (i.LIB_CODE ne '123005' and i.MEIDA_CODE ne 'PD')
															and (i.LIB_CODE ne '123004' and i.MEIDA_CODE ne 'PD')}">
														<!-- 비도서는 예약불가, 연수, 화도진 DVD는 예약가능, 20180228 화도진 DVD제외-->
														<!-- 2018.04.10 중앙(123006) 비도서 예약 가능-->
														<!-- 2018.04.10 주안(123005) 비도서 예약 가능-->
														예약불가
													</c:when>
													<c:when test="${i.RESERVATION_CNT eq i.RESERVATION_NUMBER}">
														<!-- 현재 예약수와 예약최대 수가 같으면 예약불가 -->
														예약불가(${i.RESERVATION_CNT}/${i.RESERVATION_NUMBER})
													</c:when>
													<c:otherwise>
														<!-- 예약수가 다른 경우 현재 대출중인지 여부 확인 -->
														<c:choose>
															<c:when test="${i.RESERVATION_CNT ne '0'}">
																<!-- 대출불가상태일때 -->
																<c:choose>
																	<c:when test="${i.RESERVATION_CNT eq i.RESERVATION_NUMBER}">
																		<!-- 현재 예약수와 예약최대 수가 같으면 예약불가 ex)2/2-->
																		예약불가(${i.RESERVATION_CNT}/${i.RESERVATION_NUMBER})
																	</c:when>
																	<c:otherwise>
																		<!-- 현재 예약수와 예약최대 수가 다으면 예약가능 ex) 1/2 -->
																		<a class="btn resve-req og" bookkey="${i.BOOK_KEY}" booktype="BO">예약가능</a> (${i.RESERVATION_CNT}/${i.RESERVATION_NUMBER})
																	</c:otherwise>
																</c:choose>
															</c:when>
															<c:otherwise>
																<c:choose>
																	<c:when test="${fn:length(i.RETURN_PLAN_DATE) < 1 }">
																		<!-- 대출가능상태일때 반납예정일이 없을 때 예약불가-->
																		예약불가
																	</c:when>
																	<c:otherwise>
																		<!-- 대출가능상태일때 반납예정일이 있을 때 예약가능-->
																		<c:if test="${librarySearch.booktype eq 'BOOK'}">
																		<a class="btn resve-req og" bookkey="${i.BOOK_KEY}" booktype="BO">예약가능</a> (${i.RESERVATION_CNT}/${i.RESERVATION_NUMBER})
																		</c:if>
																		<c:if test="${librarySearch.booktype eq 'NONBOOK'}">
																		<a class="btn resve-req og" bookkey="${i.BOOK_KEY}" booktype="BO">예약가능</a> (${i.RESERVATION_CNT}/${i.RESERVATION_NUMBER})
																		</c:if>
																	</c:otherwise>
																</c:choose>
															</c:otherwise>
														</c:choose>
													</c:otherwise>
												</c:choose>
												<!--
													<c:if test="${i.RESERVATION_STATUS eq '1'}">
													<c:if test="${i.MEDIA_CODE eq 'PR'}">
													<a class="btn resve-req og" bookkey="${i.BOOK_KEY}" booktype="BO">예약가능</a>(${i.RESERVATION_CNT}/${i.RESERVATION_NUMBER})
													</c:if>
													</c:if>
													<c:if test="${i.RESERVATION_STATUS eq '0'}">
													예약불가
													</c:if>
												-->
												</td>
											</tr>
										</tbody>
									</table>
									</div>
									<div class="bci" style="display: none;">
										<!-- ajax_area -->
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
					<jsp:include page="/WEB-INF/views/app/cms/common/paging_search.jsp" flush="false" />

					<div style="padding-top:30px ;text-align:right">
						도서 DB 이미지 제공 : 알라딘 인터넷서점(www.aladin.co.kr) <img src="/resources/common/img/aladin_01.png" alt="alandin" align="absmiddle"/>
					</div>
				</div>
				<div id="print_div"  style="height:25px"></div>
			</div>

			<div class="ws-filter" id="hotTrend" style="height: 370px; <c:if test="${fn:length(result.data) < 1 and !showSmain}">clear: both;</c:if>">
				<h4>실시간 검색어 순위</h4>
				<div style="text-align: center; padding-top: 105px;" >
					불러오는 중...
				</div>
			</div>
			<div class="ws-filter" <c:if test="${fn:length(result.data) < 1 or !showSmain}"> style="display: none;"</c:if>>
				<h4>검색결과 제한</h4>
				<ul>

					<li class="li-group active"><a href="" class="bi" onclick="return false;">유형별</a>
						<ul>
							<c:set var="formCnt" value="0"></c:set>
							<c:forEach items="${resultCountByFormCode.arr}" var="j">
								<c:set var="formCnt" value="${fn:escapeXml(j.totcnt)}"></c:set>
								<li><a href="" class="doSearchFormCode" keyValue1="L_FORMCODE" keyValue2="${fn:escapeXml(j.code)}"><span>${fn:escapeXml(j.title)}</span><em>(${fn:escapeXml(j.count)})</em></a></li>
							</c:forEach>
						</ul>
						<c:if test="${formCnt > 5}">
							<p><a href="#" class="moreFormcode">더보기 +</a></p>
						</c:if>
					</li>

					<li class="li-group active"><a href="" class="bi" onclick="return false;">저자별</a>
						<ul>
							<c:set var="authorCnt" value="0"></c:set>
							<c:forEach items="${resultCountByWriter.arr}" var="j">
								<c:set var="authorCnt" value="${fn:escapeXml(j.totcnt)}"></c:set>
								<li><a href="" class="doSearchWriter" keyValue1="L_AUTHORFORM" keyValue2="${fn:escapeXml(j.code)}"><span>${fn:escapeXml(j.title)}</span><em>(${fn:escapeXml(j.count)})</em></a></li>
							</c:forEach>
						</ul>
						<c:if test="${authorCnt > 5}">
							<p><a href="#" class="moreAuthor">더보기 +</a></p>
						</c:if>
					</li>

					<li class="li-group active"><a href="" class="bi" onclick="return false;">출판사</a>
						<ul>
							<c:set var="publisherCnt" value="0"></c:set>
							<c:forEach items="${resultCountByPublisher.arr}" var="j">
								<c:set var="publisherCnt" value="${fn:escapeXml(j.totcnt)}"></c:set>
								<li><a href="" class="doSearchPublisher" keyValue1="L_PUBLISHERFORM" keyValue2="${fn:escapeXml(j.code)}"><span>${fn:escapeXml(j.title)}</span><em>(${fn:escapeXml(j.count)})</em></a></li>
							</c:forEach>
						</ul>
						<c:if test="${publisherCnt > 5}">
							<p><a href="#" class="morePublisher">더보기 +</a></p>
						</c:if>
					</li>

					<li class="li-group active"><a href="" class="bi" onclick="return false;">연도별</a>
						<ul>
							<c:set var="yearCnt" value="0"></c:set>
							<c:forEach items="${resultCountByYear.arr}" var="j">
								<c:set var="yearCnt" value="${fn:escapeXml(j.totcnt)}"></c:set>
								<li><a class="doSearchYear" href="" keyValue1="L_YEAR" keyValue2="${fn:escapeXml(j.title)}"><span>${fn:escapeXml(j.title)}</span><em>(${fn:escapeXml(j.count)})</em></a></li>
							</c:forEach>
						</ul>
						<c:if test="${yearCnt > 5}">
							<p><a href="#" class="moreYear">더보기 +</a></p>
						</c:if>
					</li>
				</ul>
			</div>
		</div>
	</div>
</form:form>
<div id="vk"></div>
<form id="printForm" name="printForm" hidden="hidden">
	<input id="print_cmd_page" name="print_cmd_page" type="hidden" value="INDEX">
</form>
<OBJECT id="IEPageSetupX" classid="clsid:41C5BC45-1BE8-42C5-AD9F-495D6C8D7586" codebase="/resources/common/activeX/IEPageSetupX.cab#version=1,4,0,3" >
	<param name="copyright" value="http://isulnara.com">
	<div id="printMsg"><FONT style='font-family: "굴림", "Verdana"; font-size: 9pt; font-style: normal;'>
	<BR>  인쇄 여백제어 컨트롤이 설치되지 않았습니다.    <a href="/resources/common/activeX/IEPageSetupX.exe"><font color="red">이곳</font></a>을 클릭하여 수동으로 설치하시기 바랍니다.  </FONT>
	</div>
</OBJECT>
