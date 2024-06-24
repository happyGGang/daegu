<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>자료위치안내</title>
	<style type="text/css">
		th              { font-weight: bolder !important; text-align: center !important}
		th              { font-weight: bolder !important; text-align: left !important; }
		caption         { text-align: center !important}
		body            { line-height: 1.30 !important;margin:0;padding:0}
		h1              { font-size: 2em !important;
							margin: .67em 0 !important;}
		h2              { font-size: 1.5em !important;
							margin: .83em 0 !important;}
		h3              { font-size: 1.15em !important; margin: 0em 0 !important; padding:0}
		h4, p, blockquote, ul, form, ol, dl { margin: 1.33em 0 !important;}
		h5              { font-size: .83em !important; line-height: 1.17em !important; margin: 1.67em 0 !important;}
		h6              { font-size: .67em !important; margin: 2.33em 0 !important;}
		h1, h2, h3, h4, h5, h6, b, strong { font-weight: bolder !important;}
		blockquote      { margin-left: 0px !important;; margin-right: 0px !important;}
		i, cite, em, var, address { font-style: italic !important;}
		pre, tt, code, kbd, samp { font-family: monospace !important;}
		pre             { white-space: pre !important;}
		big             { font-size: 1.17em !important;}
		small, sub, sup { font-size: .83em !important;}
		ol, ul, dd      { margin-left: 40px !important;}
		ol              { list-style-type: decimal !important;}
		ol ul, ul ol, ul ul, ol ol { margin-top: 0 !important; margin-bottom: 0 !important;}
		br { content: "\A" !important;}
		td { border: 0px !important; padding: 0px !important; border-top:1px dashed #ccc ;}
		.print_btn {text-align:center;padding-top:10px;}
		.print_btn a {padding:5px 13px;margin-left:2px;line-height:18px;background:#f9f9f9;border:1px solid #d5d5d5;-webkit-border-radius:3px;-moz-border-radius:3px;border-radius:3px;text-decoration:none;}

		@media print {
		  @page         { margin: 1% !important;}
		  h3,body {margin:0;padding:0}
		  blockquote,
		  pre           { page-break-inside: avoid !important;}
		  tr.first td{border-top:0}
		  .print_btn {display:none}
		}
	</style>
	<script>
		
		window.print();
		setTimeout (window.close, 5000);
		window.onbeforeprint = function () { 
			console.log("onbeforeprint : 프린트 이전에 실행");
			setTimeout("dotest()", 20000);
		}

		window.onafterprint = function () { 
			console.log("onafterprint : 프린트 이후에 실행");
		}

		//setTimeout(window.print_ac(), 2000);
		function print_ac()
		{
			window.print();
			setTimeout (window.close, 5000);
		}

		function doInit() {
		  window.onblur = doOutFocus;
		}

		function doOutFocus() {
		  window.focus();
		}

		function dotest()
		{
			console.log('20초지남');
		}
	</script>
</head>

<body topmargin="0" onLoad="doInit()">
	<div id="target">
		<div style="font-size: 15px; font-weight: bold;font-family: 맑은 고딕"><h3>[자료위치안내]</h3></div>		
		<table cellspacing="0" cellpadding="0">
			<colgroup>
				<col style="width:80px;" class="col1">
				<col class="col2">
			</colgroup>
			<tbody>
				<tr class="first">
					<td colspan="2" class="first last td1">---------------------------------------</td>
				</tr>
				<tr>
					<td style="font-size: 13px; text-align: right; font-weight:bold;vertical-align:top;letter-spacing:-1px;" class="first td1">서명 : </td>
					<td style="font-size: 13px; font-weight:bold;letter-spacing:-1px;" class="last td2">&nbsp;${param.bookname}</td>
				</tr>
				<tr>
					<td style="font-size: 13px; text-align: right; font-weight:bold;letter-spacing:-1px;" class="first td1">청구기호 : </td>
					<td style="font-size: 13px; font-weight:bold;letter-spacing:-1px;" class="last td2">&nbsp;${param.callno}</td>
				</tr>
				<tr>
					<td style="font-size: 13px; text-align: right; font-weight:bold;letter-spacing:-1px;" class="first td1">등록번호 : </td>
					<td style="font-size: 13px; font-weight:bold;letter-spacing:-1px;" class="last td2">&nbsp;${param.regno}</td>
				</tr>
				<tr>
					<td style="font-size: 13px; text-align: right; font-weight:bold;letter-spacing:-1px;" class="first td1">저자 : </td>
				    <td style="font-size: 13px; font-weight:bold;letter-spacing:-1px;" class="last td2">&nbsp;${param.author}</td>
				</tr>
				<tr>
					<td style="font-size: 13px; text-align: right; font-weight:bold;letter-spacing:-1px;" class="first td1">자료실 : </td>
				    <td style="font-size: 13px; font-weight:bold;letter-spacing:-1px;" class="last td2">&nbsp;${param.locname}</td>
				</tr>
				<tr>
				   <td colspan="2" class="first last td1">---------------------------------------</td>
				</tr>
			</tbody>
		</table>
		<div>
			<div>
				<img src="${param.imgurl}" style="width:250px;">
			</div>
		</div>
	</div>

	<!-- <div class="print_btn"><a href="javascript:print_ac();">인쇄</a></div> -->
</body>
</html>


