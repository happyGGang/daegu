<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
$(function(){
	$('a.delete-btn').on('click', function(e) {
		e.preventDefault();

		if ( confirm('해당 자료를 정말 삭제 하시겠습니까?') ) {
			$('#itemDeleteForm #storage_idx').val($(this).attr('keyValue1'));
			$('#itemDeleteForm #item_idx').val($(this).attr('keyValue2'));

			if ( doAjaxPost($('#itemDeleteForm')) ) {
				$('#itemLayer').load('getItemList.do?homepage_id=${myStorage.homepage_id}&storage_idx=' + $(this).attr('keyValue1'));
			}
		}
	});

	$('a.detail-btn').on('click', function(e) {
		e.preventDefault();
		var loca = $(this).attr('keyValue1');
		var ctrl_no = $(this).attr('keyValue2');
		var img_url = $(this).attr('keyValue3');
		var booktype = $(this).attr('keyValue4');
		var item_type = $(this).attr('itemType');
		if (item_type == '1') {
			var param = 'menu_idx=' + img_url + '&regNo=' + ctrl_no + '&manageCode=' + loca + '&booktype=' + booktype;
			window.open("/${homepage.context_path}/intro/search/detail.do?" + param, "");
		} else {
// 			window.open("/${homepage.context_path}/intro/search/detailPopup.do?" + param, "", "width=600, height=500");
			location.href = img_url;
		}
	});
});
</script>
<form:form id="itemDeleteForm" modelAttribute="myItem" action="saveItem.do">
	<form:hidden path="editMode" value="DELETE"/>
	<form:hidden path="homepage_id"/>
	<form:hidden path="member_key"/>
	<form:hidden path="storage_idx"/>
	<form:hidden path="item_idx"/>
</form:form>
<div id="editDisable" class="disableBox" style="height:100%;">
	<div class="table-wrap" style="height:100%;">
		<div class="rsv-info"></div>
		<div class="auto-scroll" style="height:100%;">
			<table class="type1 center" style="">
				<thead>
					<tr>
						<th width="400">제목</th>
						<!-- <th width="100">저자</th>
						<th width="100">출판사</th> -->
						<th>청구기호</th>
						<th width="130">기능</th>
					</tr>
				</thead>
				<tbody>
					<form:form id="authIndex" modelAttribute="auth" method="POST">
						<c:if test="${fn:length(myItemList) < 1}">
							<tr >
								<td colspan="3" style="background:#f8fafb;">데이터가 존재하지 않습니다.</td>
							</tr>
						</c:if>
						<c:forEach var="i" varStatus="status" items="${myItemList}">
							<tr>
								<td >${i.item_name}</td>
								<%-- <td >${i.author}</td>
								<td >${i.publer}</td> --%>
								<td>${i.call_no}</td>
								<td width="">
									<a class="btn btn detail-btn" itemType="${i.item_type}" keyValue1="${i.loca}" keyValue2="${i.ctrl_no}" keyValue3="${i.img_url}" keyValue4="${i.publer}">상세보기</a>
									<a class="btn btn delete-btn" itemType="${i.item_type}" keyValue1="${i.storage_idx}" keyValue2="${i.item_idx}">삭제</a>
								</td>
							</tr>
						</c:forEach>
				</form:form>
				</tbody>
			</table>
		</div>
	</div>
</div>