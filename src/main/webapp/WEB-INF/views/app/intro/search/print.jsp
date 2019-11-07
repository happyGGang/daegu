<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>자료위치안내2</title>
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
@media print {
  @page         { margin: 1% !important;}
  h3,body {margin:0;padding:0}
  blockquote, 
  pre           { page-break-inside: avoid !important;}
  tr.first td{border-top:0}
}
</style>
</head>
<body topmargin="0">
<div id="target" style="width:280px;padding:5px">
<div style="font-size: 15px; font-weight: bold;font-family:돋움; text-align: center;"><h3>[자료위치안내]</h3></div>
<div style="padding-top:10px;margin-top:10px;border-top:1px dashed #555">
	<table cellspacing="0" cellpadding="0" width="100%" style="border:0px">
		<c:forEach items="${resultList}" var="i" varStatus="status">
			<tr class="first">
				<td style="font-size: 14px; text-align: justify; font-weight: bold;font-family: 돋움">서&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;명 :</td>
				<td style="font-size: 14px; font-weight: bold;font-family: 돋움;valign:top;margin-right:15px; ">${i.dsItemDetail[0].TITLE}</td>
			</tr>
			<tr >
				<td style="font-size: 14px; text-align: justify; font-weight: bold;font-family: 돋움">출 판 사 :</td>
				<td style="font-size: 14px; font-weight: bold;font-family: 돋움;valign:top;margin-right:15px; ">${i.dsItemDetail[0].PUBLISHER}</td>
			</tr>
			<tr>
				<td style="font-size: 14px; text-align: justify; font-weight: bold;font-family: 돋움">청구기호 :</td>
				<td style="font-size: 14px; font-weight: bold ;font-family: 돋움">${i.dsItemDetail[0].CALL_NO}</td>
			</tr>
			<tr>
				<td style="width: 70px; font-size: 14px; text-align: justify; font-weight: bold;font-family: 돋움">등록번호 :</td>
				<td style="font-size: 14px; font-weight: bold;font-family: 돋움 ">${i.dsItemDetail[0].ACSSON_NO}</td>
			</tr>
			<tr>
				<td style="font-size: 14px; text-align: justify; font-weight: bold;font-family: 돋움">저&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;자 :</td>
				<td style="font-size: 14px; font-weight: bold;font-family: 돋움 ">${i.dsItemDetail[0].AUTHOR}</td> 
			</tr>
			<tr>
				<td style="font-size: 14px; text-align: justify; font-weight: bold;font-family: 돋움">자&nbsp;&nbsp;료&nbsp;실 : </td>
				<td style="font-size: 14px; font-weight: bold;font-family: 돋움 ">${i.dsItemDetail[0].SUB_LOCA_NAME}</td>
			</tr>
			<tr>
				<td style="font-size: 14px; text-align: justify; font-weight: bold;font-family: 돋움">서&nbsp;&nbsp;가&nbsp;명 : </td>
				<td style="font-size: 14px; font-weight: bold;font-family: 돋움 ">${i.dsItemDetail[0].BOOKSH_NAME}</td>
			</tr>
			<c:if test="${i.dsItemDetail[0].PLACE_NO ne null and i.dsItemDetail[0].PLACE_NO ne ''}">
				<tr>
					<td style="font-size: 14px; text-align: justify; font-weight: bold;font-family: 돋움">별치기호 :</td>
					<td style="font-size: 14px; font-weight: bold;font-family: 돋움 ">${i.dsItemDetail[0].PLACE_NO}</td>
				</tr>
			</c:if>
			<tr>
				<td colspan="2"><div style="padding-top:10px;margin-top:10px;border-top:1px dashed #555"></td>
			</tr>
		</c:forEach>
	</table>
</div>
</div>
</body>
</html>