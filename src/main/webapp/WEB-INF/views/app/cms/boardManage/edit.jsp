<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cmsTag" uri="/WEB-INF/config/tld/cmsTag.tld" %>
<script type="text/javascript">
$(function(){
	$('.dialog-common').dialog({ //모달창 기본 스크립트 선언
		autoOpen: false,
		resizable: true,
		modal: true,
	    open: function(){
	        $('.ui-widget-overlay').addClass('custom-overlay');
	    },
	    close: function(){
	        $('.ui-widget-overlay').removeClass('custom-overlay');
	    },
		buttons: [
			{
				text: "저장",
				"class": 'btn btn1',
				click: function() {
					if(doAjaxPost($('#boardManageEdit'))) {
						$(this).dialog('destroy');
						$('.dialog-common').remove();
						location.reload();
// 						$('#boardManageLayer').load('index.do?editMode=MODIFY&homepage_id=${boardManage.homepage_id}');
					}
				}
			},{
				text: "취소",
				"class": 'btn',
				click: function() {
					$('#dialog-1').dialog('destroy');
				}
			}
		]
	});

	$("#dialog-1").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 1400,
		height: 800
	});

	//탭메뉴
	$('#tabs').tabs();

	$('a#adminsearch').on('click', function(e) {
		$('#dialog-searchLayer').load('adminSearch.do', function( response, status, xhr ) {
			$('#dialog-searchLayer').dialog('open');
		});

		e.preventDefault();
	});

	$('input#admin_id').on('click', function(e) {
		$('#dialog-searchLayer').load('adminSearch.do', function( response, status, xhr ) {
			$('#dialog-searchLayer').dialog('open');
		});

		e.preventDefault();
	});

	$('select#board_type').on('change', function() {
		var val = $(this).val();
		if (val == 'QNA') {
			$('input#reply_use_yn1').prop('checked', true);
			$('input#secret_use_yn1').prop('checked', true);
			$('tr#pushTr').hide();
		} else if (val == 'NOTICE') {
			$('tr#pushTr').show();
		} else if (val = 'LOSTCARD') {
			$('input#secret_use_yn1').prop('checked', true);
			$('input#reply_use_yn1').prop('checked', true);
			$('input#reply_list_yn1').prop('checked', true);
			$('input#file_use_yn2').prop('checked', true);
			$('input#comment_use_yn1').prop('checked', true);
			$('input#anonymize_yn1').prop('checked',true)

		} else {
			$('tr#pushTr').hide();
		}
	});

	$('select#category1').on('change', function() {
		if ($(this).val() == '') {
			$('input#category_use_yn').val('N');
		} else {
			$('input#category_use_yn').val('Y');
		}
	});
});
</script>
<form:form modelAttribute="boardManage" id="boardManageEdit" action="save.do" method="POST" onsubmit="return false;">
<form:hidden path="editMode"/>
<form:hidden path="homepage_id"/>
<form:hidden path="manage_idx"/>
<div class="container-tab">
	<h3>게시판 설정</h3>
	<div id="tabs">
		<ul>
			<li><a href="#tabs-1">기본 설정</a></li>
			<li><a href="#tabs-2">기타 설정</a></li>
		</ul>
		<div id="tabs-1">
			<table class="type2">
				<colgroup>
					<col width="150"/>
					<col width="300"/>
					<col width="150"/>
					<col width="300"/>
				</colgroup>
				<tbody>
					<tr>
						<th>게시판명  <em>*</em></th>
						<td><form:input path="board_name" cssClass="text" cssStyle="width:300px;" maxlength="50"/></td>
						<th>게시판종류</th>
						<td>
							<form:select path="board_type" cssClass="selectmenu">
							<c:forEach var="i" varStatus="status" items="${boardTypes}">
								<form:option value="${i.code_name}">${i.remark}</form:option>
							</c:forEach>
							</form:select>
						</td>
					</tr>
					<tr>
						<th>게시물 출력</th>
						<td>
							<form:select path="record_count" cssClass="selectmenu">
								<form:option value="10">10개</form:option>
								<form:option value="20">20개</form:option>
								<form:option value="30">30개</form:option>
								<form:option value="40">40개</form:option>
								<form:option value="50">50개</form:option>
								<form:option value="0">사용안함</form:option>
							</form:select>
						</td>
						<th>새글표시기간</th>
						<td>
							<form:select path="new_date_count" cssClass="selectmenu">
								<form:option value="1">1일</form:option>
								<form:option value="2">2일</form:option>
								<form:option value="3">3일</form:option>
							</form:select>
						</td>
					</tr>
					<tr>
						<th>제목 글자 길이</th>
						<td>
							<form:select path="new_date_count" cssClass="selectmenu">
							<c:forEach var="i" varStatus="status" begin="50" end="200" step="10">
								<form:option value="${i}">${i}자</form:option>
							</c:forEach>
							</form:select>
						</td>
						<th>게시판 사용여부</th>
						<td>
							<form:radiobutton path="board_use_yn" cssClass="selectmenu" value="Y" label="사용함" />
							<form:radiobutton path="board_use_yn" cssClass="selectmenu" value="N" label="사용안함" />
						</td>
					</tr>

					<tr>
						<th>답변 사용여부</th>
						<td>
							<form:radiobutton path="reply_use_yn" cssClass="selectmenu" value="Y" label="사용함" />
							<form:radiobutton path="reply_use_yn" cssClass="selectmenu" value="N" label="사용안함" />
						</td>
						<th>답변 리스트 사용여부</th>
						<td>
							<form:radiobutton path="reply_list_yn" cssClass="selectmenu" value="Y" label="사용함" />
							<form:radiobutton path="reply_list_yn" cssClass="selectmenu" value="N" label="사용안함" />
						</td>
					</tr>
					<tr>
						<th>에디터 사용여부</th>
						<td>
							<form:radiobutton path="editor_use_yn" cssClass="selectmenu" value="Y" label="사용함" />
							<form:radiobutton path="editor_use_yn" cssClass="selectmenu" value="N" label="사용안함" />
						</td>
						<th>댓글 사용여부</th>
						<td>
							<form:radiobutton path="comment_use_yn" cssClass="selectmenu" value="Y" label="사용함" />
							<form:radiobutton path="comment_use_yn" cssClass="selectmenu" value="N" label="사용안함" />
						</td>
					</tr>
					<tr>
						<th style="display: none;">RSS 사용</th>
						<td style="display: none;">
							<form:radiobutton path="rss_yn" cssClass="selectmenu" value="Y" label="사용함" />
							<form:radiobutton path="rss_yn" cssClass="selectmenu" value="N" label="사용안함" />
						</td>
						<th>비밀글 사용</th>
						<td>
							<form:radiobutton path="secret_use_yn" cssClass="selectmenu" value="Y" label="사용함" />
							<form:radiobutton path="secret_use_yn" cssClass="selectmenu" value="N" label="사용안함" />
						</td>
						<th>작성자명 블라인드<br/>('성**'으로 표시)</th>
						<td>
							<form:radiobutton path="anonymize_yn" cssClass="selectmenu" value="Y" label="사용함" />
							<form:radiobutton path="anonymize_yn" cssClass="selectmenu" value="N" label="사용안함" />
						</td>
					</tr>
					<tr style="display: none;">
						<th>만족도조사 사용</th>
						<td>
							<form:radiobutton path="satisfy_yn" cssClass="selectmenu" value="Y" label="사용함" />
							<form:radiobutton path="satisfy_yn" cssClass="selectmenu" value="N" label="사용안함" />
						</td>
						<th>EBOOK 사용</th>
						<td>
							<form:radiobutton path="ebook_yn" cssClass="selectmenu" value="Y" label="사용함" />
							<form:radiobutton path="ebook_yn" cssClass="selectmenu" value="N" label="사용안함" />
						</td>
					</tr>
					<tr>
						<th>글쓰기 전용 여부</th>
						<td>
							<form:radiobutton path="write_only_yn" cssClass="selectmenu" value="Y" label="사용함" />
							<form:radiobutton path="write_only_yn" cssClass="selectmenu" value="N" label="사용안함" />
						</td>
						<th>카테고리 종류</th>
						<td>
							<form:hidden path="category_use_yn" />
							<form:select path="category1" cssClass="selectmenu">
								<form:option value="">==선택==</form:option>
							<c:forEach var="i" varStatus="status" items="${codeGroupList}">
								<form:option value="${i.group_id}">${i.group_name}</form:option>
							</c:forEach>
							</form:select>
						</td>
					</tr>
					<tr>
						<th>추천여부</th>
						<td>
							<form:radiobutton path="recommend_yn" cssClass="selectmenu" value="Y" label="사용함" />
							<form:radiobutton path="recommend_yn" cssClass="selectmenu" value="N" label="사용안함" />
						</td>
						<th>파일 업로드</th>
						<td>
							<form:radiobutton path="file_use_yn" cssClass="selectmenu" value="Y" label="사용함" />
							<form:radiobutton path="file_use_yn" cssClass="selectmenu" value="N" label="사용안함" />
						</td>
					</tr>
					<tr>
						<th>파일 업로드수</th>
						<td>
							<form:select path="file_count" cssClass="selectmenu">
							<c:forEach var="i" begin="1" end="50">
								<form:option value="${i}">${i}개</form:option>
							</c:forEach>
							</form:select>
						</td>
						<th>파일 총 용량제한</th>
						<td>
							<form:select path="file_size_total" cssClass="selectmenu">
							<c:forEach var="i" begin="1" end="200">
								<form:option value="${i}">${i}MB</form:option>
							</c:forEach>
							</form:select>
						</td>
					</tr>
					<tr>
						<th>개인 동의 여부</th>
						<td>
							<form:radiobutton path="terms_yn" value="Y" label="사용함" />
							<form:radiobutton path="terms_yn" value="N" label="사용안함" />
						</td>
						<th></th>
						<td></td>
					</tr>
					<tr>
						<th>금지 확장자 파일</th>
						<td colspan="3">
							<form:input path="file_ban_ext" cssClass="text" cssStyle="width:99%;"/>
							<div class="ui-state-highlight">
								<em>* | 으로 구분하여 작성하세요.</em>
							</div>
						</td>
					</tr>
					<tr>
						<th>담당자SMS 수신</th>
						<td>
							<form:radiobutton path="charge_sms_receive_yn" cssClass="selectmenu" value="Y" label="사용함" />
							<form:radiobutton path="charge_sms_receive_yn" cssClass="selectmenu" value="N" label="사용안함" />
						</td>
						<th>담당자EMAIL 수신</th>
						<td>
							<form:radiobutton path="charge_email_receive_yn" cssClass="selectmenu" value="Y" label="사용함" />
							<form:radiobutton path="charge_email_receive_yn" cssClass="selectmenu" value="N" label="사용안함" />
						</td>

					</tr>
					<tr style="display: none;">
						<th>글쓴이SMS 수신</th>
						<td>
							<form:radiobutton path="write_sms_receive_yn" cssClass="selectmenu" value="Y" label="사용함" />
							<form:radiobutton path="write_sms_receive_yn" cssClass="selectmenu" value="N" label="사용안함" />
						</td>
						<th>글쓴이EMAIL 수신</th>
						<td>
							<form:radiobutton path="write_email_receive_yn" cssClass="selectmenu" value="Y" label="사용함" />
							<form:radiobutton path="write_email_receive_yn" cssClass="selectmenu" value="N" label="사용안함" />
						</td>
					</tr>
					<tr style="display: none;">
						<th>게시물EMAIL 발송</th>
						<td>
							<form:radiobutton path="board_email_send_yn" cssClass="selectmenu" value="Y" label="사용함" />
							<form:radiobutton path="board_email_send_yn" cssClass="selectmenu" value="N" label="사용안함" />
						</td>
						<th>게시판 기타1</th>
						<td>
							<form:input path="board_etc1" cssClass="text" cssStyle="width:100%;" maxlength="30"/>
						</td>
					</tr>
					<tr style="display: none;">
						<th>찬성/반대 표시</th>
						<td colspan="3">
							<form:radiobutton path="approval_yn" cssClass="selectmenu" value="Y" label="사용함" />
							<form:radiobutton path="approval_yn" cssClass="selectmenu" value="N" label="사용안함" />
						</td>
					</tr>
					<tr style="display: none;">
						<th>글등록전용</th>
						<td colspan="3">
							<form:radiobutton path="add_only_yn" cssClass="selectmenu" value="Y" label="글등록전용(글 목록 및 글보기는 관리자만 가능)" />
							<form:radiobutton path="add_only_yn" cssClass="selectmenu" value="N" label="사용안함" />
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div id="tabs-2">
			<table class="type2">
				<colgroup>
					<col width="150"/>
					<col width="300"/>
					<col width="150"/>
					<col width="300"/>
				</colgroup>
				<tbody>
					<tr>
						<th>추가 HTML</th>
						<td colspan="3">
							<form:radiobutton path="add_html_use_yn" cssClass="selectmenu" value="Y" label="사용함" />
							<form:radiobutton path="add_html_use_yn" cssClass="selectmenu" value="N" label="사용안함" />
						</td>
					</tr>
					<tr>
						<th>상단 추가 HTML</th>
						<td colspan="3">
							<form:textarea path="top_html" cssStyle="width:100%; height:200px;"/>
						</td>
					</tr>
					<tr>
						<th>하단 추가 HTML</th>
						<td colspan="3">
							<form:textarea path="bottom_html" cssStyle="width:100%; height:200px;"/>
						</td>
					</tr>
					<tr>
						<th>게시판 카테고리2</th>
						<td>
							<form:select path="category2" cssClass="selectmenu">
								<form:option value="">==선택==</form:option>
							<c:forEach var="i" varStatus="status" items="${codeGroupList}">
								<form:option value="${i.group_id}">${i.group_name}</form:option>
							</c:forEach>
							</form:select>
						</td>
						<th>게시판 카테고리3</th>
						<td>
							<form:select path="category3" cssClass="selectmenu">
								<form:option value="">==선택==</form:option>
							<c:forEach var="i" varStatus="status" items="${codeGroupList}">
								<form:option value="${i.group_id}">${i.group_name}</form:option>
							</c:forEach>
							</form:select>
						</td>
					</tr>
					<tr>
						<th>게시판 카테고리4</th>
						<td>
							<form:select path="category4" cssClass="selectmenu">
								<form:option value="">==선택==</form:option>
							<c:forEach var="i" varStatus="status" items="${codeGroupList}">
								<form:option value="${i.group_id}">${i.group_name}</form:option>
							</c:forEach>
							</form:select>
						</td>
						<th>게시판 카테고리5</th>
						<td>
							<form:select path="category5" cssClass="selectmenu">
								<form:option value="">==선택==</form:option>
							<c:forEach var="i" varStatus="status" items="${codeGroupList}">
								<form:option value="${i.group_id}">${i.group_name}</form:option>
							</c:forEach>
							</form:select>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
</div>
</form:form>

