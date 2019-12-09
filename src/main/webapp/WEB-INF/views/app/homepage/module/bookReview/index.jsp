<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%pageContext.setAttribute("lf", "\n");%>
<style type="text/css">
.starRev .starR1, .starRev .starR1 {cursor: pointer;}
.starR1 {position: relative;display: inline-block;width: 14px;height: 23px;background: url("/resources/common/img/ico_star.png") no-repeat;background-size: 25px;overflow: hidden;z-index: 2;}
.starR2 {position: relative;display: inline-block;right: 19px;width: 28px;height: 24px;background: url("/resources/common/img/ico_star.png") no-repeat;background-size: 25px;margin-right: -25px;}
.starR1.on {background: url("/resources/common/img/ico_starColor.png") no-repeat;background-size: 25px;}
.starR2.on {background: url("/resources/common/img/ico_starColor.png") no-repeat;background-size: 25px;}

.starNum {display: inline-block;padding-right: 15px;}

.bbs-comment-title {font-size: 140%;padding: 0 0 10px;}
.bbs-comment-title strong, .bbs-comment-title em {font-style: normal;font-weight: normal;}
.bbs-comment-title em {color: #fe9903;}

div.book-review-write {position: relative;padding: 21px 100px 22px 162px;z-index: 1;background-color: #f2f2f2}
div.book-review-write_sub {position: relative;padding: 10px 100px 0 0;z-index: 1;}
div.book-review-write div#starRevC, div.book-review-write_sub div#starRevC {position: absolute;left: 0;height: 55px;padding: 33px 5px 5px 20px;}
div.book-review-write a {position: absolute;top: 21px;right: 25px;display: inline-block;width: 100px;height: 94px;text-align: center;line-height: 94px;font-size: 110%;color: white;background: #959ca4;}
div.book-review-write_sub a {position: absolute;top: 10px;right: 0;display: inline-block;width: 100px;height: 94px;text-align: center;line-height: 94px;font-size: 110%;color: white;background: #959ca4;}
div.book-review-write_sub textarea {background-color: #fff;}
div.book-review-textarea {width: 544px;border: 2px solid #e5e5e5;background: #fff;padding: 10px;}
div.book-review-textarea_sub {border: 2px solid #e5e5e5;background: #fff;padding: 10px;}
div.book-review-textarea textarea, div.book-review-textarea_sub textarea {resize: none;width: 100%;height: 64px;border: none;background-color: #fff;}

div.bcl-list div.bcl-box {position: relative;border-bottom: 1px solid #e5e5e5;padding: 15px;}
div.bcl-list div.bcl-box div.bcl-header span.name {font-size: 110%;font-weight: 600;}
div.bcl-list div.bcl-box div.bcl-header span.published {color: #888;font-size: 90%;margin-left: 5px;}
div.bcl-list div.bcl-box div.bcl-header span.name, div.bcl-list div.bcl-box div.bcl-header span.published {position: relative;bottom: 5px;}
div.bcl-list div.bcl-box div.bcl-content {position:relative;padding: 5px 0 5px;z-index: 3;}
div.bcl-list div.bcl-box div.bcl-btns {position: absolute;top: 15px;right: 15px;font-size: 90%;}
div.bcl-list div.bcl-box div.bcl-btns a {border: 1px solid #cbcbcb; background-color: #f6f6f6;padding: 4px 10px;}
</style>
<script type="text/javascript">
var url = '/${homepage.context_path}/module/bookReview/index.do';
var formData = 'manage_code=${fn:escapeXml(bookReview.manage_code)}&reg_no=${fn:escapeXml(bookReview.reg_no)}';

$(document).ready(function() {
	
	 $('.starRev span').on('click', function() {
    	$(this).parent().children('span').removeClass('on');
    	$(this).addClass('on').prevAll('span').addClass('on');
    	return false;
    });
	
	<%-- 댓글 수정 --%>
	$('a.bookReview_modify_btn').on('click', function(e) {
		e.preventDefault();
		$('div#bookReview_content_' + $(this).attr('keyValue')).toggle();
		$('div#bookReview_contentModify_' + $(this).attr('keyValue')).toggle();
	});
	
	$('a#book_review_save').on('click', function(e) {
    	e.preventDefault();
		if('${member.login}' == 'false') {
			alert('로그인 후 사용 가능합니다.');
    		return false;
    	}
		
		if('${bookReviewFlag}' == 'H') {
			alert('대출이력이 없습니다.');
			return false;
		} else if('${bookReviewFlag}' == 'D') {
			alert('서평을 이미 작성하였습니다.');
			return false;
		}
    	
    	var book_review_score = $('#starRevC .starR1.on, #starRevC .starR2.on').length * 0.5;
    	var book_review_content = $('textarea#book_review_content').val();
    	var manage_code = $(this).attr('keyValue');
    	var reg_no = $(this).attr('keyValue2');
    	
		if(book_review_content.search(/\S/) == -1) {
			alert('공백은 입력할 수 없습니다.');
			return false;
		}
    	
    	if(book_review_content == '') {
    		alert('서평을 작성하세요.');
    		return false;
    	}
    	
    	$('form#bookReview input#book_review_score').val(book_review_score);
    	$('form#bookReview input#book_review_content').val(book_review_content);
    	$('form#bookReview input#manage_code').val(manage_code);
    	$('form#bookReview input#reg_no').val(reg_no);
    	
    	if(doAjaxPostSubmit($('form#bookReview'))) {
    		doAjaxLoad('div#bookReviewDiv', url, formData);
    	}
    	
    });
    
    $('a.book_review_mod').on('click' ,function(e) {
    	e.preventDefault();
    	var idx = $(this).attr('keyValue');
    	var book_review_score = $('#starRev'+idx+' .starR1.on, #starRev'+idx+' .starR2.on').length * 0.5;
    	var book_review_content = $('textarea#book_review_text'+idx).val();
    	
    	$('form#bookReview input#editMode').val('MODIFY');
    	$('form#bookReview input#book_review_idx').val(idx);
    	$('form#bookReview input#book_review_score').val(book_review_score);
    	$('form#bookReview input#book_review_content').val(book_review_content);
    	
    	if(doAjaxPostSubmit($('form#bookReview'))) {
    		doAjaxLoad('div#bookReviewDiv', url, formData);
    	}
    });
    
    $('a.book_review_del').on('click', function(e) {
    	e.preventDefault();
    	if(!confirm('선택한 서평을 삭제하시겠습니까?')) {
    		return false;
    	}
    	
    	$('form#bookReviewDel #book_review_idx_d').val($(this).attr('keyValue'));
    	
    	if(doAjaxPost($('form#bookReviewDel'))) {
    		doAjaxLoad('div#bookReviewDiv', url, formData);
    	}
    });
    
});

function doAjaxPostSubmit(form, ajaxBody) {
	jQuery.ajaxSettings.traditional = true;
	var formData = serializeObject(form);
	var responseValid = false;
	
	$.ajax({
		type: "POST",
		url: form.attr('action'),
		async: false,
		data: formData,
		dataType:'json',
		success: function(response) {
			response = eval(response);
			responseValid = response.valid;
			if(response.valid) {
				if(response.message != null && response.message.replace(/\s/g,'').length!=0) {
					alert(response.message);
				}
				if(response.reload) {
					location.reload();
				}
				if(response.targetOpener) {
					window.open(response.url, '', 'width=500,height=510');
					return false;
				}
				if(response.url != null && response.url.replace(/\s/g,'').length!=0) {
					/**
					* ajaxBody 값이 존재한다면 ajax , 아니라면 form 을 이용하여 화면이동한다.
					*/
					if(ajaxBody != null && ajaxBody.replace(/\s/g,'').length!=0) {
						doAjaxLoad(ajaxBody, response.url, response.data);
					} else {
						doGetLoad(response.url, response.data);
					}
				}
			} else {
				if(response.message != null && response.message.replace(/\s/g,'').length!=0) {
					alert(response.message);
				} else {
					if (response.result != null && response.result.length > 0) {
						for(var i =0 ; i < response.result.length ; i++) {
							alert(response.result[i].code);
							$('#'+response.result[i].field).focus();
							$('#'+response.result[i].field, $(form)).css('border-color', 'red');
							$('#'+response.result[i].field, $(form)).on('change', function() {
								$(this).css('border-color', '');
							});
							break;
						}
					}
				}
				
				if(response.url != null && response.url.replace(/\s/g,'').length!=0) {
					if(ajaxBody != null && ajaxBody.replace(/\s/g,'').length!=0) {
						doAjaxLoad(ajaxBody, response.url, response.data);
					} else {
						doGetLoad(response.url, response.data);
					}
				}
			}
		},
		error: function(jqXHR, textStatus, errorThrown) {
			alert('[' + textStatus + ']관리자에게 문의하세요. : ' + errorThrown + ', ' + jqXHR.status);
		}
	});
	
	return responseValid;
}
</script>
<form:form modelAttribute="bookReview" action="/${homepage.context_path}/module/bookReview/save.do">
	<form:hidden path="editMode" value="ADD" htmlEscape="true"/>
	<form:hidden path="menu_idx" htmlEscape="true"/>
	<form:hidden path="book_review_idx" htmlEscape="true"/>
	<form:hidden path="book_review_name" htmlEscape="true"/>
	<form:hidden path="reg_no" htmlEscape="true"/>
	<form:hidden path="manage_code" htmlEscape="true"/>
	<form:hidden path="book_review_content" htmlEscape="true"/>
	<form:hidden path="book_review_score" htmlEscape="true"/>
</form:form>

<form:form modelAttribute="bookReview" id="bookReviewDel" action="/${homepage.context_path}/module/bookReview/delete.do">
	<form:hidden path="book_review_idx" id="book_review_idx_d" htmlEscape="true"/>
	<form:hidden path="editMode" id="editMode_d" value="DELETE" htmlEscape="true"/>
</form:form>

<div class="bbs-comment-title">
	<strong>서평 </strong>
	<em>${fn:length(bookReviewList)}</em>
</div>

<%-- <c:if test="${member.login and bookReviewFlag}"> --%>
<%-- <c:if test="${member.login}"> --%>
<div class="book-review-write">
	<div class="starRev" id="starRevC">
		<span class="starR1 on"></span>
		<span class="starR2"></span>
		<span class="starR1"></span>
		<span class="starR2"></span>
		<span class="starR1"></span>
		<span class="starR2"></span>
		<span class="starR1"></span>
		<span class="starR2"></span>
		<span class="starR1"></span>
		<span class="starR2"></span>
	</div>
	<div class="book-review-textarea">
		<c:choose>
		<c:when test="${bookReviewFlag eq 'H'}">
			<textarea id="book_review_content" disabled="disabled" placeholder="대출 이력이 없습니다." />
		</c:when>
		<c:when test="${bookReviewFlag eq 'D'}">
			<textarea id="book_review_content" disabled="disabled" placeholder="서평을 작성하였습니다." />
		</c:when>
		<c:when test="${member.login and bookReviewFlag eq 'P'}">
			<textarea id="book_review_content" rows="3" cols="50" placeholder="서평을 입력하세요."></textarea>
		</c:when>
		<c:otherwise>
			<textarea id="book_review_content" disabled="disabled" placeholder="로그인 후 사용가능합니다." />
		</c:otherwise>
		</c:choose>
	</div>
	<a href="#" id="book_review_save" keyValue="${fn:escapeXml(bookReview.manage_code)}" keyValue2="${fn:escapeXml(bookReview.reg_no)}">서평 작성</a>
</div>
<%-- </c:if> --%>

<div class="bcl-list">
	<c:forEach var="i" varStatus="status" items="${bookReviewList}">
	<div class="bcl-box">
		<div class="bcl-header">
			<c:set value="${member.rec_key eq i.book_review_loan_id}" var="modify_star" />
			<div class="starNum <c:if test="${modify_star}">starRev</c:if>" id="starRev${i.book_review_idx}">
				<span class="starR1 <c:if test="${i.book_review_score >= 0.5}">on</c:if>"></span>
				<span class="starR2 <c:if test="${i.book_review_score >= 1}">on</c:if>"></span>
				<span class="starR1 <c:if test="${i.book_review_score >= 1.5}">on</c:if>"></span>
				<span class="starR2 <c:if test="${i.book_review_score >= 2}">on</c:if>"></span>
				<span class="starR1 <c:if test="${i.book_review_score >= 2.5}">on</c:if>"></span>
				<span class="starR2 <c:if test="${i.book_review_score >= 3}">on</c:if>"></span>
				<span class="starR1 <c:if test="${i.book_review_score >= 3.5}">on</c:if>"></span>
				<span class="starR2 <c:if test="${i.book_review_score >= 4}">on</c:if>"></span>
				<span class="starR1 <c:if test="${i.book_review_score >= 4.5}">on</c:if>"></span>
				<span class="starR2 <c:if test="${i.book_review_score >= 5}">on</c:if>"></span>
			</div>
			<span class="name">${i.book_review_name}(${i.book_review_web_id})</span>
			<span class="published" title="<fmt:formatDate value="${i.add_date}" pattern="yyyy.MM.dd HH:mm" />"><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM.dd HH:mm" /></span>
		</div>
		<div class="bcl-content" id="bookReview_content_${i.book_review_idx}">
			<p class="speech">
				<span style="word-break:normal;">${fn:replace(i.book_review_content, lf, '<br/>')}</span>
			</p>
		</div>
		<div class="book-review-write_sub" id="bookReview_contentModify_${i.book_review_idx}" style="display:none;">
			<div class="book-review-textarea_sub">
				<textarea id="book_review_text${i.book_review_idx}" placeholder="수정할 서평을 입력하세요.">${i.book_review_content}</textarea>
			</div>
			<a href="#" class="book_review_mod" keyValue="${i.book_review_idx}">서평 수정</a>
		</div>
		<c:if test="${member.login and i.book_review_loan_id eq member.rec_key}">
		<div class="bcl-btns">
			<a href="" class="bookReview_modify_btn" keyValue="${i.book_review_idx}">수정</a>
<!-- 			<span class="txt-bar"></span> -->
			<a href="" class="book_review_del" keyValue="${i.book_review_idx}">삭제</a>
		</div>
		</c:if>
	</div>
	</c:forEach>
</div>