<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" type="text/css" href="/resources/book/search/css/default.css"/>
<script type="text/javascript">
$(function() {
	$('#req-btn').on('click', function(e) {
		doGetLoad('req.do');
		e.preventDefault();
	});

	$('.cancel-btn').on('click', function(e) {
		$('#editMode').val("CANCEL");
		$('#select_no').val($(this).attr('keyValue1'));
		if ( doAjaxPost($('#modHope')) ) {
			location.reload();
		}
		e.preventDefault();
	});

	$('.del-btn').on('click', function(e) {
		$('#editMode').val("DELETE");
		$('#select_no').val($(this).attr('keyValue'));
		if ( doAjaxPost($('#modHope')) ) {

		}
		e.preventDefault();
	});

 	$('a#search-btn').on('click', function(e) {
		e.preventDefault();
		$('#search_text').val(compactTrim($('#search_text').val()));
		doGetLoad('allHistory.do', $('form#librarySearch').serialize());
	});

	$('input#search_start_date').datepicker({
		maxDate: $('input#search_end_date').val(),
		onClose: function(selectedDate){
			$('input#search_end_date').datepicker('option', 'minDate', selectedDate);
		}
	});
	$('input#search_end_date').datepicker({
		minDate: $('input#search_start_date').val(),
		onClose: function(selectedDate){
			$('input#search_start_date').datepicker('option', 'maxDate', selectedDate);
		}
	});


	$('div#board_paging a').on('click', function(e) {
		$('#viewPage').attr('value', $(this).attr('keyValue'));
		var param = serializeCustom($('form#librarySearch'));
		doGetLoad('allHistory.do', param);
		e.preventDefault();
	});

	$('select#rowCount').on('change', function() {
		$('#viewPage').attr('value', '1');
		var param = serializeCustom($('form#librarySearch'));
		doGetLoad('allHistory.do', param);
	});


});

function compactTrim(str) {
	return str.replace( /(\s*)/g, "");
}
</script>


<form:form modelAttribute="librarySearch" action="allHistory.do" >
<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
<div class="bbs-notice" style="margin-top:10px;margin-bottom:20px;padding:20px;text-align:center;" >
	조회기간 :
		<form:input path="search_start_date" cssClass="text ui-calendar new_text01"/><label for="search_start_date" style="display: none;">시작일</label> ~
		<form:input path="search_end_date" cssClass="text ui-calendar new_text01"/><label for="search_end_date" style="display: none;">종료일</label>
		<form:hidden path="menu_idx"/>
	<span style="color:#ccc;padding:0 10px 0 15px;">│</span>
	<p class="m_br_box"></p>
	신청상태 :
	<form:select path="furnish_status" cssClass="selectmenu new_select_box">
		<form:option value="" label="전체"></form:option>
		<form:option value="1" label="신청중"></form:option>
		<form:option value="2" label="처리중"></form:option>
		<form:option value="3" label="소장중"></form:option>
		<form:option value="4" label="취소"></form:option>
	</form:select>
	
	<form:select path="search_type" cssClass="selectmenu new_select_box" >
		<form:option value="title" label="서명"></form:option>
		<form:option value="author" label="저자"></form:option>
		<form:option value="publisher" label="발행자"></form:option>
		<form:option value="publish_year" label="발행년"></form:option>
	</form:select>
	<form:input path="search_text" cssClass="text new_text01" accesskey="s" title="검색어" alt="검색어"  placeholder="검색어를 입력하세요" style="height:33px !important;background:#fff;border:1px solid #ccc;border-radius:3px !important;"/>
	<a href="#" id="search-btn" class="btn btn1">조회</a>
</div>

<c:choose>
	<c:when test="${homepage.context_path eq 'dalseonglib'}">
	<div id="libraryList" class="libraryList">
		<div>
			<input id="checkAll" name="libraryCodes" type="checkbox" value="ALL"/><label for="checkAll">전체</label>
		</div>
		<div>
			<ul>
				<li>
					<form:checkbox path="libraryCodes" value="BR" class="libCheck lib_BR" label="달성군립도서관"/>
				</li>
				<li>
					<form:checkbox path="libraryCodes" value="GA" class="libCheck lib_GA" label="화원읍작은도서관"/>
				</li>
				<li>
					<form:checkbox path="libraryCodes" value="GB" class="libCheck lib_GB" label="논공읍작은도서관"/>
				</li>
				<li>
					<form:checkbox path="libraryCodes" value="HG" class="libCheck lib_HG" label="다사읍작은도서관"/>
				</li>
				<li>
					<form:checkbox path="libraryCodes" value="GD" class="libCheck lib_GD" label="다사읍서재작은도서관"/>
				</li>
				<li>
					<form:checkbox path="libraryCodes" value="GF" class="libCheck lib_GF" label="유가읍작은도서관"/>
				</li>
				<li>
					<form:checkbox path="libraryCodes" value="GH" class="libCheck lib_GH" label="옥포읍작은도서관"/>
				</li>
				<li>
					<form:checkbox path="libraryCodes" value="FR" class="libCheck lib_FR" label="가창면참꽃작은도서관"/>
				</li>
				<li>
					<form:checkbox path="libraryCodes" value="GE" class="libCheck lib_GE" label="하빈면작은도서관"/>
				</li>
				<li>
					<form:checkbox path="libraryCodes" value="GC" class="libCheck lib_GC" label="구지면작은도서관"/>
				</li>
				<li>
					<form:checkbox path="libraryCodes" value="FN" class="libCheck lib_FN" label="달성군청소년센터"/>
				</li>
				<li>
					<form:checkbox path="libraryCodes" value="FJ" class="libCheck lib_FJ" label="달성군청도서관"/>
				</li>
			</ul>
		</div>
		<div class="end"></div>
	</div>
	<div class="end" style="padding:7px 0;"></div>
	</c:when>
	<c:when test="${homepage.context_path eq 'seogulib'}">
	<div id="libraryList" class="libraryList">
		<div>
			<input id="checkAll" name="libraryCodes" type="checkbox" value="ALL"/><label for="checkAll">전체</label>
		</div>
		<div>
			<ul>
				<li>
					<form:checkbox path="libraryCodes" value="BL" class="libCheck lib_BL" label="서구어린이도서관"/>
				</li>
				<li>
					<form:checkbox path="libraryCodes" value="BQ" class="libCheck lib_BQ" label="비산도서관"/>
				</li>
				<li>
					<form:checkbox path="libraryCodes" value="BP" class="libCheck lib_BP" label="서구영어도서관"/>
				</li>
				<li>
					<form:checkbox path="libraryCodes" value="BM" class="libCheck lib_BM" label="비원도서관"/>
				</li>
				<li>
					<form:checkbox path="libraryCodes" value="BN" class="libCheck lib_BN" label="원고개도서관"/>
				</li>
				<li>
					<form:checkbox path="libraryCodes" value="GQ" class="libCheck lib_GQ" label="내당2,3동 드림도서관"/>
				</li>
				<li>
					<form:checkbox path="libraryCodes" value="FU" class="libCheck lib_FU" label="내당4동어린이도서관"/>
				</li>
				<li>
					<form:checkbox path="libraryCodes" value="FZ" class="libCheck lib_FZ" label="비산7동 작은도서관"/>
				</li>
				<li>
					<form:checkbox path="libraryCodes" value="FH" class="libCheck lib_FH" label="새마을문고대구서구지부작은도서관"/>
				</li>
				<li>
					<form:checkbox path="libraryCodes" value="FT" class="libCheck lib_FT" label="서구청작은도서관"/>
				</li>
				<li>
					<form:checkbox path="libraryCodes" value="HC" class="libCheck lib_HC" label="달성토성마을 다락방 작은도서관"/>
				</li>
			</ul>
		</div>
		<div class="end"></div>
	</div>
	<div class="end" style="padding:7px 0;"></div>
	</c:when>
	<c:when test="${homepage.context_path eq 'dalseolib'}">
	<div id="libraryList" class="libraryList">
		<div>
			<input id="checkAll" name="libraryCodes" type="checkbox" value="ALL"/><label for="checkAll">전체</label>
		</div>
		<div>
			<ul>
				<li>
					<form:checkbox path="libraryCodes" value="BU" class="libCheck lib_BU" label="성서도서관"/>
				</li>
				<li>
					<form:checkbox path="libraryCodes" value="BV" class="libCheck lib_BV" label="달서어린이도서관"/>
				</li>
				<li>
					<form:checkbox path="libraryCodes" value="BW" class="libCheck lib_BW" label="도원도서관"/>
				</li>
				<li>
					<form:checkbox path="libraryCodes" value="BX" class="libCheck lib_BX" label="본리도서관"/>
				</li>
				<li>
					<form:checkbox path="libraryCodes" value="BY" class="libCheck lib_BY" label="달서가족문화도서관"/>
				</li>
				<li>
					<form:checkbox path="libraryCodes" value="BZ" class="libCheck lib_BZ" label="달서영어도서관"/>
				</li>
				<li>
					<form:checkbox path="libraryCodes" value="FA" class="libCheck lib_FA" label="이곡2동공립작은도서관"/>
				</li>
				<li>
					<form:checkbox path="libraryCodes" value="FB" class="libCheck lib_FB" label="용산1동작은도서관"/>
				</li>
				<li>
					<form:checkbox path="libraryCodes" value="FC" class="libCheck lib_FC" label="장기동작은도서관"/>
				</li>
				<li>
					<form:checkbox path="libraryCodes" value="FD" class="libCheck lib_FD" label="죽전동공립작은도서관"/>
				</li>
				<li>
					<form:checkbox path="libraryCodes" value="FW" class="libCheck lib_FW" label="웃는얼굴아트센터 도서실"/>
				</li>
				<li>
					<form:checkbox path="libraryCodes" value="FX" class="libCheck lib_FX" label="행정정보문고센터"/>
				</li>
				<li>
					<form:checkbox path="libraryCodes" value="GK" class="libCheck lib_GK" label="학산작은도서관"/>
				</li>
			</ul>
		</div>
		<div class="end"></div>
	</div>
	<div class="end" style="padding:7px 0;"></div>
	</c:when>
	<c:when test="${homepage.context_path eq 'namdm' || homepage.context_path eq 'namic'}">
	<div id="libraryList" class="libraryList">
		<div>
			<input id="checkAll" name="libraryCodes" type="checkbox" value="ALL"/><label for="checkAll">전체</label>
		</div>
		<div>
			<ul>
				<li>
					<form:checkbox path="libraryCodes" value="BT" class="libCheck lib_BT" label="이천어울림도서관"/>
				</li>
				<li>
					<form:checkbox path="libraryCodes" value="BS" class="libCheck lib_BS" label="대명어울림도서관"/>
				</li>
				<li>
					<form:checkbox path="libraryCodes" value="FE" class="libCheck lib_FE" label="꿈틀작은도서관"/>
				</li>
			</ul>
		</div>
		<div class="end"></div>
	</div>
	<div class="end" style="padding:7px 0;"></div>
	</c:when>
	<c:when test="${homepage.context_path eq 'junggu'}">
	<div id="libraryList" class="libraryList">
		<div>
			<input id="checkAll" name="libraryCodes" type="checkbox" value="ALL"/><label for="checkAll">전체</label>
		</div>
		<div>
			<ul>
				<li>
					<form:checkbox path="libraryCodes" value="FS" class="libCheck lib_FS" label="대구중구영어도서관"/>
				</li>
				<li>
					<form:checkbox path="libraryCodes" value="FF" class="libCheck lib_FF" label="남산4동작은도서관"/>
				</li>
				<li>
					<form:checkbox path="libraryCodes" value="FQ" class="libCheck lib_FQ" label="동인 느티나무 도서관"/>
				</li>
				<li>
					<form:checkbox path="libraryCodes" value="FY" class="libCheck lib_FY" label="중구청교양정보실"/>
				</li>
				<li>
					<form:checkbox path="libraryCodes" value="GG" class="libCheck lib_GG" label="대신동작은도서관"/>
				</li>
				<li>
					<form:checkbox path="libraryCodes" value="HA" class="libCheck lib_HA" label="삼덕마루 작은도서관"/>
				</li>
				<li>
					<form:checkbox path="libraryCodes" value="HF" class="libCheck lib_HF" label="대봉2동작은도서관"/>
				</li>
			</ul>
		</div>
		<div class="end"></div>
	</div>
	<div class="end" style="padding:7px 0;"></div>
	</c:when>
	<c:when test="${homepage.context_path eq 'beomeo' || homepage.context_path eq 'yonghak' || homepage.context_path eq 'gosan'}">
	<div id="libraryList" class="libraryList">
		<c:if test="${homepage.context_path eq 'yonghak' and fn:length(mediaCodeList) < 1}">
			<form:hidden path="media_code"/>
		</c:if>

		<div>
			<input id="checkAll" name="libraryCodes" type="checkbox" value="ALL"/><label for="checkAll">전체</label>
		</div>
		<div>
			<ul>
				<li>
					<form:checkbox path="libraryCodes" value="BD" class="libCheck lib_BD" label="범어도서관"/>
				</li>
				<li>
					<form:checkbox path="libraryCodes" value="BE" class="libCheck lib_BE" label="용학도서관"/>
				</li>
				<li>
					<form:checkbox path="libraryCodes" value="BF" class="libCheck lib_BF" label="고산도서관"/>
				</li>
				<li>
					<form:checkbox path="libraryCodes" value="BG" class="libCheck lib_BG" label="파동도서관"/>
				</li>
				<li>
					<form:checkbox path="libraryCodes" value="BH" class="libCheck lib_BH" label="무학숲도서관"/>
				</li>
				<li>
					<form:checkbox path="libraryCodes" value="BJ" class="libCheck lib_BJ" label="책숲길도서관"/>
				</li>
				<li>
					<form:checkbox path="libraryCodes" value="BK" class="libCheck lib_BK" label="물망이도서관"/>
				</li>
				<li>
					<form:checkbox path="libraryCodes" value="FG" class="libCheck lib_FG" label="사월역도서관"/>
				</li>
			</ul>
		</div>
		<div class="end"></div>
	</div>
	<div class="end" style="padding:7px 0;"></div>
	</c:when>
	<c:when test="${homepage.context_path eq 'bukgs' || homepage.context_path eq 'bukdh' || homepage.context_path eq 'buktj'}">
	<div id="libraryList" class="libraryList">
		<div>
			<input id="checkAll" name="libraryCodes" type="checkbox" value="ALL"/><label for="checkAll">전체</label>
		</div>
		<div>
			<ul>
				<li>
					<form:checkbox path="libraryCodes" value="BA" class="libCheck lib_BA" label="구수산도서관"/>
				</li>
				<li>
					<form:checkbox path="libraryCodes" value="BB" class="libCheck lib_BB" label="대현도서관"/>
				</li>
				<li>
					<form:checkbox path="libraryCodes" value="BC" class="libCheck lib_BC" label="태전도서관"/>
				</li>
				<li>
					<form:checkbox path="libraryCodes" value="GJ" class="libCheck lib_GJ" label="태전1동 작은도서관"/>
				</li>
				<li>
					<form:checkbox path="libraryCodes" value="GL" class="libCheck lib_GL" label="산격1동 작은도서관"/>
				</li>
				<li>
					<form:checkbox path="libraryCodes" value="GM" class="libCheck lib_GM" label="북구영어작은도서관"/>
				</li>
				<li>
					<form:checkbox path="libraryCodes" value="GN" class="libCheck lib_GN" label="침산1동 작은도서관"/>
				</li>
				<li>
					<form:checkbox path="libraryCodes" value="GP" class="libCheck lib_GP" label="노원동 작은도서관"/>
				</li>
				<li>
					<form:checkbox path="libraryCodes" value="HB" class="libCheck lib_HB" label="서변동작은도서관"/>
				</li>
				<li>
					<form:checkbox path="libraryCodes" value="HD" class="libCheck lib_HD" label="노원행복도서관"/>
				</li>
				<li>
					<form:checkbox path="libraryCodes" value="HE" class="libCheck lib_HE" label="한강공원부키도서관"/>
				</li>
			</ul>
		</div>
		<div class="end"></div>
	</div>
	<div class="end" style="padding:7px 0;"></div>
	</c:when>
	<c:when test="${homepagePath eq 'donggu'}">
	<div id="libraryList" class="libraryList">
		<div>
			<input id="checkAll" name="libraryCodes" type="checkbox" value="ALL"/><label for="checkAll">전체</label>
		</div>
		<div>
			<ul>
				<li><form:checkbox path="libraryCodes" value="CA" class="libCheck lib_CA" label="안심도서관"/></li>
				<li><form:checkbox path="libraryCodes" value="CB" class="libCheck lib_CB" label="신천도서관"/></li>
				<li><form:checkbox path="libraryCodes" value="GR" class="libCheck lib_GR" label="신암2동 작은도서관"/></li>
				<li><form:checkbox path="libraryCodes" value="GS" class="libCheck lib_GS" label="신암3동 작은도서관"/></li>
				<li><form:checkbox path="libraryCodes" value="GZ" class="libCheck lib_GZ" label="동구청 작은도서관"/></li>
				<li><form:checkbox path="libraryCodes" value="GU" class="libCheck lib_GU" label="불로어울림 작은도서관"/></li>
				<li><form:checkbox path="libraryCodes" value="GV" class="libCheck lib_GV" label="지저동 작은도서관"/></li>
				<li><form:checkbox path="libraryCodes" value="FM" class="libCheck lib_FM" label="반야월역사 작은도서관"/></li>
				<li><form:checkbox path="libraryCodes" value="FL" class="libCheck lib_FL" label="도평동 작은도서관"/></li>
				<li><form:checkbox path="libraryCodes" value="GY" class="libCheck lib_GY" label="해안동 작은도서관"/></li>
				<li><form:checkbox path="libraryCodes" value="GX" class="libCheck lib_GX" label="방촌동 작은도서관"/></li>
				<li><form:checkbox path="libraryCodes" value="GW" class="libCheck lib_GW" label="동촌역사 작은도서관"/></li>
				<li><form:checkbox path="libraryCodes" value="GT" class="libCheck lib_GT" label="효목1동 작은도서관"/></li>
				<li><form:checkbox path="libraryCodes" value="FP" class="libCheck lib_FP" label="효목2동 작은도서관"/></li>
				<li><form:checkbox path="libraryCodes" value="FK" class="libCheck lib_FK" label="신천3동 작은도서관"/></li>
			</ul>
		</div>
		<div class="end"></div>
	</div>
	<div class="end" style="padding:7px 0;"></div>
	</c:when>
	<c:otherwise>

	</c:otherwise>
</c:choose>
<form:hidden path="menu_idx"/>
<div class="book-list" style="margin-top:30px;padding-top:15px;">
	<c:if test="${fn:length(hopeList) < 1 }"> <h3>희망도서신청 내역이 없습니다.</h3></c:if>
	<div class="box">
		<div class="item">
			<div class="bci">
				<table summary="신청정보">
					<colgroup>
						<col width="8%"/>
						<col >
						<col width="20%"/>
						<col width="10%"/>
						<col width="12%"/>
						<col width="8%"/>
					</colgroup>
					<thead>
						<tr>
							<th class="center">순번</th>
							<th class="center">서명</th>
							<th class="center">저자</th>
							<th class="center">출판사</th>
							<th class="center">신청일</th>
							<th class="center">처리결과</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${hopeList}" var="i" varStatus="status">
						<c:if test="${status.first}">
						<h3>신청내역 수: 총 ${paging.totalDataCount} 건</h3>
						<p style="text-align:right;margin-top:-45px;margin-bottom:15px;">
							<form:select path="rowCount" cssClass="new_select_box">
								<form:option value="10" label="10개씩 보기" />
								<form:option value="20" label="20개씩 보기" />
								<form:option value="30" label="30개씩 보기" />
								<form:option value="50" label="50개씩 보기" />
								<form:option value="100" label="100개씩 보기" />
							</form:select>
						</p>
						</c:if>
						<tr>
							<th>${paging.listRowNum - status.index}</th>
							<td>${i.TITLE}</td>
							<td>${i.AUTHOR}</td>
							<td>${i.PUBLISHER}</td>
							<td>${i.APPLICANT_DATE}</td>
							<td>
							<c:choose>
								<c:when test="${i.FURNISH_STATUS eq '1'}">신청중</c:when>
								<c:when test="${i.FURNISH_STATUS eq '2'}">처리중</c:when>
								<c:when test="${i.FURNISH_STATUS eq '3'}">소장중</c:when>
								<c:when test="${i.FURNISH_STATUS eq '4'}">취소</c:when>
							</c:choose>
							</td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<form:hidden path="viewPage"/>
	<div id="board_paging" class="dataTables_paginate">
		<c:if test="${paging.firstPageNum > 0}">
			<a href="" class="paginate_button previous" keyValue="${paging.firstPageNum}">처음</a>
		</c:if>
		<c:if test="${paging.prevPageNum > 0}">
			<a href="" class="paginate_button previous" keyValue="${paging.prevPageNum}">이전</a>
		</c:if>
		<span>
			<c:forEach var="i" varStatus="status" begin="${paging.startPageNum}" end="${paging.endPageNum}">
				<c:choose>
					<c:when test="${i eq paging.viewPage}">
						<a href="" class="paginate_button current" keyValue="${i}">${i}</a>
					</c:when>
					<c:otherwise>
						<a href="" class="paginate_button" keyValue="${i}">${i}</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:if test="${paging.nextPageNum > 0}">
				<a href="" class="paginate_button next" keyValue="${paging.nextPageNum}">다음</a>
			</c:if>
			<c:if test="${paging.totalPageCount ne paging.lastPageNum}">
				<a href="" class="paginate_button next" keyValue="${paging.totalPageCount}">맨끝</a>
			</c:if>
		</span>
	</div>
</div>
</form:form>

<form:form id="modHope" modelAttribute="librarySearch" method="POST" action="save.do">
	<form:hidden path="editMode"/>
	<form:hidden path="select_no"/>
</form:form>