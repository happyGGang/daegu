<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<c:choose>
	<c:when test="${homepage.context_path eq 'dmsl'}">
	<script type="text/javascript">
	$(function() {

		$('#save-btn').on('click', function(e) {
			e.preventDefault();
			if (!confirm('별관 이동도서관 신청을 하시겠습니까?')) {
				return false;
			}

			if (doAjaxPost($('form#librarySearch'))) {
				history.back();
			}
		});

	});
	</script>
	</c:when>
	<c:otherwise>
	<script type="text/javascript">
	$(function() {

		$('#save-btn').on('click', function(e) {
			e.preventDefault();
			if (!confirm('무인예약 신청을 하시겠습니까?\n도서연체시 대출불가')) {
				return false;
			}

			if ($('select#worker').val() == '') {
				alert('수령장소를 선택하세요.');
				$('select#worker').focus();
				return false;
			}

			if (doAjaxPost($('form#librarySearch'))) {
				history.back();
			}
		});

	});
	</script>
	</c:otherwise>
</c:choose>

<!-- contents-title-->
<div id="contents-title">
	<h2>무인예약 신청을 위한 신청사항<span style="font-weight:300">을 확인하세요.</span></h2>
</div>
<!-- /contents-title-->

<form:form modelAttribute="librarySearch" action="save.do" method="post" onsubmit="return false;">
<form:hidden path="bookkey"/>
<form:hidden path="regNo"/>
<form:hidden path="manageCode"/>
<form:hidden path="menu_idx"/>
<form:hidden path="book_name"/>
<form:hidden path="shelf_loc_name"/>
<input type="hidden" name="booktype" id="booktype" value="${fn:substring(detail.WORKING_STATUS,0,2) }"/>
<!-- <input type="hidden" name="title" value="${detail.TITLE_INFO}"/> -->
<c:if test="${homepage.context_path eq 'dmsl'}">
<input type="hidden" name="exprire_date_cnt" value="7"/>
</c:if>
<c:if test="${homepage.context_path eq 'gukbo'}">
<input type="hidden" name="exprire_date_cnt" value="7"/>
</c:if>
<c:if test="${homepage.context_path eq '228'}">
<input type="hidden" name="exprire_date_cnt" value="3"/>
</c:if>
<c:if test="${homepage.context_path eq 'dalseolib' || homepage.context_path eq 'kids' || homepage.context_path eq 'seongseo' || homepage.context_path eq 'bolli' || homepage.context_path eq 'family' || homepage.context_path eq 'english'}">
<input type="hidden" name="exprire_date_cnt" value="7"/>
</c:if>
<c:if test="${homepage.context_path eq 'dalseonglib'}">
<input type="hidden" name="exprire_date_cnt" value="1"/>
</c:if>
<c:if test="${homepage.context_path eq 'nearbylib'}">
<input type="hidden" name="exprire_date_cnt" value="3"/>
</c:if>
<c:if test="${homepage.context_path eq 'seogulib'}">
<input type="hidden" name="exprire_date_cnt" value="1"/>
</c:if>

<div class="delibery_info">

	<div class="" style="padding:10px 0;font-size:120%">(<span style="color:red;font-weight:bold;">*</span>) 항목은 필수 입력값입니다.</div>
	<table class="table_01">
		<colgroup>
			<col width="28%" />
			<col width="*"/>
		</colgroup>
		<tbody>
			<tr>
				<th>신청인</th>
				<td class="left">${sessionScope.member.member_name}</td>
			</tr>
			<tr>
				<th>소장도서관</th>
				<td class="left">${detail.LIB_NAME}</td>
			</tr>
			<c:choose>
			<c:when test="${homepage.context_path eq 'dmsl'}">
			<input type="hidden" name="worker" id="worker" value="DMSL0011"/>
			</c:when>
			<c:otherwise>
			<tr>
				<th>수령장소</th>
				<td class="left">
					<form:select path="worker" style="border:1px solid #c9c9c9;border-radius:4px;height:30px">
						<c:if test="${homepage.context_path eq 'gukbo'}">
						<form:option value="SUB01">반월당역 예약대출기</form:option>
						</c:if>
						<c:if test="${homepage.context_path eq '228'}">
						<form:option value="DBECOBOXLIB01">스마트도서관</form:option> 
						</c:if>
						<c:if test="${sessionScope.member.member_id eq 'hyunwoo929' || sessionScope.member.member_id eq 'hwani6865'}">
							<form:option value="DSSUB02">용산역</form:option>
							<form:option value="DSSUB01">상인역</form:option>
							<form:option value="SSSUBCO01">성서도서관</form:option>
							<form:option value="BRSUBCO01">본리도서관</form:option>
						</c:if>
						<c:if test="${homepage.context_path eq 'dalseolib' || homepage.context_path eq 'kids' || homepage.context_path eq 'seongseo' || homepage.context_path eq 'bolli' || homepage.context_path eq 'family' || homepage.context_path eq 'english'}">
						<form:option value="DSSUB02">용산역</form:option>
						<form:option value="DSSUB01">상인역</form:option>
						</c:if>
						<c:if test="${homepage.context_path eq 'dalseonglib'}">
						<form:option value="DSGLIB01">지하1층 자전거보관대옆</form:option>
						</c:if>
						<c:if test="${homepage.context_path eq 'nearbylib'}">
						<form:option value="ESIASUBCO01">이시아폴리스 메가박스</form:option>
						</c:if>
						<c:if test="${homepage.context_path eq 'seogulib'}">
						<form:option value="BMSUB01">비원도서관 1층 입구</form:option>
						</c:if>
					</form:select>
					<c:if test="${homepage.context_path eq '228'}">
						<p style="font-weight:bold;">
							※ 후 수령가능 문자를 받으시면 스마트도서관(1층 현관 좌측)에서 대출 가능합니다.
						</p>
					</c:if>
				</td>
			</tr>
			</c:otherwise>
			</c:choose>
			 <tr>
				<th>도서명</th>
				<td class="left">${detail.TITLE_INFO}</td>
			 </tr>
			 <tr>
				<th>등록번호</th>
				<td class="left">${detail.REG_NO}</td>
			 </tr>
		</tbody>
	</table>

	<c:choose>
	<c:when test="${homepage.context_path eq 'dmsl'}">
	</c:when>
	<c:when test="${homepage.context_path eq 'nearbylib'}">
	</c:when>
	<c:otherwise>
	<div id="" class="" style="text-align: center; padding-top: 15px;">
		<p style="color: red;font-weight: bold;">* 도서연체중에는 무인예약대출불가 (본인 대출상태 확인필요)</p>
		<c:if test="${homepage.context_path eq 'jungang'}">
		<p style="color: red;font-weight: bold;">* 서고자료는 도서관 전화문의 후 예약필요</p>
		</c:if>
		<c:if test="${homepage.context_path eq 'dalseolib'}">
		<p style="color: red;font-weight: bold;">* 소장도서관 대출 허용 권수(10권) 초과 시 무인예약 도서 대출 불가능(반납 후 대출가능)</p>
		</c:if>
	</div>
	</c:otherwise>
	</c:choose>


	<div class="btnArea" style="text-align: center; padding-top:5px;">
		<a href="#" id="save-btn" class="btn btn03">확인</a>
		<a href="javascript:history.back();" class="btn btn02">취소</a>
	</div>
</div>
</form:form>