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
		//setTimeout(window.print(), 1000);
		function print_ac()
		{
			window.print();
			setTimeout (window.close,5000);
		}

		function doInit() {
		  window.onblur = doOutFocus;
		}

		function doOutFocus() {
		  window.focus();
		}
	</script>
</head>

<body topmargin="0" onLoad="doInit()">
	<div id="target">
		<div style="font-size: 15px; font-weight: bold;font-family: 맑은 고딕"><h3>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[자료위치안내]</h3></div>
		<table cellspacing="0" cellpadding="0">
		</table>
		<table cellspacing="0" cellpadding="0">
			<colgroup>
				<col style="width:110px;" class="col1">
				<col class="col2">
			</colgroup>
			<tbody>
				<tr class="first">
				   <td colspan="2" class="first last td1">-------------------------------------------</td>
				</tr>
				<tr>
				    <td style="font-size: 14px; font-weight: bold;font-family: 맑은 고딕 " class="last td2">${detail.imgUrl}</td>
				    <td style="font-size: 14px; font-weight: bold;font-family: 맑은 고딕 " class="last td2">${detail.imgUrl}</td>
				    <td style="font-size: 14px; font-weight: bold;font-family: 맑은 고딕 " class="last td2">${detail.locName}</td>
				</tr>
				<tr>
				   <td colspan="2" class="first last td1">-------------------------------------------</td>
				</tr>
			</tbody>
		</table>
	</div>

	<div class="print_btn"><a href="javascript:print_ac();">인쇄</a></div>
</body>
</html>


