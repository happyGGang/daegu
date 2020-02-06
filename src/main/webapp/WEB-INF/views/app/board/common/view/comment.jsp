<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="boardTag" uri="/WEB-INF/config/tld/boardTag.tld"%>
<%pageContext.setAttribute("lf", "\n");%>
<script type="text/javascript">
$(document).ready(function() {
	var board_idx = $('input#comment_board_idx').val();
	var manage_idx = $('input#comment_manage_idx').val();

	<%-- 코멘트 등록 --%>
	$('button#boardComment_add_btn').on('click', function(e) {
		e.preventDefault();
		<c:choose>
		<c:when test="${sessionScope.member.login}">
		try {
			$('#boardCommentFileArray > option').prop('selected', true);
		} catch (e) {
		}
		doAjaxPost($('#boardComment'), 'div#bbs-comment');
		</c:when>
		<c:otherwise>
		alert('로그인 후 사용 가능합니다.');
		</c:otherwise>
		</c:choose>
	});

	<%-- 댓글 삭제 --%>
	$('a#boardComment_delete_btn').on('click', function(e) {
		e.preventDefault();
		try {
			$('#boardCommentFileArray > option').prop('selected', true);
		} catch (e) {
		}
		if(confirm('삭제 하시겠습니까?')) {
			var param =
			{
				'board_idx' : $('input#comment_board_idx').val(),
				'comment_idx' : $(this).attr('keyValue')
			};

			$.ajax({
		        type: 'post',
		        url: '/board/boardComment/delete.do',
		        async: false,
		        data: param,
		        success: function(response) {
		            if(response.valid) {
						alert(response.message);
						var url = '/board/boardComment/index.do';
						var formData = 'board_idx=' + board_idx + '&manage_idx=' + manage_idx;
						doAjaxLoad('div#bbs-comment',url, formData);
					} else {
		                for(var i =0 ; i < response.result.length ; i++) {
							alert(response.result[i].code);
							$('#'+response.result[i].field).focus();
							break;
						}
					}
		         },
		         error: function(jqXHR, textStatus, errorThrown) {
		             alert('[' + textStatus + ']관리자에게 문의하세요. : ' + errorThrown);
		         }
		    });
		}
	});

	<%-- 댓글 수정 --%>
	$('a#boardComment_modify_btn').on('click', function(e) {
		e.preventDefault();
		$('div#boardComment_content_' + $(this).attr('keyValue')).toggle();
		$('div#boardComment_contentModify_' + $(this).attr('keyValue')).toggle();
		$('div#boardComment_contentReply_' + $(this).attr('keyValue')).hide();
	});

	<%-- 댓글 수정(저장) --%>
	$('button#boardComment_modify_save_btn').on('click', function(e) {
		e.preventDefault();
		var comment_content = $(this).parents('div.bbs-comment-write').find('textarea').val();

		var param =
		{
			'editMode' : 'MODIFY',
			'board_idx' : board_idx,
			'comment_idx' : $(this).attr('keyValue'),
			'comment_content' : comment_content
		};

		commentSave(param);
	});

	<%-- 댓글 답글 --%>
	$('button#boardComment_reply_btn').on('click', function(e) {
		e.preventDefault();
		$('div#boardComment_content_' + $(this).attr('keyValue')).show();
		$('div#boardComment_contentReply_' + $(this).attr('keyValue')).toggle();
		$('div#boardComment_contentModify_' + $(this).attr('keyValue')).hide();
	});

	<%-- 댓글 답글(저장) --%>
	$('button#boardComment_reply_save_btn').on('click', function(e) {
		e.preventDefault();
		var comment_content = $(this).parents('div.bbs-comment-write').find('textarea').val();

		var param =
		{
			'editMode' : 'REPLY',
			'board_idx' : board_idx,
			'comment_idx' : $(this).attr('comment_idx'),
			'group_comment_idx' : $(this).attr('group_comment_idx'),
			'parent_comment_idx' : $(this).attr('parent_comment_idx'),
			'group_comment_depth' : $(this).attr('group_comment_depth'),
			'comment_content' : comment_content
		};

		commentSave(param);
	});

	function commentSave(param) {
		try {
			$('#boardCommentFileArray > option').prop('selected', true);
		} catch (e) {
		}
		$.ajax({
	        type: 'post',
	        url: '/board/boardComment/save.do',
	        async: false,
	        data: param,
	        success: function(response) {
	            if(response.valid) {
					alert(response.message);
					var url = '/board/boardComment/index.do?board_idx=' + board_idx + '&manage_idx=' + manage_idx;
					doAjaxLoad('div#bbs-comment', url, '');
				} else {
	                for(var i =0 ; i < response.result.length ; i++) {
						alert(response.result[i].code);
						$('#'+response.result[i].field).focus();
						break;
					}
				}
	         },
	         error: function(jqXHR, textStatus, errorThrown) {
	             alert('[' + textStatus + ']관리자에게 문의하세요. : ' + errorThrown);
	         }
	    });
	}
});
</script>
<div class="bbs-comment-title">
	<strong>댓글 </strong>
	<em>${fn:length(boardCommentList)}</em>
</div>

<form:form modelAttribute="boardComment" action="/board/boardComment/save.do" method="post" onsubmit="return false;">
<c:if test="${boardComment.manage_idx eq '563'}">
	<ul style="float: right;">
	<c:if test="${not empty authMBA and authMBA and board.request_state eq '0'}">
	<li style="margin-top:-30px;">
		<form:checkbox path="imsi_v_20" value="Y" label="접수" cssStyle="vertical-align:middle;"/>
		<form:select path="imsi_v_19" cssClass="selectmenu" items="${phoneList}" itemLabel="code_name" itemValue="remark">
		</form:select>
	</li>
	</c:if>
	<c:choose>
	<c:when test="${not empty authMBA and authMBA or (not empty authMBRE and authMBRE and board.request_state eq '1')}">
	<li style="margin-top:-35px;">
		<form:checkbox path="imsi_v_18" value="Y" label="처리완료" cssStyle="vertical-align:middle;"/>
	</li>
	</c:when>
	<c:when test="${not empty authMBA and authMBA or (not empty authMBRE and authMBRE and board.request_state eq '0' and board.category1 eq '0020')}">
	<div style="margin-top:-35px;">
		<form:checkbox path="imsi_v_18" value="Y" label="처리완료" cssStyle="vertical-align:middle;"/>
	</li>
	</c:when>
	</c:choose>
	</ul>

</c:if>
<form:hidden id="comment_board_idx" path="board_idx" />
<form:hidden id="comment_manage_idx" path="manage_idx" />
<div class="bbs-comment-write">
	<div class="bbs-comment-textarea">
	<c:choose>
	<c:when test="${sessionScope.member.login}">
		<form:textarea path="comment_content" placeholder="댓글을 입력하세요."/>
	</c:when>
	<c:otherwise>
		<textarea id="comment_content" disabled="disabled" placeholder="로그인 후 사용가능합니다." />
	</c:otherwise>
	</c:choose>
	</div>
	<button id="boardComment_add_btn">댓글 작성</button>
</div>
<c:if test="${boardComment.manage_idx eq '563'}">
<jsp:include page="/WEB-INF/views/app/board/common/view/commentFile.jsp" flush="false" />
</c:if>
</form:form>

<div id="commentArea" class="bbs-comment-list">
	<c:forEach var="i" varStatus="status" items="${boardCommentList}">
	<div class="bcl${i.group_comment_depth > 0?' reply':''}" style="padding-left:${(i.group_comment_depth + 1) * 15}px">
		<div class="bcl-box">
			<div class="bcl-header">
				<span class="name">${i.user_name}</span>
				<abbr class="published" title="<fmt:formatDate value="${i.add_date}" pattern="yyyy.MM.dd HH:mm" />"><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM.dd HH:mm" /></abbr>
				<button class="btn-init" id="boardComment_reply_btn" keyValue="${i.comment_idx}"><i class="fa fa-reply"></i> <span>답글</span></button>
			</div>
			<c:if test="${fn:length(i.fileList) > 0}">
			<div class="bcl-header">
				<c:forEach var="j" varStatus="statusJ" items="${i.fileList}">
				<span>
				<a href="${getContextPath}/boardComment/boardCommentFile/download/${boardComment.manage_idx}/${j.comment_idx}/${j.comment_file_idx}.do"><i class="fa <boardTag:file_ext file_ext="${j.file_ext_name}"/>"></i><span>${j.file_name}</span></a>
				</span>
				<c:if test="${!statusJ.first}"> | </c:if>
				</c:forEach>
			</div>
			</c:if>
			<div class="bcl-content" id="boardComment_content_${i.comment_idx}">
				<p class="speech">
					<span style="word-break:normal;">${fn:replace(i.comment_content, lf, '<br/>')}</span>
				</p>
			</div>
			<div class="bbs-comment-write" id="boardComment_contentModify_${i.comment_idx}" style="display:none;">
				<div class="bbs-comment-textarea">
					<textarea placeholder="수정할 댓글을 입력하세요.">${i.comment_content}</textarea>
				</div>
				<button id="boardComment_modify_save_btn" keyValue="${i.comment_idx}">댓글 수정</button>
			</div>
			<div class="bbs-comment-write" id="boardComment_contentReply_${i.comment_idx}" style="display:none;">
				<div class="bbs-comment-textarea">
					<textarea placeholder="답글을 입력하세요."></textarea>
				</div>
				<button id="boardComment_reply_save_btn" comment_idx="${i.comment_idx}" group_comment_idx="${i.group_comment_idx}" parent_comment_idx="${i.comment_idx}" group_comment_depth="${i.group_comment_depth}">답글 작성</button>
			</div>
			<c:if test="${sessionScope.member.login and i.user_id eq sessionScope.member.member_id}">
			<div class="bcl-btns">
				<a href="" class="b1" id="boardComment_modify_btn" keyValue="${i.comment_idx}">수정</a>
				<span class="txt-bar"></span>
				<a href="" class="b2" id="boardComment_delete_btn" keyValue="${i.comment_idx}">삭제</a>
			</div>
			</c:if>
		</div>
	</div>
	</c:forEach>


</div>