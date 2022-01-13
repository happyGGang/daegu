<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" type="text/css" href="/resources/book/search/css/default.css"/>


<!-- contents-title-->
<div id="contents-title">
	<h2>상호대차 신청을 위한 선택사항<span style="font-weight:300">을 확인하세요.</span></h2>
</div>
<!-- /contents-title-->	

<form id="sanghoForm" action="sanghoSave.do" method="post">
<div class="delibery_info">
	<input type="hidden" id="option" name="option" value="req"/>
	<input type="hidden" id="regno" name="regno" value=""/>
	<input type="hidden" id="libcode" name="libcode" value=""/>
	<input type="hidden" id="specieskey" name="specieskey" value=""/>
	<input type="hidden" id="localkey" name="localkey" value=""/>	
	<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
	
	<div class="" style="padding:10px 0;font-size:120%">(<span style="color:red;font-weight:bold;">*</span>) 항목은 필수 입력값입니다.</div>
	<table class="editTbl">
		<colgroup>
		   <col width="28%" />
		   <col width="*"/>
		</colgroup>
		<tbody>
			<tr>
				<th>신청인</th>
				<td></td>
			</tr>
			<tr>
				<th>제공도서관</th>
				<td></td>
			</tr>
			<tr>
				<th>이용도서관</th>
				<td>
					<select id="uselibcode" name="uselibcode" style="border:1px solid #c9c9c9;border-radius:4px;height:30px">
						<option value="126143">연제도서관</option>						
						<option value="126049">거제2동작은도서관</option>						
						<option value="126048">밤골작은도서관</option>						
						<option value="126047">배산작은도서관</option>						
						<option value="126068">해뜰새마을문고</option>						
						<option value="726245">해맞이작은도서관</option>						
					</select>
				</td>
			</tr>
			<tr>
				<th>도서명</th>
				<td></td>
			 </tr>
			 <tr>
				<th>등록번호</th>
				<td></td>
			 </tr>
			 <tr>
				<th>부록대출여부</th>
				<td>
					<input id="appendixrctyn" name="appendixrctyn" type="checkbox" value="Y"/><label for="appendixrctyn1"> (해당 도서에 부록이 있을 시 부록도 같이 대출하겠습니다.)</label>
				</td>
			 </tr>
		</tbody>
	</table>
	<div class="btnArea" style="text-align: center; padding-top: 25px;">
		<a href="/yjbooks/" id="cancel-btn" class="btn btn02">취소</a>
		<a href="#" id="save-btn" class="btn btn03">확인</a>
	</div>
</div>
</form>