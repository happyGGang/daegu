<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<h2>새 책 드림 서비스 정보수정</h2>

<form:form modelAttribute="bookDream" onsubmit="return false;" action="modify.do" method="post">
<form:hidden path="editMode"/>
<form:hidden path="r_no"/>
	<ul class="con01">
		<li><span class="title">신청자</span> <span class="con">${bookDream.r_name}</span></li>
		<li><span class="title">전화번호</span> <span class="con"><form:input path="r_hp" numberOnly="true" maxlength="11"/> </span>*숫자만 입력가능합니다.</li>
		<li><span class="title">이메일</span> <span class="con"><form:input path="r_email"/></span></li>
	</ul>
	<p class="btn_wrap">
		<button class="btn btn-large btn-success">
			<span>수정하기</span>
		</button>
	</p>
</form:form>

<script>
	$(function() {
		$('button.btn-success').on('click', function() {
			if (confirm('신청정보를 수정하시겠습니까?')) {
				$('input#editMode').val('MODIFY');
				doAjaxPost($('form#bookDream'));
			}
		});
	});
	$(document).on("keyup", "input:text[numberOnly]", function() {
		$(this).val($(this).val().replace(/[^0-9]/gi, ""));
	});
</script>
