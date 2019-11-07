<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" type="text/css" href="/resources/common/css/fontawesome.min.css"/>
<link rel="stylesheet" type="text/css" href="/resources/common/css/select2.min.css"/>
<link rel="stylesheet" type="text/css" href="/resources/common/css/jquery.mmenu.css"/>
<link rel="stylesheet" type="text/css" href="/resources/common/css/default.css"/>
<link rel="stylesheet" type="text/css" href="/resources/common/css/login.css"/>
<link rel="stylesheet" type="text/css" href="/resources/board/css/default.css"/>
<link rel="stylesheet" type="text/css" href="/resources/book/search/css/default.css"/>
<!--[if lte IE 7]>
<link rel="stylesheet" type="text/css" href="/resources/common/css/fontawesome-ie7.min.css"/>
<![endif]-->
<!--[if lte IE 8]>
<link rel="stylesheet" type="text/css" href="/resources/homepage/geic/css/ie.css"/>
<![endif]-->
<script type="text/javascript" src="/resources/common/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="/resources/common/js/jquery-ui-1.12.0.min.js"></script>
<script type="text/javascript" src="/resources/common/js/jquery-ui-1.12.0-datepicker.min.js"></script>
<script type="text/javascript" src="/resources/common/js/jquery.bxslider.min.js"></script>
<script type="text/javascript" src="/resources/common/js/jquery.mmenu.min.js"></script>
<script type="text/javascript" src="/resources/common/js/default.js"></script>
<script type="text/javascript" src="/resources/common/js/common.js"></script>
<script type="text/javascript" src="/resources/board/js/common.js"></script>
<script type="text/javascript" src="/resources/homepage/geic/js/common.js"></script>
<script type="text/javascript" src="/resources/common/js/kakao.min.js"></script>
<script type="text/javascript">
var authorViewPage = 1;
var authorTotalCnt = '${result.totalCnt}';
var publisherViewPage = 1;
var publisherTotalCnt = '${result.totalCnt}';
var formCodeViewPage = 1;
var formCodeTotalCnt = '${result.totalCnt}';
var yearViewPage = 1;
var yearTotalCnt = '${result.totalCnt}';

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

	<%-- 저자 더 보기 --%>
	$('a.moreAuthor').on('click', function(e) {
		e.preventDefault();
		$.ajax({
			url:'table2.do',
			data:'allBookListStr='+$('input#allBookListStr').val() + '&viewPage=' + (authorViewPage+1),
			type:'post',
			success:function(html) {
				$('a.moreAuthor').parent('p').prev('ul').append(html);
				authorViewPage++;
				if ((authorViewPage*5) > authorTotalCnt) {
					$('a.moreAuthor').hide();
				}
			}
		});
	});
	<%-- 출판사 더 보기 --%>
	$('a.morePublisher').on('click', function(e) {
		e.preventDefault();
		$.ajax({
			url:'table3.do',
			data:'allBookListStr='+$('input#allBookListStr').val() + '&viewPage=' + (publisherViewPage+1),
			type:'post',
			success:function(html) {
				$('a.morePublisher').parent('p').prev('ul').append(html);
				publisherViewPage++;
				if ((publisherViewPage*5) > publisherTotalCnt) {
					$('a.morePublisher').hide();
				}
			}
		});
	});

	<%-- 유형 더 보기 --%>
	$('a.moreFormcode').on('click', function(e) {
		e.preventDefault();
		$.ajax({
			url:'table5.do',
			data:'allBookListStr='+$('input#allBookListStr').val() + '&viewPage=' + (formcodeViewPage+1),
			type:'post',
			success:function(html) {
				$('a.moreFormcode').parent('p').prev('ul').append(html);
				formcodeViewPage++;
				if ((formcodeViewPage*5) > formcodeTotalCnt) {
					$('a.moreFormcode').hide();
				}
			}
		});
	});

	<%-- 연도 더 보기 --%>
	$('a.moreYear').on('click', function(e) {
		e.preventDefault();
		$.ajax({
			url:'table4.do',
			data:'allBookListStr='+$('input#allBookListStr').val() + '&viewPage=' + (yearViewPage+1),
			type:'post',
			success:function(html) {
				$('a.moreYear').parent('p').prev('ul').append(html);
				yearViewPage++;
				if ((yearViewPage*5) > yearTotalCnt) {
					$('a.moreYear').hide();
				}
			}
		});
	});

	$('#vk-popup').on('click', function(e) {
		PopupVirtualKeyboard.toggle('search_text','vk');
	});

	$('#toggleLibList').on('click', function(e) {
		$('div#libraryList').slideToggle(function() {
			if (!$('div#libraryList').is(':visible')) {
				$('div#libraryList input:checkbox').prop('checked', false);
				$('div#libraryList input:checkbox[searched=true]').prop('checked', true);
			}
		});
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
			alert('선택된 도서가 없습니다.');
			return false;
		}

		var checkList = $('#librarySearch input[name="print_param"]:checked').clone();
		$('#storageReqForm').append(checkList);
		$('#storageReqForm input').attr('name', 'strList');
		window.open("/${homepage.context_path}/module/myStorage/viewStorage.do?"+serializeCustom($('form#storageReqForm')), "", "width=350, height=350");
		//내 보관함 이동.
	});

	$('select#rowCount').on('change', function() {
		$('#do-search').click();
	});

	// No 'Access-Control-Allow-Origin' header is present on the requested resource. Origin 'http://localhost:81' is therefore not allowed access.
	// API 서버에서 추가 작업이 필요함.
	/* function AutoFill(){
		$.ajax({
	        type:'GET',
	        url:'${liboneApiUrl}',
	        data:'cmd=GETAUTOFILL&searchKeyword=어린',
	        success:function(response){
	            console.log(response);
	        },
	        error:function(e){
	            alert(e.responseText);
	        }
	    });
	} */

	$('#librarySearch #search_text').on('keyup',function(e){
		 switch (e.keyCode) {
         case 8:  // Backspace
         case 9:  // Tab
         case 13: // Enter
         case 37: // Left
         case 38: // Up
         case 39: // Right
         case 40: // Down
         break;

         default:
        	 $.ajax({
     	        type:'GET',
     	        async:true,
     	        url:'autoFill.do',
     	        data:'searchKeyword='+encodeURIComponent($(this).val()),
     	        success:function(response){
     	        	var autofillArr = response.autofillArr;
     	        	var autoFillStr = [];
     	        	$.each(autofillArr, function(i, v) {
     	        		autoFillStr.push('<a class="autoText">' + v.word + '</a>');
     	        	});
     	            $('#autoFill').html(autoFillStr.join(','));
     	            $('a.autoText').on('click', function(e) {
     	            	e.preventDefault();
     	            	$('#librarySearch #search_text').val($(this).text());
     	            	$('#librarySearch #do-search').click();
     	            });
     	        },
     	        error:function(e){
     	        }
     	    });
     	}
	});
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
		$('input#vLoca').val($(this).attr('vLoca'));
		$('input#vCtrl').val($(this).attr('vCtrl'));
		$('input#vImg').val($(this).attr('vImg'));
		$('input#isbn').val($(this).attr('isbn'));
		$('input#tid').val($(this).attr('tid'));
		var formData = serializeParameter(['vLoca', 'vCtrl', 'vImg', 'isbn', 'tid', 'menu_idx']);
		doGetLoad('detail.do', formData);
// 		$('form#detailForm').submit();
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
		$('div#search-results').load('tableForBoard.do', $.extend(true, param, param2));
		if (isSubSearch) {
			$('input#sub_search1').prop('checked', true);
		}
		$('body').scrollTop(0);
	}

	$('div#search-results img').on('error', function() {
		var $this = $(this);
		$this.attr('src', '/resources/common/img/noImg.gif');
		$this.parent().addClass('noImg');
	});

	$('a#excelDownload').on('click', function(e) {
		e.preventDefault();
		var checkedLength = $('form#librarySearch input[name=print_param]:checked').length;
		if (checkedLength < 1) {
			alert('선택된 도서가 없습니다.');
			return false;
		}
		var clone = $('form#librarySearch input[name=print_param]:checked').clone();
		var clone2 = $('form#librarySearch input[name=libraryCodes]:checked').clone();
		$('form#excelForm').append(clone);
		$('form#excelForm').append(clone2);
		$('form#excelForm input#excel_viewPage').val($('form#librarySearch input#viewPage').val());
		$('form#excelForm input#excel_search_text').val($('form#librarySearch input#search_text').val());
		$('form#excelForm input#excel_search_type2').val($('form#librarySearch input#search_type2').val());
		$('form#excelForm').submit();
		$('form#excelForm input[name=print_param]').remove();
		$('form#excelForm input[name=libraryCodes]').remove();

	});

	$('div#hotTrend').load('hotTrend.do');
	<c:if test="${empty librarySearch.search_text}">
	$('div#cms_paging').hide();
	</c:if>


	$('a#ageLoanBestBtn').on('click', function(e) {
		e.preventDefault();
// 		$('div#ageLoanBest').load('ageLoanBest.do', function( response, status, xhr ) {
// 			$('div#ageLoanBest').dialog();
// 		});
		$('div#ageLoanBest').html(
			'<div style="text-align: center; padding-top: 100px;">'+
			'<img id="loading_img" alt="loading" src="/resources/common/img/viewLoading.gif" />'+
			'<br/><br/>'+
			'대출 순위 불러오는 중'+
			'</div>'
		);
		$('div#ageLoanBest').load('ageLoanBest.do');
		$('div#ageLoanBest').dialog({
			width:1100,
			height:500,
			resizable: true,
	 		modal: true
		});
	});

	$('a.selectBook').on('click', function(e) {
		e.preventDefault();
		window.opener.getIlusData($(this).attr('keyValue'));
		window.close();
	});

        if ('${fn:escapeXml(param.search_type)}'=='') {
                $('select#search_type').val('L_TITLEAUTHOR');
        }
});
$(document).on("keyup", "input:text[numberOnly]", function() {
	$(this).val($(this).val().replace(/[^0-9]/gi, ""));
});
</script>
<form:form modelAttribute="librarySearch" id="excelForm" action="excelDownload.do" method="post" style="display: none;">
<form:hidden id="excel_search_type2"       path="search_type2"/>
<form:hidden id="excel_search_type"       path="search_type"/>
<form:hidden id="excel_search_text"       path="search_text"/>
<form:hidden id="excel_search_library"    path="search_library"/>
<form:hidden id="excel_search_form_code"  path="search_form_code"/>
<form:hidden id="excel_search_kdc"        path="search_kdc"/>
<form:hidden id="excel_search_athor"      path="search_athor"/>
<form:hidden id="excel_search_year"      path="search_year"/>
<form:hidden id="excel_search_publisher"  path="search_publisher"/>
<form:hidden id="excel_menu_idx"          path="menu_idx"/>
<form:hidden id="excel_viewPage"          path="viewPage"/>
<form:hidden id="excel_excel_type"        path="excel_type" value="SEARCH"/>
</form:form>
<form id="storageReqForm" style="display: none;">
<input type="hidden" name="_csrf" value="${_csrf.token}">
</form>
<form:form modelAttribute="librarySearch" id="detailForm" action="detail.do" method="post">
	<form:hidden path="menu_idx"/>
	<form:hidden path="vLoca"/>
	<form:hidden path="vCtrl"/>
	<form:hidden path="vImg"/>
	<form:hidden path="isbn"/>
	<form:hidden path="tid"/>
</form:form>

<form:form modelAttribute="librarySearch" action="indexForBoard.do" method="POST">
	<form:hidden path="allBookListStr" value="${result.allBookListStr}"/>
	<form:hidden path="search_type2"/>
	<form:hidden path="search_library"/>
	<form:hidden path="search_form_code"/>
	<form:hidden path="search_kdc"/>
	<form:hidden path="search_year"/>
	<form:hidden path="search_athor"/>
	<form:hidden path="search_publisher"/>
	<form:hidden path="menu_idx"/>
	<form:hidden path="viewPage"/>
	<form:hidden path="excel_type"/>
	<div class="search-wrap">
		<%--
		<c:if test="${librarySearch.search_text ne null and librarySearch.search_text ne ''}">
		<div>
			<form:checkbox path="sub_search" label="검색결과 내 재검색"/>
		</div>
		</c:if>
		--%>
		<div class="search-form">
			<div class="box1" style="width: 15%;">
				<select id="search_type" name="search_type" class="selectmenu" style="width:100%;font-size:105%;padding-left:12px;border:0px;">
					<option value="L_TITLEAUTHOR" <c:if test="${librarySearch.search_type eq 'L_TITLEAUTHOR'}">selected="selected"</c:if>>서명or저자</option>
					<option value="L_TITLE" <c:if test="${librarySearch.search_type eq 'L_TITLE'}">selected="selected"</c:if>>서명[전방일치]</option>
					<option value="L_AUTHOR" <c:if test="${librarySearch.search_type eq 'L_AUTHOR'}">selected="selected"</c:if>>저자[전방일치]</option>
					<option value="L_PUBLISHER" <c:if test="${librarySearch.search_type eq 'L_PUBLISHER'}">selected="selected"</c:if>>출판사[완전일치]</option>
					<option value="INDEXSEARCH" <c:if test="${librarySearch.search_type eq 'INDEXSEARCH'}">selected="selected"</c:if>>목차[부분일치]</option>
				</select>
			</div>
			<div class="box">
				<div class="b1">
					<form:input path="search_text" type="text" class="text" placeholder="검색어를 입력하세요." onfocus="PopupVirtualKeyboard.attachInput(this)" cssStyle="ime-mode:active; width:90%;"/>
				</div>
				<div class="b2">
					<button id="do-search"><i class="fa fa-search"></i><span class="blind">검색</span></button>
				</div>
			</div>
			<br/>
			<div id="autoFill">
			</div>

			<p style="height:auto">
				<a id="vk-popup" class="btn" style="line-height:140%" title="새창열림">
				  <i class="fa fa-keyboard-o" style="font-size:19px;color:#777"></i><span>다국어입력기</span>
				</a>
				<a id="toggleLibList" class="btn" style="line-height:140%">
				  <i class="fa fa-leanpub" style="font-size:19px;color:#777"></i><span>타도서관검색</span>
				</a>
				<%--
				<c:if test="${result.totalCnt > 0}">
				<a id="excelDownload" class="btn" style="line-height:140%">
					<i class="fa fa-file-excel-o" style="font-size:19px;color:#777"></i><span>엑셀 저장</span>
				</a>
				</c:if>
				 --%>
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
						<c:if test="${i.lib_manage_code ne '00347034'}">
						<li>
							<c:choose>
								<c:when test="${i.lib_manage_code eq '00000001'}">
									<form:checkbox id="lib_${i.lib_manage_code}" searched="true" path="libraryCodes" label="${i.lib_name}" value="${i.lib_manage_code}" checked="checked"/>
								</c:when>
								<c:when test="${fn:indexOf(librarySearch.libraryCodes, i.lib_manage_code)!= -1 or fn:indexOf(librarySearch.libraryCodes, 'ALL') != -1}">
									<form:checkbox id="lib_${i.lib_manage_code}" searched="true" path="libraryCodes" label="${i.lib_name}" value="${i.lib_manage_code}" checked="checked"/>
								</c:when>
								<c:otherwise>
									<form:checkbox id="lib_${i.lib_manage_code}" path="libraryCodes" label="${i.lib_name}" value="${i.lib_manage_code}" />
								</c:otherwise>
							</c:choose>
						</li>
						</c:if>
					</c:forEach>
				</ul>
			</div>
		</div>
		<div class="search-info" >
			<c:if test="${result.code eq '0000'}">
				검색결과 '<b class="og"><i>${librarySearch.search_text}</i></b>'에 대한 <b>${librarySearch.viewPage}</b>/${result.totalPage}페이지, 총 <b>${result.totalCnt}</b>건
			</c:if>
		</div>
		<%--
		* 경상북도교육청 공공도서관에서 소장하고 있는 국내외 자료를  통합검색 할 수 있습니다.
		--%>
		<c:set var="showSmain" value="${librarySearch.search_text ne null and librarySearch.search_text ne ''}"></c:set>
<%-- 		<c:if test="${librarySearch.search_text ne null and librarySearch.search_text ne ''}"> --%>
		<c:if test="${fn:length(result.data) < 1 and showSmain}">
		<p style="text-align: center;">
			<b>찾으시는 자료가 없습니다. </b>
		</p>
		</c:if>
		<div class="smain">
			<div class="box" style="min-height: 500px;">
				<div class="ws-toolbar"<c:if test="${!showSmain}">style="display: none;"</c:if>>
					<%--
					<div class="checkbox">
						<input type="hidden" name="" value="on"/>
						<input id="checkAllBook" name="" type="checkbox" value="Y"/>
						<label for="checkAllBook">전체</label>
					</div>
					<div class="control">
						<a href="#" id="addMyLib" class="btn"><span>내보관함</span><i class="fa fa-plus"></i></a>
						<form:select path="sortField" cssClass="selectmenu" cssStyle="width: 90px;">
							<form:option value="PUBLISH_DATE" label="발행년도"></form:option>
							<form:option value="TITLE" label="서명"></form:option>
							<form:option value="AUTHOR" label="저자"></form:option>
							<form:option value="PUBLISHER" label="발행처"></form:option>
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
						</form:select>
					</div>
					--%>
				</div>
				<div id="search-results" class="search-results">
					<%--
					<c:if test="${empty librarySearch.search_text}">
					<div id="loadingLoanBest" style="text-align: center; padding-top: 105px;">
						<img id="loading_img" alt="loading" src="/resources/common/img/viewLoading.gif" />
						<br/><br/>
						대출 순위 불러오는 중
					</div>
					</c:if>
					--%>
					<c:forEach items="${result.data}" var="i">
						<div class="row">
							<p class="admin"><input name="print_param" type="checkbox" class="checkBook" value="${i.libCode}_${i.rec_key}_${i.tid}_${i.img}"/></p>
							<div class="thumb">
								<c:choose>
									<c:when test="${i.img eq '' or fn:contains(i.img, 'noimg')}">
										<a href="#" vLoca="${i.libCode}" vCtrl="${i.rec_key}" vImg="${i.img}" isbn="${i.isbn}" tid="${i.tid}" class="goDetail noImg">
											<img src="/resources/common/img/noImg.gif" alt="noImage"/>
										</a>
									</c:when>
									<c:otherwise>
										<a href="#" vLoca="${i.libCode}" vCtrl="${i.rec_key}" vImg="${i.img}" isbn="${i.isbn}" tid="${i.tid}" class="goDetail">
											<img src="${i.img}" alt="${i.title}"/>
										</a>
									</c:otherwise>
								</c:choose>
							</div>
							<div class="box">
								<div class="item">
									<div class="bif">
										<c:set var="replaceStr" value="<span style='color:#ffa651'>${librarySearch.search_text}</span>"/>
										<a href="#" vLoca="${i.libCode}" vCtrl="${i.rec_key}" vImg="${i.img}" isbn="${i.isbn}" tid="${i.tid}" class="name goDetail">${fn:replace(i.title, librarySearch.search_text, replaceStr)}</a>
										<p>${fn:replace(i.author, librarySearch.search_text, replaceStr)}</p>
										<p>${fn:replace(i.publisher, librarySearch.search_text, replaceStr)}, ${i.year}</p>
										<p>${i.libName}</p>
										<p>${i.placeName}</p>
										<div class="stat">
<%-- 											<a href="#" class="showSlide" vLoca="${i.libCode}" vCtrl="${i.rec_key}"><span>이용가능여부</span><i class="fa fa-sort-down"></i></a> --%>
											<span>[${i.callno}]</span>
											<a href="#" class="selectBook" vLoca="${i.libCode}" vCtrl="${i.rec_key}"
												keyValue="${i.title}///${i.year}///${i.author}///${i.publisher}///${i.isbn}///${i.callno}///${i.img}///${i.rec_key}///${i.placeName}">
												<span>선택하기</span><i class="fa fa-sort-down"></i>
											</a>
										</div>
									</div>
									<div class="bci" style="display: none;">
										<!-- ajax_area -->
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
					<jsp:include page="/WEB-INF/views/app/cms/common/paging_search_tableforboard.jsp" flush="false" />
				</div>
			</div>

			<div class="ws-filter" id="ageLoanBestDiv" style="padding-bottom: 20px; display: none;">
				<a id="ageLoanBestBtn" class="btn" style="line-height:140%">
				  <i class="fa fa-keyboard-o" style="font-size:19px;color:#777"></i><span>연령별 대출순위</span>
				</a>
			</div>
			<%--
			<div class="ws-filter" id="hotTrend" style="height: 350px;">
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
								<c:set var="formCnt" value="${j.totcnt}"></c:set>
								<li><a href="" class="doSearchFormCode" keyValue1="L_FORMCODE" keyValue2="${j.code}"><span>${j.title}</span><em>(${j.count})</em></a></li>
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
								<c:set var="authorCnt" value="${j.totcnt}"></c:set>
								<li><a href="" class="doSearchWriter" keyValue1="L_AUTHORFORM" keyValue2="${j.code}"><span>${j.title}</span><em>(${j.count})</em></a></li>
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
								<c:set var="publisherCnt" value="${j.totcnt}"></c:set>
								<li><a href="" class="doSearchPublisher" keyValue1="L_PUBLISHERFORM" keyValue2="${j.code}"><span>${j.title}</span><em>(${j.count})</em></a></li>
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
								<c:set var="yearCnt" value="${j.totcnt}"></c:set>
								<li><a class="doSearchYear" href="" keyValue1="L_YEAR" keyValue2="${j.title}"><span>${j.title}</span><em>(${j.count})</em></a></li>
							</c:forEach>
						</ul>
						<c:if test="${yearCnt > 5}">
							<p><a href="#" class="moreYear">더보기 +</a></p>
						</c:if>
					</li>

				</ul>
			</div>--%>
		</div>
<%-- 		</c:if> --%>
	</div>
</form:form>
<div id="vk"></div>
