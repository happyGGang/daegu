<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" type="text/css" href="/resources/book/css/default.css"/>
<script src="/resources/common/js/moment.min.js"></script>
<style>
	.clearfix {
	    clear: both;
	    overflow: hidden;
	}
	.inputDate {
		padding: 0 10px 0 5px;
	}
</style>
<script type="text/javascript">
	$(function() {
		$('input#searchStartDate').datepicker({
			maxDate: $('input#searchStartDate').val(),
			onClose: function(selectedDate){
				$('input#searchEndDate').datepicker('option', 'minDate', selectedDate);
			}
		});
		$('input#searchEndDate').datepicker({
			minDate: $('input#searchEndDate').val(),
			onClose: function(selectedDate){
				$('input#searchStartDate').datepicker('option', 'maxDate', selectedDate);
			}
		});
		
		$("#toYearBtn, #toMonthBtn, #toWeekBtn").click(fnSetSearchDate);
		
		function fnSetSearchDate(){
			switch($(this).attr("id")){
				case "toYearBtn":
					$("#searchStartDate").val(moment().startOf('year').format("YYYY-MM-DD"));
					$("#searchEndDate").val(moment().endOf('year').format("YYYY-MM-DD"));
					break;
				case "toMonthBtn":
					$("#searchStartDate").val(moment().startOf('month').format("YYYY-MM-DD"));
					$("#searchEndDate").val(moment().endOf('month').format("YYYY-MM-DD"));
					break;
				case "toWeekBtn":
					$("#searchStartDate").val(moment().startOf('week').format("YYYY-MM-DD"));
					$("#searchEndDate").val(moment().endOf('week').format("YYYY-MM-DD"));
					break;
			}
		}
		
		$("input[type=checkbox][name=age], input[type=checkbox][name=region], input[type=checkbox][name=kdc]").click(fnSearchSelectMulti);

		function fnSearchSelectMulti(){
			if($(this).val() == ""){
				$("input[type=checkbox][name=" + $(this).attr("name") + "]:gt(0)").prop("checked", false)
			}else{
				$("input[type=checkbox][name=" + $(this).attr("name") + "]:first").prop("checked", false)
			}
		}
		
		
		$('a#searchBtn').on('click', function(e) {
			e.preventDefault();
			$('#viewPage').val(1);
			doGetLoad('index.do', serializeCustom($('form#librarySearch')));
		});
		
		<c:forEach items="${popularBookList}" varStatus="status" var="i">
			$('a#btn${status.count}, a#cover${status.count}').on('click', function(e) {
				e.preventDefault();
				$('input#isbn13').val('${i.isbn13}');
				doGetLoad('detail.do', serializeCustom($('form#librarySearch')));
			});
		</c:forEach>
	});
</script>
<form:form modelAttribute="librarySearch" action="index.do" onsubmit="return false;">
	<form:hidden path="menu_idx"/>
	<form:hidden path="isbn13"/>
	<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
	
	<!-- 도서 필터 -->
	<div class="bookFilterForm">
		<div class="filterFormArea clearfix">
			<div class="field clearfix">
				<strong class="tit">성별</strong>
				<div class="radiobtnGroup">
					<span class="radiobtn"><form:radiobutton path="gender" id="searchGenderAll" value=""/><label for="searchGenderAll">전체</label></span>
					<span class="radiobtn"><form:radiobutton path="gender" id="searchGender1" value="0"/><label for="searchGender1">남자</label></span>
					<span class="radiobtn"><form:radiobutton path="gender" id="searchGender2" value="1"/><label for="searchGender2">여자</label></span>
				</div>
			</div>
			<div class="field clearfix">
				<strong class="tit">연령대</strong>
				<div class="radiobtnGoup">
					<span class="radiobtn">
						<form:checkbox path="age" id="searchAgesAll" value="" label="전체"/>
					</span>
					<span class="radiobtn">
						<form:checkbox path="age" id="searchAges1" value="0" label="영유아(0~5세)"/>
					</span>
					<span class="radiobtn">
						<form:checkbox path="age" id="searchAges2" value="6" label="유아(6~7세)"/>
					</span>
					<span class="radiobtn">
						<form:checkbox path="age" id="searchAges3" value="8" label="초등(8~13 세)"/>
					</span>
					<span class="radiobtn">
						<form:checkbox path="age" id="searchAges4" value="14" label="청소년(14~19 세)"/>
					</span>
					<span class="radiobtn">
						<form:checkbox path="age" id="searchAges5" value="20" label="20대"/>
					</span>
					<span class="radiobtn">
						<form:checkbox path="age" id="searchAges6" value="30" label="30대"/>
					</span>
					<span class="radiobtn">
						<form:checkbox path="age" id="searchAges7" value="40" label="40대"/>
					</span>
					<span class="radiobtn">
						<form:checkbox path="age" id="searchAges8" value="50" label="50대"/>
					</span>
					<span class="radiobtn">
						<form:checkbox path="age" id="searchAges9" value="60" label="60대이상"/>
					</span>
				</div>
			</div>
			<div class="field clearfix">
				<strong class="tit">지역</strong>
				<div class="radiobtnGoup">
					<span class="radiobtn">
						<form:checkbox path="region" id="searchRegionAll" value="" label="전체"/>
					</span>
					<span class="radiobtn">
						<form:checkbox path="region" id="searchRegion1" value="11" label="서울"/>
					</span>
					<span class="radiobtn">
						<form:checkbox path="region" id="searchRegion2" value="21" label="부산"/>
					</span>
					<span class="radiobtn">
						<form:checkbox path="region" id="searchRegion3" value="22" label="대구"/>
					</span>
					<span class="radiobtn">
						<form:checkbox path="region" id="searchRegion4" value="23" label="인천"/>
					</span>
					<span class="radiobtn">
						<form:checkbox path="region" id="searchRegion5" value="24" label="광주"/>
					</span>
					<span class="radiobtn">
						<form:checkbox path="region" id="searchRegion6" value="25" label="대전"/>
					</span>
					<span class="radiobtn">
						<form:checkbox path="region" id="searchRegion7" value="26" label="울산"/>
					</span>
					<span class="radiobtn">
						<form:checkbox path="region" id="searchRegion8" value="29" label="세종"/>
					</span>
					<span class="radiobtn">
						<form:checkbox path="region" id="searchRegion9" value="31" label="경기"/>
					</span>
					<span class="radiobtn">
						<form:checkbox path="region" id="searchRegion10" value="32" label="강원"/>
					</span>
					<span class="radiobtn">
						<form:checkbox path="region" id="searchRegion11" value="33" label="충북"/>
					</span>
					<span class="radiobtn">
						<form:checkbox path="region" id="searchRegion12" value="34" label="충남"/>
					</span>
					<span class="radiobtn">
						<form:checkbox path="region" id="searchRegion13" value="35" label="전북"/>
					</span>
					<span class="radiobtn">
						<form:checkbox path="region" id="searchRegion14" value="36" label="전남"/>
					</span>
					<span class="radiobtn">
						<form:checkbox path="region" id="searchRegion15" value="37" label="경북"/>
					</span>
					<span class="radiobtn">
						<form:checkbox path="region" id="searchRegion16" value="38" label="경남"/>
					</span>
					<span class="radiobtn">
						<form:checkbox path="region" id="searchRegion17" value="39" label="제주"/>
					</span>
				</div>
			</div>
			<div class="field clearfix">
				<strong class="tit">주제</strong>
				<div class="radiobtnGoup">
					<span class="radiobtn">
						<form:checkbox path="kdc" id="searchSubjectAll" value="" label="전체"/>
					</span>
					<span class="radiobtn">
						<form:checkbox path="kdc" id="searchSubject1" value="0" label="총류"/>
					</span>
					<span class="radiobtn">
						<form:checkbox path="kdc" id="searchSubject2" value="1" label="철학"/>
					</span>
					<span class="radiobtn">
						<form:checkbox path="kdc" id="searchSubject3" value="2" label="종교"/>
					</span>
					<span class="radiobtn">
						<form:checkbox path="kdc" id="searchSubject4" value="3" label="사회과학"/>
					</span>
					<span class="radiobtn">
						<form:checkbox path="kdc" id="searchSubject5" value="4" label="자연과학"/>
					</span>
					<span class="radiobtn">
						<form:checkbox path="kdc" id="searchSubject6" value="5" label="기술과학"/>
					</span>
					<span class="radiobtn">
						<form:checkbox path="kdc" id="searchSubject7" value="6" label="예술"/>
					</span>
					<span class="radiobtn">
						<form:checkbox path="kdc" id="searchSubject8" value="7" label="언어"/>
					</span>
					<span class="radiobtn">
						<form:checkbox path="kdc" id="searchSubject9" value="8" label="문학"/>
					</span>
					<span class="radiobtn">
						<form:checkbox path="kdc" id="searchSubject10" value="9" label="역사"/>
					</span>
				</div>
			</div>
			<div class="field clearfix">
				<strong class="tit">대출기간</strong>
				<div class="inputDateGroup">
					<span class="inputDate">
						<form:input path="startDt" cssClass="ui-calendar" title="검색 시작 날짜" id="searchStartDate" readonly="readonly" maxlength="10"/>
					</span> ~
					<span class="inputDate">
						<form:input path="endDt" cssClass="ui-calendar" title="검색 종료 날짜" id="searchEndDate" readonly="readonly" maxlength="10"/>
					</span>
				</div>
				<div class="radiobtnGroup">
					<span class="radiobtn"><input type="radio" id="toYearBtn" name="searchDateType" value="toYear" ><label for="toYearBtn">금년</label></span>
					<span class="radiobtn"><input type="radio" id="toMonthBtn" name="searchDateType" value="toMonth" ><label for="toMonthBtn">금월</label></span>
					<span class="radiobtn"><input type="radio" id="toWeekBtn" name="searchDateType" value="toWeek" ><label for="toWeekBtn">금주</label></span>
				</div>
			</div>
			<!-- <div class="field clearfix">
				<strong class="tit">도서관</strong>
				<form:select path="libCode" id="searchLibrary" title="도서관선택" class="form-ele auto">
				<%-- 
					<form:option value="0">도서관선택</form:option>
					<form:option value="111347" >도곡정보문화도서관</form:option>
					<form:option value="111070" >논현도서관</form:option>
					<form:option value="111071" >논현정보도서관</form:option>
					<form:option value="711266" >대치1동작은도서관</form:option>
					<form:option value="111039" >대치도서관</form:option>
					<form:option value="111479" >못골도서관</form:option>
					<form:option value="111474" >못골한옥어린이도서관</form:option>
					<form:option value="711267" >삼성도서관</form:option>
					<form:option value="711268" >세곡도서관</form:option>
					
					<!-- <option value="SF" >세곡마루도서관</option> -->
				
					<form:option value="711269" >역삼2동작은도서관</form:option>
					<form:option value="111103" >역삼도서관</form:option>
					<form:option value="111127" >역삼푸른솔도서관</form:option>
					<form:option value="711265" >열린도서관</form:option>
					<form:option value="111073" >정다운도서관</form:option>
					<form:option value="111056" >즐거운도서관</form:option>
					<form:option value="111069" >청담도서관</form:option>
					<form:option value="111075" >행복한도서관</form:option>
				
					<form:option value="TD" >개포4동주민도서관</option>
					<form:option value="TC" >도곡2동주민도서관</option>
					<form:option value="TG" >수서동주민도서관</option>
					<form:option value="TA" >신사동주민도서관</option>
					<form:option value="TB" >압구정동주민도서관</option>
					<form:option value="TF" >일원1동주민도서관</option>
					<form:option value="TE" >일원본동주민도서관</option> --%>
					
				</form:select>
			</div> -->
			<div class="btnSearch"><a href="#link" class="btn" id="searchBtn">검색</a></div>
		</div>
		<div class="filterDescArea">
			<ul class="ref-list">
				<li>『도서관 정보나루』에서 제공하는 인기도서를 전국 공공도서관의 대출정보 빅데이터를 바탕으로 검색합니다.</li>
				<li>성별, 연령대, 지역, 주제, 대출기간의 조건을 선택해서 해당 인기도서(다대출도서)를 검색할 수 있습니다.</li>
				<li>연령대, 지역, 주제는 다중선택이 가능합니다.</li>
			</ul>
		</div>
	</div>
					<!-- //도서 필터 -->
	<!-- 도서 목록 -->
	<div class="">
		<ul class="book-list">
			<c:forEach items="${popularBookList}" var="i" varStatus="status">
					<li>
						<div class="thumb">
							<a href="/${homepage.context_path}/intro/search/index.do?menu_idx=13&booktype=BOOKANDNONBOOK&title=${fn:trim(i.bookname)}" class="cover" id="cover${status.count}">
								<em class="rank top">${status.count}</em>
								<img class="bookCoverImg" src="${i.bookImageURL}" alt="표지">
							</a>
						</div>
						<dl class="bookInfoList clearfix">
							<dt class="bookName"><a href="#" id="btn${status.count}">${i.bookname}</a></dt>
							<dd class="list">
								<ul class="dot-list">
									<li>저자 : ${i.authors}</li>
									<li>발행처 : ${i.publisher}</li>
									<li>발행연도 : ${i.publication_year}</li>
									<li>ISBN : ${i.isbn13}</li>
									<li>대출건수 : ${i.loan_count}건
								</ul>
								<div class="btnArea">
									<a href="/${homepage.context_path}/intro/search/index.do?menu_idx=13&booktype=BOOKANDNONBOOK&title=${fn:trim(i.bookname)}"  class="btn search">소장자료검색</a>
								</div>
							</dd>
						</dl>
					</li>
			</c:forEach>
		</ul>
	</div>
	<!-- //도서 목록 -->
	
	<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
		<jsp:param name="formId" value="#librarySearch"/>
	</jsp:include>	
</form:form>