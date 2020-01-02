<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="boardTag" uri="/WEB-INF/config/tld/boardTag.tld"%>
<% pageContext.setAttribute("crlf", "\r\n"); %>
<link rel="stylesheet" type="text/css" href="/resources/book/css/serial.css">
<link rel="stylesheet" type="text/css" href="/resources/book/search/css/default.css">

<script type="text/javascript" src="/resources/board/js/ebook/liquid.js"></script>
<script type="text/javascript" src="/resources/board/js/ebook/swfobject.js"></script>
<script type="text/javascript" src="/resources/board/js/ebook/ebook.js"></script>
<script type="text/javascript">
$(document).ready(function() {

<!--


flippingBook.pages = [
	'/data/ebook/11453032/1.jpg' , '/data/ebook/11453032/2.jpg' , '/data/ebook/11453032/3.jpg' , '/data/ebook/11453032/4.jpg' , '/data/ebook/11453032/5.jpg' , '/data/ebook/11453032/6.jpg' , '/data/ebook/11453032/7.jpg' , '/data/ebook/11453032/8.jpg' , '/data/ebook/11453032/9.jpg' , '/data/ebook/11453032/10.jpg' , '/data/ebook/11453032/11.jpg' , '/data/ebook/11453032/12.jpg' , '/data/ebook/11453032/13.jpg' , '/data/ebook/11453032/14.jpg' , '/data/ebook/11453032/15.jpg' , '/data/ebook/11453032/16.jpg' , '/data/ebook/11453032/17.jpg' , '/data/ebook/11453032/18.jpg' , '/data/ebook/11453032/19.jpg' , '/data/ebook/11453032/20.jpg' , '/data/ebook/11453032/21.jpg' , '/data/ebook/11453032/22.jpg' , '/data/ebook/11453032/23.jpg' , '/data/ebook/11453032/24.jpg' , '/data/ebook/11453032/25.jpg' , '/data/ebook/11453032/26.jpg' , '/data/ebook/11453032/27.jpg' , '/data/ebook/11453032/28.jpg' , '/data/ebook/11453032/29.jpg' , '/data/ebook/11453032/30.jpg' , '/data/ebook/11453032/31.jpg' , '/data/ebook/11453032/32.jpg' , '/data/ebook/11453032/33.jpg' , '/data/ebook/11453032/34.jpg' , '/data/ebook/11453032/35.jpg' , '/data/ebook/11453032/36.jpg' , '/data/ebook/11453032/37.jpg' , '/data/ebook/11453032/38.jpg' , '/data/ebook/11453032/39.jpg' , '/data/ebook/11453032/40.jpg' , '/data/ebook/11453032/41.jpg' , '/data/ebook/11453032/42.jpg' , '/data/ebook/11453032/43.jpg' , '/data/ebook/11453032/44.jpg' , '/data/ebook/11453032/45.jpg' , '/data/ebook/11453032/46.jpg' , '/data/ebook/11453032/47.jpg' , '/data/ebook/11453032/48.jpg' , '/data/ebook/11453032/49.jpg' , '/data/ebook/11453032/50.jpg' , '/data/ebook/11453032/51.jpg' , '/data/ebook/11453032/52.jpg' , '/data/ebook/11453032/53.jpg' , '/data/ebook/11453032/54.jpg' , '/data/ebook/11453032/55.jpg' , '/data/ebook/11453032/56.jpg' , '/data/ebook/11453032/57.jpg' , '/data/ebook/11453032/58.jpg' , '/data/ebook/11453032/59.jpg' , '/data/ebook/11453032/60.jpg' , '/data/ebook/11453032/61.jpg' , '/data/ebook/11453032/62.jpg' , '/data/ebook/11453032/63.jpg' , '/data/ebook/11453032/64.jpg' , '/data/ebook/11453032/65.jpg' , '/data/ebook/11453032/66.jpg' , '/data/ebook/11453032/67.jpg' , '/data/ebook/11453032/68.jpg' , '/data/ebook/11453032/69.jpg' , '/data/ebook/11453032/70.jpg' , '/data/ebook/11453032/71.jpg' , '/data/ebook/11453032/72.jpg' , '/data/ebook/11453032/73.jpg' , '/data/ebook/11453032/74.jpg' , '/data/ebook/11453032/75.jpg' , '/data/ebook/11453032/76.jpg' , '/data/ebook/11453032/77.jpg' , '/data/ebook/11453032/78.jpg' , '/data/ebook/11453032/79.jpg' , '/data/ebook/11453032/80.jpg' , '/data/ebook/11453032/81.jpg' , '/data/ebook/11453032/82.jpg' , '/data/ebook/11453032/83.jpg' , '/data/ebook/11453032/84.jpg' , '/data/ebook/11453032/85.jpg' , '/data/ebook/11453032/86.jpg' , '/data/ebook/11453032/87.jpg' , '/data/ebook/11453032/88.jpg' , '/data/ebook/11453032/89.jpg' , '/data/ebook/11453032/90.jpg' , '/data/ebook/11453032/91.jpg' , '/data/ebook/11453032/92.jpg' , '/data/ebook/11453032/93.jpg' , '/data/ebook/11453032/94.jpg' , '/data/ebook/11453032/95.jpg' , '/data/ebook/11453032/96.jpg' , '/data/ebook/11453032/97.jpg' , '/data/ebook/11453032/98.jpg' , '/data/ebook/11453032/99.jpg' , '/data/ebook/11453032/100.jpg' , '/data/ebook/11453032/101.jpg' , '/data/ebook/11453032/102.jpg' , '/data/ebook/11453032/103.jpg' , '/data/ebook/11453032/104.jpg' ,
	'/data/ebook/11453032/105.jpg' , '/data/ebook/11453032/106.jpg' , '/data/ebook/11453032/107.jpg' , '/data/ebook/11453032/108.jpg' , '/data/ebook/11453032/109.jpg' , '/data/ebook/11453032/110.jpg' , '/data/ebook/11453032/111.jpg' , '/data/ebook/11453032/112.jpg' , '/data/ebook/11453032/113.jpg' , '/data/ebook/11453032/114.jpg' , '/data/ebook/11453032/115.jpg' , '/data/ebook/11453032/116.jpg' , '/data/ebook/11453032/117.jpg' , '/data/ebook/11453032/118.jpg' , '/data/ebook/11453032/119.jpg' , '/data/ebook/11453032/120.jpg' , '/data/ebook/11453032/121.jpg' , '/data/ebook/11453032/122.jpg' 	];



flippingBook.contents = [
	 [ '1', 1 ]  ,  [ '2', 2 ]  ,  [ '3', 3 ]  ,  [ '4', 4 ]  ,  [ '5', 5 ]  ,  [ '6', 6 ]  ,  [ '7', 7 ]  ,  [ '8', 8 ]  ,  [ '9', 9 ]  ,  [ '10', 10 ]  ,  [ '11', 11 ]  ,  [ '12', 12 ]  ,  [ '13', 13 ]  ,  [ '14', 14 ]  ,  [ '15', 15 ]  ,  [ '16', 16 ]  ,  [ '17', 17 ]  ,  [ '18', 18 ]  ,  [ '19', 19 ]  ,  [ '20', 20 ]  ,  [ '21', 21 ]  ,  [ '22', 22 ]  ,  [ '23', 23 ]  ,  [ '24', 24 ]  ,  [ '25', 25 ]  ,  [ '26', 26 ]  ,  [ '27', 27 ]  ,  [ '28', 28 ]  ,  [ '29', 29 ]  ,  [ '30', 30 ]  ,  [ '31', 31 ]  ,  [ '32', 32 ]  ,  [ '33', 33 ]  ,  [ '34', 34 ]  ,  [ '35', 35 ]  ,  [ '36', 36 ]  ,  [ '37', 37 ]  ,  [ '38', 38 ]  ,  [ '39', 39 ]  ,  [ '40', 40 ]  ,  [ '41', 41 ]  ,  [ '42', 42 ]  ,  [ '43', 43 ]  ,  [ '44', 44 ]  ,  [ '45', 45 ]  ,  [ '46', 46 ]  ,  [ '47', 47 ]  ,  [ '48', 48 ]  ,  [ '49', 49 ]  ,  [ '50', 50 ]  ,  [ '51', 51 ]  ,  [ '52', 52 ]  ,  [ '53', 53 ]  ,  [ '54', 54 ]  ,  [ '55', 55 ]  ,  [ '56', 56 ]  ,  [ '57', 57 ]  ,  [ '58', 58 ]  ,  [ '59', 59 ]  ,  [ '60', 60 ]  ,  [ '61', 61 ]  ,  [ '62', 62 ]  ,  [ '63', 63 ]  ,  [ '64', 64 ]  ,  [ '65', 65 ]  ,  [ '66', 66 ]  ,  [ '67', 67 ]  ,  [ '68', 68 ]  ,  [ '69', 69 ]  ,  [ '70', 70 ]  ,  [ '71', 71 ]  ,  [ '72', 72 ]  ,  [ '73', 73 ]  ,  [ '74', 74 ]  ,  [ '75', 75 ]  ,  [ '76', 76 ]  ,  [ '77', 77 ]  ,  [ '78', 78 ]  ,  [ '79', 79 ]  ,  [ '80', 80 ]  ,  [ '81', 81 ]  ,  [ '82', 82 ]  ,  [ '83', 83 ]  ,  [ '84', 84 ]  ,  [ '85', 85 ]  ,  [ '86', 86 ]  ,  [ '87', 87 ]  ,  [ '88', 88 ]  ,  [ '89', 89 ]  ,  [ '90', 90 ]  ,  [ '91', 91 ]  ,  [ '92', 92 ]  ,  [ '93', 93 ]  ,  [ '94', 94 ]  ,  [ '95', 95 ]  ,  [ '96', 96 ]  ,  [ '97', 97 ]  ,  [ '98', 98 ]  ,  [ '99', 99 ]  ,  [ '100', 100 ]  ,  [ '101', 101 ]  ,  [ '102', 102 ]  ,  [ '103', 103 ]  ,  [ '104', 104 ]  ,  [ '105', 105 ]  ,  [ '106', 106 ]  ,  [ '107', 107 ]  ,  [ '108', 108 ]  ,  [ '109', 109 ]  ,  [ '110', 110 ]  ,  [ '111', 111 ]  ,  [ '112', 112 ]  ,  [ '113', 113 ]  ,  [ '114', 114 ]  ,  [ '115', 115 ]  ,  [ '116', 116 ]  ,  [ '117', 117 ]  ,  [ '118', 118 ]  ,  [ '119', 119 ]  ,  [ '120', 120 ]  ,  [ '121', 121 ]  ,  [ '122', 122 ]  	];




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
	flippingBook.settings.zoomPath = "http://hub.tglnet.or.kr/data/ebook/11453032/";
	flippingBook.settings.flipSound = "http://hub.tglnet.or.kr/content/ebook/skin1/sounds/01.mp3";
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
		document.location.href="http://hub.tglnet.or.kr/content/ebook/index.php?eb_pk="+eb_pk;
	}

	function ebook_go1(url){
	location.href = url;
}

//-->
});
</script>


<form id="frm_sch" action="/content/ebook/index.php?eb_pk=11453032"  method="post">
<div>
	<input type="hidden" name="is_size" value="min" />
</div>

	<div id="fbFooter">

		<div id="logo">
					</div>

		<div id="content_move">
			<select onchange = "go_ebook_url(this.value);">

				<option value="17065612" >大邱中央圖書館80年史</option>


				<option value="16582443" >圖書館報. 창간호</option>


				<option value="17013969" >圖書館報. 제2호</option>


				<option value="17082857" >圖書館報. 제3호</option>


				<option value="17170394" >圖書館報 제4호</option>


				<option value="17182315" >圖書館報. 제5호</option>


				<option value="19561980" >圖書館報. 第6號</option>


				<option value="17192888" >圖書館報. 제7호</option>


				<option value="1956381" >圖書館報. 第8號</option>


				<option value="17201415" >圖書館報. 제9호</option>


				<option value="17212405" >圖書館報. 제10호</option>


				<option value="17222575" >圖書館報. 제11호</option>


				<option value="19565200" >圖書館報. 第12號</option>


				<option value="17231962" >圖書館報. 제13호</option>


				<option value="19571917" >圖書館報. 第14號</option>


				<option value="19572782" >圖書館報. 第15號</option>


				<option value="19573800" >圖書館報. 第16號</option>


				<option value="19580195" >圖書館報. 第17號</option>


				<option value="19581719" >圖書館報. 第18號</option>


				<option value="19584227" >圖書館報. 第19號</option>


				<option value="19590186" >圖書館報. 第20號</option>


				<option value="17241993" >圖書館報. 제21호</option>


				<option value="19592724" >圖書館報. 第22號</option>


				<option value="11453032" selected='selected'>圖書館報. 第23號</option>


				<option value="11542706" >圖書館報. 第24號</option>


				<option value="12362025" >圖書館報. 第25號</option>


				<option value="18152712" >圖書館報. 第26號</option>


				<option value="13045181" >圖書館報. 第27號</option>


				<option value="2005131" >圖書館報. 제28호</option>


				<option value="20061717" >圖書館報. 제29호</option>


				<option value="13302237" >圖書館報. 第30號</option>


				<option value="20065749" >圖書館報. 제31호</option>


				<option value="20183184" >圖書館報. 제32호</option>


				<option value="20193348" >圖書館報. 제33호</option>


				<option value="1203173" >圖書館報. 제34호</option>


				<option value="18382138" >圖書館報. 제35호</option>


				<option value="11280934" >圖書館報. 제36호</option>


				<option value="12450462" >圖書館報. 제37호</option>


				<option value="17581511" >圖書館報. 제38호</option>


				<option value="14110354" >圖書館報. 제39호</option>


				<option value="15045761" >圖書館報. 제40호</option>


			</select>
		</div>


		<div id="fbMenu">
			<img src="http://hub.tglnet.or.kr/content/ebook/skin1/img/btnPrevious.gif" width="31" height="33" border="0" id="fbBackButton" alt="이전페이지" /><img src="/content/ebook/skin1/img/btnNext.gif" width="31" height="33" border="0" id="fbForwardButton" alt="다음페이지" />
			<img src="http://hub.tglnet.or.kr/content/ebook/skin1/img/btnDiv.gif" width="7" height="33" border="0" class="div" alt="" />
			<img src="http://hub.tglnet.or.kr/content/ebook/skin1/img/btnZoom.gif" width="31" height="33" border="0" id="fbZoomButton" alt="확대/축소" /><img src="/content/eboo
85d
k/skin1/img/btnPrint.gif" width="31" height="33" border="0" id="fbPrintButton" alt="인쇄" /><img src="http://hub.tglnet.or.kr/content/ebook/skin1/img/btnHelp.gif" width="31" height="33" border="0" id="fbHelpButton" alt="이용방법" onclick="window.open('/content/ebook/skin1/help.html','help','width=392,height=593');" style="cursor:pointer;" />

			<img src="http://hub.tglnet.or.kr/content/ebook/skin1/img/btnDiv.gif" width="7" height="33" border="0" class="div" alt="" />
			<img src="http://hub.tglnet.or.kr/content/ebook/skin1/img/btnMax.gif" width="21" height="33" border="0" alt="최대화" onclick="ebook_size();" style="cursor:pointer;" /><img src="/content/ebook/skin1/img/btnClose.gif" width="21" height="33" border="0" alt="닫기" onclick="window.close();" style="cursor:pointer;" />
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
				<li><input type="text" size="10" title="검색어를 입력하세요" id="p_keyword" name="p_keyword"  value="" style="height:14px;font-size:11px;"></li>
				<li style="padding-left:3px;"><input type="image" src="http://hub.tglnet.or.kr/content/ebook/skin1/img/btnSearch.gif" alt="검색" /></li>
				<li style="padding-left:4px;"><a href="javascript:;" onclick="ebook_go1('/content/ebook/index.php?eb_pk=11453032');"><img src="http://hub.tglnet.or.kr/content/ebook/skin1/img/btnTotalview.gif" alt="전체보기" /></a></li>
				<li style="padding-left:5px;"><img src="http://hub.tglnet.or.kr/content/ebook/skin1/img/btnDiv2.gif" width="7" height="22" border="0" class="div" alt="" /></li>
			</ul>
		</div>

	</div>

	<div id="fbContainer">
		<div id="altmsg"><a class="altlink" href="http://www.adobe.com/shockwave/download/download.cgi?P1_Prod_Version=ShockwaveFlash">Download Adobe Flash Player.</a></div>
	</div>


</form>
