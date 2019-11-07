<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="boardTag" uri="/WEB-INF/config/tld/boardTag.tld"%>
<% pageContext.setAttribute("crlf", "\r\n"); %>
<jsp:include page="/WEB-INF/views/app/board/common/view/script.jsp" flush="false" />
<script type="text/javascript">
$(function() {
	$('a#deleteNewsLetter').on('click', function(e) {
		var name = $('#newLetterApply #name').val();
		var email = $('#newLetterApply #email').val();
		if(confirm('탈퇴하시겠습니까?')) {
			$.ajax({
		        type: 'post',
		        url: '/pr/module/pub/newsLetter/applyDelete.do',
		        async: false,
		        data: {'name' : name, 'email' : email},
		        dataType : 'json',
		        success: function(response) {
		        	response = eval(response);
		        	if(response.valid) {
		        		alert(response.message);
			        	location.reload();
		        	} else {
		        		alert(response.message);
		        	}

		      	}
		    }); 
		}
	});
		
	$('a#saveModify').on('click', function(e) {
		var name = $('#newLetterApply #name').val();
		var email = $('#newLetterApply #email').val();
		if(confirm('신청하시겠습니까?')) {
			$.ajax({
		        type: 'post',
		        url: '/pr/module/pub/newsLetter/apply.do',
		        async: false,
		        data: {'name' : name, 'email' : email},
		        dataType : 'json',
		        success: function(response) {
		        	response = eval(response);
		        	if(response.valid) {
		        		alert(response.message);
			        	location.reload();
		        	} else {
		        		alert(response.message);
		        	}
		      	}
		    }); 
		}
	});
		
	$('#name').on('click', function(e) {
		doGetLoad('/main/userLogin/index.do?login_type=personnal');
		e.preventDefault();
	});
		
});
</script>
<form id="newLetterApply" method="post" action="/cms/module/pub/newsLetter/apply.do">
<form hidden="editMode">
	<table summary="교육소식지 신청">
		<colgroup>
			<col width="30%" />
			<col width="45%" />
			<col width="15%" />
		</colgroup>
		<thead>
			<tr class="center">
				<td><span>성명</span>&emsp;
					<c:choose>
						<c:when test="${sessionScope.member.login}">
							${sessionScope.member.dept_nm}
							<input type="hidden" id="name" name="name"/>
						</c:when>
						<c:otherwise>
							<input type="text" id="name" name="name" class="text">
						</c:otherwise>
					</c:choose>
				</td>
				<td><span>이메일</span>&emsp;<input type="text" id="email" name="email" class="text" style="width:240px "></td>
				<td>
					<a href="" class="btn btn2" id="saveModify" >신청</a>
					<a href="" class="btn" id="deleteNewsLetter">탈퇴</a>
				</td>
			</tr>
		</thead>
	</table>
	
	<br/>
	
<br/>
<div class="brdGuide">
    <h4><img src="/resources/homepage/dge/images/board/tit_brdGuide.gif" width="78" height="24" alt="잠깐만" /></h4>
    <div class="exp">
        <ul>
            <li><a href="http://old.dge.go.kr/dge/servlet/fs.HDServlet_FS?tc=HL.cmd.DEHL_CMD&gb=VIEW&bbsSno=423&pageNum=8&subPage=1" target="_blank">이전 홈페이지 게시판 바로가기</a></li>
        </ul>
    </div>
</div>
	
</form>



<form:form modelAttribute="board" method="get">
<jsp:include page="/WEB-INF/views/app/board/common/form_param.jsp" flush="false" />
<jsp:include page="/WEB-INF/views/app/board/common/form_paging_param.jsp" flush="false" />
<form:hidden path="editMode"/>
<form:hidden path="target_manage_idx"/>
<form:hidden path="category1"/>
</form:form>
<div class="wrapper-bbs">
	<div class="bbs-view">
		<div class="bbs-view-header">
			<jsp:include page="/WEB-INF/views/app/board/common/view/moveOrCopy.jsp" flush="false" />
			<dl>
				<dt>${board.title}</dt>
			<jsp:include page="/WEB-INF/views/app/board/common/view/ebook.jsp" flush="false" />
				<dd class="info">
					<div class="panel-left">
						<c:choose>
						<c:when test="${boardManage.anonymize_yn eq 'Y' and not authMBA}">
						<c:set var="user_name" value="${fn:substring(board.user_name, -1, 1)}**"/>
						</c:when>
						<c:otherwise>
						<c:set var="user_name" value="${board.user_name}"/>
						</c:otherwise>
						</c:choose>
						<i>작성자</i><span>${user_name}<c:if test="${authMBA}">(${board.add_id})</c:if></span>
						<i>작성일</i><span><fmt:formatDate value="${board.add_date}" pattern="yyyy.MM.dd HH:mm"/></span>
					</div>
					<div class="panel-right">
						<a href="#bbs-comment">
						<i>댓글</i><span>0</span></a>
						<i>조회수</i><span><fmt:formatNumber value="${board.view_count}" pattern="#,###"/></span>
					</div>
				</dd>
			</dl>
		</div>
		<div class="bbs-view-body">
			${fn:replace(board.content, crlf, '<br/>')}
			<dl class="share">
				<dt>공유하기</dt>
				<dd>
					<a href="" class="facebook"><i class="fa fa-facebook"></i> <span>페이스북</span></a>
					<a href="" class="twitter"><i class="fa fa-twitter"></i> <span>트위터</span></a>
				</dd>
				<jsp:include page="/WEB-INF/views/app/board/common/view/approval.jsp" flush="false" />
			</dl>
		</div>
		<div class="bbs-view-header">
			<dl>
				<jsp:include page="/WEB-INF/views/app/board/common/view/file.jsp" flush="false" />
			</dl>
		</div>
	</div>

	<jsp:include page="/WEB-INF/views/app/board/common/view/beforeNext.jsp" flush="false" />

	<jsp:include page="/WEB-INF/views/app/board/common/view/button.jsp" flush="false" />
</div>