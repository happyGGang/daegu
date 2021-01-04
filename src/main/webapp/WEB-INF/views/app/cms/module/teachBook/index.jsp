<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
$(function(){
	$('select#homepage_id_1').on('change', function(e) {
		if($(this).val() != '') {
			$('input#homepage_id_1').val($(this).val());
			$('#adminTeachBookForm').submit();
		}
		
		e.preventDefault();
	});
	
	$('select#large_category_idx').on('change', function() {
		if ( $(this).val() > 0 ) {
			$.get('/cms/module/category/getCategoryGroupList.do?homepage_id=' + $('#homepage_id_1').val() + '&large_category_idx=' + $(this).val(), function(response) {
				$('select#group_idx option').remove();
				$('select#group_idx').append('<option value="0">선택</option>');
				$.each(response, function(i, v) {
					$('select#group_idx').append('<option value="' + v.group_idx + '">' + v.group_name + '</option>');
				});
			});	
		}
		else {
			$('select#group_idx option').remove();
			$('select#group_idx').append('<option value="0">대분류를 선택 해주세요</option>');
			$('select#category_idx option').remove();
			$('select#category_idx').append('<option value="0">중분류를 선택 해주세요</option>');
			// 0일때는 강좌 전체를 가져온다.
			$.get('/cms/module/teach/getTeachList.do?homepage_id=' + $('#homepage_id_1').val() + '&large_category_idx=' + $('select#large_category_idx').val(), function(response) {
				$('select#teach_idx option').remove();
				$('select#teach_idx').append('<option keyValue1="0" keyValue2="0" keyValue3="0" value="0">선택</option>');
				$.each(response.teachList, function(i, v) {
					$('select#teach_idx').append('<option keyValue1="' + v.group_idx + '" keyValue2="' + v.category_idx + '" keyValue3="'+v.large_category_idx+'" value="' + v.teach_idx + '">' + v.teach_name + '</option>');
				});
			});	
		}
		$('select#teach_idx option').remove();
		$('select#teach_idx').append('<option keyValue1="0" keyValue2="0" value="0">소분류를 선택해주세요</option>');
	}).trigger('change');
	
	$('select#group_idx').on('change', function() {
		if ( $(this).val() > 0 ) {
			$.get('/cms/module/category/getCategoryList.do?homepage_id=' + $('#homepage_id_1').val() + '&group_idx=' + $(this).val() + '&large_category_idx=' + $('select#large_category_idx').val(), function(response) {
				$('select#category_idx option').remove();
				$('select#category_idx').append('<option value="0">선택</option>');
				$.each(response.categoryList, function(i, v) {
					$('select#category_idx').append('<option value="' + v.category_idx + '">' + v.category_name + '</option>');
				});
			});
			$.get('/cms/module/teach/getTeachList.do?homepage_id=' + $('#homepage_id_1').val() + '&group_idx=' + $(this).val() + '&category_idx=' + $('select#category_idx').val() + '&large_category_idx=' + $('select#large_category_idx').val(), function(response) {
				$('select#teach_idx option').remove();
				$('select#teach_idx').append('<option keyValue1="0" keyValue2="0" keyValue3="0" value="0">선택</option>');
				$.each(response.teachList, function(i, v) {
					$('select#teach_idx').append('<option keyValue1="' + v.group_idx + '" keyValue2="' + v.category_idx + '" keyValue3="'+v.large_category_idx+'" value="' + v.teach_idx + '">' + v.teach_name + '</option>');
				});
			});	
		}
		else {
			$('select#category_idx option').remove();
			$('select#category_idx').append('<option value="0">중분류를 선택 해주세요</option>');
			// 0일때는 강좌 전체를 가져온다.
			$.get('/cms/module/teach/getTeachList.do?homepage_id=' + $('#homepage_id_1').val() + '&group_idx=' + $('select#group_idx').val() + '&category_idx=' + $(this).val(), function(response) {
				$('select#teach_idx option').remove();
				$('select#teach_idx').append('<option keyValue1="0" keyValue2="0" keyValue3="0" value="0">선택</option>');
				$.each(response.teachList, function(i, v) {
					$('select#teach_idx').append('<option keyValue1="' + v.group_idx + '" keyValue2="' + v.category_idx + '" keyValue3="'+v.large_category_idx+'" value="' + v.teach_idx + '">' + v.teach_name + '</option>');
				});
			});	
		}
		$('select#teach_idx option').remove();
		$('select#teach_idx').append('<option keyValue1="0" keyValue2="0" keyValue3="0" value="0">소분류를 선택해주세요</option>');
	}).trigger('change');
	
	$('select#category_idx').on('change', function() {
		if ( $(this).val() > 0 ) {
			$.get('/cms/module/teach/getTeachList.do?homepage_id=' + $('#homepage_id_1').val() + '&group_idx=' + $('select#group_idx').val() + '&category_idx=' + $(this).val(), function(response) {
				$('select#teach_idx option').remove();
				$('select#teach_idx').append('<option keyValue1="0" keyValue2="0" keyValue3="0" value="0">선택</option>');
				$.each(response.teachList, function(i, v) {
					$('select#teach_idx').append('<option keyValue1="' + v.group_idx + '" keyValue2="' + v.category_idx + '" keyValue3="'+v.large_category_idx+'" value="' + v.teach_idx + '">' + v.teach_name + '</option>');
				});
			});	
		}
		else {
			$('select#teach_idx option').remove();
			$('select#teach_idx').append('<option keyValue1="0" keyValue2="0" keyValue3="0" value="0">소분류를 선택해주세요</option>');
			$.get('/cms/module/teach/getTeachList.do?homepage_id=' + $('#homepage_id_1').val() + '&group_idx=' + $('select#group_idx').val() + '&category_idx=' + $(this).val(), function(response) {
				$('select#teach_idx option').remove();
				$('select#teach_idx').append('<option keyValue1="0" keyValue2="0" keyValue3="0" value="0">선택</option>');
				$.each(response.teachList, function(i, v) {
					$('select#teach_idx').append('<option keyValue1="' + v.group_idx + '" keyValue2="' + v.category_idx + '" keyValue3="'+v.large_category_idx+'" value="' + v.teach_idx + '">' + v.teach_name + '</option>');
				});
			});	
		}
	});
	
	$('a.print-btn').on('click', function(e) {
		e.preventDefault();
		var divToPrint = $("table#teachBookArea").parent().clone();
		divToPrint.prepend($('div.printTitle').html());
		divToPrint.find('div.stat-info').remove();
		divToPrint.find('table').css('text-align', 'center').css('width', '100%');
		divToPrint.find('tbody td').css('border', '1px solid #666');
	   	var newWin = window.open("");
	   	newWin.document.write(divToPrint[0].outerHTML);
	   	newWin.document.close();
	   	newWin.print();
	   	newWin.close();
	});
	
	$('a.excel-btn').on('click', function(e) {
		e.preventDefault();
		if ( $('#excelDownForm #teach_idx').val() == 0 ) {
			alert('강좌를 선택해주세요.');
			return false;
		}
		
		$('#excelDownForm').attr('action', 'excelDownload.do').submit();
	});
	
	$('a.csv-btn').on('click', function(e) {
		e.preventDefault();
		if ( $('#excelDownForm #teach_idx').val() == 0 ) {
			alert('강좌를 선택해주세요.');
			return false;
		}
		
		$('#excelDownForm').attr('action', 'csvDownload.do').submit();
	});
	
	$('select#teach_idx').on('change', function(e) {
		$('#excelDownForm #group_idx').val($(this).find('option:selected').attr('keyValue1'));
		$('#excelDownForm #category_idx').val($(this).find('option:selected').attr('keyValue2'));
		$('#excelDownForm #large_category_idx').val($(this).find('option:selected').attr('keyValue3'));
		$('#excelDownForm #teach_idx').val($(this).val());
		$('#teachBookLayer').load('teachBook.do?homepage_id=' + $('#homepage_id_1').val() + '&group_idx=' + $(this).find('option:selected').attr('keyValue1') + '&category_idx=' + $(this).find('option:selected').attr('keyValue2') + '&large_category_idx=' + $(this).find('option:selected').attr('keyValue3') + '&teach_idx=' + $(this).val());
		e.preventDefault();
	}).trigger('change');
	
});	 
</script>
<form:form id="excelDownForm" modelAttribute="teachBook" action="excelDownload.do" method="get">
	<form:hidden path="homepage_id"/>
	<form:hidden path="group_idx"/>
	<form:hidden path="category_idx"/>
	<form:hidden path="large_category_idx"/>
	<form:hidden path="teach_idx"/>
	<form:hidden path="sel_date"/>
</form:form>
<form:form id="adminTeachBookForm" modelAttribute="teachBook" action="index.do">
<%--	<form:hidden id="homepage_id_1" path="homepage_id"/>--%>
	
	<div class="wrapper wrapper-white">
		<div class="infodesk" style="width:98%;">
			<c:choose>
				<c:when test="${fn:length(subHomepageList) > 0  and asideHomepageId ne 'h50' and asideHomepageId ne 'h51' and asideHomepageId ne 'h37'}">
					<span>
					도서관 : <form:select id="homepage_id_1" path="homepage_id" items="${subHomepageList}" itemLabel="homepage_name" itemValue="homepage_id"></form:select>
					</span>
					<br/>
				</c:when>

				<c:when test="${asideHomepageId eq 'h50'}">
					<span>
					도서관 :
					<form:select id="homepage_id_1" path="homepage_id">
						<form:option value="h50">범어</form:option>
						<form:option value="h54">책숲길</form:option>
						<form:option value="h55">물망이</form:option>
					</form:select>
					</span>
					<br/>
				</c:when>


				<c:when test="${asideHomepageId eq 'h51'}">
					<span>
						도서관 :
					<form:select id="homepage_id_1" path="homepage_id">
						<form:option value="h51">용학</form:option>
						<form:option value="h56">파동</form:option>
						<form:option value="h57">무학숲</form:option>
					</form:select>
					</span>
					<br/>
				</c:when>



				<c:when test="${asideHomepageId eq 'h37'}">
					<span>
						도서관 :
					<form:select id="homepage_id_1" path="homepage_id">
						<form:option value="h72">도원</form:option>
						<form:option value="h67">성서</form:option>
						<form:option value="h68">본리</form:option>
						<form:option value="h69">달서가족문화</form:option>
						<form:option value="h66">달서어린이</form:option>
						<form:option value="h70">달서영어</form:option>
						<form:option value="h41">독서문화진흥</form:option>
					</form:select>
					</span>
					<br/>
				</c:when>
				<c:otherwise>
					<form:hidden id="homepage_id_1" path="homepage_id"/>
				</c:otherwise>
			</c:choose>
			<span>대분류 : 
				<form:select path="large_category_idx" style="width:200px;margin-right:10px;">
					<form:option class="all" value="0" label="선택" />
					<form:options itemValue="teach_code" itemLabel="code_name" items="${teachLargeCategoryList}"/>
				</form:select>
			</span>
			<span>중분류 : 
				<form:select path="group_idx" style="width:200px;margin-right:10px;">
					<form:option class="all" value="0" label="선택" />
					<form:options itemValue="group_idx" itemLabel="group_name" items="${categoryGroupList}"/>
				</form:select>
			</span>
			<span>소분류 : 
				<form:select path="category_idx" style="width:200px;margin-right:10px;">
					<form:option value="0" label="중분류를 선택해주세요" />
				</form:select>
			</span>
			<span>강좌 : 
				<form:select path="teach_idx" style="width:300px;">
					<form:option keyValue1="0" keyValue2="0" keyValue3="0" value="0" label="소분류를  선택해주세요" />
				</form:select>
			</span>
			
			<a class="btn btn2 print-btn" style="float:right;">인쇄</a>
			<a class="btn btn2 csv-btn" style="float: right;"><i class="fa fa-file-excel-o"></i><span>CSV저장</span></a>
			<a class="btn btn2 excel-btn" style="float:right;"><i class="fa fa-file-excel-o"></i><span>엑셀저장</span></a>
		</div>
		<div id="teachBookLayer" class="auto-scroll" style="height:600px;"></div>
		<div class="ui-state-highlight" style="width:98%">
			( ● : 출석&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;△ : 지각&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;× : 결석&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- : 데이터없음 ) 기호는 버튼 입니다. 상단 종류를 선택후 클릭하면 즉시 반영 됩니다.<br/>
			* 날짜 클릭시 해당 날짜에 대해 모든 수강생들을 '출석(●)' 처리 가능 합니다.<br/>
			* 수강생 이름 클릭시 해당 수강생에 대해 모든 날짜를 '출석(●)' 처리 가능 합니다.<br/>
			* 일괄 처리 시 다소 시간이 걸릴수 있습니다.
			
		</div>	
	</div>
</form:form>
