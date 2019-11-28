<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript">
$(function() {
	$('#save-btn').on('click', function(e) {
		e.preventDefault();
		doAjaxPost($('#memberInfoForm'));
	});
});
</script>

<div class="join-wrap" style="padding: 0;">
	<div class="txt-box" style="margin-bottom: 20px;">
		<div id="txt_box_wrapper02">
			<div id="txt_box_wrap02">
				<ul>
					<li>- 경상북도교육청 통합 도서관회원이 아닌 책이음 회원은 ID를 생성하여 홈페이지를 이용할 수 있습니다.</li>
					<li>- ID가 없는 책이음 회원만 ID 생성이 가능합니다.</li>
					<li>- 대출자번호와 이름으로 조회 후 본인인증을 통하여 ID를 생성할 수 있습니다.</li>
				</ul>
			</div>
		</div>
	</div>

	<form:form modelAttribute="memberInfo" id="memberInfoForm" action="userInfoSearch.do">
		<form:hidden path="menu_idx"/>

		<div style="text-align: right;">
			(<span style="color: red; font-weight: bold;">*</span>) 항목은 필수 입력값입니다.
		</div>
		<table id="memberForm">
			<tbody>
				<tr>
					<th>
						대출자 번호(<span style="color: red;">*</span>)
					</th>
					<td>
						<form:input path="user_id" class="text" numberOnly="true"/>
					</td>
				</tr>
				<tr>
					<th>
						이름(<span style="color: red;">*</span>)
					</th>
					<td>
						<form:input path="user_name" class="text"/>
					</td>
				</tr>
			</tbody>
		</table>
	</form:form>
	<div class="btn-wrap">
		<a href="#" id="save-btn" class="btn btn1">확인</a>
		<a href="/${homepage.context_path}/index.do" id="cancel-btn" class="btn">취소</a>
	</div>
	<br/>
</div>
