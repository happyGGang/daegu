<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>

<link href="/resources/archive/skin1/css/common.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="/resources/archive/skin1/js/liquid.js"></script>
<script type="text/javascript" src="/resources/archive/skin1/js/swfobject.js"></script>
<script type="text/javascript" src="/resources/archive/skin1/js/ebook.js"></script>


<script type="text/javascript">
	flippingBook.pages = [
		<c:forEach var="i" varStatus="status" items="${archivePageList}">
		'/data/archive/${archive.homepage_id}/${i.book_idx}/${i.server_file_name}'<c:if test="${!status.last}">,</c:if>
		</c:forEach>
	];

	flippingBook.contents = [
		<c:forEach var="i" varStatus="status" items="${archivePageList}">
		['${i.subject}', ${i.code}]<c:if test="${!status.last}">,</c:if>
		</c:forEach>
	];



	flippingBook.settings.bookWidth = 820;
	flippingBook.settings.bookHeight = 580;
	flippingBook.settings.pageBackgroundColor = 0xffffff;	//페이지배경색상
	flippingBook.settings.backgroundColor = 0x4D4D4D;		//배경색상
	flippingBook.settings.zoomUIColor = 0xffffff;			//스크롤색상
	flippingBook.settings.useCustomCursors = true;
	flippingBook.settings.dropShadowEnabled = false,
	flippingBook.settings.zoomImageWidth = 916;
	flippingBook.settings.zoomImageHeight = 1296;
	flippingBook.settings.downloadURL = "";
	flippingBook.settings.zoomPath = "/data/archive/${archive.homepage_id}/${archive.book_idx}/";
	flippingBook.settings.flipSound = "/resources/archive/skin1/sounds/01.mp3";
	flippingBook.settings.staticShadowsDepth = "1";


	flippingBook.create();

	

	
	function ebook_size() {
		
		is_size = document.getElementById('frm_sch').is_size.value;

		if(is_size == "max"){//1024
			min();
		}else if(is_size == "min"){
			max();
		}
		
	}


	function max() {
		document.getElementById('frm_sch').is_size.value = "max";
		self.moveTo(0,0);
		self.resizeTo(screen.availWidth,screen.availHeight);
	}

	function min() {
		

		document.getElementById('frm_sch').is_size.value = "min";

		self.moveTo(0,0);
		self.resizeTo(1024,768);
	}

	function go_ebook_url(eb_pk){
		document.location.href="index.do?eb_pk="+eb_pk;
	}

	function ebook_go1(url){
	location.href = url;
}
</script>



</head>
<body>

<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
<form id="frm_sch" action="index.do"  method="get">
	<input type="hidden" name="is_size" value="max" />
	<input type="hidden" name="search_type" value="subject">	
	<div id="fbFooter">

		<div id="logo">
		</div>

		<div id="content_move">
		</div>

		<div id="fbMenu">
			<img src="/resources/archive/skin1/img/btnPrevious.gif" width="31" height="33" border="0" id="fbBackButton" alt="이전페이지" /><img src="/resources/archive/skin1/img/btnNext.gif" width="31" height="33" border="0" id="fbForwardButton" alt="다음페이지" />
			<img src="/resources/archive/skin1/img/btnDiv.gif" width="7" height="33" border="0" class="div" alt="" />
			<img src="/resources/archive/skin1/img/btnZoom.gif" width="31" height="33" border="0" id="fbZoomButton" alt="확대/축소" /><img src="/resources/archive/skin1/img/btnPrint.gif" width="31" height="33" border="0" id="fbPrintButton" alt="인쇄" /><img src="/resources/archive/skin1/img/btnHelp.gif" width="31" height="33" border="0" id="fbHelpButton" alt="이용방법" onclick="window.open('/resources/archive/skin1/help.html','help','width=392,height=593');" style="cursor:pointer;" />

			<img src="/resources/archive/skin1/img/btnDiv.gif" width="7" height="33" border="0" class="div" alt="" />
			<img src="/resources/archive/skin1/img/btnMax.gif" width="21" height="33" border="0" alt="최대화" onclick="ebook_size();" style="cursor:pointer;" /><img src="/resources/archive/skin1/img/btnClose.gif" width="21" height="33" border="0" alt="닫기" onclick="window.close();" style="cursor:pointer;" />
		</div>

		<div id="fbContents">
			<ul>
				<li style="padding-top:3px;"><span class="fbPaginationMinor">페이지</span></li>
				<li style="padding-top:3px;"><span id="fbCurrentPages">1</span></li>
				<li style="padding-top:3px;"><span id="fbTotalPages" class="fbPaginationMinor2"></span></li>
				<li>
					<select id="fbContentsMenu" name="fbContentsMenu" title="페이지이동">
						<option></option>
					</select>
				</li>
			</ul>
		</div>

		<div id="fbContents2">
			<ul>
				<li><input type="text" size="10" title="검색어를 입력하세요" id="p_keyword" name="search_text"  value="${archive.keyword}" style="height:14px;font-size:11px;"></li>
				<li style="padding-left:3px;"><input type="image" src="/resources/archive/skin1/img/btnSearch.gif" alt="검색" /></li>
				<li style="padding-left:4px;"><a href="#total" onclick="ebook_go1('index.do?book_idx=${archive.book_idx}');"><img src="/resources/archive/skin1/img/btnTotalview.gif" alt="전체보기" /></a></li>
				<li style="padding-left:5px;"><img src="/resources/archive/skin1/img/btnDiv2.gif" width="7" height="22" border="0" class="div" alt="" /></li>
			</ul>
		</div>

	</div>

	<div id="fbContainer">
		<div id="altmsg"><a class="altlink" href="http://www.adobe.com/shockwave/download/download.cgi?P1_Prod_Version=ShockwaveFlash">Download Adobe Flash Player.</a></div>
	</div>
	
	<script LANGUAGE="JavaScript">
		max();
	</script>
	
</form>
</body>
</html>
