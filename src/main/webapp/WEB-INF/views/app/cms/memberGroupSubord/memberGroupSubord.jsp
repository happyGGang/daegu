<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
var list = $('tbody#authGroupList tr');
var a;
$(document).ready(function() {
	//테이블 공통 (tr,th,td 처음과 끝 요소 클래스명 부여)
	$('table tr:first-child').addClass('first');
	$('table tr').each(function(){
		$(this).children('th:first-child,td:first-child').addClass('first');
		$(this).children('th:last-child,td:last-child').addClass('last');
	});

	<%--저장--%>
	$('a#saveMmemberGroupSubord').on('click', function(e){
		e.preventDefault();
		$('select#memberList option').prop('selected', true);
		doAjaxPost($('form#memberGroupSubord'));
	});

	<%--추가--%>
	$('a#addMember').on('click', function(e) {
		e.preventDefault();
		var selectedList = $('select#cate2 option:selected').clone();
		$('select#memberList').append(selectedList);
		$('select#cate2 option:selected').remove();
		var sortList = $('select#memberList').sort_select_box();
		$('select#memberList option').remove();
		$('select#memberList').append(sortList);
	});

	<%--제거--%>
	$('a#removeMember').on('click', function(e) {
		e.preventDefault();
		var selectedList = $('select#memberList option:selected').clone();
		$('select#cate2').append(selectedList);
		$('select#memberList option:selected').remove();
		var sortList = $('select#cate2').sort_select_box();
		$('select#cate2 option').remove();
		$('select#cate2').append(sortList);
	});
	
	<%--검색--%>
	$('a#findMember').on('click', function(e) {
		e.preventDefault();
		
		$.get('findMember.do?search_text='+$('input#searchText').val() + '&member_group_idx='+$('input#member_group_idx').val(), function(data) {
			if (data != null && data.length > 0) {
				data = eval(data);
				$('select#cate2 option').remove();
				for (var i=0; i<data.length; i++) {
					var option = '<option value="'+data[i].member_id+'">'+data[i].member_name+'('+data[i].member_id+')'+'</option>';
					$('select#cate2').append(option);	
				}
			} else {
				alert('검색결과가 없습니다.');
			}
		})
	});
	
	
	
	<%--이름으로 정렬--%>
	$.fn.sort_select_box = function(){
	    var my_options = $("#" + this.attr('id') + ' option');
	    my_options.sort(function(a,b) {
	        if (a.text > b.text) return 1;
	        else if (a.text < b.text) return -1;
	        else return 0
	    })
	   return my_options;
	}
});
</script>

<div id="editDisable" class="disableBox">
	<%-- disable 상태로 변경 --%>
	<c:if test="${memberGroupSubord.editMode eq 'FIRST'}">
	<div class="mask"></div>
	</c:if>
	<div class="infodesk">
		<span>관리자 권한그룹 설정</span> 
		<div class="button">
			<a href="#" class="btn btn5" id="saveMmemberGroupSubord"><i class="fa fa-floppy-o" aria-hidden="true"></i></i><span>저장</span></a>
		</div>
	</div>
	<form:form modelAttribute="memberGroupSubord" method="POST" action="save.do" onsubmit="return false;">
	<form:hidden path="member_group_idx"/>
		<div style="margin-left: 100px; height: 600px; text-align: center;">
		
			<div class="leftBox" style="width: 350px; float: left;">
				<div class="contentsBox">
					<div class="categoryEdit ">
						<p class="title" style="text-align: center;">${memberGroupSubord.member_group_name} 관리자</p>
						<form:select path="memberList" size="2" cssStyle="width:100%; height: 540px;" multiple="true">
							<c:forEach var="i" varStatus="status" items="${memberGroupSubordList}">
							<option value="${i.member_id}">${i.member_name}(${i.member_id})</option>
							</c:forEach>
						</form:select>
					</div>
				</div>
			</div>
			<div style="width: 71px; margin: 0 10px 0 60px; float: left; ">
				<div style="display:table-cell; height:540px; vertical-align: middle;">
					<div>
						<a href="#" class="btn btn1" id="addMember"><i class="fa fa-arrow-left" aria-hidden="true"></i><span>추가</span></a> 
						<br/>
						<br/>
						<br/>
						<br/>
						<a href="#" class="btn btn1" id="removeMember"><i class="fa fa-arrow-right" aria-hidden="true"></i><span>제거</span></a>
					</div>
				</div>
			</div>
			<div class="rightBox" style="width: 350px; margin-left: 50px; float: left;">
				<div class="categoryEdit">
					<p class="title" style="text-align: center;">관리자리스트</p>
					<select id="cate2" name="cate2" size=2 style="width: 100%; height: 540px;" multiple="multiple">
						<c:forEach var="i" varStatus="status" items="${memberGroupSubordReadyList}">
						<option value="${i.member_id}">${i.member_name}(${i.member_id})</option>
						</c:forEach>
					</select>
				</div>
				<div>
					<form:input id="searchText" path="search_text" /><a href="#" class="btn btn1" id="findMember"><i class="fa fa-search" aria-hidden="true"></i><span>검색</span></a>
				</div>
			</div>
		</div>
	</form:form>
	<div class="alert">
<!-- 		<ul> -->
<!-- 			<li>여러개 나오는 설명 문구를 출력합니다.</li> -->
<!-- 			<li>목록을 선택하시면 상세정보를 볼 수 있습니다.</li> -->
<!-- 		</ul> -->
	</div>
	<div id="dialog-2" class="dialog-common" title="권한정보">
	</div>
</div>	