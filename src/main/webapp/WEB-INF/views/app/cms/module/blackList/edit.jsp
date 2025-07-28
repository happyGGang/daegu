<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<style>
	ul.tree {
		list-style: none;
		padding-left: 20px;
		font-family: "Segoe UI", "맑은 고딕", sans-serif;
		color: #333;
	}

	ul.tree ul {
		margin-left: 20px;
		border-left: 1px solid #ccc;
		padding-left: 10px;
	}

	ul.tree li {
		margin: 6px 0;
		position: relative;
	}

	ul.tree li::before {
		content: "•";
		position: absolute;
		left: -15px;
		color: #999;
		font-size: 14px;
	}

	ul.tree label {
		cursor: pointer;
		display: inline-block;
		font-size: 14px;
		line-height: 1.5;
	}

	ul.tree input[type="checkbox"] {
		margin-right: 6px;
	}
</style>



<script type="text/javascript">
if (!String.prototype.startsWith) {
    Object.defineProperty(String.prototype, 'startsWith', {
        value: function(search, pos) {
            pos = !pos || pos < 0 ? 0 : +pos;
            return this.substring(pos, pos + search.length) === search;
        }
    });
}
$(function() {
	$form = $('form#blackListEdit');

	$('.dialog-common').dialog({ //모달창 기본 스크립트 선언
		autoOpen: false,
		resizable: false,
		modal: true,
	    open: function(){
	        $('.ui-widget-overlay').addClass('custom-overlay');
	    },
	    close: function(){
	        $('.ui-widget-overlay').removeClass('custom-overlay');
	        $('body > div.ui-dialog').remove();
	    },
		buttons: [
			{
				text: "저장",
				"class": 'btn btn1',
				click: function() {
					if ($('input[name="black_type"]:checked').length == 0) {
						alert('블랙 구분 1개 이상 선택하셔야 합니다. 블랙리스트 해제는 해당 아이디 삭제를 해주세요.');
						return false;
					}

					const $teachInputs = $('input[name="teach_code"]');
					const $groupInputs = $('input[name="group_idx"]');
					const $categoryInputs = $('input[name="category_idx"]');
					const isAnyChecked = $teachInputs.is(':checked') ||
							$groupInputs.is(':checked') ||
							$categoryInputs.is(':checked');

					if (!isAnyChecked) {
						alert('강좌 구분을 1개 이상 선택하셔야 합니다. 블랙리스트 해제는 해당 아이디 삭제를 해주세요.');
						return false;
					}

					if ($('input#member_name').val() == '') {
						alert('이름을 입력해주세요.');
						return false;
					}

					if(doAjaxPost($form)) {

						$(this).dialog('destroy');
						if ( '${blackListOne.after_click_btn}' != '' ) {
							$('${blackListOne.after_click_btn}').click();
						}
						else {
							location.reload();
						}
					}
				}
			},{
				text: "취소",
				"class": 'btn',
				click: function() {
					$(this).dialog('destroy');
				}
			}
		]
	});

	// "전체" 체크박스 클릭 시
	$('#teach_code_all').on('change', function () {
		const isChecked = $(this).is(':checked');

		// 트리 내 모든 체크박스 상태 변경
		$('.tree input[type="checkbox"]').prop('checked', isChecked);

		// "전체" 외 단일 체크박스도 재귀적으로 부모 갱신
		$('.tree input[type="checkbox"]').each(function() {
			updateParents($(this));
		});
	});

	// 트리 내부 체크 시 전체 상태 갱신
	$('.tree').on('change', 'input[type="checkbox"]', function () {
		updateAllCheckboxState();
		if (this.id === 'teach_code_all') return; // 자기 자신이 또 반응하지 않게 방지

		$(this).closest('li').find('input[type="checkbox"]').prop('checked', this.checked);
		updateParents($(this));
	});

	function updateAllCheckboxState() {
		const total = $('.tree input[type="checkbox"]').length;
		const checked = $('.tree input[type="checkbox"]:checked').length;

		$('#teach_code_all').prop('checked', total === checked);
	}
	function updateParents($checkbox) {
		const $parentLi = $checkbox.closest('ul').closest('li');
		if ($parentLi.length === 0) return;

		const $allSiblings = $parentLi.find('> ul > li input[type="checkbox"]');
		const $checkedSiblings = $parentLi.find('> ul > li input[type="checkbox"]:checked');

		const $parentCheckbox = $parentLi.children('label').children('input[type="checkbox"]');

		if ($parentCheckbox.length) {
			$parentCheckbox.prop('checked', $checkedSiblings.length === $allSiblings.length);
			updateParents($parentCheckbox);
		}
	}

});
</script>

<form:form modelAttribute="blackListOne" id="blackListEdit" method="post" action="/cms/module/blackList/save.do">
	<form:hidden path="homepage_id"/>
	<form:hidden path="black_idx"/>
	<form:hidden path="editMode"/>
	<table class="type2">
		<colgroup>
	       <col width="130" />
	       <col width="*"/>
       	</colgroup>
       	<tbody>
        	<tr id="memberIdTr">
	         	<th>신청자ID</th>
	         	<td>
	         		<c:choose>
	         			<c:when test="${blackListOne.editMode eq 'ADD' }">
	         				<form:input path="member_id" class="text" />
	         			</c:when>
	         			<c:otherwise>
	         				${blackListOne.member_id}
							<form:hidden path="member_id" value="${blackListOne.member_id}" />
	         			</c:otherwise>
	         		</c:choose>
	       		</td>
	       	</tr>
	       	<tr>
				<th>신청자 성명</th>
				<td>
					<form:input path="member_name" class="text" cssStyle="width:100px"/>
				</td>
			</tr>
			<tr>
				<th>블랙 구분</th>
				<td>
					<c:choose>
						<c:when test="${blackListOne.black_type ne null and blackListOne.black_type ne ''}">
							<c:forEach items="${blackTypeList}" var="i">
								<c:set var="checkStr" value="${fn:indexOf(blackListOne.black_type, i.code_id) != -1 ? 'checked' : '' }"/>
								<form:checkbox path="black_type" label="${i.code_name}" value="${i.code_id}" checked="${checkStr}" />
							</c:forEach>
						</c:when>
						<c:otherwise>
							<form:checkboxes items="${blackTypeList}" path="black_type" itemLabel="code_name" itemValue="code_id"/>
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<tr>
				<th>강좌 구분</th>
				<td class="teach_code_td">
					<span> <input id="teach_code_all" name="teach_code_all" type="checkbox" value="ALL" <c:if test="${teachAllChecked}">checked</c:if> >
						<label for="teach_code_all">전체</label> </span>
					<c:choose>
						<c:when test="${(blackListOne.teach_code ne null and blackListOne.teach_code ne '') or (blackListOne.group_idx ne null) or (blackListOne.category_idx ne null)}">
							<ul class="tree">
								<c:forEach items="${teachCodeList}" var="tc"> <!-- 대분류 -->
									<li>
										<c:set var="teachCodeCheck" value="${fn:indexOf(blackListOne.teach_code, tc.teach_code) != -1 ? 'checked' : '' }"/>
										<label><input type="checkbox" name="teach_code" value="${tc.teach_code}" ${teachCodeCheck} /> ${tc.code_name}</label>
										<c:if test="${not empty tc.groupList}">
											<ul>
												<c:forEach items="${tc.groupList}" var="grp"> <!-- 중분류 -->
													<c:set var="group_idx_val" value="${tc.teach_code}_${grp.group_idx}"/>
													<c:set var="groupCheckStr" value="${teachCodeCheck ne '' ? teachCodeCheck : fn:contains(blackListOne.group_idx,group_idx_val) ? 'checked' : ''}" />
													<li>
														<label><input type="checkbox" name="group_idx" value="${group_idx_val}" ${groupCheckStr} /> ${grp.group_name}</label>
														<c:if test="${not empty grp.categoryList}">
															<ul>
																<c:forEach items="${grp.categoryList}" var="cat"> <!-- 소분류 -->
																	<c:set var="category_idx_val" value="${tc.teach_code}_${grp.group_idx}_${cat.category_idx}"/>

																	<%--대분류 중분류	둘중 하나라도 체크가 되어있다면--%>
																	<c:set var="checkValue" value="${teachCodeCheck ne '' or groupCheckStr ne ''}"/>
																	<c:set var="checkStr" value="${checkValue ? 'checked' : fn:indexOf(blackListOne.category_idx, category_idx_val) != -1 ? 'checked' : '' }"/>
																	<li>
																		<label><input type="checkbox" name="category_idx" value="${category_idx_val}" ${checkStr} /> ${cat.category_name}</label>
																	</li>
																</c:forEach>
															</ul>
														</c:if>
													</li>
												</c:forEach>
											</ul>
										</c:if>
									</li>
								</c:forEach>
							</ul>
						</c:when>
						<c:otherwise>
							<ul class="tree">
								<c:forEach items="${teachCodeList}" var="tc"> <!-- 대분류 -->
									<li>
										<label><form:checkbox path="teach_code" value="${tc.teach_code}" /> ${tc.code_name}</label>
										<c:if test="${not empty tc.groupList}">
											<ul>
												<c:forEach items="${tc.groupList}" var="grp"> <!-- 중분류 -->
													<li>
														<label><form:checkbox path="group_idx" value="${tc.teach_code}_${grp.group_idx}" /> ${grp.group_name}</label>
														<c:if test="${not empty grp.categoryList}">
															<ul>
																<c:forEach items="${grp.categoryList}" var="cat"> <!-- 소분류 -->
																	<li>
																		<label><form:checkbox path="category_idx" value="${tc.teach_code}_${grp.group_idx}_${cat.category_idx}" /> ${cat.category_name}</label>
																	</li>
																</c:forEach>
															</ul>
														</c:if>
													</li>
												</c:forEach>
											</ul>
										</c:if>
									</li>
								</c:forEach>
							</ul>

						</c:otherwise>
					</c:choose>
				</td>
			</tr>

        	<tr>
	         	<th>사유</th>
	         	<td><form:input path="reason" class="text" style="width:100%"/></td>
        	</tr>
		</tbody>
	</table>
</form:form>
