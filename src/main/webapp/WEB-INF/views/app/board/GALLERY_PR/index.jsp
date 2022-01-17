<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="boardTag" uri="/WEB-INF/config/tld/boardTag.tld"%>
<jsp:include page="/WEB-INF/views/app/board/common/index/script.jsp" flush="false" />
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
<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
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
							<input type="hidden" id="name" name="name" value="${sessionScope.member.dept_nm}"/>
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

	<div class="page_exp2">
		<i class="fa fa-exclamation-circle"></i>
		<span>대구광역시교육청은 개인정보보호법에 의거하여, 아래와 같은 내용으로 개인정보를 수집하고 있습니다.<br/>
			- 개인 정보 수집 및 이용목적: 교육정책 홍보를 위해 필요한 최소한의 개인정보를 수집<br/>
			- 개인정보 수집 및 이용 항목: 메일 발송을 위한 내용(성명, 이메일)<br/>
			- 수집된 개인정보의 보유 및 이용기간: 회원 탈퇴시까지</span>
	</div>
	
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





<form:form modelAttribute="board" action="index.do" method="get" onsubmit="return false;">
<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
<jsp:include page="/WEB-INF/views/app/board/common/form_param.jsp" flush="false" />
<div class="wrapper-bbs">
	<jsp:include page="/WEB-INF/views/app/board/common/index/infodesk.jsp" flush="false" />
	<div class="table-wrap">
		<ul class="bbs_gallery" id="board_tbody">
			<c:forEach var="i" varStatus="status" items="${boardList}">
			<li>
				<div class="thumb">
					<c:choose>
					<c:when test="${i.preview_img ne null}">
						<a href="" keyValue="${i.board_idx}"><img src="/data/board/${i.manage_idx}/${i.board_idx}/${i.preview_img}" alt="${i.title}"/></a>
					</c:when>
					<c:otherwise>
						<a href="" keyValue="${i.board_idx}"><img src="/resources/common/img/noimage.gif" alt="${i.title}"></a>
					</c:otherwise>
					</c:choose>
				</div>
				<div class="info">
					<a href="" keyValue="${i.board_idx}">${i.title}</a>
					<div class="meta">
						<c:choose>
						<c:when test="${boardManage.anonymize_yn eq 'Y'}">
						<c:set var="user_name" value="${fn:substring(i.user_name, -1, 1)}**"/>
						</c:when>
						<c:otherwise>
						<c:set var="user_name" value="${i.user_name}"/>
						</c:otherwise>
						</c:choose>
						${i.secret_yn ne 'Y'? user_name:'비공개'}
						<span class="txt-bar"></span>
						<abbr class="published"><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM.dd"/></abbr>
					</div>
				</div>
			</li>
			</c:forEach>
		</ul>
	</div>

	<jsp:include page="/WEB-INF/views/app/board/common/index/button.jsp" flush="false" />
	
	<jsp:include page="/WEB-INF/views/app/board/common/index/paging.jsp" flush="false">
		<jsp:param name="formId" value="#board"/>
	</jsp:include>
</div>
</form:form>