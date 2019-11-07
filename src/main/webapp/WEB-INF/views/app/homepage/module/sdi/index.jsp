<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript">
$(function() {
	
	$('a#save-btn').on('click', function(e) {
		e.preventDefault();
		var num = $(this).attr("keyValue");
		var editMode = $(this).attr("keyValue2");
		
		$('#keyword').val($('#keyword'+num).val());
		$('#type').val($('#type'+num).val());
		$('#editMode').val(editMode);
		
		if(editMode == 'MODIFY') {
			var sdi_idx = $(this).attr("keyValue3");
			$('#sdi_idx').val(sdi_idx);
		}
		
		doAjaxPost($('#sdiIndex'));
		
	});
	
	$('a#modify-btn').on('click', function(e) {
		e.preventDefault();
		var num = $('input:radio[name="selector"]:checked').attr("keyValue");
		
		$('div.editMode').css("display", "none");
		$('div.addMode').css("display", "block");
		
		$('.modifyMode').css("display", "none");
		$('.viewMode').css("display", "block");
		
		$('#viewMode'+num).css("display", "none");
		$('#modifyMode'+num).css("display", "block");
		
	});
	
	$('a#cancel2-btn').on('click', function(e) {
		e.preventDefault();
		var num = $(this).attr("keyValue");
		
		$('#modifyMode'+num).css("display", "none");
		$('#viewMode'+num).css("display", "block");
		
	});
	
	$('a#delete-btn').on('click', function(e) {
		e.preventDefault();
				
		$('#sdi_idx').val($('input:radio[name="selector"]:checked').val());
		$('#editMode').val("DELETE");
		
		doAjaxPost($('#sdiIndex'));
		
	});
	
	$('a#cancel-btn').on('click', function(e) {
		e.preventDefault();
		var num = $(this).attr("keyValue");
		
		$('div#editMode'+num).css("display", "none");
		$('div#addMode'+num).css("display", "block");
		
	});
	
	$('a#add-btn').on('click', function(e) {
		e.preventDefault();
		var num = $(this).attr("keyValue");
		
		$('.modifyMode').css("display", "none");
		$('.viewMode').css("display", "block");
		
		$('div.editMode').css("display", "none");
		$('div.addMode').css("display", "block");
		
		$('div#editMode'+num).css("display", "block");
		$('div#addMode'+num).css("display", "none");
		
		
	});
});

</script>
<form:form modelAttribute="sdi" id="sdiIndex" action="/${homepage.context_path}/module/sdi/save.do" method="post">
<form:hidden path="homepage_id"/>
<form:hidden path="menu_idx"/>
<form:hidden path="editMode"/>
<form:hidden path="keyword"/>
<form:hidden path="type"/>
<form:hidden path="sdi_idx"/>

	<div class="txt-box" style="margin-bottom: 20px;">
		<div id="txt_box_wrapper02">
			<div id="txt_box_wrap02">
				<ul>
					<li><i class="fa fa-square"></i> SDI서비스는 관심 키워드를 등록 하면 신착도서에 키워드가 포함된 도서가 있을때 <span style="color:green;">문자 알림 및 검색까지 가능한 서비스</span>입니다.</li>
					<li>&nbsp;&nbsp;&nbsp;(단, 문자는 회원정보에 등록하신 휴대전화번호로 안내되며 SMS수신여부에 동의하지 않으면 알림서비스를 받으실 수 없습니다.)</li>
					<li><i class="fa fa-square"></i> 관심 키워드는 서명, 저자, 출판사 등으로 최대 3개까지 등록 가능합니다.</li>
				</ul>
			</div>
		</div>
	</div>
	
	<div class="table-wrap">
		<table class="type1 center">
			<colgroup>
				<col width="100"/>
				<col />			
			</colgroup>
			<thead>
				<tr>
					<th>선택</th>
					<th>키워드</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="i" varStatus="status" items="${sdiList}" end="3">				
					<tr>
						<td><input type="radio" id="selector" name="selector" class="selector" value="${i.sdi_idx}" keyValue="${status.index}"/></td>
						
						<td id="viewMode${status.index}" class="viewMode" style="display: block;">[${i.type_name}] ${i.keyword}</td>
						<td id="modifyMode${status.index}" class="modifyMode" style="display: none;">
							<form:select path="type${status.index}" cssStyle="height:24px;">									
									<c:forEach var="j" items="${keyword_type}">
										<option value="${j.code_id}" <c:if test="${j.code_id eq i.type}">selected="selected"</c:if>>${j.code_name}</option>
									</c:forEach>
							</form:select>
							<input type="text" id="keyword${status.index}" value="${i.keyword}"/>
							<span class="btn07"><a id="save-btn" class="btn btn1" keyValue="${status.index}" keyValue2="MODIFY" keyValue3="${i.sdi_idx}">수정</a></span>
							<span class="btn07"><a id="cancel2-btn" keyValue="${status.index}" class="btn btn2">취소</a></span>	
						</td>
					</tr>
					
				</c:forEach>
				
				<c:forEach var="i" varStatus="status" begin="${fn:length(sdiList)}" end="2">
					<tr>
						<td colspan="2">
							<div id="addMode${status.index}" class="addMode" style="display: block;">
								<a id="add-btn" keyValue="${status.index}" class="btn btn1">+추가</a>
							</div>
							
							<div id="editMode${status.index}" class="editMode" style="text-align: center; margin: 0px; display: none;">								
								<form:select path="type${status.index}" cssStyle="height:24px;" >									
									<form:options itemLabel="code_name" itemValue="code_id" items="${keyword_type}"/>
								</form:select>
																
								<input type="text" id="keyword${status.index}"/>
								<span class="btn07"><a id="save-btn" class="btn btn1" keyValue="${status.index}" keyValue2="ADD">등록</a></span>
								<span class="btn07"><a id="cancel-btn" keyValue="${status.index}" class="btn btn2">취소</a></span>
							</div>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div class="join-wrap">
			<div class="btn-wrap">
				<span>선택항목을 </span>
				<a href="#" id="search-btn" class="btn btn1">검색하기</a>
				<a href="#" id="modify-btn" class="btn">수정하기</a>
				<a href="#" id="delete-btn" class="btn">삭제하기</a>
			</div>
			<br/>
		</div>	
	</div>
</form:form>